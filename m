Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B366E46E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDQL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDQL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:56:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2AB8682
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gP0S443LaMj7TRidv8xgYhysgY7/1wengzxzodpEXA0=; b=qziPfpA3Y9O59o/xz1qK81ipUU
        UThDRsiwDtXtjDOtLekqDzS6d0g6a3UnfvH2hhGP560b93jDPqUoCyID5T9I0QOENuUKpH28gj+mr
        v2eVQu6EHRRIocYZFgpIXroereG6+nt7/iZCHbfrJ1ymxxeWOJjD6j3iq1q8IX7IZSZkVgdEhnQ96
        a5UwkOCMFo4ejSGNWGc0MeWY6Aqu3K3TprN5jV+/+/pPBeJ31ynSSDjJiBWfY+BeqiuGGlj3X8tXN
        F/kczLzrHgqvhTT4DfMSfy4yyYwvYHIlv28ahIUzYNUJPjxVcQjP13vRt4inagAyMj4vs+9qNMDhB
        sZbw9s6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poNS1-00BJML-2J; Mon, 17 Apr 2023 11:55:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85EDF3002A3;
        Mon, 17 Apr 2023 13:55:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68C9324248708; Mon, 17 Apr 2023 13:55:16 +0200 (CEST)
Date:   Mon, 17 Apr 2023 13:55:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Message-ID: <20230417115516.GM83892@hirez.programming.kicks-ass.net>
References: <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
 <20230414160945.GC761523@hirez.programming.kicks-ass.net>
 <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
 <20230414192407.GA778423@hirez.programming.kicks-ass.net>
 <2428e6a2-9578-1e1d-bdef-ffcc87301503@linux.intel.com>
 <20230414220106.GC778423@hirez.programming.kicks-ass.net>
 <d53d4df7-d0b8-2fbc-4912-f89686b5d931@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53d4df7-d0b8-2fbc-4912-f89686b5d931@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:47:29PM -0700, Andi Kleen wrote:

> > You really *must* make then a group such that perf knows what events to
> > associated with the LBR event and constain them to the 0-3 range of
> > PMCs.
> > 
> > If you want multiplexing, simply create multiple groups with an LBR
> > event in them.
> 
> 
> Well if you force groups then you require user space or a user which
> understands all the constraints

The LBR feature is naturally a group read, very similar to
PERF_SAMPLE_READ+PERF_FORMAT_GROUP.

> to create groups. I thought one of the basic ideas of perf was to be able to
> abstract those things.

Yeah, the abstraction at hand is a group.
