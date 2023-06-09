Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052347296CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbjFIKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbjFIKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:25:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494108A6B;
        Fri,  9 Jun 2023 03:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 150BD65674;
        Fri,  9 Jun 2023 10:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89486C433EF;
        Fri,  9 Jun 2023 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686305735;
        bh=69i66ox8ltEgL7P8307OpSEFPOK7ge4DxS4uiN/dP78=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cg6IWFuxqv09zXT72fguVqtyCBgiTwtFNBa8tvGamnt4MY4ymz+ncSpIeKky8SqPv
         pW+TE/qUpmBjmEY6XQl+sPzBlcZjXD4NQRm+DdI14BFVhdnzZ4riUaMdpMmkbxGj1d
         XnXGKBC8R+qpA8CFqn1MXSahpTr4+P3M7/9sAyERl8JeRK2yf+Ve6qi00dNeuiyUiW
         pXqds5te6TQVBcuJYpR04MMRf1bt+Mtba/79ghQbLQirBu0NuOFqNe+syHsVFF4sbq
         Gx3W/R5cELcFGcm7taPUhLdAxcQSraloLhTlrtJJobj2+tuG6a+GfParBHAnneyuuF
         eEbfxTq8Bg7kg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath9k: Fix possible stall on ath9k_txq_list_has_key()
References: <20230609093744.1985-1-repk@triplefau.lt>
Date:   Fri, 09 Jun 2023 13:15:32 +0300
In-Reply-To: <20230609093744.1985-1-repk@triplefau.lt> (Remi Pommarel's
        message of "Fri, 9 Jun 2023 11:37:44 +0200")
Message-ID: <87sfb1gcvv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remi Pommarel <repk@triplefau.lt> writes:

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

Title is missing "wifi:" but I can add that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
