Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECDE6D9160
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjDFIVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjDFIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:21:02 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CE10F1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:21:00 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id dc30so33245346vsb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680769260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAfsXtBn0nzDoaEWurrUoZWu1BXoDWafMp8Ribw2xoM=;
        b=RWBBfn97A35m/Jk0+ZQHiYyz1tSkPCA8NXd7OvfztgUpqnxS4IwrXVkPgsvbhI3K8J
         C2Y1gq8zbIz8ovfukafOgPsUgiw3fdIeDRR2tV18tFbtNt6tWwiKMxM0vzPzoPg84LTN
         MlOAEz0P0HNHAPDpegqFGjb1/3jTgRac52EvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAfsXtBn0nzDoaEWurrUoZWu1BXoDWafMp8Ribw2xoM=;
        b=Qvp9uev+dUqCl/eMS+2Rf8miZWeDHyTlOSA17WURm2S2+PwhqF0T/yKZk4uKJthyX1
         CNf/a5qC0NvpQZj77gnsc66vtFiqQZ4SJG9N1e9jaebSeuFCsejsGQmGiV/FIANL6gqs
         8jLGaUEUsgc2/X3STMKgjvSmhDJXUgw5GPkpX9tsDMowCcvcohZNOZNVQuvbamMBTuk6
         mnKesd9hk0v8yfLQEnTUgR06IB+8/zUJ70+Sj5cLJa+8owRNXrJTaYcY1MbO4fpFlVe0
         5EMgtIWRFhy8OJaEao2kxTcL7wyMSwBHyn5tT+NV1r+P4G6ozZqr12Ac1wn61AaEKpe+
         GkjQ==
X-Gm-Message-State: AAQBX9c2Vp+ALvO+7MFWSEeJCGt3KGonycunusYqoKgd63QO8Kyh2SU3
        V20ljaQmOAZTw9D/GH49zBu3/rFVS78jShx07shnYg==
X-Google-Smtp-Source: AKy350az8HRB7kj3jahdnvQ8woBX6GVD/2pwkH0213hhBPvI/j4AeaNthtmiBUpiixn8/Rtdqp8Pfx5DUNJg/F/8jvI=
X-Received: by 2002:a67:c81e:0:b0:414:4ef3:839 with SMTP id
 u30-20020a67c81e000000b004144ef30839mr6485313vsk.7.1680769259766; Thu, 06 Apr
 2023 01:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230404104800.301150-1-angelogioacchino.delregno@collabora.com> <20230404104800.301150-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230404104800.301150-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 6 Apr 2023 16:20:48 +0800
Message-ID: <CAGXv+5FrUPUg_SsRz6LrW_K_C7By2tSCQ9W_MNJr8XCOcn7gLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] drm/mediatek: dp: Move AUX and panel poweron/off
 sequence to function
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 6:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Everytime we run bridge detection and/or EDID read we run a poweron
> and poweroff sequence for both the AUX and the panel; moreover, this
> is also done when enabling the bridge in the .atomic_enable() callback.
>
> Move this power on/off sequence to a new mtk_dp_aux_panel_poweron()
> function as to commonize it.
> Note that, before this commit, in mtk_dp_bridge_atomic_enable() only
> the AUX was getting powered on but the panel was left powered off if
> the DP cable wasn't plugged in while now we unconditionally send a D0
> request and this is done for two reasons:
>  - First, whether this request fails or not, it takes the same time
>    and anyway the DP hardware won't produce any error (or, if it
>    does, it's ignorable because it won't block further commands)
>  - Second, training the link between a sleeping/standby/unpowered
>    display makes little sense.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 76 ++++++++++++-------------------
>  1 file changed, 30 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 84f82cc68672..76ea94167531 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1253,6 +1253,29 @@ static void mtk_dp_audio_mute(struct mtk_dp *mtk_d=
p, bool mute)
>                            val[2], AU_TS_CFG_DP_ENC0_P0_MASK);
>  }
>
> +static void mtk_dp_aux_panel_poweron(struct mtk_dp *mtk_dp, bool pwron)
> +{
> +       if (pwron) {
> +               /* power on aux */
> +               mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> +                                  DP_PWR_STATE_BANDGAP_TPLL_LANE,
> +                                  DP_PWR_STATE_MASK);
> +
> +               /* power on panel */
> +               drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POW=
ER_D0);
> +               usleep_range(2000, 5000);
> +       } else {
> +               /* power off panel */
> +               drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POW=
ER_D3);
> +               usleep_range(2000, 3000);
> +
> +               /* power off aux */
> +               mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> +                                  DP_PWR_STATE_BANDGAP_TPLL,
> +                                  DP_PWR_STATE_MASK);
> +       }
> +}
> +
>  static void mtk_dp_power_enable(struct mtk_dp *mtk_dp)
>  {
>         mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_RESET_AND_PROBE,
> @@ -1937,16 +1960,9 @@ static enum drm_connector_status mtk_dp_bdg_detect=
(struct drm_bridge *bridge)
>         if (!mtk_dp->train_info.cable_plugged_in)
>                 return ret;
>
> -       if (!enabled) {
> -               /* power on aux */
> -               mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> -                                  DP_PWR_STATE_BANDGAP_TPLL_LANE,
> -                                  DP_PWR_STATE_MASK);
> +       if (!enabled)
> +               mtk_dp_aux_panel_poweron(mtk_dp, true);
>
> -               /* power on panel */
> -               drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POW=
ER_D0);

