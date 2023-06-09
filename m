Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68FB7296C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbjFIKYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbjFIKXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:23:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8983D5;
        Fri,  9 Jun 2023 03:14:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f61530506aso15954745e9.1;
        Fri, 09 Jun 2023 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686305679; x=1688897679;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4w797wispCQIvC1+I191yIlxN8vu+W70vn1IehhZLk=;
        b=Ivrc3ZX4qYJ6ptP2qfaWCzgYDY0FcK4PjynEUT5H6p1ZmYda4MfKG45lNxBRgVFf/4
         4P44paMMKpv4PRGMcFmImdPnpkWcAGGwHeX19pj1M4JKGSPcIQzcZGdBxE97z1JWKR70
         t4ibY7GDC6UuCiFZWC1Eo6aRYhXs7MI7NUZrJiEZM1aoTBemz0JtWCZrZuqO4Gnk61Fo
         N1cR+5a+3bRLYiDVqSLT3Xt8HAS9JwvHAvCw8oStp56p7JY1BAkqCCoprrBhBziVrLvk
         84APqVCmV03im6mlOP9kpgFfe11KgsWX4WvV9Gf+H+Q+G/B521skQsNKsTKkrfj9FcAf
         AiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686305679; x=1688897679;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S4w797wispCQIvC1+I191yIlxN8vu+W70vn1IehhZLk=;
        b=eC6dHMVStFZagZJ0EAGSK1g8RvaCoFk5f7cWNbHu557KlwXsm+U30QPgggn1Tn3WGZ
         +nf77xL2dTvNh9N7OTPoWmXBQNSDITWR8GxIg4/cbc7OhnvW84mY2HvmN52XeEvl0qq2
         4qhEjrflk29Cz35F/9npAYw6qjXxZMhAahXa54NWG4BOUVfiNvgrkRnPA4YQSb7/3esT
         W4PDhoeOqQr95H0bNNmJZV1r/MGAmVa4htljoLwKGA23eTjScCv813KJF6977cB5/AY1
         GpW5LWos8W+intjCpHLB16DKo5N7chCAMUDT1K9HHX0JZtEFEeMDgOoFC4sfVxc2866M
         T4aw==
X-Gm-Message-State: AC+VfDyII+jn/1nhlRvWY9FxLUt5IcxfoWvuQS+MJhSQjziEnqTg7At8
        vNRy4z7U1Tuh6VY0laejOMM=
X-Google-Smtp-Source: ACHHUZ7o5LyWmK1syHp15DLngMz8RBlouRr4Yt8JP7cr+FGnQs7cIrbH4zikm6Yy1VhKpl3F3ZKobw==
X-Received: by 2002:a7b:ce8c:0:b0:3f1:789d:ad32 with SMTP id q12-20020a7bce8c000000b003f1789dad32mr776146wmj.11.1686305679340;
        Fri, 09 Jun 2023 03:14:39 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id m6-20020adfdc46000000b0030e5bd253aasm4049044wrj.39.2023.06.09.03.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 03:14:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 12:14:38 +0200
Message-Id: <CT81H24H03PE.33SAJUIJQMY90@syracuse>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath9k: Fix possible stall on ath9k_txq_list_has_key()
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     "Remi Pommarel" <repk@triplefau.lt>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "Kalle Valo" <kvalo@kernel.org>,
        "Jouni Malinen" <jouni@codeaurora.org>
X-Mailer: aerc 0.15.1
References: <20230609093744.1985-1-repk@triplefau.lt>
In-Reply-To: <20230609093744.1985-1-repk@triplefau.lt>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 9, 2023 at 11:37 AM CEST, Remi Pommarel wrote:
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
> ---
>  drivers/net/wireless/ath/ath9k/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless=
/ath/ath9k/main.c
> index a4197c14f0a9..7f9f06ea8a05 100644
> --- a/drivers/net/wireless/ath/ath9k/main.c
> +++ b/drivers/net/wireless/ath/ath9k/main.c
> @@ -850,7 +850,7 @@ static bool ath9k_txq_list_has_key(struct list_head *=
txq_list, u32 keyix)
>  static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
>  {
>  	struct ath_hw *ah =3D sc->sc_ah;
> -	int i;
> +	int i, j;
>  	struct ath_txq *txq;
>  	bool key_in_use =3D false;
> =20
> @@ -868,8 +868,9 @@ static bool ath9k_txq_has_key(struct ath_softc *sc, u=
32 keyix)
>  		if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA) {
>  			int idx =3D txq->txq_tailidx;
> =20
> -			while (!key_in_use &&
> -			       !list_empty(&txq->txq_fifo[idx])) {
> +			for (j =3D 0; !key_in_use &&
> +			     !list_empty(&txq->txq_fifo[idx]) &&
> +			     j < ATH_TXFIFO_DEPTH; j++) {
>  				key_in_use =3D ath9k_txq_list_has_key(
>  					&txq->txq_fifo[idx], keyix);
>  				INCR(idx, ATH_TXFIFO_DEPTH);

Works with AR9392 (Qualcomm Atheros AR93xx Wireless Network Adapter (rev 01=
))

Tested-by: Nicolas Escande <nico.escande@gmail.com>

---
Nicolas E.
