Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36F45B819A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiINGqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiINGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:46:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEE861726
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:46:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b5so24063644wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ImmVW0/zlsxHuw+mi1Y/IEzHEHB3es0bsHMSoWAgL4k=;
        b=u+lq0otXn+KFbHR11SKSKZ+asxqc1H4lSrT/Aw6f7w3zGwHYtEcttBGlS3k8gKusPG
         CbAJlMmhtPy1LkGly9A9yChqyYDjJW7gM4oBWv3nDjPFnQHa/Kp8rgF53AAr3yxlQWd5
         Qm4Ps0L9LvLibt7KC7weO7oGIwK+NPyXTKaI+3RlkXNGKXTrQt0FQlKYUz2HBojG+r9B
         c7epBJr25jHh+OXIfSVGIBw2hxbLjLEfVVDzityV4J5ck0ywrGpKOehQZpkkwm40jOgL
         q6U+WQpjIvrtpwE2Gqxei7ZILJsEtOcgd6qUVfZQvbCufQBQ84wc4wn4Gs5pz2OJ6EU+
         pCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ImmVW0/zlsxHuw+mi1Y/IEzHEHB3es0bsHMSoWAgL4k=;
        b=SQfyrsLGLtio9FxtQi5+AKsO4OqN9f44CxjAuK0RGPl3S//CKD2cub5vAFuoSK36eM
         n2SvGSoLWVEnALMSMP/syNo1UIIrDN63I0Zyr8Wmx8sV+JdNS/K5qIPHeylcjb5Y0MHZ
         nsFp7qu4wZPubzkPj1ny9n4q4SNEnYr42HIqDc3ZiSDen1ePpw/BkZj+Yk1lhpOQBTLI
         C1mCiHKO/BLbgdqFTN4EY82mAqAgO7aTYCsM5cuUC9+9t0yNekLUR/w2JzS4OyNwnAhN
         nFH2HUsZO0YzCv8y1xr4gk+Eq2v6BVlFfeyCPwqEQVl++NgE0wROVwqpZHpxtOceDCWg
         QD3g==
X-Gm-Message-State: ACgBeo1PQhbmiTOGe+pa4Z2gZAdpFMZJK2IKdqpjdZPG8/5CJMQAeifm
        1C2HGhvHY5ok3q5K1kAzrvHJWQ==
X-Google-Smtp-Source: AA6agR4+sQtyB4wK6jRKjx2OlMzlixZ167jBff5k7cF+FUTrqgsIco8SvtKudY3At2GX0GTDOP0o3Q==
X-Received: by 2002:a05:6000:1861:b0:22a:bb41:886d with SMTP id d1-20020a056000186100b0022abb41886dmr5011968wri.661.1663137973060;
        Tue, 13 Sep 2022 23:46:13 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe110000000b00229b76f872asm14930035wrz.27.2022.09.13.23.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 23:46:11 -0700 (PDT)
Date:   Wed, 14 Sep 2022 07:46:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, tony@atomide.com, afd@ti.com,
        khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Message-ID: <YyF4rDbR/lwblAVt@google.com>
References: <20220913121419.15420-1-jneanne@baylibre.com>
 <20220913121419.15420-5-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913121419.15420-5-jneanne@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022, Jerome Neanne wrote:

> The TPS65219 is a power management IC PMIC designed to supply a wide
> range of SoCs in both portable and stationary applications. Any SoC can
> control TPS65219 over a standard I2C interface.
> 
> It contains the following components:
> - Regulators.
> - Over Temperature warning and Shut down.
> - GPIOs
> - Multi Function Pins (MFP)
> - power-button
> 
> This patch adds support for tps65219 PMIC. At this time only
> the functionalities listed below are made available:
> 
> - Regulators probe and functionalities
> - warm and cold reset support
> - SW shutdown support
> - Regulator warnings via IRQs
> - Power-button via IRQ
> 
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  MAINTAINERS                  |   1 +
>  drivers/mfd/Kconfig          |  14 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/tps65219.c       | 320 ++++++++++++++++++++++++++++++++
>  include/linux/mfd/tps65219.h | 345 +++++++++++++++++++++++++++++++++++
>  5 files changed, 681 insertions(+)
>  create mode 100644 drivers/mfd/tps65219.c
>  create mode 100644 include/linux/mfd/tps65219.h

Please resend this to the email indicated in MAINTAINERS.

-- 
DEPRECATED: Please use lee@kernel.org
