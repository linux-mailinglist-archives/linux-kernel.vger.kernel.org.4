Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9EB63B687
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 01:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiK2AWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 19:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiK2AWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 19:22:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E7BF51;
        Mon, 28 Nov 2022 16:22:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3C7061510;
        Tue, 29 Nov 2022 00:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB85C433C1;
        Tue, 29 Nov 2022 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669681361;
        bh=iLjIZpm+UZYRllUhZgZEVRAxBO/09IBUENSiD2Zo5y4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S/QLroqymLNoMg33MXPNORwgkEW1uuMkk5czpqpfU1p8kbs4mHmxEL4Kwwk5mVw/s
         I85t9RxXoC14ytJgsbBwoR5XtReamytnERsQ2dhsdlUOrNq3pD3Si4WDORprgfj0Ls
         p4hmEJNDiENANdMKeyp+C8qZ2ZlkUq7sJWNG3OHQY9mOocJVmPTeHG56U86bcYRFXL
         2vMocwH1YKaMWngI9B8zqVqRHX+7Tn3+JmqP83yNfAiDrMV55PP/46lCH/7Fe+x4je
         3NPN4h78uzZHpU8oqJc7dv6MKvQ5/21C66Y/raK8BoCfDVKX936tkAJ8DI2qCxreNB
         iUwKNm8tJ3SbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D43A05C0EBE; Mon, 28 Nov 2022 16:22:40 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:22:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 0/3] rcu-tasks: Fix race against exiting pid_ns
Message-ID: <20221129002240.GP4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221125135500.1653800-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125135500.1653800-1-frederic@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 02:54:57PM +0100, Frederic Weisbecker wrote:
> Pengfei Xu has reported a deadlock involving calls to unshare(),
> perf_event_open() and clone3() calls. It requires CAP_SYS_ADMIN
> to reproduce (at least I don't see a way for a non privilege process to
> reproduce).
> 
> See this thread for details: https://lore.kernel.org/all/Y3sOgrOmMQqPMItu@xpf.sh.intel.com/
> And this document for the collaborative analysis with Boqun, Paul and Neeraj:
> https://docs.google.com/document/d/1hJxgiZ5TMZ4YJkdJPLAkRvq7sYQ-A7svgA8no6i-v8k
> 
> The two first patches are small improvements. The fix is in the last patch.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/dev
> 
> HEAD: 45ef5a0a4be4e0db9eadcc86e8f346d34c62e744

Hearing no objections, queued for further review and testing.

And thank you very much!  That race between synchronize_rcu_tasks() and
zap_pid_ns_processes() certainly was more than a bit on the non-trivial
side.  Good show!!!

							Thanx, Paul

> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (3):
>       rcu-tasks: Improve comments explaining tasks_rcu_exit_srcu purpose
>       rcu-tasks: Remove preemption disablement around srcu_read_[un]lock() calls
>       rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()
> 
> 
>  include/linux/rcupdate.h |  2 ++
>  kernel/pid_namespace.c   | 17 +++++++++++++++
>  kernel/rcu/tasks.h       | 55 ++++++++++++++++++++++++++++++++++++------------
>  3 files changed, 60 insertions(+), 14 deletions(-)
