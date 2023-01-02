Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE965AF04
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjABJr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjABJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:47:01 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623BA5FB0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:46:56 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g13so40894631lfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOSH1C5CfYfmPliXAbNEvFv7j4iFV+C5hOgV7eJDr+Q=;
        b=Wr9A/5xS+AfsPBRo4SLTkHXh6yN57bJZrMOYjINP/j2UQ19KhIbsRYfWNhl16n3i3K
         aOKLFOoeayI2jRvCc8ynrjQY3cRX5hHVq1J+XFmOQft/jn3su5Y7OHgFkgtc2vIXBxuq
         OrTZLIiAh042yVPgPDnzUEz4XBrkenB9PkQ8Um4XbD0NoIdPz9F3iEgwW7fIxUFq0Mk2
         oSjVsoYUnVh6FMiwzbW+Hm/C0lXZZ5YWLLrJbFyO9XeA0GES1degOo4CqtqxjdVfgJ20
         Fhd2jImHaKd263t6v1ehJAh28QwQrqbkz182No3E5zfArbfq8P0mNNx93Yz/PKPsqs8o
         RJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOSH1C5CfYfmPliXAbNEvFv7j4iFV+C5hOgV7eJDr+Q=;
        b=Hw6Jp/tWYE7Yni4X9tFxTpq8PWaZpn9ZQJqs+s/t7KOxNX38Landcagw4a82d5Oe+a
         9VGHEYKr1M29auCQ00ggt02YKnPJ8Z90zpcQwN5V5HsTnk0KQ7mCmAeZJFy1uejjYzVj
         E9qYRjtEwf4NjNEao6tWHdEdIpc8Pwb3GDVlsKCcoWZk8IE1KBFEEtFKkp0U75DPOgEC
         led42ihV57HommWACY8K1KNRyotnz1XfOSUFpah6aVtGVn5YeuFpCzdPYtUtVD3r00Vp
         OZZ+243x3H0qKZBHSbEPM69eg7w+crTE/UWmQBUtLgq/t3Ggh/TCZXG2jTGNoXTTTY7R
         vKmA==
X-Gm-Message-State: AFqh2kqZt9hpyoMf3d1YT0zJDgIv38O6xGPpjEtCw/uFBKoXHTtl+KUb
        4P5DvcD+vNqOeeQir3Uq7HSzAg==
X-Google-Smtp-Source: AMrXdXsP24ybZy3WPPDdBe3z+LH+QUjMEVmTH3kN19+j3nbmCidqEzTzDZEfY07dpalYPObVZMXt2w==
X-Received: by 2002:a19:f804:0:b0:4b5:28e5:29f8 with SMTP id a4-20020a19f804000000b004b528e529f8mr13391213lff.42.1672652815976;
        Mon, 02 Jan 2023 01:46:55 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm4382143lfa.297.2023.01.02.01.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:46:55 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] arm64: dts: qcom: sm6350: Pad addresses to 8 hex digits
Date:   Mon,  2 Jan 2023 10:46:33 +0100
Message-Id: <20230102094642.74254-9-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102094642.74254-1-konrad.dybcio@linaro.org>
References: <20230102094642.74254-1-konrad.dybcio@linaro.org>
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
v1 -> v2:
No changes

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8944dcbbe3a2..e71ffc31d41e 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -557,7 +557,7 @@ gpi_dma0: dma-controller@800000 {
 
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
-			reg = <0x0 0x8c0000 0x0 0x2000>;
+			reg = <0x0 0x008c0000 0x0 0x2000>;
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
@@ -630,7 +630,7 @@ gpi_dma1: dma-controller@900000 {
 
 		qupv3_id_1: geniqup@9c0000 {
 			compatible = "qcom,geni-se-qup";
-			reg = <0x0 0x9c0000 0x0 0x2000>;
+			reg = <0x0 0x009c0000 0x0 0x2000>;
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
@@ -702,7 +702,7 @@ i2c8: i2c@988000 {
 
 			uart9: serial@98c000 {
 				compatible = "qcom,geni-debug-uart";
-				reg = <0 0x98c000 0 0x4000>;
+				reg = <0 0x0098c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				pinctrl-names = "default";
@@ -1654,11 +1654,11 @@ aoss_qmp: power-controller@c300000 {
 
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0 0xc440000 0 0x1100>,
-			      <0 0xc600000 0 0x2000000>,
-			      <0 0xe600000 0 0x100000>,
-			      <0 0xe700000 0 0xa0000>,
-			      <0 0xc40a000 0 0x26000>;
+			reg = <0 0x0c440000 0 0x1100>,
+			      <0 0x0c600000 0 0x2000000>,
+			      <0 0x0e600000 0 0x100000>,
+			      <0 0x0e700000 0 0xa0000>,
+			      <0 0x0c40a000 0 0x26000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.39.0

