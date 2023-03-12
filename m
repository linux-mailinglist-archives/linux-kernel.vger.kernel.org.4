Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EFD6B6796
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCLPlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCLPlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:41:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EA443936
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9049B80CB3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738A3C433A0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678635705;
        bh=o9txECpxOStZ4lEk7MbenubZLU/t1F2jRrj8TI3/DK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nICM0YirOa0QJ1qDKCG0Tn9jcP5bqDn7WJWLOMSN9+FhpIqOrA5Jwqj+V2Pe7h+dE
         Z6KyiJjlJdoQIQE1TAyVSa/BHs/4n/sWkEAj7kElaFFWC4m4IiNkxeN3nUl2hO7jim
         IcfHPmWB/iFUwf/IalB4FFL8qBZlcqt4r5e45R3oK5IIyk+gsxrW0MG0WO0TkJpPS4
         65/8aLmA2gJdk6uw5fo5+Buz0J5D23sQ5ca2gCoBi9T7S7ZBMWeRxIKTGaxRzcCkiQ
         gpu2SYRnq3MsY3vsdiMTpsW/0b3UMtN7cYKetDlTeTZiPesHsimy8bFv+gXZNq8Qz9
         yJT7UPPowMygA==
Received: by mail-lj1-f177.google.com with SMTP id a32so10178714ljr.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:41:45 -0700 (PDT)
X-Gm-Message-State: AO0yUKUKJTuraAPKN55HG2lq+rb1Q8afi7MmDn1PQxoLcP5BkcoFV13E
        /3HC2DqwDEAmDxhhxyj2zOeHPRekoJWZyKLBeg==
X-Google-Smtp-Source: AK7set/JnYxeve0nDAXri0t02WExqjWC+ImSGEpC8YZHj1h3xzkeP8L25/oKwG9AWC1n3SNm1DT/3bGQ08Fc1lFbtAQ=
X-Received: by 2002:a05:651c:336:b0:293:2f6e:91bf with SMTP id
 b22-20020a05651c033600b002932f6e91bfmr9669363ljp.7.1678635703439; Sun, 12 Mar
 2023 08:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230202045734.2773503-1-wenst@chromium.org>
In-Reply-To: <20230202045734.2773503-1-wenst@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 12 Mar 2023 23:41:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8yhi2Vd01ph-W0HOmULs=tC5yARi_89Wddei=BTo5VKg@mail.gmail.com>
Message-ID: <CAAOTY_8yhi2Vd01ph-W0HOmULs=tC5yARi_89Wddei=BTo5VKg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: dp: Only trigger DRM HPD events if
 bridge is attached
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guillaume Ranquet <granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chen-Yu:

Chen-Yu Tsai <wenst@chromium.org> =E6=96=BC 2023=E5=B9=B42=E6=9C=882=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The MediaTek DisplayPort interface bridge driver starts its interrupts
> as soon as its probed. However when the interrupts trigger the bridge
> might not have been attached to a DRM device. As drm_helper_hpd_irq_event=
()
> does not check whether the passed in drm_device is valid or not, a NULL
> pointer passed in results in a kernel NULL pointer dereference in it.
>
> Check whether the bridge is attached and only trigger an HPD event if
> it is.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort drive=
r")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
> Changes since v1
> - Dropped prerequisite-patch-ids
> - Added Guillaume's Reviewed-by
>
> This applies on top of mediatek-drm-next.
>
>  drivers/gpu/drm/mediatek/mtk_dp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 1f94fcc144d3..a82f53e1a146 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1823,7 +1823,8 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd,=
 void *dev)
>         spin_unlock_irqrestore(&mtk_dp->irq_thread_lock, flags);
>
>         if (status & MTK_DP_THREAD_CABLE_STATE_CHG) {
> -               drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
> +               if (mtk_dp->bridge.dev)
> +                       drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
>
>                 if (!mtk_dp->train_info.cable_plugged_in) {
>                         mtk_dp_disable_sdp_aui(mtk_dp);
> --
> 2.39.1.456.gfc5497dd1b-goog
>
