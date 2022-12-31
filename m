Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1C65A478
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiLaNAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiLaM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:33 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A4E009
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:32 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id cf42so35169600lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ65VvJ3kX6hIqWv3QscxYLubIMP/hUfG0etyqa3ojA=;
        b=mLFszxd4SPFPh374U3JH7uBBtWxMGVgC6RCcebQF1fDqGQO4Koy6w2oIDwdpSKb5TD
         hXvzpKnX8pOd8vwMZrNNypAKV2Ury4MfRcZSgSoyAlRDfLdKh7nHzMQj5qgKtGB7Ui7d
         Xa55xMixcUjU8DyJdfkKSiLg7sbX6+lIX+/KY6jNs+zJuIZd7PYe0MpBZ3U3AtshadRg
         /HSzRK1hnSMEKDVpJiH8BW3lF8dbtDG9t5wC5PThO9TOd55sfd+9Q5l64tAwtGq0qU5V
         AZROCZa+2t1KzDwy38pGF3nLkofBpnk+sXUO8vAiej04H3hQapX45yE3+kUOXyK3yOFE
         zN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ65VvJ3kX6hIqWv3QscxYLubIMP/hUfG0etyqa3ojA=;
        b=CGTJ6Gc6udV/xwL1F+eV8MH6WN4Y5qlydJ5vOmll3noblbwLB7J35dS09iWqqVADXw
         0oPWs7LSRlH/5z1IbLwYPt5Etma9KDoUcNtgJwna8xF1TM8gQ+PLDSfkcVB83LdLbWNW
         I4FDLvJQi5L9j5dM7FNobVjmKr/DwT/oyciqH6UvI6cOZFfbqve/K132RKwq6XZ6jtAR
         FoF4CHdA0IRm46RqX2El1ZVhgavfg7uQXqTS7E3iFV+FViM928LKqZovU3e7CHAyMrKH
         +LZu/RZah6IcrQx3NfGP5ULEWfxrOHqZSL7z9s9bnPcd3GUIC7hgcZ1hnVD8OB85Z+oz
         dt9A==
X-Gm-Message-State: AFqh2kpzs7hga+QhO5/XQN6giCYA5PYL56C3ex/1JqXzEOHhDxAMe63E
        2x0S9f6cqJKZqnq5Xp8Z9/86NA==
X-Google-Smtp-Source: AMrXdXtJ0klYzHg3MKA8fKVpqNLbFhOl8cqg7IPnVLjRcgUJvXuSG/kLhnPqE7AenUNFrIIst0I8Tw==
X-Received: by 2002:ac2:59c9:0:b0:4a4:68b7:d621 with SMTP id x9-20020ac259c9000000b004a468b7d621mr9742325lfn.8.1672491572006;
        Sat, 31 Dec 2022 04:59:32 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:31 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] arm64: dts: qcom: sm8250: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:59:04 +0100
