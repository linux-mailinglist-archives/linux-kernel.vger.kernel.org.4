Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF886CABA6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjC0ROB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjC0RN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:13:58 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E030C1;
        Mon, 27 Mar 2023 10:13:57 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id x3so39059550edb.10;
        Mon, 27 Mar 2023 10:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY9MkMEfq0rtpITAYQsVIbaSEu5rkXEFrZ/WULaQF+w=;
        b=NCBMUme002ANns1iORxbL2oCi5QWeriXuOhcJ5MyWgz/TIMqQoc6CEKrxJ+UPrLsA8
         5pLhuqndQg2yoWidNYcEfhq013oBxE087KXVOVwu98H1turl453T88fURv3wVv2tVUmU
         NFP+sLEn+1xICExYApbIRuCHRmns8mNRZ5zNMr/0NhlLmIgtGgoP+exQLL8fSIw81yu1
         FyUoklmsciQQfq29ifoole/caWlpHF1y82rDdIfu6S4z4RgCqpI1KoNHlcMKPjes+QnH
         6ybyk3RuYWOTWeNexoMhRM9GHv/RpEPGsAzIuJCAp+AEm31sJMLWWQGz3yEFaXx+2PlW
         S4PQ==
X-Gm-Message-State: AAQBX9dHUxMIGGw0ovhySN01h/Ls51uPlp0MXktfqSZvG5HcpSp5MoGo
        33TA3I1KKyFCxlJfRtlC2ToI1XaBFx6CDHOYNvcHY9E/
X-Google-Smtp-Source: AKy350aZDqhWcU7EVw+CmqQuXdIe4jvumwx1/OIAjVr9zH/Jnyvws8G2bpeIyY5GkUCfmMCBvL3bFkOnoQDA0j9VY1Q=
X-Received: by 2002:a17:907:6285:b0:931:f8b1:4472 with SMTP id
 nd5-20020a170907628500b00931f8b14472mr6098691ejc.2.1679937235734; Mon, 27 Mar
 2023 10:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144726.1545543-1-robh@kernel.org>
In-Reply-To: <20230310144726.1545543-1-robh@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 19:13:44 +0200
Message-ID: <CAJZ5v0hAeRa9xsp6-_um9j-9F6nf=PYuOC2mgMAmmUHP+9=RZg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Use of_property_present() for testing DT
 property presence
To:     Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 3:48 PM Rob Herring <robh@kernel.org> wrote:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Daniel, are you going to apply this, or should I take it directly?

> ---
>  drivers/thermal/cpufreq_cooling.c                  | 2 +-
>  drivers/thermal/imx8mm_thermal.c                   | 2 +-
>  drivers/thermal/imx_thermal.c                      | 4 ++--
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 9f8b438fcf8f..4608555b7ec3 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -633,7 +633,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>                 return NULL;
>         }
>
> -       if (of_find_property(np, "#cooling-cells", NULL)) {
> +       if (of_property_present(np, "#cooling-cells")) {
>                 struct em_perf_domain *em = em_cpu_get(policy->cpu);
>
>                 cdev = __cpufreq_cooling_register(np, policy, em);
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index 72b5d6f319c1..334ce8e9830b 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -282,7 +282,7 @@ static int imx8mm_tmu_probe_set_calib(struct platform_device *pdev,
>          * strongly recommended to update such old DTs to get correct
>          * temperature compensation values for each SoC.
>          */
> -       if (!of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
> +       if (!of_property_present(pdev->dev.of_node, "nvmem-cells")) {
>                 dev_warn(dev,
>                          "No OCOTP nvmem reference found, SoC-specific calibration not loaded. Please update your DT.\n");
>                 return 0;
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index fb0d5cab70af..77d6567a3f47 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -594,7 +594,7 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>
>         np = of_get_cpu_node(data->policy->cpu, NULL);
>
> -       if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
> +       if (!np || !of_property_present(np, "#cooling-cells")) {
>                 data->cdev = cpufreq_cooling_register(data->policy);
>                 if (IS_ERR(data->cdev)) {
>                         ret = PTR_ERR(data->cdev);
> @@ -671,7 +671,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, data);
>
> -       if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
> +       if (of_property_present(pdev->dev.of_node, "nvmem-cells")) {
>                 ret = imx_init_from_nvmem_cells(pdev);
>                 if (ret)
>                         return dev_err_probe(&pdev->dev, ret,
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 8a9055bd376e..dace6591220e 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -223,7 +223,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
>          * using DT, then it must be aware that the cooling device
>          * loading has to happen via cpufreq driver.
>          */
> -       if (of_find_property(np, "#thermal-sensor-cells", NULL))
> +       if (of_property_present(np, "#thermal-sensor-cells"))
>                 return 0;
>
>         data = ti_bandgap_get_sensor_data(bgp, id);
> --
> 2.39.2
>
