Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0645A5FBCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJKVZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJKVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:25:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3192C60693;
        Tue, 11 Oct 2022 14:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbIcl2tBoIIIiFNWWqmcoP9mpEtEOaAzawThl/LuGwz1wTIlQkn3PYRIVgXbzqnhr4IWHV5BY4ZKpMLanFI5lihPgxWW3ymaLZ6RYDV7BSgMJXQdQcrJ+iEwB4JoatNLDjgDQKfpOKB43GS7ILKpbCg876BHeEqNojmUo9AQEzleIrDd9dzYtcYqerIlxUdWqWh7xxYn4Y7xvYkrjtV1O7U0+3vy48O9AHxflUwxvxDhwUKT7PYw0tfXlsNZ6sSKGfvVxb4vxKcQuJqZaSYKNIvVJsSdCf7PcoeOpbBGwiu8bzNNd1fItDSTFcRBQUdpF7Rh2YuUCQ9XE2GjuBWN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn1uyyHXoJnfU4w4yH40mxjpFyV6dZ8gVBmSSyp/iB4=;
 b=MnQgIL6xH7Hq7Ya6WAgtSUonW559U1IigOckToVPToZjDfUOSbcShuJSlYwHXYdCvVj30yZuZk3JlHm9urwWNmJfZpOp8A+5AT/vCdOL8lQd+MMPni/MV4vN0+F9PtqNPn0B5sj41TPHU+06S2q5LpaBGiYD0FgPDfRRMqWWLwQ0C3IXv98x9GtAKitQwqBkSKFB3XLq9FcEFJt9rcTUHVtnOjz6DVBF66behNgcrPm6k06WlDQW/9R95U9ZQ+IXzwTWFKKvRZhPhUGN/aWnmQtO3TRCLoMEjtPzrKUvE8lrmAbIhphfVpQ9paVtUSItIwAdMaYKNt1xk06LkU/QSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn1uyyHXoJnfU4w4yH40mxjpFyV6dZ8gVBmSSyp/iB4=;
 b=V9Ha5FwGdoqXgCmEA19IMvTUDkkMC84ixmFc6rsVcRxlAe0G67pnE/4xwTj//ND57thBTRQ5XE1UrrEDUCbt9+wJyvqNFl+UIPdkBQdc0nMu66n3Tk4QxSmivg3TzcKfSHitK34262mk4ROhwCrq4xCp4bgKDyOC9px7uezjf48=
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 21:25:12 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::9f) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 21:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 11 Oct 2022 21:25:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 16:25:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 14:25:11 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 16:25:10 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v10 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
Date:   Tue, 11 Oct 2022 14:24:56 -0700
Message-ID: <20221011212501.2661003-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011212501.2661003-1-tanmay.shah@amd.com>
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ce0641-ee7e-4b2b-b1b2-08daabcf14c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHEsmiRSpeSnCCEDhFJuJllprQAtqsQ2N6nduH+vcFNx4vK3xn7AlpPMb2zSphuY9CT0MUsrBQMTMwr97rtngijl4O5jGqy/plfvAs8VFCcAzKfIR3Swjvo2aXiHXLPXWI+8EZn1ClGMGL9/6Wa1nB4/HSuSMNhulDWiLv/oH3m/zir7H3VJM8G2zJIuXKNA6r+UzRWtyJdb/6y1Gk934zElL29L6cb9KP8JTWe8tYb+QtsyLZq8zxRYAP/mEX/crwEPymtvBSwL2kn9WSI3TMGQHVyttkI03DxNWfSzZy/4tUdroFjgdCEjw/UEb+L0JvE0GzEADHMXLSUt0eNTaPsYHhlEGOuJbVjXD/1nBcmQiLZFgSClZJqBUMW/V621cvpE0cna9nheFb5h1LyxdXV8PwbGDbtzuLAdl4MXaQURQsyE0njRKKJ2Uy8f4H1q3O0HgqYQK4Yf9ALBSZnbZ7FtFimEdLnKQ/wlP5PJ9AdOa8192f4jJKOvOg1VdtEkYmVHrTQtD+IRSvBgJGQNoTgkx59DqxH3AcEo5ar+xlT0J0IcE1EMxgVqZRpbpf3ktpXiIntB4MJOWC3CTT3gB/PB5T+3HF672Wp9M1x7quiHL7Lbltjd1N85v5bQBbbWfmFNgvKeuFDYkwy6j+IhECGAXlrTyAvKOUHgOHZ+g+60MjQ+PScMNYQaaWtnUaEBM6/HvMt0oemljaFke9mOiTHnR/YMFn0t3V+p5xeyACwoq+e5sQSeKh12lx6dJSwK1DXZ9UMWxr1aKnHQvTYjLscICdjy6etFq/cMNdItGSzwMH7dNNQqrptTwT+mFFJ5bjDmgtCAXzCFIj9lDaPfOxj0UKlgvsT2Mx6vEgWlpgiEZfKzzB0fnNITkJHxlZjZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(1076003)(186003)(5660300002)(336012)(26005)(6636002)(83380400001)(426003)(47076005)(44832011)(36756003)(54906003)(82310400005)(316002)(478600001)(110136005)(356005)(81166007)(36860700001)(40480700001)(966005)(6666004)(2616005)(86362001)(82740400003)(40460700003)(4326008)(41300700001)(70586007)(70206006)(8676002)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 21:25:12.0983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ce0641-ee7e-4b2b-b1b2-08daabcf14c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
(cluster).

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v10:
  - rename example node to remoteproc

