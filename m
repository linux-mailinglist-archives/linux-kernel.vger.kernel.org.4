Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E608C5BC47C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiISIlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiISIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:41:05 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89BD11A2F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:41:00 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 63so160400ybq.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=EMEe3EnrmTz4VXJwt3zNe2mWyBL9jqG4mEETorWmETg=;
        b=SoyqYVokxMm1uUEputqTB5NtFHq2AOYVphA3SiugU5Db88W1jAKad2wuq+xMWhwTie
         61GIwvjPhTrBhQacCpgFH7SI7SMmwzrSZ3qrkGOMSYTfu1XdCjF/o14QjtFup/T3p+OZ
         rValRdjjh5dz7Oh8DNgTLxaSEzUa2tfJncXvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EMEe3EnrmTz4VXJwt3zNe2mWyBL9jqG4mEETorWmETg=;
        b=bPtAX/pcKJx2VEBBhAEPtZUByMWvtHQcpTf5A/TIgSwYDYSIulyDENJKC1WCZ7hTjG
         Xsa7Oe9ufMpW8+eUK+q+Fpszwwra4w6Cw7pM6f8wOqi7Cse7Qc3YYwKDJo50yPo+Dt4Y
         Mwxfy94Cuso7GA/ob7yg1D4hwU9r4KmOb6LxMNtNYALOh83YHV3HNmTPrf5BLB72mKGz
         qCFqbCGbi6ggI7wi4VvTed5qg/ICElG4hD0alp71mF3nYt5ZylLrwtwRe8NDQWWzPW7A
         oP16ZasCNw+eAKpVtH1gsFG2TGH3ikjZEHRpSXh+1KKjD2f4m7bQ0B2BHz1BcJDsFPeU
         PGyA==
X-Gm-Message-State: ACrzQf1NcoUCTLvsrnyRYKuBpaCamhFXzOUoxwr56NwAbDft2Jdwpeqo
        6bfgnMo2PLhfyN/ifQFyWukfbnb5z1cYz6CyttS28w==
X-Google-Smtp-Source: AMsMyM67MXm/lQa1tGGwV3xRvrukDuk9G5nv3c5F7slxubnSc3M0kXcOawAQvsxcSxx7dCi+CFAeJs1NlPue8RXoIMI=
X-Received: by 2002:a05:6902:1202:b0:6ae:4d4e:f7ea with SMTP id
 s2-20020a056902120200b006ae4d4ef7eamr14310764ybu.393.1663576860104; Mon, 19
 Sep 2022 01:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220804194325.1596554-1-nfraprado@collabora.com>
In-Reply-To: <20220804194325.1596554-1-nfraprado@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 19 Sep 2022 16:40:34 +0800
Message-ID: <CAJMQK-hOxxvkjgOxA6KLLUJxxBehHDQvRo-Y_FLMPLEfkoVMzA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Move mtk_dsi_stop() call back to mtk_dsi_poweroff()
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 4:39 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> As the comment right before the mtk_dsi_stop() call advises,
> mtk_dsi_stop() should only be called after
> mtk_drm_crtc_atomic_disable(). That's because that function calls
> drm_crtc_wait_one_vblank(), which requires the vblank irq to be enabled.
>
> Previously mtk_dsi_stop(), being in mtk_dsi_poweroff() and guarded by a
> refcount, would only be called at the end of
> mtk_drm_crtc_atomic_disable(), through the call to mtk_crtc_ddp_hw_fini()=
.
> Commit cde7e2e35c28 ("drm/mediatek: Separate poweron/poweroff from
> enable/disable and define new funcs") moved the mtk_dsi_stop() call to
> mtk_output_dsi_disable(), causing it to be called before
> mtk_drm_crtc_atomic_disable(), and consequently generating vblank
> timeout warnings during suspend.
>
> Move the mtk_dsi_stop() call back to mtk_dsi_poweroff() so that we have
> a working vblank irq during mtk_drm_crtc_atomic_disable() and stop
> getting vblank timeout warnings.
>
> Fixes: cde7e2e35c28 ("drm/mediatek: Separate poweron/poweroff from enable=
/disable and define new funcs")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested on mt8183 jacuzzi and mt8186 that this patch fixes the vblank warnin=
g.

> ---
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 9cc406e1eee1..f8ad59771551 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -685,6 +685,16 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>         if (--dsi->refcount !=3D 0)
>                 return;
>
> +       /*
> +        * mtk_dsi_stop() and mtk_dsi_start() is asymmetric, since
> +        * mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disa=
ble(),
> +        * which needs irq for vblank, and mtk_dsi_stop() will disable ir=
q.
> +        * mtk_dsi_start() needs to be called in mtk_output_dsi_enable(),
> +        * after dsi is fully set.
> +        */
> +       mtk_dsi_stop(dsi);
> +
> +       mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
>         mtk_dsi_reset_engine(dsi);
>         mtk_dsi_lane0_ulp_mode_enter(dsi);
>         mtk_dsi_clk_ulp_mode_enter(dsi);
> @@ -735,17 +745,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *d=
si)
>         if (!dsi->enabled)
>                 return;
>
> -       /*
> -        * mtk_dsi_stop() and mtk_dsi_start() is asymmetric, since
> -        * mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disa=
ble(),
> -        * which needs irq for vblank, and mtk_dsi_stop() will disable ir=
q.
> -        * mtk_dsi_start() needs to be called in mtk_output_dsi_enable(),
> -        * after dsi is fully set.
> -        */
> -       mtk_dsi_stop(dsi);
> -
> -       mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
> -
>         dsi->enabled =3D false;
>  }
>
> --
> 2.37.1
>
