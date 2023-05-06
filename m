Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977656F9118
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjEFKJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjEFKJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:09:06 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8304C04;
        Sat,  6 May 2023 03:09:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 346A8iqt097916;
        Sat, 6 May 2023 05:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683367724;
        bh=ZcGs+6i6xW4Yu7JgT5yx4TaDMr7IDnOHdOmGqI71KKE=;
        h=From:To:CC:Subject:Date;
        b=q7NV2Kl9IHFFShNgd9OZoDYL1x39PLuxG4GFBiiMc1qTzWYcMkhwI4hm81v46R6+M
         4d7xL7wVX1eoQ+9VlqUCUVNvf5Ps209LisemW9C7BEG5yso8RlhlgyuuhPcToGtuy0
         9DSfSPpdaQLSsol8V+WDVXXGOWDJzD6yWHMCquK4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 346A8iew118434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 6 May 2023 05:08:44 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 6
 May 2023 05:08:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 6 May 2023 05:08:43 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 346A8eAu025949;
        Sat, 6 May 2023 05:08:40 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>, <n-francis@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [RFC PATCH v2] arm64: dts: ti: k3-j721s2: Add reserved status in msmc node.
Date:   Sat, 6 May 2023 15:38:26 +0530
Message-ID: <20230506100826.1525641-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI K3 SOCs have msmc sram, part of it can be configured as L3 cache
depending upon system firmware configuration file.

This could be possible to have no L3 cache or variable size of
L3 cache.
In either case top of 64KB of SRAM has to be reserved for system
firmware called tifs.

https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html?highlight=msmc
Section: TISCI_MSG_QUERY_MSMC.

But u-boot as part of fix up is deleting sysfw and l3cache node
before passing DT to OS
https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/common.c#L412

But keeping tifs subnode as is, tifs subnode memory region is also not
accessible to OS.

In my view we can handle in two ways
1) delete tifs node as well
In this case, only accessible sram will be visible to OS
https://lore.kernel.org/all/20230420081128.3617214-1-u-kumar1@ti.com/

2) make these nodes (tifs, atf and l3cache) as reserved,
so that OS has complete view of memory.

This is patch for option 2 to mark atf, l3-cache and tifs as
reserved. and let u-boot to set correct size for these nodes
as part of runtime fixup.

Nishanth suggested to discuss in k.org group
https://lore.kernel.org/all/20230502230022.5pjywy6h7oqrkmwh@elusive/

So sending this patch for suggestion for selection right option.
Also other options are welcome.


Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Changes since v1:
https://lore.kernel.org/all/20230503144706.1265672-1-u-kumar1@ti.com/
- remove cover letter for 1 patch

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 2dd7865f7654..791993060f44 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -14,14 +14,17 @@ msmc_ram: sram@70000000 {
 		ranges = <0x0 0x0 0x70000000 0x400000>;
 
 		atf-sram@0 {
+			status = "reserved";
 			reg = <0x0 0x20000>;
 		};
 
 		tifs-sram@1f0000 {
+			status = "reserved";
 			reg = <0x1f0000 0x10000>;
 		};
 
 		l3cache-sram@200000 {
+			status = "reserved";
 			reg = <0x200000 0x200000>;
 		};
 	};
-- 
2.34.1

