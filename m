Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB985FFFFA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJPOsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJPOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:48:18 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DE573C16C;
        Sun, 16 Oct 2022 07:48:09 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 49D501402C9;
        Sun, 16 Oct 2022 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665931687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMybwLMLlth99DWUE9yhG7qXyR2N9mR/hTWgjCOFWs8=;
        b=JnBz7UeTi8gPDABOMDauz6tUGd/qh5znUefQbgu+jLN2NRpPdP1EgEQhQBLhBpYVF3qTGP
        t8VG7PbR6z+phr8HrzXvIuScNAwNBE2GuRBhrAmewJbvB79Wu+lLqUDed8Y3ar47giiXdw
        PYGXm2bXybytVfmouYlVDpVuCddggm8=
From:   Caleb Connolly <kc@postmarketos.org>
To:     caleb@connolly.tech
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [RESEND PATCH 4/7] arm64: dts: qcom: sdm845-oneplus-common: commonize uart6 pinconf
Date:   Sun, 16 Oct 2022 15:47:10 +0100
Message-Id: <20221016144714.1742824-5-kc@postmarketos.org>
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
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 30 ++-----------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 392461c29e76..5d99908d4628 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -19,7 +19,7 @@
 / {
 	aliases {
 		serial0 = &uart9;
-		hsuart0 = &uart6;
+		serial1 = &uart6;
 	};
 
 	chosen {
@@ -500,35 +500,11 @@ pinconf-rx {
 	};
 };
 
-/*
- * Prevent garbage data on bluetooth UART lines
- */
-&qup_uart6_default {
-	pinmux {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "qup6";
-	};
-
-	cts {
-		pins = "gpio45";
-		bias-pull-down;
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
-
 &uart6 {
 	status = "okay";
 
+	pinctrl-0 = <&qup_uart6_4pin>;
+
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
-- 
2.38.0

