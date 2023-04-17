Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455536E45EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjDQLAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDQLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:00:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4037ED;
        Mon, 17 Apr 2023 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qAwfrPnNclTtYIr2T/WtfaYPceP7Audmu+SG7iP0hiY=; b=XFJZfNir+HHYcVnr91cef5KybD
        AFLuToNXZo4xhu6058jHimjaxx0DHbxStXUWvwKjdNg8Nm/KhmvEfiKdxhNK9M5OZh6m+Ohu9je10
        wbLF0nlauqkCH50ncll7d5Ka8bBHL1vZm8tX+XY+mjeM2OcryOdBR9ObZmb1qgaz+1Zv/ZcdXFVMR
        ZdU8ht/KAIOFvJ5yqRDJPlAgBFn3MVfCjh3Q7WquD1yW3zplLbLsOS6FDTi01Fikid9AxAQ2WJnnb
        4XwfWe/ruE8dmimQGaL6xRe+ccPp3WWw+p2WjNYvzUBBLJJ8vPpYFSv9R8nIUS50QdY8vcwRPFkhI
        55o3Yp2Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1poMY4-00HIUt-2L;
        Mon, 17 Apr 2023 10:57:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66D103001E5;
        Mon, 17 Apr 2023 12:57:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 201D424248704; Mon, 17 Apr 2023 12:57:27 +0200 (CEST)
Date:   Mon, 17 Apr 2023 12:57:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/5] perf: Add ioctl to emit sideband events
Message-ID: <20230417105727.GG83892@hirez.programming.kicks-ass.net>
References: <20230414082300.34798-1-adrian.hunter@intel.com>
 <20230414082300.34798-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414082300.34798-2-adrian.hunter@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:22:56AM +0300, Adrian Hunter wrote:
> perf tools currently read /proc to get this information, but that
> races with changes made by the kernel.
> 
> Add an ioctl to output status-only sideband events for a currently
> active event on the current CPU. Using timestamps, these status-only
> sideband events will be correctly ordered with respect to "real"
> sideband events.
> 
> The assumption is a user will:
> 	- open and enable a dummy event to track sideband events
> 	- call the new ioctl to get sideband information for currently
> 	  running processes as needed
> 	- enable the remaining selected events
> 
> The initial sideband events to be supported will be: fork, namespaces, comm
> and mmap.
> 
> Add a new misc flag PERF_RECORD_MISC_STATUS_ONLY to differentiate "real"
> sideband events from status-only sideband events.
> 
> The limitation that the event must be active is significant. The ioctl
> caller must either:
> 	i)  For a CPU context, set CPU affinity to the correct CPU.
> 	    Note, obviously that would not need to be done for system-wide
> 	    tracing on all CPUs. It would also only need to be done for the
> 	    period of tracing when the ioctl is to be used.
> 	ii) Use an event opened for the current process on all CPUs.
> 	    Note, if such an additional event is needed, it would also use
> 	    additional memory from the user's perf_event_mlock_kb /
> 	    RLIMIT_MEMLOCK limit.

Why would a single per-task event not work? I see nothing in the code
that would require a per-task-per-cpu setup. Or am I just having trouble
reading again?
