Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0347B6C4EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCVPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCVPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:03:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D734ECEE;
        Wed, 22 Mar 2023 08:03:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o11so19559042ple.1;
        Wed, 22 Mar 2023 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679497431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smYcs7fLtGwmFdHuuP1DnYf9p3IVPubqdNb8zF92Q1Q=;
        b=pu+s50skGOCGdHbeFUVOK8KQOkSXZ2vr9++OFaZRJ3JDm5cCYr6aDdBIIO+xT6C88i
         vbF6WR8dpIaXFstPLqtnKBkgydwjpB1jFAPXrcw6/8ZIikJIblq0LSiU64XxNk1TxdHP
         ITJgNTst6f/agl5MD9dRAYifmNdUzH49TW9k8WQNQPrskXO3NB2eMmWsnyapbc1cNatG
         eadTIUqvy/VuBZfQa3fa8FREuaKyYbqNfEF225foh6q7YJrxqGUU5YcoAMkBonW3aOyo
         t9K2V5/XI8UDxTGf1TEAfQ0EEw3XmewyPidADr2yIdQhHHNf0MzU4kbDE7oTErUB0n+I
         Gy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smYcs7fLtGwmFdHuuP1DnYf9p3IVPubqdNb8zF92Q1Q=;
        b=ZhCynz0vSlhJ6kNtVyGd1ueCIS6kqplx5c/oXu88fn2nHrExUvYVSLJ9kN3D0rtuG7
         6OmlEKR6DgCzA+CK8bsjSSX2g0Dz7PSHMk3SXigmZeureX5MB5IP++2UMuhi8SgTQE68
         2smkoplbdMzEbCrq8UWwTzhgYEh2cD0zCjDa1niQ+gFqPFT7PYo4JVmGiyyKdd1Va2Y2
         AKQDTQ02/FYH2cLbvPZ5jnqVuZVBfQIoC8i/uM8ae7RTXIejUTUmd80NfCIoxhnucsU8
         Lponjbh6evhhTXCcb0BlVGl+JtLJgqKH4U4pNOFr/QwY8xGd10Go1bZB1uvO2CrXpa6g
         8uNg==
X-Gm-Message-State: AO0yUKUoPmsEQpt/NYPYe0USJDXLJzc5KtC28y8p4meSnBdgU9DWBNrD
        LHf5uX7zbKD6vlTyN9IXDDfOtwcw7K6LpQ==
X-Google-Smtp-Source: AK7set8uqW9C1bybyP65LspV1SJDWf5To2sO736+biVwh/7Yn0mR/jS3o6X7MSAAjkS4xfoJLQ3wOQ==
X-Received: by 2002:a17:903:1c6:b0:1a1:d366:b085 with SMTP id e6-20020a17090301c600b001a1d366b085mr3225108plh.21.1679497430773;
        Wed, 22 Mar 2023 08:03:50 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id o7-20020a635d47000000b0050fb4181e8bsm2761238pgm.40.2023.03.22.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:03:50 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH 2/4] arm64: dts: qcom: sm8250-xiaomi-elish: add mdss and dsi node
Date:   Wed, 22 Mar 2023 23:03:18 +0800
Message-Id: <20230322150320.31787-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322150320.31787-1-lujianhua000@gmail.com>
References: <20230322150320.31787-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xiaomi-elish uses dual dsi mode panel and dsi phy type is cphy.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index a43d4b73ffca..3f1d43a00b66 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -469,6 +469,74 @@ &cdsp {
 	status = "okay";
 };
 
+&dsi0 {
+	vdda-supply = <&vreg_l9a_1p2>;
+	qcom,dual-dsi-mode;
+	qcom,master-dsi;
+	qcom,sync-dual-dsi;
+	status = "okay";
+
+	display_panel: panel@0 {
+		reg = <0>;
+		vddio-supply = <&vreg_l14a_1p88>;
+		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight>;
+
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				panel_in_0: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1{
+				reg = <1>;
+				panel_in_1: endpoint {
+					remote-endpoint = <&dsi1_out>;
+				};
+			};
+
+		};
+	};
+};
+
+&dsi0_out {
+	data-lanes = <0 1 2>;
+	remote-endpoint = <&panel_in_0>;
+};
+
+&dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	phy-type = <PHY_TYPE_CPHY>;
+	status = "okay";
+};
+
+&dsi1 {
+	vdda-supply = <&vreg_l9a_1p2>;
+	qcom,dual-dsi-mode;
+	qcom,sync-dual-dsi;
+	/* DSI1 is slave, so use DSI0 clocks */
+	assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
+	status = "okay";
+};
+
+&dsi1_out {
+	data-lanes = <0 1 2>;
+	remote-endpoint = <&panel_in_1>;
+};
+
+&dsi1_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	phy-type = <PHY_TYPE_CPHY>;
+	status = "okay";
+};
+
 &gmu {
 	status = "okay";
 };
@@ -533,6 +601,10 @@ fuel-gauge@55 {
 	};
 };
 
+&mdss {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
-- 
2.39.2

