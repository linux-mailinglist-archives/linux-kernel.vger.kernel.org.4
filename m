Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E73B68F787
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjBHSzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:55:37 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1697918A95;
        Wed,  8 Feb 2023 10:55:37 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id c15so16187780oic.8;
        Wed, 08 Feb 2023 10:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8d0ESE5MK3b2wd99nPGv7KGBzjZjqzw2XHEjluBMZs=;
        b=F/uk+I3pB+JSVgcLXdBUYhIj/nDMoSnNsKn0Hxr7nJQp0JXd+1WQAJBA/aSf+hj2rZ
         +RbhKwKIIpawTn6AQILeRcBSGT+iPKSSgKbStmyk3uBDLUDC7Ps4UGMWBpH/sXgNTh0n
         8z2YutjzAZlTSBMzos+cRArZdCupDYIVOzb3VqwidLE417tjqjph9Us/+YBaJ9UOXmpg
         0yBpRfipVCWDlD8WkYvAUJ/izEdTUZmUy5TrHY9K2prkuaYVebnZU+/vAeVd9/JTcR6P
         rdz51s2gv/VDab0HAh+X0KdF6x+IiJZVB1QLFADo6x262eId6tzBsa1PwdM+xaTESrCO
         RBWA==
X-Gm-Message-State: AO0yUKXoAWqpJS2RfZ6CCQ70avSl2/vzdvm5QuJAtt65F5MYFlRCH9vx
        15uL1Ef6iPRwf+Zad8lC4g+XkZyAkQ==
X-Google-Smtp-Source: AK7set8KL0fKVdt4dp3+enkzwIWYhrqb88oVzpwYio6H74+ost/bBV8ObwJWto6+y+cJg4mdOFOpew==
X-Received: by 2002:a05:6808:643:b0:367:18a6:eb26 with SMTP id z3-20020a056808064300b0036718a6eb26mr3739093oih.42.1675882536219;
        Wed, 08 Feb 2023 10:55:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p2-20020a0568301d4200b0068be61a7ac6sm8384747oth.56.2023.02.08.10.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:55:35 -0800 (PST)
Received: (nullmailer pid 2305872 invoked by uid 1000);
        Wed, 08 Feb 2023 18:55:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Richter <rric@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: cavium: Fix GICv3 ITS nodes
Date:   Wed,  8 Feb 2023 12:55:06 -0600
Message-Id: <20230208185506.2305349-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv3 ITS is an MSI controller, therefore its node name should be
'msi-controller'. The ITS node is also expected to have '#msi-cells'.
Add it on Thunder as there are no users. Thunder2 uses 'msi-parent', but
Robin says that should be 'msi-map' instead and I'm not sure what's
correct for it.

The unit-addresses of both the ITS and main GIC node on thunder2 are also
wrong, so fix them while we're here.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi  | 3 ++-
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
index e0a71795261b..8ad31dee11a3 100644
--- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
@@ -389,9 +389,10 @@ gic0: interrupt-controller@8010,00000000 {
 			      <0x8010 0x80000000 0x0 0x600000>; /* GICR */
 			interrupts = <1 9 0xf04>;
 
-			its: gic-its@8010,00020000 {
+			its: msi-controller@801000020000 {
 				compatible = "arm,gic-v3-its";
 				msi-controller;
+				#msi-cells = <1>;
 				reg = <0x8010 0x20000 0x0 0x200000>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
index dfb41705a9a9..3419bd252696 100644
--- a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
@@ -55,7 +55,7 @@ psci {
 		method = "smc";
 	};
 
-	gic: interrupt-controller@400080000 {
+	gic: interrupt-controller@4000080000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <3>;
 		#address-cells = <2>;
@@ -67,7 +67,7 @@ gic: interrupt-controller@400080000 {
 		      <0x04 0x01000000 0x0 0x1000000>;	/* GICR */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-		gicits: gic-its@40010000 {
+		gicits: msi-controller@4000100000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			reg = <0x04 0x00100000 0x0 0x20000>;	/* GIC ITS */
-- 
2.39.1

