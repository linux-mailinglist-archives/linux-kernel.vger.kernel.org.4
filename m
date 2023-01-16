Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74466D089
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjAPUtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjAPUsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:48:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF627D78;
        Mon, 16 Jan 2023 12:48:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so28611089wrz.12;
        Mon, 16 Jan 2023 12:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+y549WFrfi+OlC1xxWy9ijxq65pYOOQO6QXWp02qzg=;
        b=LLI8lKQUa0dcarx6HlvG1MbOgJ5N6dpvhOTyMi1xu/so5dNtB44vYI/mA5KWxw301x
         CuVXn0PN6PxYuZnk+/TiBxlqI9kmjrEGqUmHrY0Kr4twmbXW7kj+1y1HDGpgQxz+HbUb
         pVfpddC94tTOT0zHBK6VfwIYMddlkhEyHbGlJJHgMz7vGmxm0GdjuZ5LdZjXpcl2Zi0+
         FDz+gVp7IdcNMQA9aQGR7RMH9kycSaEI15KpNW2RbmqrwwGf6imS9QwoPwVWmzk2ZT9K
         9WDCDIR4uwgHPxvQEQ7S+hdGmoTnLds6o85Tll0JGUVVDms0A3Nc2CuHtTDnmL+4/tJB
         uy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+y549WFrfi+OlC1xxWy9ijxq65pYOOQO6QXWp02qzg=;
        b=QcVM5zmYMVgKEhO4zVeiYHXwu+5AEMovepfmhNCim4nVJfrhhVJWZBVWTkdhM1XQF4
         U/Ha64CJB+DYMgemd4lc+Z9VbW29/MyuLw4XsnFgs2R4ssZa/fvcon0I6Qvi455vomsP
         n/7CBb8LEvtxqiiIC9MXJPdm+PkyGDK9lP0tJ8XL5tiGoNRJa/Oh8zMrB76BGYLOdsnR
         UyTflLp2O1ubIaAS3HuOPwlntiedHhkrpwgpf8FtAPHZDn+NysEIuJew3ze4k21r1PIG
         6a78PMeGEMMhi6VVsNx3HzevxMkgizvSVJ5hSzSNNh9JCfMTFPWWVh0k1wWN69y4jVC4
         9v5w==
X-Gm-Message-State: AFqh2kovyELvwk/lWeegw46oskbfGGTs7rtE5SqDmWx9TIVluHRkIhuC
        5MxWSDYRvCLMFmdsbWPhtAI=
X-Google-Smtp-Source: AMrXdXtMwhOwczW9Pbo3jHsnInhyTkJH/QdS+U3csjrJut+OGTaxO/KtwjftBWfaC+Q2GyoFXRU2ug==
X-Received: by 2002:a5d:4582:0:b0:2bc:5c5f:cdd0 with SMTP id p2-20020a5d4582000000b002bc5c5fcdd0mr8367554wrq.3.1673902085335;
        Mon, 16 Jan 2023 12:48:05 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm27785372wrd.40.2023.01.16.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:48:05 -0800 (PST)
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
Subject: [PATCH v7 7/7] ARM: dts: qcom: rename kpss-acc-v2 nodes to power-manager nodes
Date:   Mon, 16 Jan 2023 21:47:51 +0100
Message-Id: <20230116204751.23045-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116204751.23045-1-ansuelsmth@gmail.com>
References: <20230116204751.23045-1-ansuelsmth@gmail.com>
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

Change kpss-acc-v2 nodes naming to power-manager to reflect Documentation
schema.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 8 ++++----
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 8 ++++----
 arch/arm/boot/dts/qcom-msm8974.dtsi | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 4b0d2b4f4b6a..e70ab70b6697 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -353,25 +353,25 @@ saw_l2: power-controller@f9012000 {
 			regulator;
 		};
 
-		acc0: clock-controller@f9088000 {
+		acc0: power-manager@f9088000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9088000 0x1000>,
 			      <0xf9008000 0x1000>;
 		};
 
-		acc1: clock-controller@f9098000 {
+		acc1: power-manager@f9098000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9098000 0x1000>,
 			      <0xf9008000 0x1000>;
 		};
 
-		acc2: clock-controller@f90a8000 {
+		acc2: power-manager@f90a8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90a8000 0x1000>,
 			      <0xf9008000 0x1000>;
 		};
 
-		acc3: clock-controller@f90b8000 {
+		acc3: power-manager@f90b8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90b8000 0x1000>,
 			      <0xf9008000 0x1000>;
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index acb08dcf9442..442062b433fc 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -325,22 +325,22 @@ crypto: crypto@8e3a000 {
 			status = "disabled";
 		};
 
-		acc0: clock-controller@b088000 {
+		acc0: power-manager@b088000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0x0b088000 0x1000>, <0xb008000 0x1000>;
 		};
 
-		acc1: clock-controller@b098000 {
+		acc1: power-manager@b098000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0x0b098000 0x1000>, <0xb008000 0x1000>;
 		};
 
-		acc2: clock-controller@b0a8000 {
+		acc2: power-manager@b0a8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0x0b0a8000 0x1000>, <0xb008000 0x1000>;
 		};
 
-		acc3: clock-controller@b0b8000 {
+		acc3: power-manager@b0b8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0x0b0b8000 0x1000>, <0xb008000 0x1000>;
 		};
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 4b485f5612c4..705ae61ee35c 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -416,22 +416,22 @@ saw_l2: power-controller@f9012000 {
 			regulator;
 		};
 
-		acc0: clock-controller@f9088000 {
+		acc0: power-manager@f9088000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9088000 0x1000>, <0xf9008000 0x1000>;
 		};
 
-		acc1: clock-controller@f9098000 {
+		acc1: power-manager@f9098000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9098000 0x1000>, <0xf9008000 0x1000>;
 		};
 
-		acc2: clock-controller@f90a8000 {
+		acc2: power-manager@f90a8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90a8000 0x1000>, <0xf9008000 0x1000>;
 		};
 
-		acc3: clock-controller@f90b8000 {
+		acc3: power-manager@f90b8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90b8000 0x1000>, <0xf9008000 0x1000>;
 		};
-- 
2.37.2

