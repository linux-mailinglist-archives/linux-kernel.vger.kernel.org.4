Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2642C5F12A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiI3Tat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiI3TaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:30:18 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D42DAB4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bs18so4226516ljb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TyDtIBZ/b6jNbw8Fg/X93utCMqZp3mIZumdRr4BC1ys=;
        b=PxZNFQb6tRWIVB/oh/y+mkO956MqsAvFKZJSaNafXM7ZaAeXdlfLDnVI+Wf8znmuQe
         baDF0HnsOo5olni9dS6qBQGCulmoAmCiDYZYl+40eMIRq+0pE5PXC4OzWaLzFdI/Y4oM
         9UNArVSAd47LkePD5909ajFznKFX78/QQggwYKu5u3DIwHem8zbqlFAcjZZDzeECuSTm
         5ESfv8DbJxzgTd0C84KIyN7YpyjThLyyShPz4Qu8bCbzP6ckMRA6YmtOx3oHrNkNeBWv
         8tUIMLqXtlDjSu4+MgV/XhzXoPZrpe/b3BDbk8KMJRr+/qXMN0PQOcx9dVYWTts7NIhx
         /FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TyDtIBZ/b6jNbw8Fg/X93utCMqZp3mIZumdRr4BC1ys=;
        b=oNku8UTCth5Ss1vy7I+tCuz/30X+0e3p6xEFOWF9PChUoNNGIKvFwy9uVydP+z4K8d
         buhQpEUOM5upkM9dxeKPuULHA6Bi0V8MVNZM/NXXsIesf3XEFjBs0a1qNqfNT9M5ib6G
         ZoTie7apdU2WEyplZShsRo52abKzZsXHdYZF9ZHZ8b8z5o++lM7ZaHtOtifN/wczHE0S
         ZQQ2l+dzmgGnYpqIwpdzVaHdr9Qgr/vOzRGgdxN0CyBZJr4kMyLuSi2795ZrvDARAago
         flKAMpgKehLruL842b7OVO8cyQ6mrtcqbP4oCoj/kMNH4QnR9iIMpY3Kdqu+O7eUOqfT
         bjgA==
X-Gm-Message-State: ACrzQf1GYksMlfocl06jEVgmPXHra+4oPSm2zGUh/6rd3cPr+RUZCLzh
        AbnGj/Rz16EYijlJfXb9+ya2/Q==
X-Google-Smtp-Source: AMsMyM4UxTw00TXiFkFvZOhxBgpeuK2v7ANJB3EVXClVqbCtymSg02pRTD98y0DpEr9uVxMvviZ8YA==
X-Received: by 2002:a2e:5d0:0:b0:26a:9a2d:ca90 with SMTP id 199-20020a2e05d0000000b0026a9a2dca90mr3032480ljf.102.1664566203545;
        Fri, 30 Sep 2022 12:30:03 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049f9799d349sm393603lfb.187.2022.09.30.12.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:30:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 06/16] arm64: dts: qcom: sc7280-idp-ec-h1: add missing QUP GPIO functions
Date:   Fri, 30 Sep 2022 21:29:44 +0200
Message-Id: <20220930192954.242546-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

Add default GPIO function to SPI10 and SPI14 chip-select pins on SC7280
IDP, as required by bindings.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
index b35f3738933c..3cfeb118d379 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
@@ -95,11 +95,13 @@ h1_ap_int_odl: h1-ap-int-odl-state {
 
 	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high-state {
 		pins = "gpio43";
+		function = "gpio";
 		output-high;
 	};
 
 	qup_spi14_cs_gpio_init_high: qup-spi14-cs-gpio-init-high-state {
 		pins = "gpio59";
+		function = "gpio";
 		output-high;
 	};
 };
-- 
2.34.1

