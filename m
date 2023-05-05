Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3196F7F73
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjEEI5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEEI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7306E13C22;
        Fri,  5 May 2023 01:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06B0761212;
        Fri,  5 May 2023 08:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A4CC433D2;
        Fri,  5 May 2023 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683277065;
        bh=i5q4WohYE0g9LUCRH2pDqZUtOvfmz1IOwB04BZJnsC0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=f3W8bMfOAJWexMq4CAgvuzWOD6FZjYD8Ovsf30k/sXsggEnylsg9oNdncJ/EgCD61
         zYvQdZp2+RIbi2fTr54XnP9fP98uHb0Ju5GAtMimSNXikpMYFugMFeZGqzkjD8jPP1
         m30AFRRlaUE/7ZCDbESc+x5FneaUnLaTg9Lg+bZvYFpRMKWeh2L2T1VkuDETqXKHnG
         XJQTD38iEG4R7pAHM9BCtrosss5nkUOR+puE90XTzaTHsjYmEg7ONfOl51X3XpREWn
         22FzFbCyGQ9BkKDmz03MMUckK40EkBf+sCRCk5zrzQQuhH/IwmIMrxSuMVDzfmFLDo
         vtlkwV0Cg1xvA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Takeshi Misawa <jeantsuru.cumc.mandola@gmail.com>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vasanthakumar Thiagarajan <vasanth@atheros.com>,
        Sujith <Sujith.Manoharan@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Senthil Balasubramanian <senthilkumar@atheros.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net] Fix memory leak in htc_connect_service
References: <ZFTEkCsFcEa44CN8@DESKTOP>
Date:   Fri, 05 May 2023 11:57:39 +0300
In-Reply-To: <ZFTEkCsFcEa44CN8@DESKTOP> (Takeshi Misawa's message of "Fri, 5
        May 2023 17:55:44 +0900")
Message-ID: <87fs8bp33w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takeshi Misawa <jeantsuru.cumc.mandola@gmail.com> writes:

> Timeout occurs in htc_connect_service(), then this function returns
> without freeing skb.
>
> Fix this by going to err path.
>
> syzbot report:
> https://syzkaller.appspot.com/bug?id=fbf138952d6c1115ba7d797cf7d56f6935184e3f
> BUG: memory leak
> unreferenced object 0xffff88810a980800 (size 240):
>   comm "kworker/1:1", pid 24, jiffies 4294947427 (age 16.220s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff83b971c6>] __alloc_skb+0x206/0x270 net/core/skbuff.c:552
>     [<ffffffff82eb3731>] alloc_skb include/linux/skbuff.h:1270 [inline]
>     [<ffffffff82eb3731>] htc_connect_service+0x121/0x230 drivers/net/wireless/ath/ath9k/htc_hst.c:259
>     [<ffffffff82ec03a5>] ath9k_htc_connect_svc drivers/net/wireless/ath/ath9k/htc_drv_init.c:137 [inline]
>     [<ffffffff82ec03a5>] ath9k_init_htc_services.constprop.0+0xe5/0x390 drivers/net/wireless/ath/ath9k/htc_drv_init.c:157
>     [<ffffffff82ec0747>] ath9k_htc_probe_device+0xf7/0x8a0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:959
>     [<ffffffff82eb3ef5>] ath9k_htc_hw_init+0x35/0x60 drivers/net/wireless/ath/ath9k/htc_hst.c:521
>     [<ffffffff82eb68dd>] ath9k_hif_usb_firmware_cb+0xcd/0x1f0 drivers/net/wireless/ath/ath9k/hif_usb.c:1243
>     [<ffffffff82aa835b>] request_firmware_work_func+0x4b/0x90 drivers/base/firmware_loader/main.c:1107
>     [<ffffffff8129a35a>] process_one_work+0x2ba/0x5f0 kernel/workqueue.c:2289
>     [<ffffffff8129ac7d>] worker_thread+0x5d/0x5b0 kernel/workqueue.c:2436
>     [<ffffffff812a4fa9>] kthread+0x129/0x170 kernel/kthread.c:376
>     [<ffffffff81002dcf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Reported-and-tested-by: syzbot+b68fbebe56d8362907e8@syzkaller.appspotmail.com
> Signed-off-by: Takeshi Misawa <jeantsuru.cumc.mandola@gmail.com>
> ---
>  drivers/net/wireless/ath/ath9k/htc_hst.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

The title should begin with "wifi: ath9k:", see more info from the wiki
link below.

Also ath9k patches go to ath-next, not to the net tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
