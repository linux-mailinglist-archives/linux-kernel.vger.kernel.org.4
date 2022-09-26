Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754025E9AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiIZHot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiIZHoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:44:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F973135F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s6so9477794lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bp5cvx9fIhQfhCXFHIFjM/9YPHYEQQKS2L+foqEXDwU=;
        b=K8R8T71OFh1qFXgRIofeKlRvO7UoChMKeiC5oPlg/CFU2MZvkNjjJn75IlUF8x3yvJ
         qb6ER8LBxkKwQ4jkyW+yevZ/yKmAyhCdH39VCga8IOkgDkD2BSmHcXNTnHJhz2MvVxKy
         QZ4T5kjELiR4P8IGbK3y9tM/32LB23tljJjwIBXmDEbPnorffd25SXpu9KQMTFR8LRax
         b7NWtbEjI7efqDVfPDps+2kyHtHGpIQF3sQw3eRgkA440VFy2D0WvHu1kid82BGDrgIT
         MlL1QObp8kHscA0I1mdV77tdhUH0UL/52BCLBoZ7BT709JZwAEztP8xQkwzSHO8aeeR4
         R6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bp5cvx9fIhQfhCXFHIFjM/9YPHYEQQKS2L+foqEXDwU=;
        b=5pPjlqCf5W8J45jgeG13wIOuvZSsRIM2G4+PUav0wKXjZ0XndC74dgyEPyKziSsm9/
         Bx5zoEaRog9yGOnZXuLAhzKxTvGStnINrKq/qFZRQ6uZltdYIv0iL3ip3WJXxAYNqovh
         TWQSP/TWoozEGx/CiAfaDqhSIQ0iDFkguCTdDBN1PZeUu8VL+8DttE2CDYR+sg3rRBEX
         UFHYRN+7rBXPSlWIep9kP3W7q5ab8088p+KJ+hlZ3ChR9j+wSJPpW8vfaDgusfmchpEU
         C3iNuPKbdOiDtYJBY6oiQuhFcBQbDOjUnoC/LyIETNCAXsEhcQQYDjFoVYxHN9B8tTnO
         S3Aw==
X-Gm-Message-State: ACrzQf0FTVeRZPIujsd/QC4fh7UH94RX/4WConPQI2MORiYf/1QyMtmy
        VraXw1RP/uVf1H/2mJ6O8DXtuQ==
X-Google-Smtp-Source: AMsMyM68O/1nAWGajx8MRDDW7F0SbcoXWSW5BTnmXX7jp3el8aMS+RH03l2EzDTVNJEK+5+hi3pGsw==
X-Received: by 2002:ac2:464b:0:b0:49e:b29c:2b04 with SMTP id s11-20020ac2464b000000b0049eb29c2b04mr8033402lfo.127.1664178266704;
        Mon, 26 Sep 2022 00:44:26 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:44:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/33] arm64: dts: qcom: ipq6018-cp01-c1: correct blspi1 pins
Date:   Mon, 26 Sep 2022 09:43:43 +0200
Message-Id: <20220926074415.53100-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
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

When BLSPI1 (originally SPI0, later renamed in commit f82c48d46852
("arm64: dts: qcom: ipq6018: correct QUP peripheral labels")) was added,
the device node lacked respective pin configuration assignment.   It
used also blsp0_spi function but that was probably the same mistake as
naming it SPI0.

Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index 1ba2eca33c7b..afc2dc79767d 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -37,6 +37,8 @@ &blsp1_i2c3 {
 
 &blsp1_spi1 {
 	cs-select = <0>;
+	pinctrl-0 = <&spi_0_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	flash@0 {
@@ -57,7 +59,7 @@ i2c_1_pins: i2c-1-pins {
 
 	spi_0_pins: spi-0-pins {
 		pins = "gpio38", "gpio39", "gpio40", "gpio41";
-		function = "blsp0_spi";
+		function = "blsp1_spi";
 		drive-strength = <8>;
 		bias-pull-down;
 	};
-- 
2.34.1

