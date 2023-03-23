Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D836D6C5B07
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCWAIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCWAIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:08:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA842F7B2;
        Wed, 22 Mar 2023 17:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPKvgQFkv0BtrC/ykdExmYi9HLDB29Av4UFgdBZ3Jk+LjLHLZgi2cK1CvtOUoIKELtaayhISKdeO3imLgd9oWeJC5NZto9HNJUJpA5In/MMN7RaRqmhlAe4EHmpNZ+bgrxTMudjCnCnIKwMfqZZjmKaiRDyyLpRlt5Qz45x5rlkaiteY+oWngdmxFc9VIqkFs4CNOPgh8E3IsBg1Q9KUUfIJYDgnVmREewiGmYzQtMTDkkNOj6XI/Zeum4iJ5sIYGhiY6a9M/PR2lxjKVM282+POeTrBwXbGv2vbrA4XRWwkIkE1+GJwiPlA2RWWVXsrXBANf7Ks54kcsaIl50Witg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKnW45e7WATID2AQ00PmM4L++2zkqYt0EGCGnck4u+o=;
 b=bHeD+jEAf0p44YBtUCS5q9q3Q16HekzqYPuOCiMhfgJYuHRinU2NZ4G6BuTDOXzQFsLSzO8am84U2q8Fx1+wmslF5NiIzpwZ2FXdaM1k7Rk50rTALcwdIk5o8Ovsz87xFBcSBxiQ2VW7W/N6Nx17dve9GC6wXrug3a94cGZu2hNmKC+Zi9Eej0/Y7HjQxKQl9A0yqct7H3GmhhLfSUOUWq6jkpTmuDU0diUXRiHLT881Ht+SdNCzSsNyQNYj7UyJodea13M6nIQ8Jlea6nb8Rbcj1WATMdv1sfkXkfMAAZb/8rr20lb+IlEKO31/zJYnrO1OPzzQTSFImeFIDhuJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKnW45e7WATID2AQ00PmM4L++2zkqYt0EGCGnck4u+o=;
 b=ujQHIfh0NYRPeIE30N60tiHBzVwXCrGDf/p7rOuZznjMMBw0lY2bo+ROl531bfQV/fGKQVF6T/7LMUOb8x0YxFxQamRJg5PXEzr/XMOuFGBcI+1EnYvbpcxwyrIFGWS9/cV0BKgId7yA5HP5RrVcrSFuiLmBo5ZaeRUhOkPzAyA=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 00:08:20 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::ae) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 00:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 00:08:19 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:08:16 -0500
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
Subject: [PATCH v12 05/15] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
Date:   Wed, 22 Mar 2023 17:06:47 -0700
Message-ID: <20230323000657.28664-6-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323000657.28664-1-blarson@amd.com>
References: <20230323000657.28664-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: a7527218-22c6-4464-259d-08db2b32b5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSykyYH8XMsMe9KGTz9LRuxd3MiateOm8MNGbQijrejjblrtV8Ri+uVfQvd26Ma/N8um4HVPv6mNhEnKsz7UszXKmxL+WK2fRH/WihswFsI00tRcEXyjihm4oU2SNYHPBFQZfldoJX7uO56w0Q45802x6bSBWuqYtAA5rMrYeECSie/6BXq62zOOfE1EgqQg0+y0toQ6ya/sN6cGIiVJ6i0eLrsd5xttW3tR1bpfREe8INnDh/EC/dgM99G8hx3kBZ9/ZZKqG4J7AqKQ0w4BN7z51hbikSnBUoGROQLLZIGf1VtGYXri1Kr61ZepMMcnO8hrdzbi8cZrohYj4yIHEA1HSHzvJkon2EeIG4G34v//eq4T2uM2tV8Juh3uiMRRckatVygsxfOdxozCH4wpfpSWr8+ZZPF6Irw4J39YKDw/paTm+n7jW/7iSUuIYAMlzhMGoN61+eqZUpk1IdekG/6GNcvRnHGFPMqS3f55U0w3OA2vTNyqN39Q+4hz+7k2YQr+iJhKgSKB300t7oIL3lgbhK0uDOREe6xYd3CzActEcf9Q+BIGWLdukOK2hTb8vEnMC554W6KXjg/Rd2ezkpMkC1vK5l6VHgLKlZ+0VbqHw/ChY8yaAAmjEaZwFIrT1HbPv59orhoGBVJ1T6aitmx9Z2QmxeKV3jLIWe0jV40gROzUpHEBF+Aa64Nzr4cYC1/cOPgXqrv7wc4C7BMYS7MWzRKDOSx7/WmMDmte29YNrnGuFstsm26fbFXBEVKwyCuFt5EZJZuc4ayqxgM2LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(2616005)(47076005)(83380400001)(426003)(81166007)(2906002)(70206006)(4326008)(316002)(356005)(40460700003)(41300700001)(40480700001)(8676002)(36756003)(6916009)(82740400003)(966005)(16526019)(8936002)(6666004)(186003)(7406005)(478600001)(26005)(1076003)(36860700001)(54906003)(336012)(7416002)(70586007)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:08:19.8159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7527218-22c6-4464-259d-08db2b32b5a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the AMD Pensando Elba SoC Controller which is a SPI connected
device providing a miscellaneous set of essential board control/status
registers.  This device is present in all Pensando SoC based designs.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v11 changes:
- Fixed the compatible which should have stayed as 'amd,pensando-elba-ctrl',
  the commit message, and the filename
- Reference spi-peripheral-props
- Delete spi-max-frequency
- Remove num-cs from example

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
 .../soc/amd/amd,pensando-elba-ctrl.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml
new file mode 100644
index 000000000000..f1d3ed4f519b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/amd/amd,pensando-elba-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Controller
+
+description:
+  The AMD Pensando Elba SoC Controller is a SPI connected device with essential
+  control/status registers accessed on chip select 0.  This device is present
+  in all Pensando SoC based designs.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    enum:
+      - amd,pensando-elba-ctrl
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#reset-cells'
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
+
+        system-controller@0 {
+            compatible = "amd,pensando-elba-ctrl";
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

