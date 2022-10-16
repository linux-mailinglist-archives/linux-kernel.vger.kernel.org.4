Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6CE600270
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJPRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJPRaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:30:17 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90D3023EA0;
        Sun, 16 Oct 2022 10:30:16 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 653D41402C7;
        Sun, 16 Oct 2022 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665941414; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmAHFNIPG4R/4pg5dzKf5wTHE0K6fc3VSz40IAZ3aos=;
        b=JtfiFXJbdAObywfWqWqIjMLBMs/u5TAxwC41ktdma2SZ1trRHyQJUKn7uUyTV4CUP0ADj0
        nXE6GW+q4pV8j5ClPOONtv1C5Ui31jAwnYNWSTbanhch3BzFAVAid3DsyplIwgQexR+DNW
        A58WrTtsIKAIXkqFBc0P9kQS0EEyFa4=
From:   Caleb Connolly <kc@postmarketos.org>
To:     caleb@connolly.tech
Cc:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sdm845-shift-axolotl: fix Bluetooth
Date:   Sun, 16 Oct 2022 18:29:42 +0100
Message-Id: <20221016172944.1892206-3-kc@postmarketos.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016172944.1892206-1-kc@postmarketos.org>
References: <20221016172944.1892206-1-kc@postmarketos.org>
Reply-To: Caleb Connolly <caleb@connolly.tech>
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

From: Dylan Van Assche <me@dylanvanassche.be>

Add serial1 alias, firmware name and use 4 pin UART pinmux.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 83261c9bb4f2..bb77ccfdc68c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -23,6 +23,7 @@ / {
 	aliases {
 		display0 = &framebuffer0;
 		serial0 = &uart9;
+		serial1 = &uart6;
 	};
 
 	chosen {
@@ -693,9 +694,17 @@ config {
 &uart6 {
 	status = "okay";
 
+	pinctrl-0 = <&qup_uart6_4pin>;
+
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
+		/*
+		 * This path is relative to the qca/
+		 * subdir under lib/firmware.
+		 */
+		firmware-name = "axolotl/crnv21.bin";
+
 		vddio-supply = <&vreg_s4a_1p8>;
 		vddxo-supply = <&vreg_l7a_1p8>;
 		vddrf-supply = <&vreg_l17a_1p3>;
-- 
2.38.0

