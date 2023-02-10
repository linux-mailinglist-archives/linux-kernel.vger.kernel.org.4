Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB6691BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjBJJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjBJJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:41:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F85ACFB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:41:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso3593796wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FXtJIM3du57xUfV949O/wulNn8qW+AxKoWuOnlA8Zs8=;
        b=Q4I+nSXtzNQtYSSBlK1tnkNWOBobkj//fQnII73nliusIFWbS4CyMXwv790TWVzaIR
         XeJFKMr09KxD6VEIwh0GADzS0KBeXwSd/Z2PuYcBx5wrwvwYKnpwCDcrhxRlRw1DIemu
         MShr1vbHI1OaKEdj393Dhbfx1croPFoH/IAHV4O1JI2sVfq1pnRj8CyYMXARz/VHSfkB
         +G0O6Aj1djeAFoK6kGfSCNq92z0a1Be0RoRQsmFaFkAFFZi/8jacKoA+8TQepXSM+Kfj
         3xzyBztnswh5ZMW2uGJwfNW1lkjNA2TL5EfxLYmohtuFUIh9ADwLNXuqvunAKu5Ksdr8
         LJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXtJIM3du57xUfV949O/wulNn8qW+AxKoWuOnlA8Zs8=;
        b=7d5Gf8z7SCIaXtaiyRqGCidG1WbDSgn6raAB8hBxwyA2rQaGVyNOU73Wkyf0YPM5i2
         0AclIM95epA9jH7HSOzgekeCeiR30gLtJ2zblhyN70PDxhKlLmbeSre6MudIzHZtpKov
         Ymt68ufNwp/oO6T7uvyIYeF9Uh/O7kwdsFrDLhtZF8wndEfTR0cRMNmZaj86xYaQjIIq
         oekdeAvcFKpZlL/o8ijjF6BAD/339sauRM2GsFlsVlL/vsZX2b6xFDJlQgalvtSzI1u0
         T682zZcr9ot+1OVbiljSHnoVpsUmf+tNQaLgFHN6emA8rtMrQJoNZ2GeWVJrlXcUlqpQ
         1SsA==
X-Gm-Message-State: AO0yUKVnjQwgCvEJiooMZLhqchkc2qNPK60JOUaFHLEegC3+Rpl5wRXd
        NS+mBltnWdqDBWC9+sDOWXnmmA==
X-Google-Smtp-Source: AK7set9g8UOPh4E6E2LgZ5q7toZT7ywT9NslTSP9dH/BzqJlUMVqwQWZGYqb6Lx8fO9DrtqztHmmEQ==
X-Received: by 2002:a05:600c:3317:b0:3e0:111:28a9 with SMTP id q23-20020a05600c331700b003e0011128a9mr12224837wmp.22.1676022063255;
        Fri, 10 Feb 2023 01:41:03 -0800 (PST)
Received: from linaro.org (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id f3-20020a056000128300b002c3e600d1a8sm3208693wrx.95.2023.02.10.01.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 01:41:02 -0800 (PST)
Date:   Fri, 10 Feb 2023 10:40:56 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
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
Message-ID: <20230210094056.GC175687@linaro.org>
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Mon, Feb 06, 2023 at 04:34:29PM +0100, Daniel Lezcano wrote:
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

Are you ok if I take this patch ?

Thanks

  -- Daniel


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
