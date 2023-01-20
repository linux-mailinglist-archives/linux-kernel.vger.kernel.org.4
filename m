Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78516675BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjATRkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjATRkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:40:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F15DBC3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:40:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g10so4674763wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPLPvg2uT7xNYWk0DfZ111zSBkmikQxIwUT5J/mgO2c=;
        b=RVt/425eYeb1svgpsQcsE7Egizut7s4oCVOkqu3iBbdq2A3Yvo2+JwNybc6UMo3tvE
         ej4o6wHa6E7stF2mTCv2BBpaxeT/x/jG50PKDqjY7NFzS9sQDkNUW2WMgqPsor5qOSHC
         UeOG5ltZy0y1MdFqIljy82w/YbkIxBEt2TQlnDHKrw06Ehee+FwAdvagjEJTsRisNc+Z
         D6inwzhfGwhu/uGXxDTlWk1FDi7hyBpLUKixFSHU6VGQ7zWqb9t1bPlNsMnyrFd9h6hl
         Xk6TXmzNOmuKMJnBFNaZU55GSPrk2QMWkCa3isthkzyiiKE3R++yfjqB7KHgwBJ9sEfR
         0zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPLPvg2uT7xNYWk0DfZ111zSBkmikQxIwUT5J/mgO2c=;
        b=ip96dqJRbNWxpYbhvPLALJBTM68P0gQJOaxxnxf0PPwvwe9SFhun25kdYFcUboD8ms
         6oNiVQX6GC9NA5SsF5tvfYeLbw87qe02Fg1rQx9XADDU15fYZHx7hyGxZ95S96f9TKJO
         MEtRIowDInCnB16q3Q1MqPD99sJkrr+1a4j1QdcYE0jCCj/gKFqLTAZN37hK7gFmgauT
         qDXfu5nt71pqLnPFWDKHSELww6/sav1jbrL13RS7Z8pZnuLEFeYKtcAbERXEd4kOblX2
         3sI5PWegdOe1cxaFmalLVHeU3d/yPiBQrdZPvzfCBnmXnI2pRnB2LBC6u4j01eEAf4+3
         JCWQ==
X-Gm-Message-State: AFqh2koxGPgfaWzTr+ozBi+kE7Uo89xmMH8KhUS8vETam9iDseU+XM4L
        pWJ+3cfOBSVq0WhDvJ5A7fdvjX2yknn/saBM
X-Google-Smtp-Source: AMrXdXuOlPk+5uf/TXLUtIfdayDgrrFEdR/JC8sDpjol9StC6mUzODgxz8QP9mpVRIPgHzuB+NF7aw==
X-Received: by 2002:a05:600c:3514:b0:3c6:c6c9:d75e with SMTP id h20-20020a05600c351400b003c6c6c9d75emr15856181wmq.0.1674236439587;
        Fri, 20 Jan 2023 09:40:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b003db2dbbd710sm3467855wms.25.2023.01.20.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:40:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: qcom: apq8060-dragonboard: align MPP pin node names with DT schema
Date:   Fri, 20 Jan 2023 18:40:36 +0100
Message-Id: <20230120174036.351937-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

DT schema expects nodes ending with "pins:

  qcom-apq8060-dragonboard.dtb: mpps@50: cm3605-mpps-state: 'oneOf' conditional failed, one must be fixed:
    'mpp5' does not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Warning visible after:
https://lore.kernel.org/r/20230120165103.1278852-1-robh@kernel.org
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 7a4c59e04af6..8e4b61e4d4b1 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -435,15 +435,13 @@ &pm8058_led133 {
 
 &pm8058_mpps {
 	dragon_cm3605_mpps: cm3605-mpps-state {
-		mpp5 {
-			pins = "mpp5";
-			function = "analog";
-			input-enable;
-			bias-high-impedance;
-			/* Let's use channel 5 */
-			qcom,amux-route = <PMIC_MPP_AMUX_ROUTE_CH5>;
-			power-source = <PM8058_GPIO_S3>;
-		};
+		pins = "mpp5";
+		function = "analog";
+		input-enable;
+		bias-high-impedance;
+		/* Let's use channel 5 */
+		qcom,amux-route = <PMIC_MPP_AMUX_ROUTE_CH5>;
+		power-source = <PM8058_GPIO_S3>;
 	};
 };
 
-- 
2.34.1

