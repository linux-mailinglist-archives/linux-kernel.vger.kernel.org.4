Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DAD6D9BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbjDFPHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbjDFPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:07:16 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456DAF11;
        Thu,  6 Apr 2023 08:06:58 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 415B448FC7;
        Thu,  6 Apr 2023 20:06:55 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680793615; bh=t2Au1NFulgtj3JUVd+q3OVyUhu9F/G6xYLSj/GEnDns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEY+IJ+7eXoC0jZMmiGq0TQ9WQduR2N036HkYL/PvYinQOJ0r3dbxy5KdyhXZ27lO
         XF3XQwp6DaYDzedOiVkY2lHEtUz3lO0B9n46HNzNAs3zUbNmgBM+47O8vAqpnRyJm7
         ydgwTaTseivUddNBgkFCUu5vnIsiKfc+g4BcZVuI/AxotXB2/0zXw8ZarPKGv7LXT2
         Uxa1bW1eVEXYP0VMBwE3bfMW0Smit8K8L7LKIGqSgMp2owT/YYkevbeeXgGTSDjNmt
         jDHjdHdtn0jfEkFOS+pynw4tWdRD0T5QR9DmarFs7+0at2SxaFxfm2LGmDNISnWreg
         pVmpSDdbMkpbQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, quic_srivasam@quicinc.com,
        judyhsiao@chromium.org, mka@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v4 2/4] arm64: dts: qcom: sc7180: Drop redundant disable in mdp
Date:   Thu,  6 Apr 2023 20:06:31 +0500
Message-Id: <20230406150633.83351-3-nikita@trvn.ru>
In-Reply-To: <20230406150633.83351-1-nikita@trvn.ru>
References: <20230406150633.83351-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mdss is useless without a display controller which makes explicitly
enabling mdp redundant. Have it enabled by default to drop the extra
node for all users.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ----
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 2 --
 3 files changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index fcabbc6a897f..292aed241839 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -334,10 +334,6 @@ &dsi_phy {
 	vdds-supply = <&vreg_l4a_0p8>;
 };
 
-&mdp {
-	status = "okay";
-};
-
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 26def6e12723..e72d49a3d97d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -818,10 +818,6 @@ dai-link@5 {
 	};
 };
 
-&mdp {
-	status = "okay";
-};
-
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 6f40301faa1c..13e4a5045fdc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2983,8 +2983,6 @@ mdp: display-controller@ae01000 {
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
 
-				status = "disabled";
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.39.2

