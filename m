Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02986A70C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCAQWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCAQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:22:33 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C28302BE;
        Wed,  1 Mar 2023 08:22:32 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 321GKeV8065246;
        Wed, 1 Mar 2023 10:20:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677687640;
        bh=eJOulfBTO406+XJwSAbUrw3TOVKL7z76SdXOdRRvd8g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=oITlJuKJL0Igo+Zp8Mw3to8q1ph1GEIt/d3yESZ3cer2ebuhWbdbMI3A5SmJvB3FN
         V+iCTjreym1r6VJb2vPdvJYz95D6QkQDjk525lQPej2NRTUvuqozcO2ayatgFg+2/r
         1bTPhJR/a6fqQcqeL9vlm4O3gnX/VFyNSv0aWTr0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 321GKeZv003448
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Mar 2023 10:20:40 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 1
 Mar 2023 10:20:40 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 1 Mar 2023 10:20:40 -0600
Received: from [10.250.235.39] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 321GKE84054644;
        Wed, 1 Mar 2023 10:20:15 -0600
Message-ID: <2493cf75-f78c-993a-01e6-8f89556973f0@ti.com>
Date:   Wed, 1 Mar 2023 21:50:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 02/19] thermal/core: Use the thermal zone 'devdata'
 accessor in thermal located drivers
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Talel Shenhar <talel@amazon.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Tim Zimmermann <tim@linux4.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Jiang Jian <jiangjian@cdjrlc.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM TSENS THERMAL DRIVER" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
 <20230228112238.2312273-3-daniel.lezcano@linaro.org>
From:   "Gole, Dhruva" <d-gole@ti.com>
Organization: Texas Instruments Incorporated
In-Reply-To: <20230228112238.2312273-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/2023 4:52 PM, Daniel Lezcano wrote:
> The thermal zone device structure is exposed to the different drivers
> and obviously they access the internals while that should be
> restricted to the core thermal code.
>
> In order to self-encapsulate the thermal core code, we need to prevent
> the drivers accessing directly the thermal zone structure and provide
> accessor functions to deal with.
>
> Use the devdata accessor introduced in the previous patch.
>
> No functional changes intended.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se> #R-Car
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> #MediaTek auxadc and lvts
> Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek lvts
> Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com> #da9062
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>  #spread
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com> #sun8i_thermal
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com> #Broadcom
> ---
>  drivers/thermal/amlogic_thermal.c                   |  2 +-
>  drivers/thermal/armada_thermal.c                    |  4 ++--
>  drivers/thermal/broadcom/bcm2711_thermal.c          |  2 +-
>  drivers/thermal/broadcom/bcm2835_thermal.c          |  2 +-
>  drivers/thermal/broadcom/brcmstb_thermal.c          |  4 ++--
>  drivers/thermal/broadcom/ns-thermal.c               |  2 +-
>  drivers/thermal/broadcom/sr-thermal.c               |  2 +-
>  drivers/thermal/da9062-thermal.c                    |  2 +-
>  drivers/thermal/db8500_thermal.c                    |  2 +-
>  drivers/thermal/dove_thermal.c                      |  2 +-
>  drivers/thermal/hisi_thermal.c                      |  2 +-
>  drivers/thermal/imx8mm_thermal.c                    |  2 +-
>  drivers/thermal/imx_sc_thermal.c                    |  2 +-
>  drivers/thermal/imx_thermal.c                       |  6 +++---
>  .../thermal/intel/int340x_thermal/int3400_thermal.c |  2 +-
>  .../intel/int340x_thermal/int340x_thermal_zone.c    |  4 ++--
>  .../int340x_thermal/processor_thermal_device_pci.c  |  4 ++--
>  drivers/thermal/intel/intel_pch_thermal.c           |  2 +-
>  drivers/thermal/intel/intel_quark_dts_thermal.c     |  6 +++---
>  drivers/thermal/intel/intel_soc_dts_iosf.c          | 13 +++++--------
>  drivers/thermal/intel/x86_pkg_temp_thermal.c        |  4 ++--
>  drivers/thermal/k3_bandgap.c                        |  2 +-
>  drivers/thermal/k3_j72xx_bandgap.c                  |  2 +-
> [...]
>  
> diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
> index 22c9bcb899c3..b5cd2c85e0c3 100644
> --- a/drivers/thermal/k3_bandgap.c
> +++ b/drivers/thermal/k3_bandgap.c
> @@ -141,7 +141,7 @@ static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
>  
>  static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
> -	struct k3_thermal_data *data = tz->devdata;
> +	struct k3_thermal_data *data = thermal_zone_device_priv(tz);

Reviewed-by: Dhruva Gole <d-gole@ti.com>


>  	int ret = 0;
>  
>  	ret = k3_bgp_read_temp(data, temp);
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> index 031ea1091909..5be1f09eeb2c 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -248,7 +248,7 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
>  /* Get temperature callback function for thermal zone */
>  static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
> -	return k3_bgp_read_temp(tz->devdata, temp);
> +	return k3_bgp_read_temp(thermal_zone_device_priv(tz), temp);
>  }
>  
>  static const struct thermal_zone_device_ops k3_of_thermal_ops = {
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index bec7ec20e79d..92b3ce426b9d 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -27,7 +27,7 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
>  			  int *temp)
>  {
>  	unsigned long reg;
> -	struct kirkwood_thermal_priv *priv = thermal->devdata;
> +	struct kirkwood_thermal_priv *priv = thermal_zone_device_priv(thermal);
>  
>  	reg = readl_relaxed(priv->sensor);
>  
> [...]

-- 
Regards,
Dhruva Gole <d-gole@ti.com>

