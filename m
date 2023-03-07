Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0486ADA52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCGJ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCGJ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:27:56 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174763C21;
        Tue,  7 Mar 2023 01:27:54 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h8so13373586plf.10;
        Tue, 07 Mar 2023 01:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678181273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhS9WuvDVLCH/07BDFe4S3wnXC3MatfvUcLm7rOWzPU=;
        b=IIwvrYveZMftYjvctthjlBYZfsacrBWVljfA/5J0vr0PcgbCGnOfcnJRU27qrxTv93
         DyiWrvJX9sGIHdz5xjFCQ8fzBQB9qp0Z537ErAGFhX8eA1OBDHJBrRFR/iEqk9XbnCdy
         q078ee9CfLzrFWHGO29KJCwSa0PIXTWBDIDjhKQC+R1dWN77mXOxTSg5G6yEd3KQY7wn
         La9hh5KbolMEXhOodflYLfQTM2GQRnPGr9FQ36cT5QmW1+K2g2TU+kQdsIQBclodnJl4
         W/XVTYkxEvweelFcBWZaF8+KJKeByx1Zv4p8CjlvWmDBUJPFzqqHGIJgboaIqAOr1xwr
         h7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678181273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhS9WuvDVLCH/07BDFe4S3wnXC3MatfvUcLm7rOWzPU=;
        b=xp0cJmQexbElRNoqaTlaZ2ZVs7O7n1ov5jPa8B+HifOwa+a7uOzqdxD6WLsZruaJl7
         J6DQkxCyeiYOqnBUM44J/dEif6twF+nj+O8Z5F9PrxePsJRXoxcZDNGbOQS3yFvd24Ls
         RfzNiq1/v1d8tExVgWsYReY/JAcUmTDFQfMKCbCoeC86d5f7Pc0iEflEa+WjL7hwNpIu
         A6S3IJXHBCn5ytW1HPKahjzxK54jbfTMD4OSFp9zf4+J9yHlh2VA0z1T4JzDFjrV84uP
         B+aBWol3ErofVrNW1refbsEg3GmEuPrx6ELou7FUs6RYlGk+iW5CSO9qB6Co3tA78wao
         VstA==
X-Gm-Message-State: AO0yUKXj6tuMBSSPaTgMxWWxP4ZjeCzvj/mgNPQ91/JsagnUAUP7omeD
        ZxVXwlczQJLkPB4RL+EK15lua29GWBUCpOsJqIw=
X-Google-Smtp-Source: AK7set/cJsa7T6lRnhe3AOvYaVAEX3dOwNKizDvDRu5d9q0M5oZM2coLOWPB9DeQoaPW9yb4Q+CgVIpU3/LV3N7Km6k=
X-Received: by 2002:a17:902:ef92:b0:19a:8259:c754 with SMTP id
 iz18-20020a170902ef9200b0019a8259c754mr5338648plb.0.1678181273514; Tue, 07
 Mar 2023 01:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20230306062633.200427-1-zyytlz.wz@163.com>
In-Reply-To: <20230306062633.200427-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 7 Mar 2023 17:27:41 +0800
Message-ID: <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     mchehab@kernel.org, bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
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

Is there anyone who can help with this? I can provide more details
like invoking chain if needed.

Thanks,
Zheng

Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=80 14:28=E5=86=99=E9=81=93=EF=BC=9A
>
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> and mtk_jpeg_enc_device_run may be called to start the
> work.
> If we remove the module which will call mtk_jpeg_remove
> to make cleanup, there may be a unfinished work. The
> possible sequence is as follows, which will cause a
> typical UAF bug.
>
> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
>
> CPU0                  CPU1
>
>                     |mtk_jpeg_job_timeout_work
> mtk_jpeg_remove     |
>   v4l2_m2m_release  |
>     kfree(m2m_dev); |
>                     |
>                     | v4l2_m2m_get_curr_priv
>                     |   m2m_dev->curr_ctx //use
>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drive=
rs/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 969516a940ba..364513e7897e 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1793,7 +1793,7 @@ static int mtk_jpeg_probe(struct platform_device *p=
dev)
>  static int mtk_jpeg_remove(struct platform_device *pdev)
>  {
>         struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
> -
> +       cancel_delayed_work(&jpeg->job_timeout_work);
>         pm_runtime_disable(&pdev->dev);
>         video_unregister_device(jpeg->vdev);
>         v4l2_m2m_release(jpeg->m2m_dev);
> --
> 2.25.1
>
