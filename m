Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7063AF87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiK1RnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiK1Rmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:42:42 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DBB2AC5D;
        Mon, 28 Nov 2022 09:40:06 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 41157D1E0D;
        Mon, 28 Nov 2022 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1669657205; bh=TWqeYHtpfShiGBY9gIUol/DHR5TcnuSKzaWiN7BTc38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TVVsX0g9zlGL4sd9s2Be0rq1T8qZFmmyqUXDVdPDfEvWv8Ammmm8R2MgXPYQ5iw8X
         ZwV1FjEqkJB5QwqPEtP8deTjIRzzGsh/EXjAj++lQ8ZYHGqZjrVRRwhCl3X8AB8Oqo
         RAW7BNygBVO7QKa0cjb6B3bbobY0WBle2VF9tzV4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/2] arm64: dts: qcom: sdm632-fairphone-fp3: Add NFC
Date:   Mon, 28 Nov 2022 18:37:44 +0100
Message-Id: <20221128173744.833018-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128173744.833018-1-luca@z3ntu.xyz>
References: <20221128173744.833018-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the node for the NQ310 chip found on this device, which is
compatible with generic nxp-nci-i2c driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
RESEND to fix Cc

 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 2920504461d3..fde93cbcd180 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -63,6 +63,21 @@ touchscreen@48 {
 	};
 };
 
+&i2c_5 {
+	status = "okay";
+
+	nfc@28 {
+		compatible = "nxp,nq310", "nxp,nxp-nci-i2c";
+		reg = <0x28>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+
+		enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+		firmware-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &pm8953_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
-- 
2.38.1

