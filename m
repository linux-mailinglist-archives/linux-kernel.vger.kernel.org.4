Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6273862D8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiKQLB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiKQLAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:00:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8376FAD1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:58:51 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id c25so2206046ljr.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmKcDm7hddmC/x4qiaZJDVe0loHtuACJqTTAG7FSgII=;
        b=p51ZwemdiBWYVixFemwKQeNFdvrcnE7Od76T1rNvhrukAot/C+POHfwKajWdn6N5BU
         dUjIOwjULWKBOS3ulKnlRPqbcsf3E0LGwqKip5PqnpIfdeYz07/ZwWTCHiOhc7cORrsg
         kC7TEkw8oBIJAxF8diOb70F21m3H7pkaS+aG4clKTX4Y4jaAzhf+7o/bHRvPV0aJGXy6
         vtDtFd4IYT41Dt6iHyZ92hbuCnSlB2DD5hyAySRTErBd0LceFP8U3BS/eDN97TMJW3I2
         Nyk0n1EfvMwPMTRqqFK4tnUFmeuQVXZACwnMJgbjJxYr/QT+lglIIM05FYtXf1EP7qRB
         Dciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmKcDm7hddmC/x4qiaZJDVe0loHtuACJqTTAG7FSgII=;
        b=CgLCA9uiaJborLOFhZZXqXW8zN0Zs4nwZpJ/LK2wsJA/DRRVJTzCqeKATSsKNkK972
         cdPZRdDB69gekCU5u2vSZNSbyaQKjxxh2a3Nr3Mm7LFtT76XjWsaE4B4uh81ye6LJDyn
         jJ+FChIC9cu7ZyGUrWXBmR4sEz1Cghndd3xcp5/JYE+SsWUAr75IYrIs/XTVUW79Frty
         CNRLItZXDhA+GKlO8r1LNRXZk5rS5+MQBLNAGxKBYmnEXfEBCC4u6wQGsKiDc7jhYnz7
         FDkEaVwrfTML6Pbwpnhshiz7VpP+DHOC3yfmeE8CxH9P6MrtmNkT/mQSgbVlRx/tkJxo
         F5jQ==
X-Gm-Message-State: ANoB5pkhsUJhQRbW7zxGnBvCO2LC18FIO4rzps0CVSYUdQqZygwVjv7L
        ixZPTVATAEzsIA4prnehwXRmba8ZugeeJvGV
X-Google-Smtp-Source: AA0mqf6jXayNUYuYVM/Q2O9jVhnf8jCQmWn9Jur7Dg3gxDEdyjQAxO00cv2p5RDoW6obLrAprLCfcg==
X-Received: by 2002:a2e:a553:0:b0:277:665c:eb4c with SMTP id e19-20020a2ea553000000b00277665ceb4cmr772966ljn.287.1668682730109;
        Thu, 17 Nov 2022 02:58:50 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id d7-20020a193847000000b00499cf3e3edcsm89123lfj.296.2022.11.17.02.58.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Nov 2022 02:58:49 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: msm8994: Drop spi-max-frequency from SPI host
Date:   Thu, 17 Nov 2022 11:58:44 +0100
Message-Id: <20221117105845.13644-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

This is a device property, not a bus host one.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index adcea31a0c68..9ff9d35496d2 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -554,7 +554,6 @@ blsp1_spi1: spi@f9923000 {
 			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			spi-max-frequency = <19200000>;
 			dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
@@ -692,7 +691,6 @@ blsp2_spi4: spi@f9966000 {
 			clocks = <&gcc GCC_BLSP2_QUP4_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
-			spi-max-frequency = <19200000>;
 			dmas = <&blsp2_dma 18>, <&blsp2_dma 19>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-- 
2.38.1