Message-Id: <20221231125911.437599-12-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231125911.437599-1-konrad.dybcio@linaro.org>
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 54 ++++++++++++++--------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 0b6a6a809503..a642ff1af094 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1899,10 +1899,10 @@ pcie0_phy: phy@1c06000 {
 			status = "disabled";
 
 			pcie0_lane: phy@1c06200 {
-				reg = <0 0x1c06200 0 0x170>, /* tx */
-				      <0 0x1c06400 0 0x200>, /* rx */
-				      <0 0x1c06800 0 0x1f0>, /* pcs */
-				      <0 0x1c06c00 0 0xf4>; /* "pcs_lane" same as pcs_misc? */
+				reg = <0 0x01c06200 0 0x170>, /* tx */
+				      <0 0x01c06400 0 0x200>, /* rx */
+				      <0 0x01c06800 0 0x1f0>, /* pcs */
+				      <0 0x01c06c00 0 0xf4>; /* "pcs_lane" same as pcs_misc? */
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
 				clock-names = "pipe0";
 
@@ -2005,12 +2005,12 @@ pcie1_phy: phy@1c0e000 {
 			status = "disabled";
 
 			pcie1_lane: phy@1c0e200 {
-				reg = <0 0x1c0e200 0 0x170>, /* tx0 */
-				      <0 0x1c0e400 0 0x200>, /* rx0 */
-				      <0 0x1c0ea00 0 0x1f0>, /* pcs */
-				      <0 0x1c0e600 0 0x170>, /* tx1 */
-				      <0 0x1c0e800 0 0x200>, /* rx1 */
-				      <0 0x1c0ee00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
+				reg = <0 0x01c0e200 0 0x170>, /* tx0 */
+				      <0 0x01c0e400 0 0x200>, /* rx0 */
+				      <0 0x01c0ea00 0 0x1f0>, /* pcs */
+				      <0 0x01c0e600 0 0x170>, /* tx1 */
+				      <0 0x01c0e800 0 0x200>, /* rx1 */
+				      <0 0x01c0ee00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
 				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
 				clock-names = "pipe0";
 
@@ -2094,7 +2094,7 @@ pcie2: pci@1c10000 {
 
 		pcie2_phy: phy@1c16000 {
 			compatible = "qcom,sm8250-qmp-modem-pcie-phy";
-			reg = <0 0x1c16000 0 0x1c0>;
+			reg = <0 0x01c16000 0 0x1c0>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -2113,12 +2113,12 @@ pcie2_phy: phy@1c16000 {
 			status = "disabled";
 
 			pcie2_lane: phy@1c16200 {
-				reg = <0 0x1c16200 0 0x170>, /* tx0 */
-				      <0 0x1c16400 0 0x200>, /* rx0 */
-				      <0 0x1c16a00 0 0x1f0>, /* pcs */
-				      <0 0x1c16600 0 0x170>, /* tx1 */
-				      <0 0x1c16800 0 0x200>, /* rx1 */
-				      <0 0x1c16e00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
+				reg = <0 0x01c16200 0 0x170>, /* tx0 */
+				      <0 0x01c16400 0 0x200>, /* rx0 */
+				      <0 0x01c16a00 0 0x1f0>, /* pcs */
+				      <0 0x01c16600 0 0x170>, /* tx1 */
+				      <0 0x01c16800 0 0x200>, /* rx1 */
+				      <0 0x01c16e00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
 				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
 				clock-names = "pipe0";
 
@@ -3792,16 +3792,16 @@ camss: camss@ac6a000 {
 			compatible = "qcom,sm8250-camss";
 			status = "disabled";
 
-			reg = <0 0xac6a000 0 0x2000>,
-			      <0 0xac6c000 0 0x2000>,
-			      <0 0xac6e000 0 0x1000>,
-			      <0 0xac70000 0 0x1000>,
-			      <0 0xac72000 0 0x1000>,
-			      <0 0xac74000 0 0x1000>,
-			      <0 0xacb4000 0 0xd000>,
-			      <0 0xacc3000 0 0xd000>,
-			      <0 0xacd9000 0 0x2200>,
-			      <0 0xacdb200 0 0x2200>;
+			reg = <0 0x0ac6a000 0 0x2000>,
+			      <0 0x0ac6c000 0 0x2000>,
+			      <0 0x0ac6e000 0 0x1000>,
+			      <0 0x0ac70000 0 0x1000>,
+			      <0 0x0ac72000 0 0x1000>,
+			      <0 0x0ac74000 0 0x1000>,
+			      <0 0x0acb4000 0 0xd000>,
+			      <0 0x0acc3000 0 0xd000>,
+			      <0 0x0acd9000 0 0x2200>,
+			      <0 0x0acdb200 0 0x2200>;
 			reg-names = "csiphy0",
 				    "csiphy1",
 				    "csiphy2",
-- 
2.39.0