Changes in v9:
  - remove power-domains property description
  - fix nitpicks in description of other properties

Changes in v8:
  - Add 'items:' for sram property

Changes in v7:
  - Add minItems in sram property

Changes in v6:
  - Add maxItems to sram and memory-region property

Changes in v5:
- Add constraints of the possible values of xlnx,cluster-mode property
- fix description of power-domains property for r5 core
- Remove reg, address-cells and size-cells properties as it is not required
- Fix description of mboxes property
- Add description of each memory-region and remove old .txt binding link
  reference in the description

Changes in v4:
  - Add memory-region, mboxes and mbox-names properties in example

Changes in v3:
  - None

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 135 ++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
new file mode 100644
index 000000000000..8079b60b950e
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx R5F processor subsystem
+
+maintainers:
+  - Ben Levinsky <ben.levinsky@amd.com>
+  - Tanmay Shah <tanmay.shah@amd.com>
+
+description: |
+  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
+  real-time processing based on the Cortex-R5F processor core from ARM.
+  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
+  floating-point unit that implements the Arm VFPv3 instruction set.
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-r5fss
+
+  xlnx,cluster-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    description: |
+      The RPU MPCore can operate in split mode (Dual-processor performance), Safety
+      lock-step mode(Both RPU cores execute the same code in lock-step,
+      clock-for-clock) or Single CPU mode (RPU core 0 is held in reset while
+      core 1 runs normally). The processor does not support dynamic configuration.
+      Switching between modes is only permitted immediately after a processor reset.
+      If set to  1 then lockstep mode and if 0 then split mode.
+      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
+      In summary,
+      0: split mode
+      1: lockstep mode (default)
+      2: single cpu mode
+
+patternProperties:
+  "^r5f-[a-f0-9]+$":
+    type: object
+    description: |
+      The RPU is located in the Low Power Domain of the Processor Subsystem.
+      Each processor includes separate L1 instruction and data caches and
+      tightly coupled memories (TCM). System memory is cacheable, but the TCM
+      memory space is non-cacheable.
+
+      Each RPU contains one 64KB memory and two 32KB memories that
+      are accessed via the TCM A and B port interfaces, for a total of 128KB
+      per processor. In lock-step mode, the processor has access to 256KB of
+      TCM memory.
+
+    properties:
+      compatible:
+        const: xlnx,zynqmp-r5f
+
+      power-domains:
+        maxItems: 1
+
+      mboxes:
+        minItems: 1
+        items:
+          - description: mailbox channel to send data to RPU
+          - description: mailbox channel to receive data from RPU
+
+      mbox-names:
+        minItems: 1
+        items:
+          - const: tx
+          - const: rx
+
+      sram:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        minItems: 1
+        maxItems: 8
+        items:
+          maxItems: 1
+        description: |
+          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
+          the RPU can execute instructions and access data from the OCM memory,
+          the main DDR memory, and other system memories.
+
+          The regions should be defined as child nodes of the respective SRAM
+          node, and should be defined as per the generic bindings in
+          Documentation/devicetree/bindings/sram/sram.yaml
+
+      memory-region:
+        description: |
+          List of phandles to the reserved memory regions associated with the
+          remoteproc device. This is variable and describes the memories shared with
+          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
+          vrings, ...). This reserved memory region will be allocated in DDR memory.
+        minItems: 1
+        maxItems: 8
+        items:
+          - description: region used for RPU firmware image section
+          - description: vdev buffer
+          - description: vring0
+          - description: vring1
+        additionalItems: true
+
+    required:
+      - compatible
+      - power-domains
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    remoteproc {
+        compatible = "xlnx,zynqmp-r5fss";
+        xlnx,cluster-mode = <1>;
+
+        r5f-0 {
+            compatible = "xlnx,zynqmp-r5f";
+            power-domains = <&zynqmp_firmware 0x7>;
+            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+            mbox-names = "tx", "rx";
+        };
+
+        r5f-1 {
+            compatible = "xlnx,zynqmp-r5f";
+            power-domains = <&zynqmp_firmware 0x8>;
+            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+            mbox-names = "tx", "rx";
+        };
+    };
+...
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
index 0d9a412fd5e0..618024cbb20d 100644
--- a/include/dt-bindings/power/xlnx-zynqmp-power.h
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -6,6 +6,12 @@
 #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
 #define _DT_BINDINGS_ZYNQMP_POWER_H
 
+#define		PD_RPU_0	7
+#define		PD_RPU_1	8
+#define		PD_R5_0_ATCM	15
+#define		PD_R5_0_BTCM	16
+#define		PD_R5_1_ATCM	17
+#define		PD_R5_1_BTCM	18
 #define		PD_USB_0	22
 #define		PD_USB_1	23
 #define		PD_TTC_0	24
-- 
2.25.1

