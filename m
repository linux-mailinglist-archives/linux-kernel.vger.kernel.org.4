Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9559C733647
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbjFPQkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345746AbjFPQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4630F7;
        Fri, 16 Jun 2023 09:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7F5561199;
        Fri, 16 Jun 2023 16:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F667C433C8;
        Fri, 16 Jun 2023 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686933598;
        bh=5lp9R0UpiEghbdexmZmI868ZlYvLCJEZHcBjVpepDvc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Bvg+jSnZGpx9jp4smNXOVqIlbxuvLZ/GdiDF8Z6iaohr/oBUVjWAXZjp/N8YmzFJb
         98O3J+UrPCnzuvuXnRcBhOZFF4uBlJCDxYrW6uTIIbnr2rxd61tNNKe+svLNk/p/Z9
         4g0d23mIOpfgAziPnrxymjPqaI9+CbVwicVtjsKiUKgWKi+nf8/KmDy4TYr5WTgW+M
         OpE/C7d9q2JRuROPyyn1PcErTIn901m6QIttNW4DMEug+tO1U9vpGU6KIX4NOB5adk
         y5hn6MoN+0QVJOgB4Gno6It5i8YCV14Vtlk8Q/a1/Sg44muDs6I3I3Hv/X7166gmK+
         tFwFFb6FQMC8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8FBBCCE0BB2; Fri, 16 Jun 2023 09:39:57 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:39:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcuscale: Move schedule_timeout _uninterruptible to
 _idle in rcu_scale_writer()
Message-ID: <a05a940b-208b-4a06-b3fd-f8cb59bcab3f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230616073926.24462-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616073926.24462-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 03:39:26PM +0800, Zqiang wrote:
> The rcuscale.holdoff can be used to delay the start of rcu_scale_writer
> kthread, however, if the rcuscale.holdoff is set and the timeout is greater
> than the hung_task_timeout_secs, can trigger the hung-task timeout:
> 
> runqemu kvm nographic slirp qemuparams="-smp 4 -m 2048M"
> bootparams="rcuscale.shutdown=0 rcuscale.holdoff=300"
> 
> [  247.071753] INFO: task rcu_scale_write:59 blocked for more than 122 seconds.
> [  247.072529]       Not tainted 6.4.0-rc1-00134-gb9ed6de8d4ff #7
> [  247.073400] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  247.074331] task:rcu_scale_write state:D stack:30144 pid:59    ppid:2      flags:0x00004000
> [  247.075346] Call Trace:
> [  247.075660]  <TASK>
> [  247.075965]  __schedule+0x635/0x1280
> [  247.076448]  ? __pfx___schedule+0x10/0x10
> [  247.076967]  ? schedule_timeout+0x2dc/0x4d0
> [  247.077471]  ? __pfx_lock_release+0x10/0x10
> [  247.078018]  ? enqueue_timer+0xe2/0x220
> [  247.078522]  schedule+0x84/0x120
> [  247.078957]  schedule_timeout+0x2e1/0x4d0
> [  247.079447]  ? __pfx_schedule_timeout+0x10/0x10
> [  247.080032]  ? __pfx_rcu_scale_writer+0x10/0x10
> [  247.080591]  ? __pfx_process_timeout+0x10/0x10
> [  247.081163]  ? __pfx_sched_set_fifo_low+0x10/0x10
> [  247.081760]  ? __pfx_rcu_scale_writer+0x10/0x10
> [  247.082287]  rcu_scale_writer+0x6b1/0x7f0
> [  247.082773]  ? mark_held_locks+0x29/0xa0
> [  247.083252]  ? __pfx_rcu_scale_writer+0x10/0x10
> [  247.083865]  ? __pfx_rcu_scale_writer+0x10/0x10
> [  247.084412]  kthread+0x179/0x1c0
> [  247.084759]  ? __pfx_kthread+0x10/0x10
> [  247.085098]  ret_from_fork+0x2c/0x50
> [  247.085433]  </TASK>
> 
> This commit therefore replaces schedule_timeout_uninterruptible() with
> schedule_timeout_idle().
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index a0eae1900708..ffdb30495e3c 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -469,7 +469,7 @@ rcu_scale_writer(void *arg)
>  	sched_set_fifo_low(current);
>  
>  	if (holdoff)
> -		schedule_timeout_uninterruptible(holdoff * HZ);
> +		schedule_timeout_idle(holdoff * HZ);
>  
>  	/*
>  	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
> -- 
> 2.17.1
> 
