Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142A072E30A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbjFMMbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjFMMbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:31:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A06F10EC;
        Tue, 13 Jun 2023 05:31:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xv+oQ0tT8oETNjrf86dEBbcKhKLIEDhUznZLgLYaIrMfDC2pW7BOXsiSb9wdFkAzodpocSVAxCp4IXTg3SGex3BCnogNQMO+K0zNvi6hGywvCEZXqmYt1xLibgk4vBmhezNxqCg9kKd0SAdwXvfazJR69hzB6PZyV1WKbY9YxS8qDb8FhA0QSJYSm6J5mw/ytxAVBn7HJcE0PXrsk7FsQlLqwQTB2vZrU3GowYyaW/KAvKlY3+LiJ3HKLrQX0VcnZFW/Fa2g0kh7IjXaxPrsLvU2FZQagbvb+COwU1CioHj5pVg9uNRn07hZZOOf5eAsp0jhcFFVoO7lrsnflFu0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6+FEnYT9R3Kd3dIQY4VkZ4ax/9Y87C0gNCnVdq1mqI=;
 b=MDXv3ueN8tboIJqN4KtNxzaO4/AHL1NhC/kiTfQ3Dlv9eysxf0M0yp1b4r3woB9y3GidJjY5Bhw/+ve52SNDpj/b9APRD5qE9w3DlUtwk4C6dIcQItvDrguy8EJzhG2vnujGD+ltHTMHFfRrQ5hQ33LnJIOoHymNYUEOg7tBsvQVvJwn8Ww94Y2eLjOIQNooPabKbID4NOesHk1ZxrTH2TLvvN/i1zITCJryq8TqyBdn51QNnNbs3w+hETtQq8gtRfR+fjlvla9YBI1MF1H+rJLrq8BoX+bKHd8OiwHYRAkwxQljTc4W5zfHjoO7kmbGIcRRvNkFawrIr6hmK7VWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6+FEnYT9R3Kd3dIQY4VkZ4ax/9Y87C0gNCnVdq1mqI=;
 b=asohAJ8KYpmOcNpYqSlJBkOi6pt4GCrF6qNLa0oXpYDrmh4p0vK4pWcEMWE/mTTlTqD3pa+ensDkGsw6eyzKJK2m45fafb1/hfcg/oJIPVGY8LqJrxxh227ALQgDpmdHUnQLZXrcvpkUADW9Hl29zNk22ZKKmdPQwCtCELiIaqY=
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Tue, 13 Jun
 2023 12:31:13 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::ce) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Tue, 13 Jun 2023 12:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 12:31:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 07:31:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 07:31:07 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 13 Jun 2023 07:31:04 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <michal.simek@xilinx.com>,
        <nava.manne@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V3] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt to yaml
Date:   Tue, 13 Jun 2023 18:00:48 +0530
Message-ID: <20230613123048.2935502-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d07c36-a6ee-4267-8dc5-08db6c0a1295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jj2TOEiPiDz+YbdXKZPm7+/mhXKXciaegtrHSyg0L15fGr0DXpfTWrKSEh90NYdRDsldMN1gZ7goyu7KOBnrfFA309HJgk9WFaDY2koqt9Mh1HHZsIQskSgBi2Pin2e85KQdytH69H/wvDt+5adYAvaWSgoSj9751kTY48P1M/cC9P0GEvH/3+koAl1WgBsaTt8ibVrxPVrJaP5w5PWh49Kw0AOMRld5D1SC3US1AD3cHIbAFeJLJFAfqAYVCIfiCwsYcKGCuJoRd+kGL8BFwBqVUfIbHIgX/60uD1pLRTHdQeXi1iuZBM3K2Mm+l2fb7myQeCBjsQSWNsM/NbsDFtFZTHyVugZ1r/V21hs6n5jnx+A8X9Knl/13Axpd2qj4MppQDwTw+JBfyFPJwulfPOkyb1NgshTGbhlD6wPDfHQ7mWmCOYsnxwAJN5vr4ll4sj5pIMtpyF5xJ6JLgVIaFaKxcEwi6lFFk6hZK1eoQBWrxaZ3NJuETy9taw3bxlu7RmgS8ZomLlsyouQr8Dd0krJplY5Ny+NyJXblfPpUDylZeyPAm7Xzi6rawpcQxvLL/cxSkTeAoLYY9zzUB/2mIJwZ27qo9csNvf60Kpps5ebDmu7/3Fcws7vV5Nn5zy7VRC3LrBkMkew4wPQC+fqDQwhl3R1P1uDzKc1mGh51xGgRoCrcC4LkRZ+Om2jKdw9/1c1bScVlLMIgs9O8bkD7AuzdDBtVqAn2RVpck3KnqxkZ8Z9uap20ny1hEdyTt7lGGPRQoNdMm2HOO7FZV/WsSu39uXaf2lUbQle2Sc4XFoheQTWfsfVoZTO0mt0YKCkd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(478600001)(54906003)(110136005)(8676002)(8936002)(36756003)(5660300002)(4326008)(6666004)(41300700001)(316002)(40460700003)(966005)(81166007)(356005)(82740400003)(426003)(336012)(47076005)(36860700001)(44832011)(86362001)(40480700001)(2616005)(82310400005)(186003)(26005)(1076003)(2906002)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 12:31:11.8758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d07c36-a6ee-4267-8dc5-08db6c0a1295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding to DT schema format. It also updates the
reset-controller description.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Changes in V2:
- Addressed the Krzysztof review comment:
 - Update DT binding to fix the dt_binding_check warning.
 - Removed 2/2 - xlnx,zynqmp-firmware.yaml binding patch: Will send after
   xlnx,zynqmp-reset.yaml binding merge.

