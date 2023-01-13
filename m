Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F96694D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbjAMKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbjAMKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E962B3F10F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id v6so8386513ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wR+hT7yUqfyT3pnNmk3hcVxmm03o8y7bnqHCIJoc3dM=;
        b=JcIsZ/SifvNLtEKfQ+kWVpXPX2wBaxCcr5fb+GRBp5IESf+7CVcI7Y7svGOA/h0hrM
         Vn/GOR1m2axlsbHDctngyvND8xuXPnSgNKeG4TersY2JeRPvZbKQp46iPjwn1sDJr0Hc
         b4oVdzg1cf96dW3qzMZ6fnyn6MGd5EhN6rekfB/W1LMQprW/8awqNe7p8Rpwl22W3Yte
         BiLolb74es2C3rJSa6IBP1k6Hcg2/jdgCQr8833pnm+0Tn5Op3fvvm1+ebV8Qiy289tJ
         Biy4V3P0wEHI7wHp/vwiwXAXxoU8PMtJEqFLVGeut//Qp6K8Drck0zK7lCEIfJRvkZ4/
         2Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR+hT7yUqfyT3pnNmk3hcVxmm03o8y7bnqHCIJoc3dM=;
        b=ek0RZgFZSqLDhfp8oAS22aJMrF11tDT5vIa9iV0au6q5nuospzGxDDZui9oF9/SMH7
         e5kYOjSnZOhO8g6m84uXNMRMDHLf7aMgPhsAafifG35gbx1s9bcqQWfp/NwpnbCUp+25
         Rp1eGup09sVTTssZn60X4lFJB4M8LVvbXJ56I7fLtruPQ6v+RiQSq2JZIkAHZpbM5++J
         KUsWDF6vv9fCc0VNmZ4bLMS84mBScOeO2lqIVCUllq5kwE6x0EHeoJmNoFyVBkhH5hpu
         JiTN1T0BNhcB55eJYEmuYtjoH0mHDSpBBsr23/0+huh3Nl6YeP+I/FUz7P1NzOAIwTv1
         kGXQ==
X-Gm-Message-State: AFqh2krnB625sWN99MbHg4c7yr9Xvz9eOQ8+UQWiSWIB2iKesBDZL9/Q
        G98AlI3R6VdnaWjmI70QjkmORg==
X-Google-Smtp-Source: AMrXdXujKgQWhBi3Ycf+ngBHGaDAfaqiZy+RD9cJ1HqnqFUc58YuwODr99DdljAd45blrffOOk98bg==
X-Received: by 2002:a17:907:c712:b0:7bd:6372:fdb4 with SMTP id ty18-20020a170907c71200b007bd6372fdb4mr91936188ejc.41.1673607108542;
        Fri, 13 Jan 2023 02:51:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0086b7ffb3b92sm146352ejh.205.2023.01.13.02.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:51:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ARM: dts: at91: align LED node names with dtschema
Date:   Fri, 13 Jan 2023 11:51:38 +0100
Message-Id: <167360709873.32944.15890904363845113359.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125144131.477089-1-krzysztof.kozlowski@linaro.org>
References: <20221125144131.477089-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 15:41:30 +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   at91-sama5d2_ptc_ek.dtb: leds: 'blue', 'green', 'red' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] ARM: dts: at91: align LED node names with dtschema
      https://git.kernel.org/krzk/linux-dt/c/3a48b303d44a19d335910f825f9a8473c5ff35e0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
