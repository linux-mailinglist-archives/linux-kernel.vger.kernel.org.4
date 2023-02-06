Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD568BC2D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjBFL6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBFL6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:58:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB50E12F28;
        Mon,  6 Feb 2023 03:58:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r3so1654445edq.13;
        Mon, 06 Feb 2023 03:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ppxjTfPrt+fO380TECKEc+9j8f0qNsSPRjIV/2FlqhQ=;
        b=aDm4q22FFAJMiLL7psWLsdmiCHHEWeaqe9df4Cj2D05wF/rp53Il86syfJA1cqw67v
         HUOvdu1YcgM4SPClp8Dd2doiCfEznIjnrbzAqn82morUSGeNbGooGE9blGu0FeFs+gEE
         7C3zyIBGTzIdj2oEZWCS/ncOj6bKDeXn6VU6W4JdYX/vP6w3pMnjyLdXUV0DCklJxq2i
         mLc3nyKE4ZwMaVsPqIPEcEldIKluga7OBFj21jfHwkzJJFOYhCl41bMQTcJbpPYdRfsY
         +otpM+3upWgko7msDXMRnG/EHjeNvmzBNYgrT8P5Z/2kPKEpdDUJZBmNn9TP3swBwqI0
         yovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppxjTfPrt+fO380TECKEc+9j8f0qNsSPRjIV/2FlqhQ=;
        b=ukBcN+91KNb46B82Emjl3KNpUG8g4QRMIM2rGZKAhn1X3KB/BJbIUwaPqTaLqbtznS
         2Hi9eQyX2o19kAGKN/m2mUDSCvgo+mvz4TwARFR2SCaAREnMKZQbKcaLSi/fYGfwoJsj
         gMfIwo7dloZUBOnUNmYbV0Y3t3rYZolN8ukrFi+ZtUlYxu7ZfMjyUuGLHl+L2fSPVpfU
         2xkSoedXqrqP5Z+hhjJgqNUeqoQ3hHiugSZpF4ogvVOK8z5HSKYjzU+xirqGRo2PLrTa
         vh/v3GIai+FM9ziTD6V2/3LHYU5g4QBX721jXikdi5SEDONgvmM8R0DEugYIWpqfI+Z6
         ZTLQ==
X-Gm-Message-State: AO0yUKVPQ0AAPqtmJkzAtPmtorTw2fbOdz5s+1V/mDu7uEBHq2X+ZX4B
        MhkhCXHuXI95ol7tijfPGoAvSZem/H8hcSWCFOFrZcAyj/o=
X-Google-Smtp-Source: AK7set8dT1GLWLBBhtdwxzc0ZvOt+xNblBgmSsJtrdZ2/k4U93LHXST34508M3qaGnCip1/HHUWhGEzFRzwQ5P5nDX0=
X-Received: by 2002:a50:d71b:0:b0:4aa:ab5b:99e7 with SMTP id
 t27-20020a50d71b000000b004aaab5b99e7mr10418edi.0.1675684725237; Mon, 06 Feb
 2023 03:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20230203141515.125205-1-n.petrova@fintech.ru>
In-Reply-To: <20230203141515.125205-1-n.petrova@fintech.ru>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 6 Feb 2023 12:58:33 +0100
Message-ID: <CAOi1vP_7Oaw8O-p2X1xymzym1Xf_RZeN0u=SeE4Zbc2y+AfgYA@mail.gmail.com>
Subject: Re: [PATCH] rbd: avoid double free memory on error path in rbd_dev_create()
To:     Natalia Petrova <n.petrova@fintech.ru>
Cc:     Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
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

On Fri, Feb 3, 2023 at 3:15 PM Natalia Petrova <n.petrova@fintech.ru> wrote:
>
> If rbd_dev_create() fails after assignment 'opts' to 'rbd_dev->opts',
> double free of 'rbd_options' happens:
> one is in rbd_dev_free() and another one is in do_rbd_add().
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1643dfa4c2c8 ("rbd: introduce a per-device ordered workqueue")
> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 04453f4a319c..ab6bfc352cde 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5357,7 +5357,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>         if (!rbd_dev)
>                 return NULL;
>
> -       rbd_dev->opts = opts;
>
>         /* get an id and fill in device name */
>         rbd_dev->dev_id = ida_simple_get(&rbd_dev_id_ida, 0,
> @@ -5372,6 +5371,7 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>         if (!rbd_dev->task_wq)
>                 goto fail_dev_id;
>
> +       rbd_dev->opts = opts;
>         /* we have a ref from do_rbd_add() */
>         __module_get(THIS_MODULE);
>
> --
> 2.34.1
>

Hi Natalia,

It seems like a similar issue is affecting rbd_dev->rbd_client and
rbd_dev->spec.  Unlike rbd_dev->opts, they are ref-counted and I'm
guessing that the verification tool doesn't go that deep.

I'd prefer all three to be addressed in the same change, since it's the
same error path.  Would you be willing to look into that and post a new
revision or should I treat just this patch as a bug report?

Thanks,

                Ilya
