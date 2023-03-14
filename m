Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6815D6B9E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCNScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCNSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6DE8DCE8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m35so1490746wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4AMa6Oqf4gT2LvWhoj3//Gdma5toQWQSvKa1CfmIFA=;
        b=MfpriJTqV7XxmV1DbN+XH1LuZMZxc5ZxvVRiNNADhMQCGEp+jK96jkBJFoiQBmFGwq
         V7+4ovPI2mAs1NkhnGwuLpI9yppJ5AIq6ZQbKiCNe5ok7nnE+xYFNjeXMvb6xnQd4XW/
         EMmfKgKPus/wkcrySLpQgVaDeoNaOMWStIC72e3g298cugZgT8FHqS3CF76ZF4jufZ5z
         WqVwYsO5V6OiayRQE2hVh03LmPDQCOKsEqTvHjO/SGzWcubnDoNELWWhXtygMehvR1Pe
         7LUHwSaKFeP4Vk0cdKadCR9ufs+LEAqCYSATRckai0YwCJlFD6K/xQEEnoAGsMHbLB3p
         7GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4AMa6Oqf4gT2LvWhoj3//Gdma5toQWQSvKa1CfmIFA=;
        b=ziBSJlmH4/Bzt6YfqtKwZeqiD7ro5pQ7WkQeYonIWSh6CY48iMYo7o/6bcsTn/Tm8H
         f8+m/2LZJnaS+Wj9T+44FNtQ+Dc0Rlk8L2xj6C4D+peH7DUaYyWTB+XGDMP3akMVm+5h
         h1Y5H8eF6B8sNJbtnTfMfr63l/nY0dEXwvRZ7XtA1P8pGMXW7Vpd+wUB4mD5Lg/GQb3d
         rnJLLC0PCgnOe7X7YXhIJ1ok8JeYkVpqnub9WCHbVfsa9EZV5Xznp+CY3GI1TyIenReL
         79XBfo+QCi8n73v96jJEdld22U9WwP/HcBCUxELI2GbTudUCAvNjCz25OOSp5g94nR/N
         s5gA==
X-Gm-Message-State: AO0yUKVRjqQJVR2Y9ZUX5egDPJyeAmbYcUuwk1JChZldLJdpwPQvbDjK
        9PQq1RQNvYyJUIn6hr5Hg3x2p8EQsCHOBMHF4eY=
X-Google-Smtp-Source: AK7set/sLhpCzzE4tmqIVfeHOmnwAcyar8EBJ+MIbwS2ol79sXUSmUiapA9ffjldZL4BDjOBr9p2CA==
X-Received: by 2002:a05:600c:a46:b0:3ed:276d:81a4 with SMTP id c6-20020a05600c0a4600b003ed276d81a4mr6734519wmq.32.1678818666912;
        Tue, 14 Mar 2023 11:31:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:31:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 14/14] arm64: dts: qcom: sa8775p: add PMIC GPIO controller nodes
Date:   Tue, 14 Mar 2023 19:30:43 +0100
Message-Id: <20230314183043.619997-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add GPIO controller nodes to PMICs that have the GPIO hooked up on
sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 437cfa8aee2f..9386a113f1f8 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -77,6 +77,16 @@ pmk8775_0_pon_resin: resin {
 				status = "disabled";
 			};
 		};
+
+		pm8775_0_gpios: gpio@8800 {
+			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8775_0_gpios 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pmk8775_1: pmic@2 {
@@ -98,6 +108,16 @@ pmk8775_2: pmic@4 {
 		reg = <0x4 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pm8775_2_gpios: gpio@8800 {
+			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8775_2_gpios 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pmk8775_3: pmic@6 {
-- 
2.37.2

