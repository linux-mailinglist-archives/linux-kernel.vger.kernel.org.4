Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED816AB569
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCFEKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCFEJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:09:17 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F57F97C;
        Sun,  5 Mar 2023 20:08:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp+xaq+eYMJ2ygLyHd0orfk7RbPF0VgKK8KyZj2BVM4laxN8Q2+ro1j4jeQ2ZoT9wtU4ovoAKEXIeJYu0DIsBDm4286NpnWCilM1WYYdeSm3SjK4LjNp78Lg5neOIuc9nx9As/s78VsmM1KDo3j7bj6Mac1t1dFw2pKecUxoaJ2eAr+YPGKNwNvGoc1PcCrpa9QZSBawgkCLqlFeniglE/y3Fsfjmc9fQgRvnvdRXm5hFnkeShbrnr/JbGK75zbKLZGZj4K5fJFvJWyTo4CN+tHKVXWQIrx1bVku/VseViqmTGs3xskelJ1jmZ+PTObnVVyPxo5EWJjnCKJWtve/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IHLtTEdvfQWQzpqYl4rUpvwK504BkmDgadLTQT1y2g=;
 b=L3HA4J1gSU9Sy5xz2dFfY+0zjZeUgoQyK4x0/MiFXDGo+dj0n7bZU8862jVNQ39lqHcM2bqDzGYwAU2gAKXoT2Ja4cLtCHP5bcRXqmkS2PH8N6XINssZ7Wgf2ud5uhKjCVEQWgcXX974aPGUNhtL+gZrBoRiTJi4/KSedX7u3KO4eLYRsLEtfMLwExRYJ/O0yK0Lbn8iSaez30HIwhCXHT3TIEf/A45wsVXv8dYHe59TKGpaX1c5gG8bVFwaxdDnl3QcS67jOdiZvN1pEHcyiE8VXLKfv7UlaAnhAHt33cF3tUk3QQ5tYW+ed6CMP8iT/WS16IlmXz4ymAV22vmX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IHLtTEdvfQWQzpqYl4rUpvwK504BkmDgadLTQT1y2g=;
 b=3/TJ8zakkDOJX8eLY9y91meuqWcIdQvnczn3At3/jfeFM4qrOKCGekw7+1dLt1gQyeGQLNbosrz4aAofbi5dviocjtuVK76X3tytfSeL4MmHZZtPm2taRww2N+5bgheOgljh/aUFebRuWADPUchez8XH6hF36UJFSeiujt5afQU=
Received: from DM6PR11CA0021.namprd11.prod.outlook.com (2603:10b6:5:190::34)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Mon, 6 Mar
 2023 04:08:54 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::c4) by DM6PR11CA0021.outlook.office365.com
 (2603:10b6:5:190::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 04:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:08:54 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:08:51 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 05/15] dt-bindings: soc: amd: amd,pensando-elbasr: Add AMD Pensando SoC System Controller
Date:   Sun, 5 Mar 2023 20:07:29 -0800
Message-ID: <20230306040739.51488-6-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd2e6dc-bf7d-470e-06a8-08db1df88062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MoxRrWt99M2iAplL/dkqhw+BmscxIIZ1BIiWFTBH8W5lOBm9agXGwQTPtfac1xbSATGb6ynb+cPN7KBqMp4fEWRAFcwx90kTH11lK6gs1cg+zHcFTGr5ISZr756+yioAB34GBCfj+xj0HrQ7yy/LiyqTvr0dwegFTvPsd2NrrbZcP74CWu1qGSiFvidwqVFHoJW912R6SgU/nJPhGssrRV6U3xQoNohJERjsjX1T35EMi9nKgFb6uP63q/DXHH+Xt3W5nY2XBUeh3SLfRMzB4206XzRS6rgWUOsQfD5lGewl0UIWXNabRD5vqhSfgAkE2yrjG+Hb7hPz7DXCuBudm/XL82ubc/1VIlWnzRJSU5/VNHXTR9Bh6mRhC8MsFoHL2SD/bpZJ5Tn7J/DAVzmJ4mrrqiNY3LoE0OTwoNZ0n+l1tDVi9NugKwzLs9cMffYmVLP5ncQLel3FiYTSqI6VMTQ+ciJrVB9vn5+HdEZXOSPJQbJ2Q6HBu98fBhTUP1GYfyEYbt5VgyCn7L0PMfWf5dQ5rlgcX8eLxDoe8ahliFTDfrIyiqkX+/Udrz/6nUMyYfi/DNBFPq39Kzx6pxDrBGEkGe0EOJ+3GujMvo60P6Mdz4APj04Dvf/Go+6ZoqeTVFjAifvtfLEigNrd9vrTfICKYqbhR+UIpD41SgaffILs7JFyK6n9UO8dlp9XdWR75H1RsqWKcskPv//vudZRNKQvvW/Y6fgikYcDbcx5jAkEWPZOBpoNpJcHaIgIxqLMJNHN2AR8E2AUtTHSu6CDiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(316002)(54906003)(478600001)(2906002)(2616005)(40460700003)(966005)(6666004)(6916009)(70586007)(8676002)(70206006)(4326008)(41300700001)(8936002)(16526019)(26005)(186003)(7416002)(7406005)(1076003)(5660300002)(83380400001)(47076005)(426003)(336012)(40480700001)(36860700001)(82740400003)(81166007)(82310400005)(36756003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:08:54.5278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd2e6dc-bf7d-470e-06a8-08db1df88062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the AMD Pensando SoC Controller which is a SPI connected device
providing a miscellaneous set of essential board control/status registers.
This device is present in all Pensando SoC based designs.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v10 changes:
- Property renamed to amd,pensando-ctrl
- Driver is renamed and moved to soc/drivers/amd affecting binding
- Delete cs property, driver handles device node creation from parent num-cs
  fixing schema reg error in a different way

v9 changes:
- Instead of four nodes, one per chip-select, a single
  node is used with reset-cells in the parent.
- No MFD API is used anymore in the driver so it made
  sense to move this to drivers/spi.
- This driver is common for all Pensando SoC based designs
  so changed the name to pensando-sr.c to not make it Elba
  SoC specific.
- Added property cs for the chip-select number which is used
  by the driver to create /dev/pensr0.<cs>

---
 .../bindings/soc/amd/amd,pensando-ctrl.yaml   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
new file mode 100644
index 000000000000..36694077b2e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/amd/amd,pensando-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Controller
+
+description: |
+  The AMD Pensando SoC Controller is a SPI connected device with essential
+  control/status registers accessed on chip select 0.  This device is present
+  in all Pensando SoC based designs.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - amd,pensando-ctrl
+
+  reg:
+    minItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - spi-max-frequency
+  - '#reset-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        system-controller@0 {
+            compatible = "amd,pensando-ctrl";
+            reg = <0>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            #reset-cells = <1>;
+        };
+    };
+
+...
-- 
2.17.1

