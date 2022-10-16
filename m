Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924FE5FFFF3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJPOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJPOsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:48:06 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6BF12AC62;
        Sun, 16 Oct 2022 07:48:05 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 07EBA1402C7;
        Sun, 16 Oct 2022 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665931684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jo1uU7GEhjOukEJcgVyoGH+HR9H31RAu1BOcT7Z3Z+c=;
        b=OF8f2nrJsZ74uJefLJb7K7FPAJPsJNzrItFSdMGm35r8yFqfzR+7iOvR5aPi+sVfeuj89z
        pHE53vBOy4zJJHyITW9XbwhcxxZi/gSzUhoCl+XvlLfdzuPAXJIeIY3Y+6vUwPYBNUgXxC
        yhvvXFiHlowy0G9SGy/tbJZfzsXo2Bo=
From:   Caleb Connolly <kc@postmarketos.org>
To:     caleb@connolly.tech
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [RESEND PATCH 2/7] arm64: dts: qcom: sdm845-cheza: commonize uart6 pinconf
Date:   Sun, 16 Oct 2022 15:47:08 +0100
Message-Id: <20221016144714.1742824-3-kc@postmarketos.org>
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
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 39 ++--------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index b5eb8f7eca1d..a8ae6de51af4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -16,7 +16,7 @@
 / {
 	aliases {
 		bluetooth0 = &bluetooth;
-		hsuart0 = &uart6;
+		serial1 = &uart6;
 		serial0 = &uart9;
 		wifi0 = &wifi;
 	};
@@ -860,6 +860,8 @@ i2c_tunnel: i2c-tunnel {
 &uart6 {
 	status = "okay";
 
+	pinctrl-0 = <&qup_uart6_4pin>;
+
 	bluetooth: wcn3990-bt {
 		compatible = "qcom,wcn3990-bt";
 		vddio-supply = <&src_pp1800_s4a>;
@@ -1079,41 +1081,6 @@ pinconf {
 	};
 };
 
-&qup_uart6_default {
-	/* Change pinmux to all 4 pins since CTS and RTS are connected */
-	pinmux {
-		pins = "gpio45", "gpio46",
-		       "gpio47", "gpio48";
-	};
-
-	pinconf-cts {
-		/*
-		 * Configure a pull-down on 45 (CTS) to match the pull of
-		 * the Bluetooth module.
-		 */
-		pins = "gpio45";
-		bias-pull-down;
-	};
-
-	pinconf-rts-tx {
-		/* We'll drive 46 (RTS) and 47 (TX), so no pull */
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	pinconf-rx {
-		/*
-		 * Configure a pull-up on 48 (RX). This is needed to avoid
-		 * garbage data when the TX pin of the Bluetooth module is
-		 * in tri-state (module powered off or not driving the
-		 * signal yet).
-		 */
-		pins = "gpio48";
-		bias-pull-up;
-	};
-};
-
 &qup_uart9_default {
 	pinconf-tx {
 		pins = "gpio4";
-- 
2.38.0