I suspect the original code was somewhat wrong already? We shouldn't need
to pull the panel out of standby just for HPD or reading EDID.

This driver probably needs a lot more cleanup. :/

ChenYu

> -               usleep_range(2000, 5000);
> -       }
>         /*
>          * Some dongles still source HPD when they do not connect to any
>          * sink device. To avoid this, we need to read the sink count
> @@ -1958,16 +1974,8 @@ static enum drm_connector_status mtk_dp_bdg_detect=
(struct drm_bridge *bridge)
>         if (DP_GET_SINK_COUNT(sink_count))
>                 ret =3D connector_status_connected;
>
> -       if (!enabled) {
> -               /* power off panel */
> -               drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POW=
ER_D3);
> -               usleep_range(2000, 3000);
> -
> -               /* power off aux */
> -               mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> -                                  DP_PWR_STATE_BANDGAP_TPLL,
> -                                  DP_PWR_STATE_MASK);
> -       }
> +       if (!enabled)
> +               mtk_dp_aux_panel_poweron(mtk_dp, false);
>
>         return ret;
>  }
> @@ -1983,15 +1991,7 @@ static struct edid *mtk_dp_get_edid(struct drm_bri=
dge *bridge,
>
>         if (!enabled) {
>                 drm_atomic_bridge_chain_pre_enable(bridge, connector->sta=
te->state);
> -
> -               /* power on aux */
> -               mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> -                                  DP_PWR_STATE_BANDGAP_TPLL_LANE,
> -                                  DP_PWR_STATE_MASK);
> -
> -               /* power on panel */
> -               drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POW=
ER_D0);
> -               usleep_range(2000, 5000);
> +               mtk_dp_aux_panel_poweron(mtk_dp, true);
>         }
>
>         /* eDP panels aren't removable, so we can return a cached EDID. *=
/
> @@ -2015,15 +2015,7 @@ static struct edid *mtk_dp_get_edid(struct drm_bri=
dge *bridge,
>         }
>
>         if (!enabled) {
> -               /* power off panel */
> -               drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POW=
ER_D3);
> -               usleep_range(2000, 3000);
> -
> -               /* power off aux */
> -               mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> -                                  DP_PWR_STATE_BANDGAP_TPLL,
> -                                  DP_PWR_STATE_MASK);
> -
> +               mtk_dp_aux_panel_poweron(mtk_dp, false);
>                 drm_atomic_bridge_chain_post_disable(bridge, connector->s=
tate->state);
>         }
>
> @@ -2188,15 +2180,7 @@ static void mtk_dp_bridge_atomic_enable(struct drm=
_bridge *bridge,
>                 return;
>         }
>
> -       /* power on aux */
> -       mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> -                          DP_PWR_STATE_BANDGAP_TPLL_LANE,
> -                          DP_PWR_STATE_MASK);
> -
> -       if (mtk_dp->train_info.cable_plugged_in) {
> -               drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POW=
ER_D0);
> -               usleep_range(2000, 5000);
> -       }
> +       mtk_dp_aux_panel_poweron(mtk_dp, true);
>
>         /* Training */
>         ret =3D mtk_dp_training(mtk_dp);
> --
> 2.40.0
>
