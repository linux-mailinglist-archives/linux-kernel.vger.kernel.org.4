Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4481A6DF4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDLMOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDLMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:14:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF2CB4;
        Wed, 12 Apr 2023 05:14:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33CCEGlq010655;
        Wed, 12 Apr 2023 07:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681301656;
        bh=ZBuHLpO3NAI8tZ1HCgNXx960GkgMPOfjXmyfDuODYTo=;
        h=From:To:CC:Subject:Date;
        b=Z73K8+NflhBrBfwxcxg7OATsIOtSBM+E8lXbvr6JW13iF5rhe2WggwEC+e6pI7IeL
         yrZ9EZ9ANPeX8IE0xawQNFr5KmD0sORCq/33SXD89S2u9wk+MQnlNSKZbQgf78C8oh
         JVNi1ZsTZ438Hm2SpmdkS5xEmF8bHbhObEGTg3+M=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33CCEGa8003059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Apr 2023 07:14:16 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 12
 Apr 2023 07:14:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 12 Apr 2023 07:14:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33CCEFil049647;
        Wed, 12 Apr 2023 07:14:16 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <b-kapoor@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <a-govindraju@ti.com>, <kishon@ti.com>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode
Date:   Wed, 12 Apr 2023 17:44:15 +0530
Message-ID: <20230412121415.860447-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to TRM for J721S2, SDR104 speed mode is supported by the SoC
but its capabilities were masked in device tree. Remove sdhci-caps-mask
to enable support for SDR104 speed mode for SD card in J721S2 SoC.

[+] Refer to : section 12.3.6.1.1 MMCSD Features, in J721S2 TRM
- https://www.ti.com/lit/zip/spruj28

Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
Changelog v1->v2:
	- Modified Commit Message and Added Fixes tag

Link to v1 : https://lore.kernel.org/all/20230404091245.336732-1-b-kapoor@ti.com/

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 8915132efcc1..95c6151ed10c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -400,8 +400,6 @@ main_sdhci1: mmc@4fb0000 {
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
-		/* Masking support for SDR104 capability */
-		sdhci-caps-mask = <0x00000003 0x00000000>;
 	};
 
 	main_navss: bus@30000000 {
-- 
2.34.1

