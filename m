Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0207D5B8A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiINOYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiINOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:23:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097FB5F132;
        Wed, 14 Sep 2022 07:23:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id go34so35126845ejc.2;
        Wed, 14 Sep 2022 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=p5b6YAFtZ4THlJI0Cqp94W0SjnmecVJSsftfNeTC90M=;
        b=RxVaUcT0Pi8VbTJ1FP7mtH0JSuF8dZ4Ujsg3Hn1GAij6eoSTywQvNhDQEcz8OexO8Q
         XIOxS0PxUrym4ZVYHk1Kmh/5xarxeciQAZfjGHhGy0UzGXpCAylKmWZMbVFt5iKF1gh7
         LVYSS9/3FoCBX6bxK8c4E9tycKEjSwtyIDMnBMh4T+VcAxfWQF0TMHkRyrpsdxB45ViB
         XyighYZhop98yRi6kSN70vrcfqKIdcu9xqOE7XzBv8M6j+0/suX36gW/9nrMTC5AY4cy
         tBcZFBFXMQ5IuQWiXzzAxC80u0lJ3B4W0kIK3Fauy4ABipeFzLn1aNk+z++MRyh6ZBcv
         NhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p5b6YAFtZ4THlJI0Cqp94W0SjnmecVJSsftfNeTC90M=;
        b=LuxWBH2F00qgbi6mw0vYh6611Xil9s/2Yg3hc3xeLV4uAugyBLnid0A2uLhFK/KXEY
         QMKGTd+vrk9749z5N0vfzCA8gl/RqsFZFihKZ+ONiEkBEjTofbW3a+pDxfpFDGyiQa2d
         wNbktWJpcpE2DcPNy/yhVfcWJKAE6gt98drup3GKQZ1yk7hhstv8cCifw6s87ZEdCz3T
         mpQq6xDLkQ4wa0CfDcVtvqaNX+tYvD+QQN/+U82lQ0FEvki8n4kyK6oQN4lyr+LeUwDr
         va54xw1zotOMsfLTFfjfGDoLf0i6VnO08mUh3fnVQH9fOmSIz7ALt1NndlMERoHvhxG7
         Q14w==
X-Gm-Message-State: ACgBeo3v2bEBUJC5HiIDVEvLf0QOBIuOIGOdFzfQ3yomfgR6GrAbcgRu
        NAgoEtqDVMAv/3EFniCN84M=
X-Google-Smtp-Source: AA6agR6e1U/m0Yqdd7D7EkrwYVm59cIapakXskD49Wtb5sFQUR3dHcWwfUssk6ktOUiyn0oHoptPqA==
X-Received: by 2002:a17:906:6a07:b0:77c:936d:5092 with SMTP id qw7-20020a1709066a0700b0077c936d5092mr12210276ejc.167.1663165398019;
        Wed, 14 Sep 2022 07:23:18 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id 9-20020a170906310900b00779cde476e4sm7614773ejx.62.2022.09.14.07.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:23:17 -0700 (PDT)
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
Subject: [PATCH v5 4/5] ARM: dts: qcom: fix various wrong definition for kpss-gcc node
Date:   Wed, 14 Sep 2022 16:22:55 +0200
Message-Id: <20220914142256.28775-5-ansuelsmth@gmail.com>
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

Fix dtbs_check warning now that we have a correct kpss-gcc yaml
schema. Add additional qcom,kpss-gcc compatible to differentiate
devices where kpss-gcc should provide a clk and where kpss-gcc should
just provide the registers and the syscon phandle.
Add missing #clock-cells and remove useless clock-output-names for
ipq806x.
Add missing bindings for msm8960 and apq8064 kpss-gcc node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 5 ++++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi | 7 +++++--
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 257fcd497f86..ecf28260fd8c 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -845,8 +845,11 @@ mmcc: clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-apq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		rpm@108000 {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index a9bf2596a417..82c1483cd6ea 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -917,11 +917,11 @@ tcsr: syscon@1a400000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
 			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
-			clock-output-names = "acpu_l2_aux";
+			#clock-cells = <0>;
 		};
 
 		lcc: clock-controller@28000000 {
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index b47c86412de2..3a6bbe8a649c 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -152,7 +152,7 @@ lcc: clock-controller@28000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
 			reg = <0x02011000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index fd7751d4d886..7796f0e4746e 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -443,7 +443,7 @@ vibrator@4a {
 		};
 
 		l2cc: clock-controller@2082000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-msm8660", "qcom,kpss-gcc", "syscon";
 			reg = <0x02082000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index a5f1eda707b5..98246e1b4f3f 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -63,7 +63,7 @@ cxo_board {
 			clock-output-names = "cxo_board";
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
@@ -148,8 +148,11 @@ clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-msm8960", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		rpm: rpm@108000 {
-- 
2.37.2

