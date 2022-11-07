Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63761FDE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiKGSuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiKGSuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:50:03 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6705B20BD3;
        Mon,  7 Nov 2022 10:50:02 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g12so18020810lfh.3;
        Mon, 07 Nov 2022 10:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qSRge+cZPqxzE/HXN6r0QoczBK8JIfjd/QYAWnu+7PY=;
        b=XzWANFxDDrK21Vx9+epjiWYQQxEWgy/O55HY2mIlzQi5DIAjkeA+wXQ3Y0Zs4lZSP4
         EbSpMR7wzMYLqmkSvWmuujVE4nlQ0MoExAlSQxg0dAXnHz0lgFxpkuxVEcb8almi3vfl
         P+FRw6MzZxy/9zNQRc2uDzxB/TbW6z+6GdCtdE5ufqnqusOi6wzcQNoFHs1NW5lIClmG
         sCIJ5L0PJreEyMTxdsJiz3EvPli6iatzGapjuKTuW3/B5TMt5SJNzr3w8W5tFm1tMEYk
         omhT0HM7NN5MGGkV4ErmB6tB3bIIjy/+U20VlBvAoFdaWmaZ75ZqE/4dioBn7krFIfdT
         8g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSRge+cZPqxzE/HXN6r0QoczBK8JIfjd/QYAWnu+7PY=;
        b=5nfx4u5xAhVPyAp1enPt9WQ8zHLzLZEFxwxokZtirR6uMKBf026IEzld/oAoTDJt9W
         pNbWSW8lPtUdSc75J5QRLPXOoDQn0KjBuM1f/KL4ZdgIwzirNxmEIsezT8177axPK+jg
         dj7qlGGnNY9iozPRi5vxa2+IFI56wDoASwP438qHgDU69CqlwfUPqhcNcJ8CktmkB983
         qvG+Y5xk0Z5YjI272KJ/Ew8OMTvf1FSNlv0c5p8NL1U7ihkqC2c+gChjG/rNcpWx4V1f
         cISvo/48bawzwrHngfnX87Y8+1XMPGuh+DLfrCV28TYgB8+Q7ZOv8eBbVsWXz/P7H3Dn
         rwRQ==
X-Gm-Message-State: ACrzQf3aBZ0Sd2FXwNcrFumdruCSbHXH3NEljj7YgXnGScZS9cR7BF3y
        gWvZ5kYKBR82+FbMo0mo7+pDJY9hx7d10YY4+FaqIE2B9PU=
X-Google-Smtp-Source: AMsMyM4LIJdrcjbPnEk6kuDtYSnV2NSHcp6vJdlZgviMDBomkWirIFbhTWp99oyCHAab3LQ4HTwwkHaoTOcrtvGNjXc=
X-Received: by 2002:a05:6512:3f2a:b0:4ae:612b:f47b with SMTP id
 y42-20020a0565123f2a00b004ae612bf47bmr17315176lfa.106.1667847000552; Mon, 07
 Nov 2022 10:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20221105190446.1324053-1-syoshida@redhat.com>
In-Reply-To: <20221105190446.1324053-1-syoshida@redhat.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Nov 2022 10:49:48 -0800
Message-ID: <CABBYNZLqk_4Xz3RuSq_cEhvyTG+Qz1icVKjvKunufCLLXhh_zg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix use-after-free read in hci_cmd_timeout()
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+19a9f729f05272857487@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shigeru,

On Sat, Nov 5, 2022 at 12:04 PM Shigeru Yoshida <syoshida@redhat.com> wrote:
>
> syzbot reported use-after-free in hci_cmd_timeout() [1].  The scenario
> for the issue is as follows:
>
> Task                                    Workqueue
> ----------------------------------------------------------------------
> hci_dev_open_sync
>   ...
>   hci_dev_init_sync  <- failed
>   ...
>   if (hdev->sent_cmd)
>     kfree_skb(hdev->sent_cmd)
>                                         hci_cmd_timeout
>                                           ...
>                                           if (hdev->sent_cmd)
>                                             sent = hdev->sent_cmd->data
>                                                    ^^ UAF occurred
>     hdev->sent_cmd = NULL
>
> When hci_dev_init_sync() failed, hci_dev_open_sync() frees
> hdev->send_cmd and set it to NULL.  However, hci_cmd_timeout() can run
> just after freeing hdev->sent_cmd because hdev->cmd_timer is not
> canceled.
>
> This patch fixes the issue by canceling hdev->cmd_timer before freeing
> hdev->sent_cmd.
>
> Link: https://syzkaller.appspot.com/bug?id=cb23ebfc8f304f510fb717cb783fe8b496c7ffb1 [1]
> Reported-by: syzbot+19a9f729f05272857487@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/bluetooth/hci_sync.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 76c3107c9f91..a011065220e4 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4696,6 +4696,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
>                         hdev->flush(hdev);
>
>                 if (hdev->sent_cmd) {
> +                       cancel_delayed_work_sync(&hdev->cmd_timer);
>                         kfree_skb(hdev->sent_cmd);
>                         hdev->sent_cmd = NULL;
>                 }
> --
> 2.38.1

A similar fix has already been applied:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=64b5c4c8e79c131fe8f135bab5e5dfaa245c5776


-- 
Luiz Augusto von Dentz
