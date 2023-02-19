Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24669C1B3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjBSR0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjBSR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:26:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7AC12F3C;
        Sun, 19 Feb 2023 09:26:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eg19so4464155edb.0;
        Sun, 19 Feb 2023 09:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3VEydMb61qXjyUuHx50DS5MjqkMWbNi7p/BGphDgb7g=;
        b=BTDQKmDAUpCMrOaZ65GdSbOPIMPVt9MrMM2yyDYjGh5NttUwebWMfZRJKk/aym79M2
         krwJSPLEjjSVd9ZxQ6t0eajf+A8F/FAe88qsZtN8cFlgeBZJP49ICI+U72C61KNSnutg
         iFLNp91+zfOuoFggFt6d/n+4QpJ5RKV2nkxoTVMm6zz7PUzmrksewDw9XE1EjJPtW3bK
         KVZrLOB+N3FfD17qI3V+oyqT49P3K9DrnzL4BKxkf4Fm3rcQkFEd8UA1sV7GFlqeRo80
         I3OKYEM7d4YiM0WiuyRG8lEqETnSubptt9k6JL7CvzICu0BvKe34O/Ykn1FXp7/3upTB
         uRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VEydMb61qXjyUuHx50DS5MjqkMWbNi7p/BGphDgb7g=;
        b=RH9Q+Gj/foacthA9IoDsV00Yl/B8zwg9uVqD0lKAx8YC1ILQyGapvv3HSqQNY2X/KE
         nuwcEvrAoYWS3fwIHMSrrcmLXNVbtD2Alv+BuF77C/0RTiwQfQx3P05XIZU3W2VqDijW
         jdGBdMWEi7L8vTeHJrRJD6jEjfzbnpvBX7p6uybXamIDb5YLEVOzBeTtyG9lhIvJWPvk
         s7hXPqdNFcdyQeXMrUfkng0+fKNasxO0u2s0ucey0leSrcr7ihGDQ/Mx0MIR0vCu2ZIW
         LOO9u3g4RO02T3w3UljwBolbDZKlckJrUXHxOpjaDZhPGxGtKo0cX54lEb7p0ZGYPB2m
         2emg==
X-Gm-Message-State: AO0yUKW/8xeTP1nBAoVIC41bQc+RjAn4K0Wo7zOV4PrgbhQDdLJXDuVG
        QTauuoJllVGY+lUGnSNdg5qBUHzpafrWq3BD0fM=
X-Google-Smtp-Source: AK7set+HJ8ugf54hyVxoMHuivdcoWWsyfiGwYdZMNvgLG69WPq5tKTBVZni7iBuMPHyMZ4Z10CLK8MHIDK89J3oADnI=
X-Received: by 2002:a17:906:c5b:b0:8cf:bb36:1486 with SMTP id
 t27-20020a1709060c5b00b008cfbb361486mr448990ejf.6.1676827593334; Sun, 19 Feb
 2023 09:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20230219143657.241542-1-daniel.lezcano@linaro.org> <20230219143657.241542-6-daniel.lezcano@linaro.org>
In-Reply-To: <20230219143657.241542-6-daniel.lezcano@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 19 Feb 2023 18:26:22 +0100
Message-ID: <CAFBinCAm+pFuuJEL3_2B3o3ZaLWxb-JqHhxY0vJfb8ZfxKOieQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/17] thermal/hwmon: Use the right device for devm_thermal_add_hwmon_sysfs()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM TSENS THERMAL DRIVER" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 3:38 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
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
> ---
>  drivers/thermal/amlogic_thermal.c                  | 2 +-
For amlogic_thermal.c:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
