Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E3613D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJaSKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaSKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:10:36 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC59100E;
        Mon, 31 Oct 2022 11:10:33 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1B387D03F1;
        Mon, 31 Oct 2022 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1667239832; bh=03cs4/GWsyd+zjE3smFFK0Esd6yU/N6x5URAFrq3wvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jxb/3OdvVt08kmnwvFljeu24VvqY+2DSRdzzVQ2SxLOtTeA1gR941UQzO+9K7RrxL
         CDwSrosLe8DWgoRZvcMlLPLhAt8ngoXJV+TFpBGRs3ysckQJjeQZXy6EwZ5HnmC/qO
         wH8MNrq371XiaApjahIBXERXqBZZWLQvA18tyJOk=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: qcom: pm8941: fix vadc channel node names
Date:   Mon, 31 Oct 2022 19:10:22 +0100
Message-Id: <20221031181022.947412-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031181022.947412-1-luca@z3ntu.xyz>
References: <20221031181022.947412-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spmi-vadc bindings require the '@' in the node.

Additionally change the node name to adc-chan which both makes it a
generic node name and also removes the underscore from it.

At the same time sort the nodes by reg value.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* Make commit message more accurate
* Make number actually hex in node address (made it decimal before)

 arch/arm/boot/dts/qcom-pm8941.dtsi | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 863e598591b7..a9e83836bf86 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -101,26 +101,33 @@ pm8941_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			bat_temp {
-				reg = <VADC_LR_MUX1_BAT_THERM>;
+
+			adc-chan@6 {
+				reg = <VADC_VBAT_SNS>;
 			};
-			die_temp {
+
+			adc-chan@8 {
 				reg = <VADC_DIE_TEMP>;
 			};
-			ref_625mv {
+
+			adc-chan@9 {
 				reg = <VADC_REF_625MV>;
 			};
-			ref_1250v {
+
+			adc-chan@a {
 				reg = <VADC_REF_1250MV>;
 			};
-			ref_gnd {
+
+			adc-chan@e {
 				reg = <VADC_GND_REF>;
 			};
-			ref_vdd {
+
+			adc-chan@f {
 				reg = <VADC_VDD_VADC>;
 			};
-			vbat_sns {
-				reg = <VADC_VBAT_SNS>;
+
+			adc-chan@30 {
+				reg = <VADC_LR_MUX1_BAT_THERM>;
 			};
 		};
 
-- 
2.38.1

