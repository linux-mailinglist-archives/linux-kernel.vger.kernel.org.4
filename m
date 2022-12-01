Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B906663F615
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiLARUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiLARUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:20:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF6EAE4C9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669915182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qx4tJBDDVJQuTwv5HZkZkSep7aBO8Jt6heDUOx7SfSo=;
        b=XC2L7m8k6niby6m1dZiF1rYq1gSJSQ5I1p6EuCGNS18L5alQRzVwFQs4Dv3CVvYb+0qEGL
        x7PmMwqOn4cjyinBfdnwtyU62GxTrlqoLxFQqKAPKO99t25GirOSZIgbVW0h7iHXi904d2
        uPZzuu4FSGLBbEBIYQEI2oGsuofsjVs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-ais3_D_1PjmpfNyH57XBNA-1; Thu, 01 Dec 2022 12:19:41 -0500
X-MC-Unique: ais3_D_1PjmpfNyH57XBNA-1
Received: by mail-qv1-f72.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so6284102qva.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qx4tJBDDVJQuTwv5HZkZkSep7aBO8Jt6heDUOx7SfSo=;
        b=X5u7msXXAl2HGZKcPDRpjo+KSFIv79CO7wkFidOx9AQQQKSpxq35myS9pf4J+99SW4
         HePJLEgl4FMhgIc89pkE0MAvQr5PJekl+dr1H/ZwZ7t0MwH/aEfPUeMlZFoVksEOV37C
         wNKnRBS7pbC5wMMrFdU/Mq44SzjI372J3+enLWXB6q9zEwTqYxfP+gUDTqirH3ptUREc
         8yFDCSs0WpANhZICBHCZZGUXXsxdXsHRqg4tV4H/qZzO7RacQF8QbOdyWjk7oplALHTU
         vhFAUR8NXwBGVLvXuZJu4kHl0d67mpn5HdIGM7YSto0kpjRz1Q5kB1ow8c+QFi5b7XhL
         djqw==
X-Gm-Message-State: ANoB5pmsNBDH5D7VtKYZ1iZLD7SilhWaeUSvE/2qx2g+1MTDGh9TBXHs
        kBHSrBigbzuovXEbIZ0fhehkrXVFvfjNnktbcTUa8xiJwxkREBdIOp+EG/aCGMdDO/Ye6nVU0Ta
        4L1gr4uwkrFZG3RZYLYxRoB2w
X-Received: by 2002:ac8:6886:0:b0:3a5:f507:8ed4 with SMTP id m6-20020ac86886000000b003a5f5078ed4mr61853831qtq.450.1669915180757;
        Thu, 01 Dec 2022 09:19:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5r3BvCutg+1QztBc5YxpRubTlOisO3GEigwdeg3f+lRep01JpM3E+7OYsn0wkXJm2DCRcFWQ==
X-Received: by 2002:ac8:6886:0:b0:3a5:f507:8ed4 with SMTP id m6-20020ac86886000000b003a5f5078ed4mr61853805qtq.450.1669915180485;
        Thu, 01 Dec 2022 09:19:40 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id g8-20020a05620a40c800b006f3e6933bacsm545421qko.113.2022.12.01.09.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:19:40 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_shazhuss@quicinc.com,
        psodagud@quicinc.com, ahalaney@redhat.com, echanude@redhat.com
Subject: [PATCH v2] arm64: dts: qcom: sa8540p-ride: enable PCIe support
Date:   Thu,  1 Dec 2022 12:19:31 -0500
Message-Id: <20221201171931.1919961-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the vreg_l11a, pcie3a, pcie3a_phy, and tlmm nodes that are necessary
in order to get PCIe working on the QDrive3.

This patch also increases the width of the ranges property for the PCIe
switch that's found on this platform. Note that this change requires
the latest trustzone (TZ) firmware that's available from Qualcomm as
of November 2022. If this is used against a board with the older
firmware, then the board will go into ramdump mode when PCIe is probed
on startup.

The ranges property is overridden in this sa8540p-ride.dts file since
this is what's used to describe the QDrive3 variant with dual SoCs.
There's another variant of this board that only has a single SoC where
this change is not applicable, and hence why this specific change was
not done in sa8540p.dtsi.

These changes were derived from various patches that Qualcomm
delivered to Red Hat in a downstream kernel.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Changes since v1:
- Add -state and -pins suffixes to tlmm (Krzysztof)

This patch depends on the following series that hasn't made it's way
into linux-next yet:

[PATCH v10 0/2] arm64: dts: qcom: add dts for sa8540p-ride board
https://lore.kernel.org/lkml/20221118025158.16902-1-quic_ppareek@quicinc.com/

I can't find the specific TZ firmware version that we have so that's why
I included the date instead.

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index a5f87a8629d6..e953165f3b73 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -51,6 +51,14 @@ vreg_l7a: ldo7 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l11a: ldo11 {
+			regulator-name = "vreg_l11a";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
 		vreg_l13a: ldo13 {
 			regulator-name = "vreg_l13a";
 			regulator-min-microvolt = <3072000>;
@@ -139,6 +147,27 @@ vreg_l8g: ldo8 {
 	};
 };
 
+&pcie3a {
+	ranges = <0x01000000 0x0 0x32200000 0x0 0x32200000 0x0 0x100000>,
+	         <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x20000000>,
+	         <0x03000000 0x6 0x00000000 0x6 0x00000000 0x2 0x00000000>;
+
+	perst-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 56 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3a_default>;
+
+	status = "okay";
+};
+
+&pcie3a_phy {
+	vdda-phy-supply = <&vreg_l11a>;
+	vdda-pll-supply = <&vreg_l3a>;
+
+	status = "okay";
+};
+
 &qup2 {
 	status = "okay";
 };
@@ -158,6 +187,31 @@ &remoteproc_nsp1 {
 	status = "okay";
 };
 
+&tlmm {
+	pcie3a_default: pcie3a-default-state {
+		perst-pins {
+			pins = "gpio151";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		clkreq-pins {
+			pins = "gpio150";
+			function = "pcie3a_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio56";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
 
-- 
2.38.1

