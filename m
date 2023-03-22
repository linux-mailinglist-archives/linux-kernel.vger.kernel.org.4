Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA36C53AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCVSYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCVSYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:24:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13891A6;
        Wed, 22 Mar 2023 11:24:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C16A62239;
        Wed, 22 Mar 2023 18:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB04C433EF;
        Wed, 22 Mar 2023 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679509453;
        bh=aWxeq5HqKialMXYsRI0N48pceUPI3ircbdDb9rBKN6o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EP3QogOAgnu3MpQ9e5iYtVyMW0DX7ZDhR9TE3rGI1LTgnqnULyUFtEQ2cvNJ9xJBZ
         dpoI/KfM3BOIV+l9P5LXnBqCTnDfcnCyPv5iVfQbOKkhjHd06CEF+oTBEEQ49yTC1j
         VojDMFy1fp2ae4KouDRckPP7Db91Enf+4fZaBa1aHpEQjWbliff0dEw4mpgc7pDCHk
         tI0nEbCKgLXL/+CWzwOsQ+IQij+WLJ4yKwVZ58mhYVk07Iuf4fHNwiDApoPFFro9rD
         IxJmanT58b/nb5GoagwU3A7H5ECR08p/755+Vp7SPs0rviJ1cblPsbz2CX/Uvi1y7K
         tv/z/rHgXNM4A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 87978154033A; Wed, 22 Mar 2023 11:24:12 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:24:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v4 2/2] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Message-ID: <d5284e08-837e-4ed2-989f-2c62f2cc0f19@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a4a3e103-78b3-4be3-80b8-bbae7b1bb2f4@paulmck-laptop>
 <20230322114241.88118-1-qiuxu.zhuo@intel.com>
 <20230322114241.88118-3-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322114241.88118-3-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:42:41PM +0800, Qiuxu Zhuo wrote:
> When running the 'kfree_rcu_test' test case with commands [1] the call
> trace [2] was thrown. This was because the kfree_scale_thread thread(s)
> still run after unloading rcuscale and torture modules. Fix the call
> trace by invoking kfree_scale_cleanup() from rcu_scale_cleanup() when
> removing the rcuscale module.
> 
> [1] modprobe rcuscale kfree_rcu_test=1
>     // After some time
>     rmmod rcuscale
>     rmmod torture
> 
> [2] BUG: unable to handle page fault for address: ffffffffc0601a87
>     #PF: supervisor instruction fetch in kernel mode
>     #PF: error_code(0x0010) - not-present page
>     PGD 11de4f067 P4D 11de4f067 PUD 11de51067 PMD 112f4d067 PTE 0
>     Oops: 0010 [#1] PREEMPT SMP NOPTI
>     CPU: 1 PID: 1798 Comm: kfree_scale_thr Not tainted 6.3.0-rc1-rcu+ #1
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>     RIP: 0010:0xffffffffc0601a87
>     Code: Unable to access opcode bytes at 0xffffffffc0601a5d.
>     RSP: 0018:ffffb25bc2e57e18 EFLAGS: 00010297
>     RAX: 0000000000000000 RBX: ffffffffc061f0b6 RCX: 0000000000000000
>     RDX: 0000000000000000 RSI: ffffffff962fd0de RDI: ffffffff962fd0de
>     RBP: ffffb25bc2e57ea8 R08: 0000000000000000 R09: 0000000000000000
>     R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
>     R13: 0000000000000000 R14: 000000000000000a R15: 00000000001c1dbe
>     FS:  0000000000000000(0000) GS:ffff921fa2200000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffffffc0601a5d CR3: 000000011de4c006 CR4: 0000000000370ee0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>      <TASK>
>      ? kvfree_call_rcu+0xf0/0x3a0
>      ? kthread+0xf3/0x120
>      ? kthread_complete_and_exit+0x20/0x20
>      ? ret_from_fork+0x1f/0x30
>      </TASK>
>     Modules linked in: rfkill sunrpc ... [last unloaded: torture]
>     CR2: ffffffffc0601a87
>     ---[ end trace 0000000000000000 ]---
> 
> Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Much better, thank you!

I queued and pushed both of them.

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 7e8965b0827a..d1221731c7cf 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -797,6 +797,11 @@ rcu_scale_cleanup(void)
>  	if (gp_exp && gp_async)
>  		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
>  
> +	if (kfree_rcu_test) {
> +		kfree_scale_cleanup();
> +		return;
> +	}
> +
>  	if (torture_cleanup_begin())
>  		return;
>  	if (!cur_ops) {
> -- 
> 2.17.1
> 
