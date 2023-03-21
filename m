Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E86C3A56
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCUTYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCUTYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:24:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CEE1CF65;
        Tue, 21 Mar 2023 12:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 600AF61D7D;
        Tue, 21 Mar 2023 19:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8EAC433EF;
        Tue, 21 Mar 2023 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679426638;
        bh=01NJ2IcYdEE0HVbmuHjF15wW1YkRe+4EE4uPxrRRDKw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m1FhD0aw02QUmecJ88ElhTrhGkwkPfr6E2Rsi8D65Iutg8mQhtgjtizh2lOI/7jOW
         y5LSADQfhCMpw8Nzbc8uYOALWNFjVEKiVT1cmAmd13j22EHBtuti0uoLz53jFzkkTO
         sOtdOY0q1R2iYVYdnsSVPEmA+lVJzEybVIbBVVXgMHn0uDsV9rDrHiYkpttF5foyWY
         dLCUpUJB9/4GweDld3YWf2YCS6xvUm2UftyCPf4I+5SV0as4rIMrCd8uW2igzsKJ0k
         jQPCW0PZKSd4TA4zsgA1xInUd0iNgqi4hQ/TLST/JSYr1IqIc2txBGn10nEOsiQlKM
         651Kk/GR8g/Sg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4EFB5154033A; Tue, 21 Mar 2023 12:23:58 -0700 (PDT)
Date:   Tue, 21 Mar 2023 12:23:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, frederic@kernel.org,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 2/2] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Message-ID: <a4a3e103-78b3-4be3-80b8-bbae7b1bb2f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <72ba8619-88cb-4bf4-8232-18d8a1b6b5bf@paulmck-laptop>
 <20230321052337.26553-1-qiuxu.zhuo@intel.com>
 <20230321052337.26553-2-qiuxu.zhuo@intel.com>
 <20230321154751.hgeppd5v327juc36@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321154751.hgeppd5v327juc36@offworld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:47:51AM -0700, Davidlohr Bueso wrote:
> On Tue, 21 Mar 2023, Qiuxu Zhuo wrote:
> 
> > When running the 'kfree_rcu_test' test case with commands [1] the call
> > trace [2] was thrown. This was because the kfree_scale_thread thread(s)
> > still run after unloading rcuscale and torture modules. Fix the call
> > trace by invoking kfree_scale_cleanup() from rcu_scale_cleanup() when
> > removing the rcuscale module.
> > 
> > [1] modprobe rcuscale kfree_rcu_test=1
> >    // After some time
> >    rmmod rcuscale
> >    rmmod torture
> > 
> > [2] BUG: unable to handle page fault for address: ffffffffc0601a87
> >    #PF: supervisor instruction fetch in kernel mode
> >    #PF: error_code(0x0010) - not-present page
> >    PGD 11de4f067 P4D 11de4f067 PUD 11de51067 PMD 112f4d067 PTE 0
> >    Oops: 0010 [#1] PREEMPT SMP NOPTI
> >    CPU: 1 PID: 1798 Comm: kfree_scale_thr Not tainted 6.3.0-rc1-rcu+ #1
> >    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> >    RIP: 0010:0xffffffffc0601a87
> >    Code: Unable to access opcode bytes at 0xffffffffc0601a5d.
> >    RSP: 0018:ffffb25bc2e57e18 EFLAGS: 00010297
> >    RAX: 0000000000000000 RBX: ffffffffc061f0b6 RCX: 0000000000000000
> >    RDX: 0000000000000000 RSI: ffffffff962fd0de RDI: ffffffff962fd0de
> >    RBP: ffffb25bc2e57ea8 R08: 0000000000000000 R09: 0000000000000000
> >    R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> >    R13: 0000000000000000 R14: 000000000000000a R15: 00000000001c1dbe
> >    FS:  0000000000000000(0000) GS:ffff921fa2200000(0000) knlGS:0000000000000000
> >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    CR2: ffffffffc0601a5d CR3: 000000011de4c006 CR4: 0000000000370ee0
> >    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >    Call Trace:
> >     <TASK>
> >     ? kvfree_call_rcu+0xf0/0x3a0
> >     ? kthread+0xf3/0x120
> >     ? kthread_complete_and_exit+0x20/0x20
> >     ? ret_from_fork+0x1f/0x30
> >     </TASK>
> >    Modules linked in: rfkill sunrpc ... [last unloaded: torture]
> >    CR2: ffffffffc0601a87
> >    ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Much better, thank you both!

But unfortunately, these patches do not apply cleanly.  Qiuxu Zhuo,
could you please forward port these to the -rcu "dev" branch [1]?

						Thanx, Paul

[1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html
