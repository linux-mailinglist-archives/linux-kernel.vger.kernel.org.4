Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F783613754
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiJaNEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJaNEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:04:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4EDFCE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xaDwwkyAJVJEGhNAHbIAkDPDRhf+szRoPKaEYBQPnD8=; b=a1ltrHwJZBMS5tX8vewGYJrEhc
        NfzREq/vLCfZjhSMB8HW2rC4/EDHmpHCrFPPJwyJZyRRSl1AGx0GQt8xuJkbXQzybZgRcih/Fj3lz
        H/Wr3JjCcZq6ph6v9vJgXhkOA9LpuAqHbZ6Z5wP6BjULjgM6MR/UcXvbbT1Lk1cXpFSEE3isIqmIw
        hL+IJUkgLUWkJZ7+ibM/RrRdLTeZs+bbDCBGHIvHVzye9rXefZnOAoDO+2g67sNAxCHNxk6zhndN5
        4v134RTU/FC1p1KvW3ZbpT2mMY1Irq0J/dzsgmhYCNCk25eb1aCu2i7J6kC6rLa2pzqpnXYKA7Ron
        kzA5BWkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opUSl-003gmz-OA; Mon, 31 Oct 2022 13:04:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4F8830013F;
        Mon, 31 Oct 2022 14:04:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A27222C74B23D; Mon, 31 Oct 2022 14:04:15 +0100 (CET)
Date:   Mon, 31 Oct 2022 14:04:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
References: <20221026224449.214839-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026224449.214839-1-joshdon@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 03:44:49PM -0700, Josh Don wrote:
> CFS bandwidth currently distributes new runtime and unthrottles cfs_rq's
> inline in an hrtimer callback. Runtime distribution is a per-cpu
> operation, and unthrottling is a per-cgroup operation, since a tg walk
> is required. On machines with a large number of cpus and large cgroup
> hierarchies, this cpus*cgroups work can be too much to do in a single
> hrtimer callback: since IRQ are disabled, hard lockups may easily occur.
> Specifically, we've found this scalability issue on configurations with
> 256 cpus, O(1000) cgroups in the hierarchy being throttled, and high
> memory bandwidth usage.
> 
> To fix this, we can instead unthrottle cfs_rq's asynchronously via a
> CSD. Each cpu is responsible for unthrottling itself, thus sharding the
> total work more fairly across the system, and avoiding hard lockups.

So, TJ has been complaining about us throttling in kernel-space, causing
grief when we also happen to hold a mutex or some other resource and has
been prodding us to only throttle at the return-to-user boundary.

Would this be an opportune moment to do this? That is, what if we
replace this CSD with a task_work that's ran on the return-to-user path
instead?
