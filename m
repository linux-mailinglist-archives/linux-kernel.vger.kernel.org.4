Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0C729A2F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbjFIMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFIMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:42:10 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787D1210A;
        Fri,  9 Jun 2023 05:42:08 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1686314526; bh=g2He+aQ5L5CX4e5+JLVtunRHUfon5Qp88QuHxQhHkGc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QEXvFYoyYeoQyiq4SyOChSBvyQmLxrg1ECZg2Lwos7aoynydD5g2lZY48v4Htzjla
         5zyusSXd5tRgwOAF8L0RUp1kLzIoF0599HUqsTnWMaLOlOd6af6kMdj+LEnYyGb5If
         XdT/K9xhRGU+zi/QtsNTPh7nCMcZ1nxWbRg52GZkeG0MNwaoZY/+78XHqW5eUcsQ2X
         yjpbwFsUWF9raPyG9jaSo5oc4sUmCjhzmttDMI7/Bwbw1RWdzGVG+zM7iQAodg5/Ls
         0qCS93TNAteMxNyN4KmCDWyB+bSo1Bi0HziPQYlAwQ7hf9W5JY0KcIPkjlauMo1E4G
         vasilfTdcVNeg==
To:     Remi Pommarel <repk@triplefau.lt>, Kalle Valo <kvalo@kernel.org>,
        Jouni Malinen <jouni@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] ath9k: Fix possible stall on ath9k_txq_list_has_key()
In-Reply-To: <20230609093744.1985-1-repk@triplefau.lt>
References: <20230609093744.1985-1-repk@triplefau.lt>
Date:   Fri, 09 Jun 2023 14:42:06 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y1kszu1t.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
> rcu:    1-....: (5254 ticks this GP) idle=3D189/1/0x4000000000000002 soft=
irq=3D8442983/8442984 fqs=3D2579
>         (t=3D5257 jiffies g=3D17983297 q=3D334)
> Task dump for CPU 1:
> task:hostapd         state:R  running task     stack:    0 pid:  297 ppid=
:   289 flags:0x0000000a
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
> Fixes: ca2848022c12 ("ath9k: Postpone key cache entry deletion for TXQ fr=
ames reference it")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Thank you for the fix!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
