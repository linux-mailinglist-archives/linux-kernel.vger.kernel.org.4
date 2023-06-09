Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E51729E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbjFIPOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbjFIPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:14:03 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C9C2D4B;
        Fri,  9 Jun 2023 08:14:01 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33b6c47898dso8257705ab.0;
        Fri, 09 Jun 2023 08:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323640; x=1688915640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlnLe4pfATl+DHVBwqaw0v4jPbOyjTsxndvN+13DO4U=;
        b=hAx9JkCXvnAEstKK3wUZ7E6VkL8Et8Waz9qqFCVaWg0SUDkJammPPEeXIwbTUKWpcY
         NqCezTDxrGy/yOs/E5cQ5ZlHSWxQMQBitoZfnUdMadx1FLr9fLtzRwYJKsrJicYkfQQh
         9dU8ylX/1vjopVlP09mrBanyb81c5nU2Hk3EDeHtgT2jQludeA+K9MyuHyLQ9ICgrRPD
         aorEkRbjlbh1ekeX7JZ+C0oonjCwgxTRkEkGKcb91SJ8eMS6h2fKiNeI/gblL6VPIaYC
         XK1mMfVP6yXWSHvH6dyMaeZtP1s/W4s/N5DgDmfe0ecjrw19CLqylHPqDS5ngKRfJ/ia
         ddEA==
X-Gm-Message-State: AC+VfDyBmzbqBXumglQuSdUp1imzMCFn0031hctr5LLUKW9pslIFADv0
        P5QlFJRDfxaRMcyyMy79pg==
X-Google-Smtp-Source: ACHHUZ67MRb0rJmdn4+48gimm54npOx3rXtHVsKxV43QbkTdBE7Slc8n9FZ20Hgxkb+KSwVkDi+hYQ==
X-Received: by 2002:a92:d590:0:b0:33d:72c0:1b4 with SMTP id a16-20020a92d590000000b0033d72c001b4mr1757273iln.10.1686323640384;
        Fri, 09 Jun 2023 08:14:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z3-20020a92bf03000000b0032b72b5c1c3sm1136035ilh.9.2023.06.09.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:13:59 -0700 (PDT)
Received: (nullmailer pid 1011188 invoked by uid 1000);
        Fri, 09 Jun 2023 15:13:57 -0000
Date:   Fri, 9 Jun 2023 09:13:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, timestamp@lists.linux.dev,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-phy@lists.infradead.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Dipen Patel <dipenp@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 6/7] dt-bindings: timestamp: restrict node name suffixes
Message-ID: <168632363634.1011122.1495504884843410484.robh@kernel.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-7-krzysztof.kozlowski@linaro.org>
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


On Tue, 30 May 2023 16:48:50 +0200, Krzysztof Kozlowski wrote:
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
>  .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