Link: https://lore.kernel.org/lkml/168612336438.2153757.6000360498539992409.robh@kernel.org/T/#m4abfe6287177d5fd09f781d298dd19d56aae5e27

Changes in V3:
- Addressed the Krzysztof review comment:
 - Removed 2/2 - xlnx,zynqmp-firmware.yaml binding patch: Will send after
   xlnx,zynqmp-reset.yaml binding merge.
 - Update title: Removed "binding".
 - Update Example:
  - Removed header file.
  - Dropped three levels of indentations: firmware and zynqmp_firmware.
  - Removed the sata example.

Link: https://lore.kernel.org/all/22e3c25e-487b-c02f-46f3-6d2ab2be8813@linaro.org/
---
 .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 -------------------
 .../bindings/reset/xlnx,zynqmp-reset.yaml     | 52 ++++++++++++++++++
 2 files changed, 52 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
deleted file mode 100644
index ed836868dbf1..000000000000
--- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
+++ /dev/null
@@ -1,55 +0,0 @@
---------------------------------------------------------------------------
- =  Zynq UltraScale+ MPSoC and Versal reset driver binding =
---------------------------------------------------------------------------
-The Zynq UltraScale+ MPSoC and Versal has several different resets.
-
-See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
-about zynqmp resets.
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required Properties:
-- compatible:	"xlnx,zynqmp-reset" for Zynq UltraScale+ MPSoC platform
-		"xlnx,versal-reset" for Versal platform
-- #reset-cells:	Specifies the number of cells needed to encode reset
-		line, should be 1
-
--------
-Example
--------
-
-firmware {
-	zynqmp_firmware: zynqmp-firmware {
-		compatible = "xlnx,zynqmp-firmware";
-		method = "smc";
-
-		zynqmp_reset: reset-controller {
-			compatible = "xlnx,zynqmp-reset";
-			#reset-cells = <1>;
-		};
-	};
-};
-
-Specifying reset lines connected to IP modules
-==============================================
-
-Device nodes that need access to reset lines should
-specify them as a reset phandle in their corresponding node as
-specified in reset.txt.
-
-For list of all valid reset indices for Zynq UltraScale+ MPSoC see
-<dt-bindings/reset/xlnx-zynqmp-resets.h>
-For list of all valid reset indices for Versal see
-<dt-bindings/reset/xlnx-versal-resets.h>
-
-Example:
-
-serdes: zynqmp_phy@fd400000 {
-	...
-
-	resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
-	reset-names = "sata_rst";
-
-	...
-};
diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
new file mode 100644
index 000000000000..0d50f6a54af3
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/xlnx,zynqmp-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zynq UltraScale+ MPSoC and Versal reset
+
+maintainers:
+  - Piyush Mehta <piyush.mehta@amd.com>
+
+description: |
+  The Zynq UltraScale+ MPSoC and Versal has several different resets.
+
+  The PS reset subsystem is responsible for handling the external reset
+  input to the device and that all internal reset requirements are met
+  for the system (as a whole) and for the functional units.
+
+  Please also refer to reset.txt in this directory for common reset
+  controller binding usage. Device nodes that need access to reset
+  lines should specify them as a reset phandle in their corresponding
+  node as specified in reset.txt.
+
+  For list of all valid reset indices for Zynq UltraScale+ MPSoC
+  <dt-bindings/reset/xlnx-zynqmp-resets.h>
+
+  For list of all valid reset indices for Versal
+  <dt-bindings/reset/xlnx-versal-resets.h>
+
+properties:
+  compatible:
+    enum:
+      - xlnx,zynqmp-reset
+      - xlnx,versal-reset
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    zynqmp_reset: reset-controller {
+        compatible = "xlnx,zynqmp-reset";
+        #reset-cells = <1>;
+    };
+
+...
-- 
2.25.1

