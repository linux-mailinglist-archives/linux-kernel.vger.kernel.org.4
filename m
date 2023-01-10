Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADC3664B31
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbjAJSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjAJSh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:37:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5200AC57;
        Tue, 10 Jan 2023 10:33:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so10809159wms.4;
        Tue, 10 Jan 2023 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GJ8ePTx035rcaOd/R7rMyibrkKO9qKgvXnxhtNv8wo=;
        b=jVcHTQCVK9t530MD+GbBhBhkrdykmYYaikRUfRMkzER6WCSCuk52TZjXmE5jL08kxz
         tOE0SXt3TR9nzuswrwJYqjDCpSroY7L0oMquMJ1+GNvCKu1HS/+4YBldSQSu5DaxtG3Y
         ajp9G9OTVaoJe+8c7gBS6ot4AiR6a1i+kXPzr89/ISBon3pYFlvnBm8dJtYqLBmOomG1
         saADoc4WR23phN2jqFyLoQRwfD29fkG+7gyzpVZlfqv/GiOiJveEZURUHYwVpYBuSiBn
         ISOhsa/uqOJPpQNC9N7EYAfv+nJvTOJi0uK5Bmd4yU3YXL4AwQ2Pa9Mrfswp7aaLjgCE
         i0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GJ8ePTx035rcaOd/R7rMyibrkKO9qKgvXnxhtNv8wo=;
        b=CmJwaTII/quRoxI0vkSd7mx2SQNIT5abQVWLuS0Y8nZ9cBS3HGUJaLZa+hi5jea3Br
         BgWo1nRrKzZMNW1JMVsiHtyzyoF2Qra/bKN0bMzpDNBCHRz7Y/NDIS/3BqNk+YrVgb7V
         rp5zfj2T6YdNafcCxRKFbmb4NRn28mlrKoQ4HS5b/VgAq0XELtUlJATcldhCoBjfb1aY
         1mB67JOwxnqIWmEzc6Uy0gMwdm6hDIiOldbthjyreqMFiIu59+3hcAqZdW0zJI+g2Zic
         kvAfZSEteAviIBqxly5XTt+nYuKXd+mLRQ4JomihRdo0SvksBGEBHNYh/Jphy2UXCApp
         l5mQ==
X-Gm-Message-State: AFqh2kr2WMDXfChfFBADD9ThrOWf8I6LsI0uuwXKiLxbVecqrn4gG6wV
        uncBOwZ2pDo6Q1dqJJGhsBg=
X-Google-Smtp-Source: AMrXdXsDJamZKt9LmuLCN/NIHnaaF2+cGu7G4rrdCwCHt+XU7Q6mb96fHhM2xeLyMvz/nhVe0WGThg==
X-Received: by 2002:a05:600c:1ca5:b0:3d1:d746:7bca with SMTP id k37-20020a05600c1ca500b003d1d7467bcamr50292504wms.4.1673375591718;
        Tue, 10 Jan 2023 10:33:11 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id r126-20020a1c2b84000000b003d35c845cbbsm19927757wmr.21.2023.01.10.10.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:33:11 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 5/6] ARM: dts: qcom: fix various wrong definition for kpss-acc-v1
Date:   Tue, 10 Jan 2023 19:32:58 +0100
Message-Id: <20230110183259.19142-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230110183259.19142-1-ansuelsmth@gmail.com>
References: <20230110183259.19142-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtbs_check warning now that we have a correct kpss-acc-v1 yaml
schema.
Add missing clocks, clock-names, clock-output-names and #clock-cells
bindings for each kpss-acc-v1 clock-controller to reflect Documentation
schema.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi |  8 ++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1e68b42acb91..af84f2d350ef 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -389,21 +389,37 @@ timer@200a000 {
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
index de87fcaaa836..e796094a7af5 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -580,6 +580,10 @@ l2cc: clock-controller@2011000 {
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		saw0: regulator@2089000 {
@@ -591,6 +595,10 @@ saw0: regulator@2089000 {
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		saw1: regulator@2099000 {
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 3bd07cac315b..4fd56d85be3f 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -208,11 +208,19 @@ regulators {
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

