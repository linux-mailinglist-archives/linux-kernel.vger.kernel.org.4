Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1E68C41E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBFRBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBFRB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:01:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD302BEE0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:00:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u21so12366920edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 09:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a6q/V+E4w1GCT3UIo80p/1jk/eyzfrAH7kZCB3dF6EI=;
        b=uCfTnrbkPsLAWL6gOh5JY9TMsdhSIK82e1NiuB7IshsdmrWsM5Hjr6FwUqZDOfVwE5
         pvNIBn/sDzqqN32lvfDoOmAh45PK1wSUkPZLuoc6AEvpCgbhlvhcegjr+D6AEUDXeYYW
         crvJhRIWcpDQskPdi0OoQGliNpJBpBY6VIzwBot4iZgUgiUf3fIUlETRkLbLODtr4PhJ
         3TWSPMBYPdaLTxs1wac12U00iQXUDjiSDIkJN5Elr/OcQAIapmSRlT2ChNGZoaEjoLvI
         /JAvT3ybEZlwj5jOQ0L0qHFxsB/XJq0OisD0eI8mYh3MtxQWHtEUbqVsfi2Ox0lT3Rd+
         Q6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6q/V+E4w1GCT3UIo80p/1jk/eyzfrAH7kZCB3dF6EI=;
        b=OW8GEkQYsm7XqpmuTYmuko8wsh3VEmRn1K8fXFH7nzyH3vhTPvvkoWKSmNJBPelChM
         IhXh5DY6fRYcSacnR0JOIPOEk6xZHC9bKKX0iomrt1fRibzdDIQkTzfPPmbA5R31mHp0
         PqTJoYEa0zTyGlMHVQR9YItD+7kN6tqLhBJ8tg5PPlNgJqoJ5RMVufSnnYH+BNEvpw1s
         rMW6YPrtYwxkS0zHgP+OWvL/REY5E+yp+9I0tiyHFUyRiuhAD8B2WPCqjK/SLks3fGPX
         po4FyONIk3yZhLMNpBP+peFRI5cW6iG4o/KVVjwpSXxg3DMFffkrXPF+DL8ungQlEknf
         2P+w==
X-Gm-Message-State: AO0yUKWT/7EFx/9WKbVZMdXiutAbFP8ObT6Sw6t6d1umpTgUcg3lmSdl
        zYpzDwNwiQS07w6m3Mqn2i74lA==
X-Google-Smtp-Source: AK7set9cQX60hct3CmrqQYLoS0zKl3hJEZ9KOOgC/H19Hq6SMdqrMyY4g16B+aPSjyDEPbDCn8cC1A==
X-Received: by 2002:a50:9ea9:0:b0:4a0:e323:d59c with SMTP id a38-20020a509ea9000000b004a0e323d59cmr246400edf.20.1675702854925;
        Mon, 06 Feb 2023 09:00:54 -0800 (PST)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id c5-20020a50d645000000b004aaa656887esm2668878edj.96.2023.02.06.09.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 09:00:54 -0800 (PST)
Date:   Mon, 6 Feb 2023 18:00:53 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
Message-ID: <Y+EyRb9klmwwHGjn@oden.dyn.berto.se>
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thanks for your work.

On 2023-02-06 16:34:29 +0100, Daniel Lezcano wrote:
> As the name states "thermal_core.h" is the header file for the core
> components of the thermal framework.
> 
> Too many drivers are including it. Hopefully the recent cleanups
> helped to self encapsulate the code a bit more and prevented the
> drivers to need this header.
> 
> Remove this inclusion in every place where it is possible.
> 
> Some other drivers did a confusion with the core header and the one
> exported in linux/thermal.h. They include the former instead of the
> latter. The changes also fix this.
> 
> The tegra/soctherm driver still remains as it uses an internal
> function which need to be replaced.
> 
> The Intel HFI driver uses the netlink internal framework core and
> should be changed to prevent to deal with the internals.
> 
> No functional changes
> 
> [ Applies to thermal/linux-next or linux-pm/linux-next ]
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/amlogic_thermal.c           | 1 -
>  drivers/thermal/armada_thermal.c            | 2 --
>  drivers/thermal/broadcom/bcm2835_thermal.c  | 1 -
>  drivers/thermal/hisi_thermal.c              | 3 +--
>  drivers/thermal/imx8mm_thermal.c            | 1 -
>  drivers/thermal/imx_sc_thermal.c            | 1 -
>  drivers/thermal/intel/intel_hfi.c           | 3 ++-
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
>  drivers/thermal/qoriq_thermal.c             | 1 -
>  drivers/thermal/rcar_gen3_thermal.c         | 1 -

