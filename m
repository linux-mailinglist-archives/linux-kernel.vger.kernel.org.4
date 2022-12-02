Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA66410EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiLBWyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiLBWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:54:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BCFE1778;
        Fri,  2 Dec 2022 14:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32E47B822E8;
        Fri,  2 Dec 2022 22:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C3FC433D6;
        Fri,  2 Dec 2022 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670021672;
        bh=WaMU7Ge0epObyaSSLOJNB/I06TYIj1nhbJdaHZ9nifY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fpe4GHWWeS2MiaKPw0dHMSVcpInftkQdeTUZ5X/QiJ84qdoWNdWS5dqoXJk1LqL7s
         /STLtU5eionxQLhWYyM6XPCWHnrIFc/YX2Xe4OCFnQw8nCfDWzezreF5bz9GA4NgBf
         w6535fLooA+1Wo/umTei7HeU+GKiHai4NXkoT9AMWWVPN/536ywcR7osuU+uNCffSl
         oIelPB0RW4g58PouANHfHb/6df2Es/ilOKxHIjpvtuGv7JAJofDFeMTzVXOqaoEztw
         6YE0aRAqQpRG9Yrv3vXBJexFcNGqlKy9RlCBtYISIHtuJLNnOm7AbNndv5aPanN8Ev
         ajPFJnby6wx+Q==
Date:   Fri, 2 Dec 2022 23:54:28 +0100
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
Message-ID: <20221202225428.GA1754872@lothringen>
References: <20221125135500.1653800-1-frederic@kernel.org>
 <20221125135500.1653800-4-frederic@kernel.org>
 <871qpkqof8.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qpkqof8.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:37:15PM -0600, Eric W. Biederman wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> Two questions.
> 
> 1) Is there any chance you need the exit_task_rcu_stop() and
>    exit_tasks_rcu_start() around schedule in the part of this code that
>    calls kernel_wait4.

Indeed it could be relaxed there too if necessary.

> 
> 2) I keep thinking zap_pid_ns_processes() should be changed so that
>    after it sends SIGKILL to all of the relevant processes to not wait,
>    and instead have wait_consider_task simply not allow the 
>    init process of the pid namespace to be reaped.
> 
>    Am I right in thinking that such a change were to be made it would
>    make remove the deadlock without having to have any special code?
> 
>    It is just tricky enough to do that I don't want to discourage your
>    simpler change but this looks like a case that makes the pain of
>    changing zap_pid_ns_processes worthwhile in the practice.

So you mean it still reaps those that were EXIT_ZOMBIE before ignoring
SIGCHLD (the kernel_wait4() call) but it doesn't sleep anymore on those
that autoreap (or get reaped by a parent outside that namespace) after
ignoring SIGCHLD? Namely it doesn't do the schedule() loop I'm working
around here and proceeds with exit_notify() and notifies its parent?

And then in this case the responsibility of sleeping, until the init_process
of the namespace is the last task in the namespace, goes to the parent while
waiting that init_process, right?

But what if the init_process of the given namespace autoreaps? Should it then
wait itself until the namespace is empty? And then aren't we back to the initial
issue?

Thanks.
