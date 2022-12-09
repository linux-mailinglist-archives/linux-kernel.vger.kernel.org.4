Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF264886D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLIS1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLIS11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:27:27 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D91DEE8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:27:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so8978787pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4w6shm/Wpz6ggc4zMRhzb9FfoJ4MU+lSfUxwokG/Em0=;
        b=DqcJe4694wkG976PjUOU2TsLdZ6AqSNNqB4CDir8muiXDWFziOVnaq4bgef+IpjXW8
         BYCQq5+CHK3zagU/kQNl2fkY6yAAgIpwkoAVkUIYm/XP0BCpkFNUmrSx6WUMKNIunWS/
         1ViUlrZGecXnoABDCfXZA+HP7XhWCtki3CYVZNe/URC5mvmJsTg1fmdWfpTdQb+s30jy
         iky6uaWQ1JeV7UkhbEB9sz0HKcP5gFKiIBEMvDIBl6xuabikBdYiLwVnjo5oCpMoS1lp
         pHALstRMOaJaOjvi7AyQNg38g3aS4UMkURCioktQVwm0X3dUqcYQyWVi54s1+DtPa0IZ
         ETeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4w6shm/Wpz6ggc4zMRhzb9FfoJ4MU+lSfUxwokG/Em0=;
        b=rf+Dk1ipBJlGiw5Pt+WOZsfypTlSUvg0AuQdGzaIAHfcnK0dAi6oNQHCqUqH91k1Ds
         siYsRkbfxDEJukYKo99lvIDHJZrtt/UfGQb8Psoy8f1w3fmdlKA9o+PI8psntydkwIew
         48qcu290lzt7Ved0Zt2lAeCzUewAIj7/66NlhBw/J4LiwjJzxyRVU9gokJbbDjd/OpNO
         YEQVk/8e30mh7r4FKvqMQXCAzvUQ8oxwh7BeNNwz9fCKE+oju1izncjLE0bdIQSg/15z
         uN5c+6sT+mk5QaJfDBZoWLzJ64kNqvzxwT3Ga/qomVT2Y8fVostoa7dfWFnAnS8Ml717
         S0VQ==
X-Gm-Message-State: ANoB5pkOxJHF/uYN8VadEPmBpGATjr/4s6K4C1mHNEqipwnGZO20W69I
        9QxBfvAzpkXvFV6Fup8k+osEgxVlQcGKaz6bLxYTyg==
X-Google-Smtp-Source: AA0mqf52WgiM//CGJflKjihIpmk/MVk3JEVMl+QooKQ81VQl/XzLSTIwuVjhLP1uqMx5c86DO4csqdVJSz8AjkOnz1M=
X-Received: by 2002:a17:90b:290:b0:219:2b00:8d23 with SMTP id
 az16-20020a17090b029000b002192b008d23mr57659625pjb.167.1670610446237; Fri, 09
 Dec 2022 10:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20221209031053.8444-1-yc.hung@mediatek.com>
In-Reply-To: <20221209031053.8444-1-yc.hung@mediatek.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Fri, 9 Dec 2022 10:27:14 -0800
Message-ID: <CAOReqxh=27P7PogzhFr+37XBfRh5Nxu1x46JpdCH=ZRDVhRbeQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: add sof be ops to check audio active
To:     YC Hung <yc.hung@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>,
        whalechang@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 7:11 PM YC Hung <yc.hung@mediatek.com> wrote:
>
> In MT8195 SOF design, both DSP and audio driver would access audio
> registers. Before DSP accesses audio registers, audio power and clock
> should be enabled. DSP will hang up if DSP access audio register but
> audio power and clock are disabled. Therefore, we add audio pm runtime
> active checking before accessing audio registers in SOF BE's callback
> hw_params function to avoid this situation.
>
> Signed-off-by: YC Hung <yc.hung@mediatek.com>

Acked-by: Curtis Malainey <cujomalainey@chromium.org>

> ---
>  sound/soc/mediatek/mt8195/mt8195-mt6359.c | 30 +++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> index 61be66f47723..4682748d82be 100644
> --- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> @@ -633,6 +633,32 @@ static const struct snd_soc_ops mt8195_rt1011_etdm_ops = {
>         .hw_params = mt8195_rt1011_etdm_hw_params,
>  };
>
> +static int mt8195_sof_be_hw_params(struct snd_pcm_substream *substream,
> +                                  struct snd_pcm_hw_params *params)
> +{
> +       struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +       struct snd_soc_component *cmpnt_afe = NULL;
> +       struct snd_soc_pcm_runtime *runtime;
> +
> +       /* find afe component */
> +       for_each_card_rtds(rtd->card, runtime) {
> +               cmpnt_afe = snd_soc_rtdcom_lookup(runtime, AFE_PCM_NAME);
> +               if (cmpnt_afe)
> +                       break;
> +       }
> +
> +       if (cmpnt_afe && !pm_runtime_active(cmpnt_afe->dev)) {
> +               dev_err(rtd->dev, "afe pm runtime is not active!!\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct snd_soc_ops mt8195_sof_be_ops = {
> +       .hw_params = mt8195_sof_be_hw_params,
> +};
> +
>  static int mt8195_rt1011_init(struct snd_soc_pcm_runtime *rtd)
>  {
>         struct snd_soc_card *card = rtd->card;
> @@ -1272,24 +1298,28 @@ static struct snd_soc_dai_link mt8195_mt6359_dai_links[] = {
>                 .name = "AFE_SOF_DL2",
>                 .no_pcm = 1,
>                 .dpcm_playback = 1,
> +               .ops = &mt8195_sof_be_ops,
>                 SND_SOC_DAILINK_REG(AFE_SOF_DL2),
>         },
>         [DAI_LINK_SOF_DL3_BE] = {
>                 .name = "AFE_SOF_DL3",
>                 .no_pcm = 1,
>                 .dpcm_playback = 1,
> +               .ops = &mt8195_sof_be_ops,
>                 SND_SOC_DAILINK_REG(AFE_SOF_DL3),
>         },
>         [DAI_LINK_SOF_UL4_BE] = {
>                 .name = "AFE_SOF_UL4",
>                 .no_pcm = 1,
>                 .dpcm_capture = 1,
> +               .ops = &mt8195_sof_be_ops,
>                 SND_SOC_DAILINK_REG(AFE_SOF_UL4),
>         },
>         [DAI_LINK_SOF_UL5_BE] = {
>                 .name = "AFE_SOF_UL5",
>                 .no_pcm = 1,
>                 .dpcm_capture = 1,
> +               .ops = &mt8195_sof_be_ops,
>                 SND_SOC_DAILINK_REG(AFE_SOF_UL5),
>         },
>  };
> --
> 2.18.0
>