For R-Car,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  drivers/thermal/samsung/exynos_tmu.c        | 3 +--
>  drivers/thermal/st/stm_thermal.c            | 1 -
>  drivers/thermal/tegra/tegra30-tsensor.c     | 1 -
>  drivers/thermal/uniphier_thermal.c          | 2 --
>  14 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index d30cb791e63c..9235fda4ec1e 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -28,7 +28,6 @@
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
>  
> -#include "thermal_core.h"
>  #include "thermal_hwmon.h"
>  
>  #define TSENSOR_CFG_REG1			0x4
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 83a4080bffc7..36653f692c80 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -19,8 +19,6 @@
>  #include <linux/regmap.h>
>  #include <linux/interrupt.h>
>  
> -#include "thermal_core.h"
> -
>  /* Thermal Manager Control and Status Register */
>  #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
>  #define PMU_TM_DISABLE_OFFS		0
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
> index 3d0710c6e004..23918bb76ae6 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -18,7 +18,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/thermal.h>
>  
> -#include "../thermal_core.h"
>  #include "../thermal_hwmon.h"
>  
>  #define BCM2835_TS_TSENSCTL			0x00
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 45226cab466e..62c67942293e 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -16,8 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/of_device.h>
> -
> -#include "thermal_core.h"
> +#include <linux/thermal.h>
>  
>  #define HI6220_TEMP0_LAG			(0x0)
>  #define HI6220_TEMP0_TH				(0x4)
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index d247b48696cb..72b5d6f319c1 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -17,7 +17,6 @@
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>  
> -#include "thermal_core.h"
>  #include "thermal_hwmon.h"
>  
>  #define TER			0x0	/* TMU enable */
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> index 378f574607f7..f32e59e74623 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -13,7 +13,6 @@
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>  
> -#include "thermal_core.h"
>  #include "thermal_hwmon.h"
>  
>  #define IMX_SC_MISC_FUNC_GET_TEMP	13
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 6e604bda2b93..c69db6c90869 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -40,10 +40,11 @@
>  
>  #include <asm/msr.h>
>  
> -#include "../thermal_core.h"
>  #include "intel_hfi.h"
>  #include "thermal_interrupt.h"
>  
> +#include "../thermal_netlink.h"
> +
>  /* Hardware Feedback Interface MSR configuration bits */
>  #define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
>  #define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT	BIT(0)
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index e2429676d0d2..101c75d0e13f 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -15,7 +15,6 @@
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
>  
> -#include "../thermal_core.h"
>  #include "../thermal_hwmon.h"
>  
>  #define QPNP_TM_REG_DIG_MAJOR		0x01
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index d111e218f362..431c29c0898a 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -13,7 +13,6 @@
>  #include <linux/thermal.h>
>  #include <linux/units.h>
>  
> -#include "thermal_core.h"
>  #include "thermal_hwmon.h"
>  
>  #define SITES_MAX		16
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 4ef927437842..0fd2fd077638 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -17,7 +17,6 @@
>  #include <linux/sys_soc.h>
>  #include <linux/thermal.h>
>  
> -#include "thermal_core.h"
>  #include "thermal_hwmon.h"
>  
>  /* Register offsets */
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 37465af59262..527d1eb0663a 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -20,11 +20,10 @@
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/thermal.h>
>  
>  #include <dt-bindings/thermal/thermal_exynos.h>
>  
> -#include "../thermal_core.h"
> -
>  /* Exynos generic registers */
>  #define EXYNOS_TMU_REG_TRIMINFO		0x0
>  #define EXYNOS_TMU_REG_CONTROL		0x20
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index e7834ccc7976..735401958f01 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -19,7 +19,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/thermal.h>
>  
> -#include "../thermal_core.h"
>  #include "../thermal_hwmon.h"
>  
>  /* DTS register offsets */
> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
> index 0ffe37ce7df7..b3218b71b6d9 100644
> --- a/drivers/thermal/tegra/tegra30-tsensor.c
> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -28,7 +28,6 @@
>  
>  #include <soc/tegra/fuse.h>
>  
> -#include "../thermal_core.h"
>  #include "../thermal_hwmon.h"
>  
>  #define TSENSOR_SENSOR0_CONFIG0				0x0
> diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
> index f8ab2ca76184..47801841b3f5 100644
> --- a/drivers/thermal/uniphier_thermal.c
> +++ b/drivers/thermal/uniphier_thermal.c
> @@ -17,8 +17,6 @@
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
>  
> -#include "thermal_core.h"
> -
>  /*
>   * block registers
>   * addresses are the offset from .block_base
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
