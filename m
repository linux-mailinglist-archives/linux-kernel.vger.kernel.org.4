Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E6161F6C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiKGOz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiKGOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:55:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CCC1E3E4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:55:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id k2so30846219ejr.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgfM4NTtnCK306YjpvWBBimKN7eI2DmTNzB4KqfbC+M=;
        b=gG1L58n/R8ro4416FI66rwb9ygjwbzvjvCJaufUO4NnnTpEWCCR7kQimaBpcyzVk6D
         7PczhDbZ1S0dBigYk5wAvbA4ii95lLeaq4zVi8KaofbZLFVVMV4GZjDRfmCxyJ9+fU+k
         M6Axs5DFRZ5mF+TTge0MFSkHD1Tko+1HCOiBr0pj7BAVj/cRxui4wMWxhLiriS1R/dCx
         smncyhoF61jdP0SnQWnUuOUBDN++ybsi2NV4eb5zHt39was/JRhKHRQdziyucaMGS08L
         8DQqgxjPc7g5DYQZ+bVp4MqaEXGNtWuOhLonEQHGKu8mcBXUpXXXie31PjGmK9oV/xKT
         LPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgfM4NTtnCK306YjpvWBBimKN7eI2DmTNzB4KqfbC+M=;
        b=tyyo1XkP2n8vLzbKAeknKjusuxOakkM1ZKz60WyN95yo8qyXBgmU+Rq23S5MEQIT+l
         pnKFzTFLi9G6dPFbCjU3m2ypG9u382QfuB+bHPcQ9X80cQ1BwxOMgKFia5jJvdyMV/Qp
         d9crBvMHWn4cmgEF84Vb3K/rKrd8PxBLoXBBvabh/ebMJO5TLOxf1GKc6GnnclxymU0x
         gwqRB8Qc3+VDOmsaNyoBjoCrJwpv0mspXMmGl2OGTA4vK96/rs+Wao4jADGrgcQM30zK
         AUMJBiZCBos9ACZZIQNhhZ1IbnGR5c0/DxwIMhierN0uaZeGMURI/Q6ZQU3/y17BafUa
         KNDQ==
X-Gm-Message-State: ACrzQf0j5jDkCcHYO8EHl0EqXYVU4f8bg7pzvdWBAK6MXTuVpMzQDBt1
        jZ/iHEcJuY6NKDousht/GeivnQ==
X-Google-Smtp-Source: AMsMyM7DVL1VthJLULQ91psrVUH89eBu/bhVpkNaeN8xijgAnPYeuxJGPApeDjzkdq4l0iWOtYsDLw==
X-Received: by 2002:a17:907:7632:b0:7a1:d4f0:e7c5 with SMTP id jy18-20020a170907763200b007a1d4f0e7c5mr48698760ejc.160.1667832930229;
        Mon, 07 Nov 2022 06:55:30 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067f0100b0078907275a44sm3503049ejr.42.2022.11.07.06.55.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Nov 2022 06:55:29 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] arm64: dts: qcom: msm/apq8x96-*: Fix up comments
Date:   Mon,  7 Nov 2022 15:55:12 +0100
Message-Id: <20221107145522.6706-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221107145522.6706-1-konrad.dybcio@linaro.org>
References: <20221107145522.6706-1-konrad.dybcio@linaro.org>
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

Switch '//' comments to C-style /* */ and fix up the contents of some.
Make sure all multiline C-style commends begin with just '/*' with
the comment text starting on a new line.
Also, fix up a single raw '2' to PM8994_GPIO_S4 while at it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8996.dtsi       |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 7f10372178d6..6ad7e5c78ae1 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -560,7 +560,7 @@ pinconf {
 			pins = "gpio5";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-low;
-			power-source = <2>; // PM8994_GPIO_S4, 1.8V
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
 		};
 	};
 
@@ -569,7 +569,7 @@ pinconf {
 			pins = "gpio19";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-low;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
 			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
 			bias-pull-down;
 		};
@@ -580,7 +580,7 @@ pinconf {
 			pins = "gpio8";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-low;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
 			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
 			bias-pull-down;
 		};
@@ -590,7 +590,7 @@ audio_mclk: clk-div1-state {
 		pinconf {
 			pins = "gpio15";
 			function = "func1";
-			power-source = <PM8994_GPIO_S4>; // 1.8V
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
 		};
 	};
 
@@ -602,7 +602,7 @@ pinconf {
 			drive-push-pull;
 			bias-pull-up;
 			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
 		};
 	};
 
@@ -623,7 +623,7 @@ pinconf {
 			input-enable;
 			bias-pull-down;
 			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
 		};
 	};
 };
@@ -679,7 +679,7 @@ pinconf {
 			input-enable;
 			bias-pull-down;
 			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index df0f67c223bb..4dccde54dd2f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
+/*
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.38.1

