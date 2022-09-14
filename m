Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3AD5B8A60
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiINOYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiINOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:23:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B65FF6F;
        Wed, 14 Sep 2022 07:23:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dv25so35052855ejb.12;
        Wed, 14 Sep 2022 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=ijfd/KEvWiVHFi8qWZkJIfx2KvjCedIXtUu+NcucKas=;
        b=OGpl1Z5DR2/BX9QVocNr1GLZfpY+ayZQFlMsRN7BhoTKX+AkFybuRHLQSmcgXAG9W3
         9VY97bBWK6E3f84JvXN6Xql4gvp59UGZC636/1+OJVaf9MNTNJBnQCoT9sblz+5/kBGt
         lLFVVUWAG1+qu0Wluu0gdjTowmutwmgoMnY6fCjJHXjdVJDTnlehMWg0JXcNENMRv/1H
         WQgxmQoNkdQyuZ0O4vlWiZeKFT5i4Jid5Lw2gY9djZUDUIWUGFYP+LxSIyqLj2d+A6U0
         V11mZ9aZrGVwXPvebcvOYQsLtaseKT9f9VXI8e7cD4ySnOcc/MoqjmXxiUpI7kpORqD1
         lFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ijfd/KEvWiVHFi8qWZkJIfx2KvjCedIXtUu+NcucKas=;
        b=vBgFtqqtUSKoynHvgr7/Wken+Y4/4xe2ja7M6YwuYmJWsfH3Z6aCP1O/14NSHt9bkx
         MaN1t8ZIEPgE/gWx5guNkDW5nbLH3GBNk5BbE6XP6DDmZjzP703m8rbnbbQjOUMh+AFo
         nhRR/wQGw2C5AXWBpXQEwaLBbyhaheeW/5Cqk810jKwBXaUDX8+KrgUp5D1M1nhqwaw3
         4xO48LpFs4Xz5haAUqEcHEtJwSYQlBiRmrSxsr3BbzMoPllqLjsOT6no3lh9bdqUkjqG
         9RJJleqLo5V7QmEC8PDSGJWVHQZ03bQDTQttaVlrwMWadHhD2zAimMy6gccF9zdQKpYd
         3Qyw==
X-Gm-Message-State: ACgBeo1iYsMVXvjEGhYW6Xfr0ajbpc3EfXeYzkFHaDzOXO0TtnKdFtM8
        n3mOVp2OLmr2xxndmBkluO4=
X-Google-Smtp-Source: AA6agR5ANKhQdvquky64nWxMWCew9jms0d+yYvrh0dhWB8YyYtRi8FRSlG9Huz2tZWcCf1qGVbvNWQ==
X-Received: by 2002:a17:907:970b:b0:77d:e675:9674 with SMTP id jg11-20020a170907970b00b0077de6759674mr9852363ejc.81.1663165399610;
        Wed, 14 Sep 2022 07:23:19 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id 9-20020a170906310900b00779cde476e4sm7614773ejx.62.2022.09.14.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:23:19 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 5/5] ARM: dts: qcom: fix various wrong definition for kpss-acc
Date:   Wed, 14 Sep 2022 16:22:56 +0200
Message-Id: <20220914142256.28775-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914142256.28775-1-ansuelsmth@gmail.com>
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtbs_check warning now that we have a correct kpss-acc yaml
schema.
Add missing clocks, clock-names, clock-output-names and #clock-cells
bindings for each kpss-acc-v1 clock-controller.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi |  8 ++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index ecf28260fd8c..8e9cb9d5aa30 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -388,21 +388,37 @@ timer@200a000 {
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		acc2: clock-controller@20a8000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x020a8000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu2_aux";
+			#clock-cells = <0>;
 		};
 
 		acc3: clock-controller@20b8000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x020b8000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu3_aux";
+			#clock-cells = <0>;
 		};
 
 		saw0: power-controller@2089000 {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 82c1483cd6ea..a6751c0c011f 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -503,11 +503,19 @@ IRQ_TYPE_EDGE_RISING)>,
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		adm_dma: dma-controller@18300000 {
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 98246e1b4f3f..14212c776635 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -173,11 +173,19 @@ regulators {
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		saw0: regulator@2089000 {
-- 
2.37.2

