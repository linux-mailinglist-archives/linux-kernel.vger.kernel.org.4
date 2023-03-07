Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC06AE544
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCGPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjCGPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:45:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C6B8C599;
        Tue,  7 Mar 2023 07:45:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l1so13623269pjt.2;
        Tue, 07 Mar 2023 07:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678203944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cVcU6vf3P7tWIhm0kR1cSYxiLWDb4NZaw72d9YIG+c=;
        b=MAJbiaw/YQxz2rySEgttJx/i+zXTARQZ5RSihtSZwrSmfkqXLt2RosawTii4vCT9Wo
         2+Hb9ZC0rkVVlk04Ej6eexSFRnBBwaZSsGBTt25QEz8mtERoxzWtV/Hn7lIC2JnSnZMV
         nPU/rjGcFD6fM9I3dj8XpNCF/OAx/Yl+YzxFg6zLgtHO97RmayDltOqZLedIajlCbDKQ
         xAUhIZh8fphkbv+ENlyexWDzr8CmgQ3vSK2wXNdLlRBPOS1V9JzmkhhVf2Y+kD+V6hkZ
         gVV4rZmjgu9wCMunP45jyZ4knPqu7QnnVklG8kGseQYxcKYP8QH0KvWcpvxJDSI4eiTF
         ueIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cVcU6vf3P7tWIhm0kR1cSYxiLWDb4NZaw72d9YIG+c=;
        b=FNA24wOOaaQx70nifYVpFwZCHNo/zlUyzRt7j3FWW3/Kkd3jcG55FbPhTFRwztFJ0X
         lLFMUQAei2ZiHVXyKISbsF0Ah1ztajBPkvsrogYZ4pXfOJOMPMJKYTlEuqQ9FNIe152y
         iAQdmw8hqXVZ9XetDMgKjlCCOqwg9kktbHVzDn5QjROpDHwcOZDlcOqmjYnPWpnPdoiN
         Ra6PztnZ29zNCv6969dd1pbkSZFWegeW7jurv7KXL/+GYreYitqyJTrhSz1fsx6pQrN6
         hZcQo6myWHZ6WTVHbKJbIsZPRPfPXTkmZnaMSjX6kWVAIAyi+Yn1A/6VWcupOBJmc/bu
         CFpg==
X-Gm-Message-State: AO0yUKUk0Kqpbb5qC1t0PJ2ldnTegBHbeDF5lX3tAr0z4B71IuM6yCmW
        OV27ifjbnL3AHTgTua1jHReuQUMZf/A9yRmvP+8=
X-Google-Smtp-Source: AK7set/r9LOOqLZZ3FGrgI738xX+9fXxQSSUCeyv2SmEXVuf0zQ3G39Cr1UPfWdgTiJmA/aTP2anc3Kisdhg7Gj6XBI=
X-Received: by 2002:a17:903:2c1:b0:19c:d414:fe6e with SMTP id
 s1-20020a17090302c100b0019cd414fe6emr5734357plk.12.1678203944402; Tue, 07 Mar
 2023 07:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20230307154157.1184826-1-zyytlz.wz@163.com>
In-Reply-To: <20230307154157.1184826-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 7 Mar 2023 23:45:33 +0800
Message-ID: <CAJedcCwMDyM6rwNNJq1OL=UxUy2e0yH9RxJNmuJWS3k7zkYRvQ@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: fix use after free bug in hantro_remove
 due to race condition
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch just fix the race condition in hantro_remove. All of the
analysis is made by static analysis.
So it may be false positives.
Please feel free to let me know if there is something I've missed.

Regards,
Zheng

Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=887=E6=97=A5=
=E5=91=A8=E4=BA=8C 23:43=E5=86=99=E9=81=93=EF=BC=9A
>
> In hantro_probe, vpu->watchdog_work is bound with
> hantro_watchdog. Then hantro_end_prepare_run may
> be called to start the work.
>
> If we close the file or remove the module which will
> call hantro_release and hantro_remove to make cleanup,
> there may be a unfinished work. The possible sequence
> is as follows, which will cause a typical UAF bug.
>
> The same thing will happen in hantro_release, and use
> ctx after freeing it.
>
> Fix it by canceling the work before cleanup in hantro_release.
>
> CPU0                  CPU1
>
>                     |hantro_watchdog
> hantro_remove     |
>   v4l2_m2m_release  |
>     kfree(m2m_dev); |
>                     |
>                     | v4l2_m2m_get_curr_priv
>                     |   m2m_dev->curr_ctx //use
>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index b0aeedae7b65..80bd856a4da9 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -1099,6 +1099,7 @@ static int hantro_remove(struct platform_device *pd=
ev)
>
>         v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
>
> +       cancel_delayed_work(&vpu->watchdog_work);
>         media_device_unregister(&vpu->mdev);
>         hantro_remove_dec_func(vpu);
>         hantro_remove_enc_func(vpu);
> --
> 2.25.1
>
