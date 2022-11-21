Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952DA632EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiKUVXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKUVXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:23:09 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D2C627C8;
        Mon, 21 Nov 2022 13:23:08 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C3425D04E7;
        Mon, 21 Nov 2022 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1669065757; bh=SjJ1/BOuKvdYofR75HAG8ro+NKLiwQoEBC7P8NdaGYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aQpgYgCXhJjOYFv6GnDNMz1w1sAEfxK00aTRkN50Kw/CZD8uaqpeb/mA4yxgtKd5S
         k//djHs6BE3PdqQ3xA/1WveGxYXs8IC2XoZiU3C1hbj5ZZPDFnJgyhfAlKjxbD3nzC
         Hgrv2Klhq3SbApgOrYmq5Na1mhxE77VT0jc2EW08=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: qcom: msm8974-*: re-add remoteproc supplies
Date:   Mon, 21 Nov 2022 22:22:26 +0100
Message-Id: <20221121212226.321514-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121212226.321514-1-luca@z3ntu.xyz>
References: <20221121212226.321514-1-luca@z3ntu.xyz>
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

As part of a recent cleanup commit, the remoteproc supplies for adsp and
modem were removed from msm8974.dtsi and now need to be set in the
device dts. Do so.

Fixes: f300826d27be ("ARM: dts: qcom-msm8974: Sort and clean up nodes")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* rebase, should compile now due to added previous patch

 .../boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts   | 11 +++++++++++
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi | 11 +++++++++++
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts    | 11 +++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 6daceaa87802..c8e91985fbec 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -343,6 +343,17 @@ led@5 {
 	};
 };
 
+&remoteproc_adsp {
+	cx-supply = <&pm8841_s2>;
+};
+
+&remoteproc_mss {
+	cx-supply = <&pm8841_s2>;
+	mss-supply = <&pm8841_s3>;
+	mx-supply = <&pm8841_s1>;
+	pll-supply = <&pm8941_l12>;
+};
+
 &rpm_requests {
 	pm8841-regulators {
 		compatible = "qcom,rpm-pm8841-regulators";
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 5a70683d9103..d4a1708117a1 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -213,6 +213,17 @@ &pm8941_wled {
 	qcom,num-strings = <2>;
 };
 
+&remoteproc_adsp {
+	cx-supply = <&pm8841_s2>;
+};
+
+&remoteproc_mss {
+	cx-supply = <&pm8841_s2>;
+	mss-supply = <&pm8841_s3>;
+	mx-supply = <&pm8841_s1>;
+	pll-supply = <&pm8941_l12>;
+};
+
 &rpm_requests {
 	pm8841-regulators {
 		compatible = "qcom,rpm-pm8841-regulators";
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 2c33f84a6e4e..36044130a739 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -318,6 +318,17 @@ led@7 {
 	};
 };
 
+&remoteproc_adsp {
+	cx-supply = <&pm8841_s2>;
+};
+
+&remoteproc_mss {
+	cx-supply = <&pm8841_s2>;
+	mss-supply = <&pm8841_s3>;
+	mx-supply = <&pm8841_s1>;
+	pll-supply = <&pm8941_l12>;
+};
+
 &rpm_requests {
 	pm8841-regulators {
 		compatible = "qcom,rpm-pm8841-regulators";
-- 
2.38.1

