Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7767E924
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjA0PMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjA0PMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:12:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB6884FBF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:12:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53417CE28C1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEBBC433A4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674832338;
        bh=XEGrj08mrGc6T/CEgbRHQGd2YGIb4XomZMq/krxPioc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NE7iOLypBK0VcyoXe938Wrub/Dw5KzL7dSr6El5xLMjFDdDwRIPzcnb+RnFl1DtR4
         zGKUbwkZUSDBwoNhnLnciBA2uFF3bwTK1gnIasFfpIKr/mtB4yhOjWYYnOTsRZT5Jp
         1o+734IVEyh++hTgc3TLwfQv34XrT54Ip0EG8+3tetxKa4A359ip3Ehvu7DMyVqjWh
         4r7bfZr3KRlXZHsFJm47FxEOMa0EkDWPOBS/DB8Tig1jfugQ814tNJDL2x7s3zbC+K
         lLG0wk7i3F7AJlWLNjiOJV3nzAa+Wqrcg2t110cjECkctz+1+EyjVYeM/ggu2PUuCN
         hjnKH0Nwe32EQ==
Received: by mail-lf1-f41.google.com with SMTP id bp15so8571490lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:12:18 -0800 (PST)
X-Gm-Message-State: AFqh2koCYOpxsxyCMTCgiVDqdNO5hShD2HFRHcONJDy8EDdgkXkC377p
        6y3BMNZpY3JOt49pVPug+ivy0ZJ4Z25cTg5qxA==
X-Google-Smtp-Source: AMrXdXsMmkgRBQo0TFynmEJqLTZw81aRoOnst7MOnAoZNQlO8IkeJrvkMJCE/StM8437PfU6MBsslI61mZGCWtvv18g=
X-Received: by 2002:a05:6512:1043:b0:4ca:f9e4:c410 with SMTP id
 c3-20020a056512104300b004caf9e4c410mr2228287lfb.97.1674832336570; Fri, 27 Jan
 2023 07:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20221122143949.3493104-1-nfraprado@collabora.com>
In-Reply-To: <20221122143949.3493104-1-nfraprado@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 27 Jan 2023 23:12:04 +0800
X-Gmail-Original-Message-ID: <CAAOTY__oFQ8DyAbdCyQEGAw7tFi+6AONiOHZxu_qJhT9MHNpoQ@mail.gmail.com>
Message-ID: <CAAOTY__oFQ8DyAbdCyQEGAw7tFi+6AONiOHZxu_qJhT9MHNpoQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Clean dangling pointer on bind error path
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>, kernel@collabora.com,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Mao Huang <littlecvr@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
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

Hi, Nicolas:

N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> =E6=96=BC 2022=E5=B9=
=B411=E6=9C=8822=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:39=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> mtk_drm_bind() can fail, in which case drm_dev_put() is called,
> destroying the drm_device object. However a pointer to it was still
> being held in the private object, and that pointer would be passed along
> to DRM in mtk_drm_sys_prepare() if a suspend were triggered at that
> point, resulting in a panic. Clean the pointer when destroying the
> object in the error path to prevent this from happening.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
> Changes in v2:
> - Added Fixes tag
>
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 39a42dc8fb85..a21ff1b3258c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -514,6 +514,7 @@ static int mtk_drm_bind(struct device *dev)
>  err_deinit:
>         mtk_drm_kms_deinit(drm);
>  err_free:
> +       private->drm =3D NULL;
>         drm_dev_put(drm);
>         return ret;
>  }
> --
> 2.38.1
>
