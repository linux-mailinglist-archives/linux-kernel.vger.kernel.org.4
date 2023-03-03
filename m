Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84E26A9BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCCQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCCQV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:21:59 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21B765ADF6;
        Fri,  3 Mar 2023 08:21:53 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Mar 2023 01:21:52 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id EE1632058442;
        Sat,  4 Mar 2023 01:21:51 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Sat, 4 Mar 2023 01:21:51 +0900
Received: from [10.212.156.241] (unknown [10.212.156.241])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 60F9D25528;
        Sat,  4 Mar 2023 01:21:44 +0900 (JST)
Message-ID: <acb7d81e-69d5-ff1b-aa0b-709c8c56010b@socionext.com>
Date:   Sat, 4 Mar 2023 01:21:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 02/18] thermal/core: Use the thermal zone 'devdata'
 accessor in thermal located drivers
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        Dhruva Gole <d-gole@ti.com>,
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Tim Zimmermann <tim@linux4.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Jiang Jian <jiangjian@cdjrlc.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ido Schimmel <idosch@nvidia.com>,
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
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
 <20230301201446.3713334-3-daniel.lezcano@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20230301201446.3713334-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/03/02 5:14, Daniel Lezcano wrote:
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
> Reviewed-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> #MediaTek auxadc and lvts
> Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek lvts
> Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com> #da9062
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>  #spread
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com> #sun8i_thermal
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com> #Broadcom
> Reviewed-by: Dhruva Gole <d-gole@ti.com> # K3 bandgap

(snip)

> diff --git a/drivers/thermal/uniphier_thermal.c
> b/drivers/thermal/uniphier_thermal.c
> index 47801841b3f5..aef6119cc004 100644
> --- a/drivers/thermal/uniphier_thermal.c
> +++ b/drivers/thermal/uniphier_thermal.c
> @@ -187,7 +187,7 @@ static void uniphier_tm_disable_sensor(struct
> uniphier_tm_dev *tdev)
> 
>   static int uniphier_tm_get_temp(struct thermal_zone_device *tz, int
> *out_temp)
>   {
> -	struct uniphier_tm_dev *tdev = tz->devdata;
> +	struct uniphier_tm_dev *tdev = thermal_zone_device_priv(tz);

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com> #uniphier

Thank you,

---
Best Regards
Kunihiko Hayashi
