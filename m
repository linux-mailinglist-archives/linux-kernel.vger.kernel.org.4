Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88A641A0C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 01:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiLDAEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 19:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLDAED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 19:04:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CB1C42D;
        Sat,  3 Dec 2022 16:04:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29C82B807E9;
        Sun,  4 Dec 2022 00:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D888C433D7;
        Sun,  4 Dec 2022 00:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670112239;
        bh=Y3yBz9Pcc8yqE2m1VhKlQSH32UcLuZuY/vu8r16m/no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQ5GgUZnBg79BWgCKA/SPQiuRKlcsWfTORldW4wT8/AUDIQjM+zWLfdl5hEnPEZmD
         U7XLg2WeOh1CkzIXH0wnayUBS8hz4VMra6H+gd2fNY0fopczgFIi7YPfVRhRUR0KQX
         R+m5TKFvyM7IOs/qiSnd6u/vVNfx1yFHAX1OQNQRvXSpN05DlurLX+h7pVYq972Z/i
         qRArKGSues5cvjc1iQSrgjuFr8N/rI/bsKN+6H57MFN6gE02JSLKm1CjCgzj6LjUH0
         hEYrUnG2pFw3e9AvZNwhM8rWtosuGscCevBIC2PfQXhu5emH8e5Q2FNN6A8It66T5e
         OT465q82SKOrA==
Date:   Sun, 4 Dec 2022 01:03:56 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()
Message-ID: <20221204000356.GA1779165@lothringen>
References: <20221125135500.1653800-1-frederic@kernel.org>
 <20221125135500.1653800-4-frederic@kernel.org>
 <871qpkqof8.fsf@email.froward.int.ebiederm.org>
 <20221202225428.GA1754872@lothringen>
 <87ilitpeq1.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilitpeq1.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:28:54PM -0600, Eric W. Biederman wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > On Wed, Nov 30, 2022 at 12:37:15PM -0600, Eric W. Biederman wrote:
> >> Frederic Weisbecker <frederic@kernel.org> writes:
> >> Two questions.
> >> 
> >> 1) Is there any chance you need the exit_task_rcu_stop() and
> >>    exit_tasks_rcu_start() around schedule in the part of this code that
> >>    calls kernel_wait4.
> >
> > Indeed it could be relaxed there too if necessary.
> 
> I was just wondering how you tell if it is necessary and if perhaps
> the kernel_wait4 was overlooked.

As for the deadlock described in this patch, it involves waiting for
another task to reap yet another task. So it doesn't look necessary to
relax the lock when the current task does the reaping.


Now the following looks possible:

      TASK A                                    TASK B                       TASK C
      -----                                   -------                       ------
      mutex_lock(&lock1)
      synchronize_srcu(tasks_rcu_exit_srcu)
                                                                            mutex_lock(&lock1)
                                                                            //wait for TASK A to release &lock1
                                              exit_tasks_rcu_start();
                                              ...
                                              zap_pid_ns_processes()
                                                  kernel_wait4()
                                                      //wait for TASK C

> > So you mean it still reaps those that were EXIT_ZOMBIE before ignoring
> > SIGCHLD (the kernel_wait4() call) but it doesn't sleep anymore on those
> > that autoreap (or get reaped by a parent outside that namespace) after
> > ignoring SIGCHLD? Namely it doesn't do the schedule() loop I'm working
> > around here and proceeds with exit_notify() and notifies its parent?
> 
> Yes.  A change to make it work like when the thread group leader exits
> before the other threads.  So any actual sleeping happens in the reaper
> of the init process when the reaper calls wait(2).
> 
> > And then in this case the responsibility of sleeping, until the init_process
> > of the namespace is the last task in the namespace, goes to the parent while
> > waiting that init_process, right?
> >
> > But what if the init_process of the given namespace autoreaps? Should it then
> > wait itself until the namespace is empty? And then aren't we back to the initial
> > issue?
> 
> The idea is that we only care when the userspace cares.  I don't think
> there is any kernel code that fundamentally cares.  There might be a few
> bits that accidentally care and those would need to be take care of when
> making the proposed change.  The wait would only exist for userspace so
> the same semantics are observed.

I mean the issue is that if the pid_namespace reaper goes for autoreaping, then
it still has to go through that loop waiting for the remaining tasks of the
pid_namespace to be reaped. The loop will just happen later in exit_notify() but
eventually the issue remains: we'll have to relax tasks_rcu_exit_srcu
around that loop.

Thanks.

> 
> Eric
