Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A418767FC18
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjA2B2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjA2B2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:28:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC983EC
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 17:28:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EABF4B80C74
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B394C4339C
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674955677;
        bh=mIyF7jlWADkWw9AY8oz5e0Hg7GQ/xOB3nucuRUy5HDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ujw0AAvn3nhSz0pjY8obTtRU8u3SlS31u9V32QJI5IrFf7b8zy2BG74kDzvZWbnFI
         Bh2ok86s6aBmi34Fysi5RwdnRQ0KMepnzh7xS9x5RXv9ns79G6n4UHBcht5JazzJL6
         0TMGFQqeANrF5u1WdCtCtkAha6g+KnzFs3P6YAoaS9ctXUzvt/rva6oHOaRrKF5ljk
         V/nC/iP/3jNlJg1NkRfirmgv4y+0o+0SVmGIXPeUUzclrmQlLfYf0v1a2Az1afpCbS
         xSMg5xBaAAMf/mDQXm52WLBos3li9K2P92ZrWtg5dSG32kB4NHD2W8UTpj2IX8GG8m
         bCuq0IXMeW+rg==
Received: by mail-lf1-f49.google.com with SMTP id cf42so14118770lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 17:27:57 -0800 (PST)
X-Gm-Message-State: AFqh2kqNYDOPfo6MOeLWdeq5cGeqyRazYbyZvOg6E1ryjScAFcY4niEY
        1Vw/YGCXY3S41igBu5Y3fI6E+Lh1nAHe4yTzKQ==
X-Google-Smtp-Source: AMrXdXvwYhYIje9oY6RR+/yUIKdNsbwcgB8kH63XKH4ThRsuXe9Yblb+SgpYteGwcOABD+DQnVzUyfOpuQg1MQrqk+Q=
X-Received: by 2002:a05:6512:3f0c:b0:4b5:2aed:39be with SMTP id
 y12-20020a0565123f0c00b004b52aed39bemr5530009lfa.195.1674955675573; Sat, 28
 Jan 2023 17:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20221128-mtk-drm-v1-0-409e7f2352e4@chromium.org>
In-Reply-To: <20221128-mtk-drm-v1-0-409e7f2352e4@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 29 Jan 2023 09:27:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9=87WTtsYhjMKi+t8-ffu0FTw2vokzeVBOSsGsWCznjA@mail.gmail.com>
Message-ID: <CAAOTY_9=87WTtsYhjMKi+t8-ffu0FTw2vokzeVBOSsGsWCznjA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Implement shutdown
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ricardo:

Ricardo Ribalda <ribalda@chromium.org> =E6=96=BC 2022=E5=B9=B411=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:42=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Poweroff the device properly, otherwise the device will not come back
> from kexec().
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 91f58db5915f..51dbd85796e9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -829,6 +829,12 @@ static int mtk_drm_remove(struct platform_device *pd=
ev)
>         return 0;
>  }
>
> +static void mtk_drm_shutdown(struct platform_device *pdev)
> +{
> +       component_master_del(&pdev->dev, &mtk_drm_ops);
> +       pm_runtime_disable(&pdev->dev);
> +}

Would it be better to implement like rockchip [1]?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/gpu/drm/rockchip/rockchip_drm_drv.c?h=3Dv6.2-rc5#n462

Regards,
Chun-Kuang.

> +
>  static int mtk_drm_sys_prepare(struct device *dev)
>  {
>         struct mtk_drm_private *private =3D dev_get_drvdata(dev);
> @@ -856,6 +862,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops =3D {
>  static struct platform_driver mtk_drm_platform_driver =3D {
>         .probe  =3D mtk_drm_probe,
>         .remove =3D mtk_drm_remove,
> +       .shutdown =3D mtk_drm_shutdown,
>         .driver =3D {
>                 .name   =3D "mediatek-drm",
>                 .pm     =3D &mtk_drm_pm_ops,
>
> ---
> base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> change-id: 20221128-mtk-drm-ca6c5ac6b389
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
