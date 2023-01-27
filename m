Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6A67DC8F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjA0DS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjA0DS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:18:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE26036FC0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33D69619E8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B73C433A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674789530;
        bh=yMqlqxCiTXbV0sP0tQtRNJGlz4yIWf+ozTmq0CkGlQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P6jgqiXM8BVBHL56uLfm1UkhlNvMqPIi/hT1o64MO9DXD1PjyMy8pGKoP0EDvnWrF
         1VLtOfjs68otRVoa8oq6ur8Ff3exwsg24OWOwiCEPfXYKBFtua/i+VrH+xWmOiB9aF
         4NGLqOzt6Alr2+NLlq7/sqSeltc8dPCcNYe77tp92UHdm6PN1EGePXpuG3+crZFGgY
         fC5+CuskVGFNu3UeErdf6CoNy47PZnl3gclDBaEclmEVJGEMbrl78lWRZ6oAqHhgIU
         d+gGOheYNK6AQWq8DT2ykPw+xxOzDk+eyRczvDwshqvZNXLWNslZno5FkWDJ9UzAt2
         TFWAaYxHgUcPw==
Received: by mail-lj1-f177.google.com with SMTP id e16so4180754ljn.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:18:50 -0800 (PST)
X-Gm-Message-State: AFqh2krNk2Z7ggjjMk2zES3W/+t5cMUfDLGbF8rDniOmqjtlQwda1Bng
        hrU2Z3nsYrnQ6gyZ/YSm3vppuRlvALZ5YH4NRA==
X-Google-Smtp-Source: AMrXdXuKl/XfTZtyJDk7sSww33tWah9JPd78aB+WMh0SYqRDti1pFGSaFGG6NZv1jxA2fNc7q0W0F+cePoApqEB7OBM=
X-Received: by 2002:a2e:82cf:0:b0:28b:bde3:7871 with SMTP id
 n15-20020a2e82cf000000b0028bbde37871mr1699213ljh.269.1674789528603; Thu, 26
 Jan 2023 19:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20230119231255.2883365-1-robdclark@gmail.com>
In-Reply-To: <20230119231255.2883365-1-robdclark@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 27 Jan 2023 11:18:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY_81bQaU0CqavppEuXk9ZCr_V136KU_NURTGfmszz38FwQ@mail.gmail.com>
Message-ID: <CAAOTY_81bQaU0CqavppEuXk9ZCr_V136KU_NURTGfmszz38FwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Drop unbalanced obj unref
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Mao Huang <littlecvr@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        "moderated list:DRM DRIVERS FOR MEDIATEK" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
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

Hi, Rob:

Rob Clark <robdclark@gmail.com> =E6=96=BC 2023=E5=B9=B41=E6=9C=8820=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Rob Clark <robdclark@chromium.org>
>
> In the error path, mtk_drm_gem_object_mmap() is dropping an obj
> reference that it doesn't own.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/med=
iatek/mtk_drm_gem.c
> index 9b3d15d3a983..f961c7c7456b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -169,8 +169,6 @@ static int mtk_drm_gem_object_mmap(struct drm_gem_obj=
ect *obj,
>
>         ret =3D dma_mmap_attrs(priv->dma_dev, vma, mtk_gem->cookie,
>                              mtk_gem->dma_addr, obj->size, mtk_gem->dma_a=
ttrs);
> -       if (ret)
> -               drm_gem_vm_close(vma);
>
>         return ret;
>  }
> --
> 2.38.1
>
