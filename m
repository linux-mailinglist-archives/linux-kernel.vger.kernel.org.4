Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB25FFFFD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJPOs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJPOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:48:19 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A2723C8C0;
        Sun, 16 Oct 2022 07:48:09 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id BA3871402CA;
        Sun, 16 Oct 2022 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665931689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4Dcgfs7tb87jF5kiMXTGRJf9D6ZKn+2WZ6hnvK634Q=;
        b=IzlnLThDTaT2YKIbc8mEhq8RzqbUFtlOXUAgaZTco5Xj2hsFOY2skV89+2FNVlH3+L8tNc
        YEBnOvOZRnKBu1Qcbb7b7Q6XThYYKHN6sf06X0fTIwQfJCm5zpOa/YucO2FjUfWJu8wQdq
        rvZxJmEYjYNeAJeVWXVgYjleQRqZ3Do=
From:   Caleb Connolly <kc@postmarketos.org>
To:     caleb@connolly.tech
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [RESEND PATCH 5/7] arm64: dts: qcom: sdm845-xiaomi-beryllium: commonize uart6 pinconf
Date:   Sun, 16 Oct 2022 15:47:11 +0100
Message-Id: <20221016144714.1742824-6-kc@postmarketos.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016144714.1742824-1-kc@postmarketos.org>
References: <20221016144714.1742824-1-kc@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caleb Connolly <caleb@connolly.tech>

Use the new qup_uart6_4pin configuration in sd845.dtsi and fix alias
name.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 29 ++-----------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 82c27f90d300..1646db2328d4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -35,7 +35,7 @@ / {
 	qcom,msm-id = <321 0x20001>;
 
 	aliases {
-		hsuart0 = &uart6;
+		serial1 = &uart6;
 	};
 
 	gpio-keys {
@@ -481,6 +481,8 @@ wcd_intr_default: wcd_intr_default {
 &uart6 {
 	status = "okay";
 
+	pinctrl-0 = <&qup_uart6_4pin>;
+
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
@@ -567,28 +569,3 @@ &wifi {
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 };
-
-/* PINCTRL - additions to nodes defined in sdm845.dtsi */
-
-&qup_uart6_default {
-	pinmux {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "qup6";
-	};
-
-	cts {
-		pins = "gpio45";
-		bias-disable;
-	};
-
-	rts-tx {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	rx {
-		pins = "gpio48";
-		bias-pull-up;
-	};
-};
-- 
2.38.0

