Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B21729DED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbjFIPLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjFIPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:11:38 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4766B6;
        Fri,  9 Jun 2023 08:11:37 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-33b04c8f3eeso7597125ab.0;
        Fri, 09 Jun 2023 08:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323497; x=1688915497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9Rb1e/uOkSXDB72S3Pmwrp86GlxpbraRGVRQBYFa9A=;
        b=S8UpEWSPRJf/VAdRaI5CCuED4CbwEx9p+nVwiVfqdRGzXoVT8lZ/2jdDehQouwfzbS
         8kT+BzfLn4avWHltbykFMPZNtIGf6b6iX1yEmXdH0aCGwbXiCjsTscrl70mzFichMLHN
         jd8OUMbcQ83vGHeVPT2p6DP+tG09WHzGqBiKNoTwkM4YXhUkKrK3spsG5q/ywPpQmyeR
         T55+7ErvOVxqkLjeaVBnEMBavWLJ+cPF0J7aOxmmzNaPvASzQTg3ZtuCbRmqifp0FJC9
         zRc9Q1QHoYF8eghxwgHZViJ8SYo3ry8DHADkVQLasCwb9LXu2F/g3BJdRjqyVtU5Cttg
         YcJA==
X-Gm-Message-State: AC+VfDwOZixTjbKaNwrN+a1+19m/OAifPVsG/pqv8gS+2PciJA6GbSIp
        IQl3qkWR/cItZWE1xUIShw==
X-Google-Smtp-Source: ACHHUZ601MkzpccdrAQ864iVAYxlzaAgWUES/WkMk0l539+cvMHRtzNzn5Ol1LJOZoG08+96U43ndg==
X-Received: by 2002:a92:c98d:0:b0:33e:7269:bb7b with SMTP id y13-20020a92c98d000000b0033e7269bb7bmr1650478iln.3.1686323496915;
        Fri, 09 Jun 2023 08:11:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y16-20020a92c750000000b0033e62b47a49sm1124240ilp.41.2023.06.09.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:11:36 -0700 (PDT)
Received: (nullmailer pid 999255 invoked by uid 1000);
        Fri, 09 Jun 2023 15:11:33 -0000
Date:   Fri, 9 Jun 2023 09:11:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-phy@lists.infradead.org, Dipen Patel <dipenp@nvidia.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        timestamp@lists.linux.dev, Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH 2/7] dt-bindings: pwm: restrict node name suffixes
Message-ID: <168632349292.998946.17372740217811972226.robh@kernel.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-3-krzysztof.kozlowski@linaro.org>
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


On Tue, 30 May 2023 16:48:46 +0200, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to:
> 1. Only one unit address or one -N suffix,
> 2. -N suffixes to decimal numbers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

