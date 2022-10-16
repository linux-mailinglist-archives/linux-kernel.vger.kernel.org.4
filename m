Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177565FFFFF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJPOsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJPOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:48:20 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA0703CBFE;
        Sun, 16 Oct 2022 07:48:13 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id BCB931402CC;
        Sun, 16 Oct 2022 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665931692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEjDpMV9FqHd8EpFEvxdteRzPjno13eoyZu2+rp7hAQ=;
        b=XRdXyhrBCtVZeIVfJIWcgZZ6hpAAbgjk535vCf0OIFfot9Atyx+AxXABpoCFTmDmSSq9NE
        JiURUz+kbvtYt/pctVyB9QMhT2CPJkRYy7KMM7iCSMNDaG5ZzsU0fXEx611500yx6lX0ru
        lg1Ini4ra/J+VlaL7/kkF+Bp859Rnxk=
From:   Caleb Connolly <kc@postmarketos.org>
To:     caleb@connolly.tech
Cc:     Dylan Van Assche <me@dylanvanassche.be>,
        Alexander Martinz <amartinz@shiftphones.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [RESEND PATCH 7/7] arm64: dts: qcom: sdm845-shift-axolotl: fix Bluetooth firmware loading
Date:   Sun, 16 Oct 2022 15:47:13 +0100
Message-Id: <20221016144714.1742824-8-kc@postmarketos.org>
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

From: Dylan Van Assche <me@dylanvanassche.be>

Add serial1 alias, firmware name and use 4 pin UART pinmux.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
Tested-by: Alexander Martinz <amartinz@shiftphones.com>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 83261c9bb4f2..3e038156af4f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -22,6 +22,7 @@ / {
 
 	aliases {
 		display0 = &framebuffer0;
+		serial1 = &uart6;
 		serial0 = &uart9;
 	};
 
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

