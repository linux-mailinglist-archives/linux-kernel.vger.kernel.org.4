Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21155BACA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiIPLph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIPLpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:45:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80141D33
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jJ/gfyFsT9QvO7TRnbdF1ML/8klCoLRCeK881VSe+pg=; b=WJzoIdT2ss0o+vZVkT6JrW2kA7
        5gZV8W2WYisd8W65uD8w7+DM3R05+ZSQDlmWDI9gUGfKFCcTOfvwY2l2NaoEAq5zl2g4Hjfoadquv
        adit7KgcYe9nHxpIjijPDQT056eTtqFOEC3VqMPPCgCKcmlKsHIpX0YijqzVv8TOVFLd1DK3zEcxM
        mezxVyHChXcYhVxO2wcMzL++5FGusgjiLbrvlF5+DIrKw18IjYz3jmD84vlCnVjrFXwUy6zONkQJJ
        H8xqzH0ZBtiJc0HOtoGr7oz2Zt4TpcdiqafohaP/S5Qpb6FybOE5ismQeND796g6ZWCUmX/hDhsrX
        0sRX4/Sg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oZ9mL-0029iU-JY; Fri, 16 Sep 2022 11:45:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7861300342;
        Fri, 16 Sep 2022 13:45:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B19CE201A0BBA; Fri, 16 Sep 2022 13:45:00 +0200 (CEST)
Date:   Fri, 16 Sep 2022 13:45:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <YyRhvEGS4ivPGf+z@hirez.programming.kicks-ass.net>
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915165407.1776363-1-yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:54:07AM +0800, Chen Yu wrote:
> And the rq lock bottleneck is composed of two paths(perf profile):
> 
> (path1):
> raw_spin_rq_lock_nested.constprop.0;
> try_to_wake_up;
> default_wake_function;
> autoremove_wake_function;
> __wake_up_common;
> __wake_up_common_lock;
> __wake_up_sync_key;
> pipe_write;
> new_sync_write;
> vfs_write;
> ksys_write;
> __x64_sys_write;
> do_syscall_64;
> entry_SYSCALL_64_after_hwframe;write

Can you please addr2line -i the raw_spin_rq_lock callsite so we know which is
the one causing grief?

Specifically; I'm worried about PSI, psi_ttwu_dequeue() can cause ttwu()
to take _2_ rq->lock, which absolutely blows for this case.
