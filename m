Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609126CD222
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjC2Ghs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjC2Ghq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:37:46 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E25A2D4D;
        Tue, 28 Mar 2023 23:37:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32T6bcQ3102626;
        Wed, 29 Mar 2023 01:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680071858;
        bh=x+EGfwgO9aghxjxrSWU4sfCF07paK9IYcru8c4BG+84=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rnOqFkIvASzkaWBiTWykszttaAFlkZ8wM0TmK62EaT/RED2Mo2QwHuxJ/uktGmtI6
         GmCgCOXQdBbZPDzCBaewcZRYhmaEuGwOBeDw6WgWJbQmClUDhukc86o09drI5tejhQ
         dKVctZQLzpuj6j5AW6fsaC7jM6YD3hS8M1vFQ/wI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32T6bc5i008917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 01:37:38 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 01:37:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 01:37:37 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32T6bTgm072630;
        Wed, 29 Mar 2023 01:37:35 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j7200-main: Switch MAIN R5F cluster to Split-mode
Date:   Wed, 29 Mar 2023 12:07:28 +0530
Message-ID: <20230329063728.14126-3-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230329063728.14126-1-a-nandan@ti.com>
References: <20230329063728.14126-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

J7200 SoCs has a R5F cluster in each of the MAIN and MCU domains, and both
of these are configured for LockStep mode at the moment. Switch the MAIN
R5F cluster to Split mode by default to maximize the number of R5F cores.
The MCU R5F cluster continues to be in the preferred LockStep mode.

Note that this configuration is the default for remoteproc mode (kernel
driver boots the R5F processors). These will be overridden for early-booted
remoteprocs through the corresponding IPC-only support in the K3 R5F
remoteproc driver.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 138381f43ce4..573a7f949b1d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -797,7 +797,7 @@ watchdog1: watchdog@2210000 {
 
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j7200-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
-- 
2.34.1

