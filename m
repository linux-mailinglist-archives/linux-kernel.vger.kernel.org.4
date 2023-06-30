Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF427440D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjF3RFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjF3REy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:04:54 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051D3C30;
        Fri, 30 Jun 2023 10:04:48 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7835bad99fbso88923439f.1;
        Fri, 30 Jun 2023 10:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144688; x=1690736688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDSvITIumvxU+9FeXxHNbJLwhZGzlxTTZldXnMbbHIk=;
        b=RruGZEIVVjV37EmwLYWeUNTEgoEZLxVyAoTrlVySuNTybnB76gI/OQ9FCuN2/9xKIa
         /zq6qEUSJBt+GMQa0gy3DnWcORqJSSV3F2ykshWOQO/zrwFxIg2/Bhhin1BGiCI9avPL
         DGfa0NCeozfC3fESajjY7jzZgmHVOtoxupq66ZsAAbOnM5d0KcRQ4II+riFfhpttfvU9
         wN/KA89OOtubXAhfGlBISy3/JZ/2gZU4RpCSLKGcT5Udz5G+T+N7SkzL8vvsm4nmB1dL
         qd6nxd/KqCICTBShtvadvURwMqvZ1j03Uv3fwtDkyjLXzleSfzXZY86blQMlua+ACBFw
         GugQ==
X-Gm-Message-State: AC+VfDzBhSbH3SnZzUTAKg4ECB4QbCRAxibYLyG7EZpIESJMUr5BtARU
        Do3zv4Ks4W3JpifkCe8RUQ==
X-Google-Smtp-Source: ACHHUZ7YVGW6lKVvg7C24o8CcDQqjgMElHyuoGKVnJCWvqYKZlQzdchG5JVGPC50uiHB8TDngxV6bA==
X-Received: by 2002:a05:6602:19d1:b0:783:5209:c01 with SMTP id ba17-20020a05660219d100b0078352090c01mr3305594iob.17.1688144687999;
        Fri, 30 Jun 2023 10:04:47 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k5-20020a02cb45000000b0040bbcee6b57sm2373025jap.133.2023.06.30.10.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:04:47 -0700 (PDT)
Received: (nullmailer pid 1908824 invoked by uid 1000);
        Fri, 30 Jun 2023 17:04:44 -0000
Date:   Fri, 30 Jun 2023 11:04:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, timestamp@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-phy@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-rtc@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dt-bindings: watchdog: restrict node name suffixes
Message-ID: <168814464489.1908194.10092224539849073775.robh@kernel.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 May 2023 16:48:51 +0200, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to -N suffixes to decimal
> numbers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/watchdog/watchdog.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Seems watchdog patches aren't getting applied... Applied, thanks!

