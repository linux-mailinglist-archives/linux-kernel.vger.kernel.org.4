Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3F5E9254
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiIYLGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiIYLGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:06:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571AB31ED5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bu25so4876874lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZUzEaSllhqvzoVgJ7uqfQ1HJ9zhADuolKSzj+1WZwig=;
        b=oUjLFV5ndMlH6do8ocKXpCh33Dd8hcfHbop7KuwzwO8Q9v+hS35Ie4D7rmwbuRvw7U
         d5ADwhgfqfbdRUTcqfrVJZwmiglngMRS3w5dBnaV2x2BR9j59z+w42XBZU9w4c66BHs+
         WhA0v41RFSGG8GOXLVNQDsGHfZPjYCsnrLCW4wjZ9mJhQiGjNMjchd77QNmtpWyUT/5P
         bShsxhN++s4omRHiz2eCwGRQ0QGVqR6btt2k777Bygv9E1kLgfG9+Oj668ygPIrI0TV6
         iLm2j7qz3XUFwaA3cPDCOrkCFfC46Wy9bCUhXwAZg1yzKDFKfrVMI/IeJ+YkwGbtkUCX
         xu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZUzEaSllhqvzoVgJ7uqfQ1HJ9zhADuolKSzj+1WZwig=;
        b=KzK+NYioTzWvvnonUtK+MYB7ZKfFZOCBM7wIyy2/LF/LQNANo3iAyEJTV0/81aWoeE
         pQXDK2dUqRiX8mTzWtqwZVYkWEe74aiKwBKOk4KYj2iS6yFtLEyA2lKYT1YAsHQrF5E8
         ypuXANyj/Yiop5JKm9L+klYWOXwfT6zcg1dqd15Wjp8/DojDoxYAvWbQ22OQSN1PsI7i
         rVsxMEEEq9XGbIhewiRAUbCqHvlrFYHekWgVPENuCxThgRMb4E7oe01AWi8UNdwESYwa
         +rYonPcgB7wtRAeefTA9+jQuwohvlsnnaSd17vRSYno+czAyw3rdJxnMhU3k1ckRPLaN
         berg==
X-Gm-Message-State: ACrzQf208RIZuo/YG0NidfH6jJiozMueEv9WRIyZ2U8vAhP1CcmXym65
        0FUJayY2FEYRQSMQ85Aamt3hJQ==
X-Google-Smtp-Source: AMsMyM4b7i4gt7nRpoAFCdZhF5YO4Q43RnApfftf20qkRe/DF9WBCdcm6hl9GPG3NOGiWbL+3NLJ8A==
X-Received: by 2002:a05:6512:3a88:b0:49f:5648:87fc with SMTP id q8-20020a0565123a8800b0049f564887fcmr6480651lfu.143.1664103980586;
        Sun, 25 Sep 2022 04:06:20 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u19-20020ac258d3000000b00492dadd8143sm2177265lfo.168.2022.09.25.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 04:06:20 -0700 (PDT)
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
Subject: [PATCH 06/15] arm64: dts: qcom: sc7280-idp-ec-h1: add missing QUP GPIO functions
Date:   Sun, 25 Sep 2022 13:05:59 +0200
Message-Id: <20220925110608.145728-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add default GPIO function to SPI10 and SPI14 chip-select pins on SC7280
IDP, as required by bindings.

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

