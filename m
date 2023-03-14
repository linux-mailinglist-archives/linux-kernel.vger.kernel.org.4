Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4006BA346
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCNXDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCNXDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:03:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE3CA04;
        Tue, 14 Mar 2023 16:02:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 464A9619D0;
        Tue, 14 Mar 2023 23:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84CFC433D2;
        Tue, 14 Mar 2023 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678834977;
        bh=SHPRGCx5smTrFzp92YfdtlCVMmQ4EWiYEDg3at7k+jc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AbpMI4YEzwipEJM0wD7Yjo/vIkMcBYFre2IZaNhhEHbPhBxiAG0poifN0tueK3jIt
         s/sbY/ZBaz5h2/w64tQdj/MucLW+ACIeMWVCIjFYnNB+vHq/rTqm6atvxSL5vhQ9jJ
         TDUwi5N+/T2Ik9ltk+Qvp9w6FB0GRk6aOy8K5QGAODOLAln2uzCk9W/508sum59tYQ
         vqTlEkELw6A8wCfjl+plu4CO96QyiC7Yl6eBD6dTdxmH7Y2lyS7NsuwBKdcZU9kBPP
         X2CaXrRCIUoV992ybLP15RX7jyTb7rbrTXNE2qXtc9hmKBglhv3K4bPCt2K+Qy+qFL
         /Hya0Hd+rDuoA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3DC731540395; Tue, 14 Mar 2023 16:02:57 -0700 (PDT)
Date:   Tue, 14 Mar 2023 16:02:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Message-ID: <d930f2a8-4b75-4109-a303-e2fc04443693@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230313080403.89290-1-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313080403.89290-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 04:04:03PM +0800, Qiuxu Zhuo wrote:
> When running the 'kfree_rcu_test' test case with commands [1] the call
> trace [2] was thrown. This was because the kfree_scale_thread thread(s)
> still run after unloading rcuscale and torture modules. Fix the call
> trace by invoking kfree_scale_cleanup() when removing the rcuscale module.

Good catch, thank you!

> [1] modprobe torture
>     modprobe rcuscale kfree_rcu_test=1

Given that loading the rcuscale kernel module automatically pulls in
the rcuscale kernel module, why the "modprobe torture"?  Is doing the
modprobes separately like this necessary to reproduce this bug?

If it reproduces without manually loading and unloading the "torture"
kernel module, could you please update the commit log to show that
smaller reproducer?

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
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  kernel/rcu/rcuscale.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 91fb5905a008..5e580cd08c58 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -522,6 +522,8 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
>  		 scale_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
>  }
>  
> +static void kfree_scale_cleanup(void);
> +

I do applaud minmimizing the size of the patch, but in this case could you
please pull the kfree_scale_cleanup() function ahead of its first use?

							Thanx, Paul

>  static void
>  rcu_scale_cleanup(void)
>  {
> @@ -542,6 +544,11 @@ rcu_scale_cleanup(void)
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
