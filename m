Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8846033DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJRUXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJRUXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:23:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA467968F;
        Tue, 18 Oct 2022 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x8Y0BR8tWiYY0RJ/fs8N8ONHE31H3d8AIGA8SWlxL8s=; b=LUvG/DpriM0EC3QZ1k3Wz8XoFq
        61hE/k4viDMxNnKbYx08KO59dYduJh3sILBsq7C30g8yodGWRPBEnh4jWPsXi3Qc2zC8N8LRnS8kw
        e8EvfvGB5Rx3SDeciuAQATaj2h5OuOCJaDdFh+4qhmDMEodI455c0sGAdfMZMx+wphHOI8cVVF5CV
        OG632L/y3NDWjJ7nds6r7rKf8kd2/4jyEPRhJbzI8eD0GINocormiGAAfFcT635CJW5UHTBYhrE+F
        VqKXzx3KfLTp2x34/H8KNBzcGdwle8QY3oVnthgUZw7SbUHD3Pm5nj/kdlN7kQGNXwVrORdwjwre+
        8rG3ptFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okt77-004ZNb-Am; Tue, 18 Oct 2022 20:23:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA58D300110;
        Tue, 18 Oct 2022 22:23:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88F2C2C0E0B83; Tue, 18 Oct 2022 22:23:00 +0200 (CEST)
Date:   Tue, 18 Oct 2022 22:23:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf: Fix missing raw data on tracepoint events
Message-ID: <Y08LJEt8B/Zgv4Gs@hirez.programming.kicks-ass.net>
References: <20221012143857.48198-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012143857.48198-1-james.clark@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 03:38:57PM +0100, James Clark wrote:
> Since commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> raw data is not being output on tracepoints due to the PERF_SAMPLE_RAW
> field not being set. Fix this by setting it for tracepoint events.
> 
> This fixes the following test failure:
> 
>   perf test "sched_switch" -vvv
> 
>    35: Track with sched_switch
>   --- start ---
>   test child forked, pid 1828
>   ...
>   Using CPUID 0x00000000410fd400
>   sched_switch: cpu: 2 prev_tid -14687 next_tid 0
>   sched_switch: cpu: 2 prev_tid -14687 next_tid 0
>   Missing sched_switch events
>   4613 events recorded
>   test child finished with -1
>   ---- end ----
>   Track with sched_switch: FAILED!
> 
> Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks!
