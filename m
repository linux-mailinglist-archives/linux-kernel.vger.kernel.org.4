Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8854C6C180C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjCTPTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjCTPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:19:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D325973
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Xg4UMcVEKxpyYT4k7A+tcw8+E06nhy//K4tdBRqLQdE=; b=O06WPACyqv5mw9P74QLw834z6/
        EKunEg1LPuko/rN453nzNgTX2JXlbf2vKL01gusbV9jFSCaJywAQpf0LIhINwuprofRG5glpjnUsa
        Uza3Uk191eT5pGJ0+jrO5lWn7VGh+cTX9FHYYpzbV6rvTHgRoUWWjz7H9YC22q8wvM7FEPxhmJyHg
        FKgQg3a40ZFpa/PVTJNW+c30ZSIUZRDQsknutFhoDrI6u7UK8Vd2G+RV5V0xnazpTUsiH3M9qCtGx
        cKe5BNPC63BW+xmMHjAZHjtxZrG+r5HRCbf2oscnaKjP0mUFJ4ZIJBJXQuYxEuveHL9F8vTG0U7+V
        f2Pg0kUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peHCW-00192K-EJ; Mon, 20 Mar 2023 15:13:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99849300288;
        Mon, 20 Mar 2023 16:13:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B9D020EEFFC3; Mon, 20 Mar 2023 16:13:31 +0100 (CET)
Date:   Mon, 20 Mar 2023 16:13:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     chi wu <wuchi.zero@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Reduce cost of sched_move_task when config
 autogroup
Message-ID: <20230320151331.GN2194297@hirez.programming.kicks-ass.net>
References: <20230319075643.28312-1-wuchi.zero@gmail.com>
 <20230320082811.GD2194297@hirez.programming.kicks-ass.net>
 <CA+tQmHBfp2ecNC1j+w0uBs5jbYwa_-JD72Rwvhxx1Q4Pv8m+XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+tQmHBfp2ecNC1j+w0uBs5jbYwa_-JD72Rwvhxx1Q4Pv8m+XQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 08:40:51PM +0800, chi wu wrote:
> Peter Zijlstra <peterz@infradead.org> 于2023年3月20日周一 16:28写道：
> >
> > On Sun, Mar 19, 2023 at 03:56:43PM +0800, wuchi wrote:
> > > Some sched_move_task calls of autogroup is useless when the
> > > task_struct->sched_task_group isn't changed because of task_group
> > > of cpu_cgroup overlay task_group of autogroup. The overlay key codes
> > > are as follows:
> > >
> > > sched_cgroup_fork->autogroup_task_group->task_wants_autogroup
> > > sched_change_group->autogroup_task_group->autogroup_task_group
> > >
> > > sched_move_task eg:
> > > task A belongs to cpu_cgroup0 and autogroup0, it will always to
> > > cpu_cgroup0 when doing exit. So there is no need to do {de|en}queue.
> > > The call graph is as follow.
> > >
> > > do_exit
> > >   sched_autogroup_exit_task
> > >     sched_move_task
> > >       dequeue_task
> > >         sched_change_group
> > >         A.sched_task_group = sched_get_task_group
> > >       enqueue_task
> > >
> > > So do some check before dequeue task in sched_move_task.
> >
> > No immediate objection; but the $subject seems to suggest you did this
> > for performance reasons, yet there are no performance results in this
> > Changelog. How much does this save under what load?
> 
> cpu:bogomips=4600.00
> kernel:6.3.0-rc3
> cpu cgroup: 6:cpu,cpuacct:/user.slice
> 
> run cmds:
> 
> #!/bin/bash
> for i in {0..10000}; do
> sleep 0 &
> done
> wait
> 
> bpftrace -e 'k:sched_move_task { @ts[tid] = nsecs; }
> kr:sched_move_task /@ts[tid]/ { @ns += nsecs - @ts[tid];
> delete(@ts[tid]); }'
> 
> cost time(ns):
>  without patch: 43528033
>  with      patch: 18934496
>                   diff: -24593537  -56.5%
> 
> About the change, move sched_task_group_changed before
> update_rq_clock as following and add the performance results in
> the Changelog?

Yes please, that gives good motivation for the change.

Thanks!
