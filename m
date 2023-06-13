Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B41C72DD50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbjFMJJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbjFMJJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:09:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2235CE56;
        Tue, 13 Jun 2023 02:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8615462A54;
        Tue, 13 Jun 2023 09:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A86C433A4;
        Tue, 13 Jun 2023 09:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686647367;
        bh=lmsdLZ4+NmJAHzquqp88g7379ja7uZr6WmrjfGsBGaY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VxK1UOwMSki02GoK5Q2zQL4RLiT6eWHT44ODg7TG8RfKQYtpb6FctPCNfh5kccQPs
         38g5zxQiX8pZEt+tDKtf4WB/2PR+a3oeK3rY20HV+7X0zQqg+iMS2Uhy+bT8nRlLBL
         vdYB+7YQPpSiWx0nItT7QYWVOfi/ETpDq24fa8CpK5u6AAPTlkZ7Z6gFadj7UzscZF
         DHqHguU181ar9pFDQoDHlhdWEYdcuxvq1Xr0aVhO3Pgssob59KzGv9TPhsx8o+XP+G
         TIZ/P9UUSZfEVx1zbiNoa4nbIQylk/VkZ7+wP7ilNQcf0vgwbxSeRl/p3JdBTeOhri
         jFcEPfE5ZjSBQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath9k: Fix possible stall on ath9k_txq_list_has_key()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230609093744.1985-1-repk@triplefau.lt>
References: <20230609093744.1985-1-repk@triplefau.lt>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Jouni Malinen <jouni@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168664736276.2274.6813770604730278810.kvalo@kernel.org>
Date:   Tue, 13 Jun 2023 09:09:26 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remi Pommarel <repk@triplefau.lt> wrote:

> On EDMA capable hardware, ath9k_txq_list_has_key() can enter infinite
> loop if it is called while all txq_fifos have packets that use different
> key that the one we are looking for. Fix it by exiting the loop if all
> txq_fifos have been checked already.
> 
> Because this loop is called under spin_lock_bh() (see ath_txq_lock) it
> causes the following rcu stall:
> 
> rcu: INFO: rcu_sched self-detected stall on CPU
> ath10k_pci 0000:01:00.0: failed to read temperature -11
> rcu:    1-....: (5254 ticks this GP) idle=189/1/0x4000000000000002 softirq=8442983/8442984 fqs=2579
>         (t=5257 jiffies g=17983297 q=334)
> Task dump for CPU 1:
> task:hostapd         state:R  running task     stack:    0 pid:  297 ppid:   289 flags:0x0000000a
> Call trace:
>  dump_backtrace+0x0/0x170
>  show_stack+0x1c/0x24
>  sched_show_task+0x140/0x170
>  dump_cpu_task+0x48/0x54
>  rcu_dump_cpu_stacks+0xf0/0x134
>  rcu_sched_clock_irq+0x8d8/0x9fc
>  update_process_times+0xa0/0xec
>  tick_sched_timer+0x5c/0xd0
>  __hrtimer_run_queues+0x154/0x320
>  hrtimer_interrupt+0x120/0x2f0
>  arch_timer_handler_virt+0x38/0x44
>  handle_percpu_devid_irq+0x9c/0x1e0
>  handle_domain_irq+0x64/0x90
>  gic_handle_irq+0x78/0xb0
>  call_on_irq_stack+0x28/0x38
>  do_interrupt_handler+0x54/0x5c
>  el1_interrupt+0x2c/0x4c
>  el1h_64_irq_handler+0x14/0x1c
>  el1h_64_irq+0x74/0x78
>  ath9k_txq_has_key+0x1bc/0x250 [ath9k]
>  ath9k_set_key+0x1cc/0x3dc [ath9k]
>  drv_set_key+0x78/0x170
>  ieee80211_key_replace+0x564/0x6cc
>  ieee80211_key_link+0x174/0x220
>  ieee80211_add_key+0x11c/0x300
>  nl80211_new_key+0x12c/0x330
>  genl_family_rcv_msg_doit+0xbc/0x11c
>  genl_rcv_msg+0xd8/0x1c4
>  netlink_rcv_skb+0x40/0x100
>  genl_rcv+0x3c/0x50
>  netlink_unicast+0x1ec/0x2c0
>  netlink_sendmsg+0x198/0x3c0
>  ____sys_sendmsg+0x210/0x250
>  ___sys_sendmsg+0x78/0xc4
>  __sys_sendmsg+0x4c/0x90
>  __arm64_sys_sendmsg+0x28/0x30
>  invoke_syscall.constprop.0+0x60/0x100
>  do_el0_svc+0x48/0xd0
>  el0_svc+0x14/0x50
>  el0t_64_sync_handler+0xa8/0xb0
>  el0t_64_sync+0x158/0x15c
> 
> This rcu stall is hard to reproduce as is, but changing ATH_TXFIFO_DEPTH
> from 8 to 2 makes it reasonably easy to reproduce.
> 
> Fixes: ca2848022c12 ("ath9k: Postpone key cache entry deletion for TXQ frames reference it")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> Tested-by: Nicolas Escande <nico.escande@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

75086cc6dee0 wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230609093744.1985-1-repk@triplefau.lt/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

