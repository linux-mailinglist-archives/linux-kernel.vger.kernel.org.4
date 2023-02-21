Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3152A69E764
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjBUSXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBUSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:22:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740FA6A5A;
        Tue, 21 Feb 2023 10:22:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cq23so20625469edb.1;
        Tue, 21 Feb 2023 10:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWBuZuItO82IFqyz0MCKd6UQRtN+LPDLboXi20Lorqc=;
        b=nHxfMRu41wzUAs9PMVxmCTZM+TTzDTKp6U8xb3FCFk8OCHPjt0O/eHNa+0iXdsMjze
         fw0AK2OeVI0wt+Wxrk0mLbc+JHeEo0Y9rAMUnzYHJ45WIA7nS5GmcfYlMhPD6eLhzEbs
         /03ULvS4qjrv80E3qAv72cLm83yyFAV7GckeDgAgU2gOcChGvbgMKYOgJmAtzuMvs8qe
         1rugqInJKPI2dPHXBOjdHpSf3EnfxiXv6rbaXRYMwvxtemLT9NAOzZLO4CQouNdHO1Ny
         EFU2g8Qb6p6UWUDeIED19Oqy6Faq2uJZ18mohAJeGIzW60Vl6EiqtTwe102l/joXzyOs
         w/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWBuZuItO82IFqyz0MCKd6UQRtN+LPDLboXi20Lorqc=;
        b=UdPcbJBMZWmszrJFqCvph3Og0jx5e+4kXhjSvTCkj5vghBMVZt3NysrjHrO3sjVVbT
         SvDKLUdp7KX4QVnPqS6M1mX7gF0D4HLGWz7fR+A0ekCVnBLSQ4VvUeMsNuEJs8H/4IBH
         EzM+mlxksEkPZ9pwUZdqJPwHWb+d4+1SaZek+6TX9JjLB8h4+VXflXj+glrvJjz1aRzY
         u9LrWyBd/Kci8MAnSUlSlUQ5W3Zi0lTDCSniERmJyd8TASZf5VrEKDFnmLdr+gEaPey9
         //NT2RoWg0ErXSfQ+3vR32BpzNxlffC40p2DJE6/2gpA3flERhKbBT+YZ6Vq8TCGJEux
         o+Ng==
X-Gm-Message-State: AO0yUKXwZlD9mLpHztQ4BFvyXVGx3QLMUFKQRLhAFaUn13sJLo6+/GW9
        d/u9mDA/uF7Rox5ABl7sjQ0=
X-Google-Smtp-Source: AK7set9RRyalSHH8Rnrhw+wG3j5tvzZjg2pF8az9E56fflvH6AQziI48YwaJ9r11hqsK2UbALLkZKg==
X-Received: by 2002:a05:6402:35c1:b0:49e:1f0e:e209 with SMTP id z1-20020a05640235c100b0049e1f0ee209mr5617045edc.10.1677003775806;
        Tue, 21 Feb 2023 10:22:55 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id i14-20020a50d74e000000b004acbde59e64sm3031509edj.8.2023.02.21.10.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:22:55 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 05/16] thermal/hwmon: Use the right device for
 devm_thermal_add_hwmon_sysfs()
Date:   Tue, 21 Feb 2023 19:22:53 +0100
Message-ID: <4462258.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20230221180710.2781027-6-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-6-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 21. februar 2023 ob 19:06:59 CET je Daniel Lezcano napisal(a):
> The devres variant of thermal_add_hwmon_sysfs() only takes the thermal
> zone structure pointer as parameter.
> 
> Actually, it uses the tz->device to add it in the devres list.
> 
> It is preferable to use the device registering the thermal zone
> instead of the thermal zone device itself. That prevents the driver
> accessing the thermal zone structure internals and it is from my POV
> more correct regarding how devm_ is used.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> #amlogic_thermal ---
>  drivers/thermal/amlogic_thermal.c                  | 2 +-
>  drivers/thermal/imx8mm_thermal.c                   | 2 +-
>  drivers/thermal/imx_sc_thermal.c                   | 2 +-
>  drivers/thermal/k3_bandgap.c                       | 2 +-
>  drivers/thermal/mediatek/auxadc_thermal.c          | 2 +-
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 2 +-
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        | 2 +-
>  drivers/thermal/qcom/tsens.c                       | 2 +-
>  drivers/thermal/qoriq_thermal.c                    | 2 +-
>  drivers/thermal/sun8i_thermal.c                    | 2 +-

For sun8i_thermal:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/thermal/tegra/tegra30-tsensor.c            | 2 +-
>  drivers/thermal/thermal_hwmon.c                    | 4 ++--
>  drivers/thermal/thermal_hwmon.h                    | 4 ++--
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
>  14 files changed, 16 insertions(+), 16 deletions(-)



