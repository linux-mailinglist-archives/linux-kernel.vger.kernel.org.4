Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ADD64F52B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLPXep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLPXe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:34:27 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF0CD139;
        Fri, 16 Dec 2022 15:34:25 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 34B8A3F360;
        Sat, 17 Dec 2022 00:34:23 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm6125-seine: Enable GPI DMA 0, QUP 0 and I2C SEs
Date:   Sat, 17 Dec 2022 00:34:08 +0100
Message-Id: <20221216233408.1283581-4-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221216233408.1283581-1-marijn.suijten@somainline.org>
References: <20221216233408.1283581-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable I2C Serial Engines 1, 2 and 3 which are known to have hardware
connected to them, leaving the rest disabled to save on power.  For
this, only GPI DMA 0 and QUP 0 need to be enabled, as nothing seems to
be connected to Serial Engines on GPU DMA 1 / QUP 1.  Beyond this
downstream only defines a UART console available on Serial Engine 4
which also resides on QUP 0.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 1b9e40d3d269..b1de85d8f1c8 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -141,10 +141,35 @@ active-config0 {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
 &hsusb_phy1 {
 	status = "okay";
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* NXP PN553 NFC @ 28 */
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Samsung touchscreen @ 48 */
+};
+
+&i2c3 {
+	clock-frequency = <1000000>;
+	status = "okay";
+
+	/* Cirrus Logic CS35L41 boosted audio amplifier @ 40 */
+};
+
 &pm6125_adc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm &rf_pa1_therm>;
@@ -246,6 +271,10 @@ &pon_resin {
 	linux,code = <KEY_VOLUMEUP>;
 };
 
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &sdc2_off_state {
 	sd-cd-pins {
 		pins = "gpio98";
-- 
2.39.0

