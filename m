Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5506C7297C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbjFILF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjFILFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:05:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D721FF3;
        Fri,  9 Jun 2023 04:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNP7mgO04PRZYzhPnnSijA8UuWy7FNFrQnuG4ajYbmuYiZxFI6jB5/w3olLGGJBiJdT4h05IQH/Hl4sEYH41kb4ObR7p7c66WOJKnZLTKVBPzgCHq4xyNovyz5fhhSoCxTKJCoc1EDfWez5HZXEZz40ktXMehrq+e3UM1H+j5RyH7O4SpXH6lx1H8k2n0J5/l9eRBLhtV4KBuhRoOWuUQgfaVtan2RVc8Lwh52mjqEcwvHqsBYc7/XGorB5sErW1TLGFdcPk3SA+1FNifq3wuAXv78gr9kKkAFcAqUBwtrwKp3ejdnbrHYo8OpAy9Ai2+R01xWbBEwonqjiosPOHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBYcypZ7x/Zc8rPi9guivh4nYH5Rcoo0xwSwUfPkjbI=;
 b=hWmk2SihkVVf7xXDA6cDZ0gqN6WYLPlEYyXu5KZiEZBU2LrYPVRSXsY4cev5dRu9ktBAgOnueg+TyYMa/wyW1i4ciTO9OJU7WoeKN8Kh46Vu3j4Z9dFPg5tIZd94mCaqnTT/zbcTox/GF0xqXVmxIIeidss63xuLD3zmtbk7clRew/7gzKs/4hxxLvuXwGQH4zsHgbs3tMJo72co0mhVz59KI777YgLJnUNajXKZPhkRkd6NBxicJR84c6vTXE0W3RuhJitQ9dw9D51581ZKm0gsgpQB2vL/yTzODD81vuJP3N6BXLeyrtgj/tuQjGtG/iwGtKuF+7BVP7tz4vIQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBYcypZ7x/Zc8rPi9guivh4nYH5Rcoo0xwSwUfPkjbI=;
 b=TTJXQrN2hA2TutzEa8BfG2z0gBHzs7q33J8C8bg2FtUQaSoHp3x0ArJd2+Utyn7yr822BHKKZL8b5f5uPk4MaN0WuFsz7B36Tk3fy9KFzWYkwfVmuco9p6JoE6kg9Nog2afr7kN7A3vJUHy9bob8o7d9RySk/W4d3ze+RR+KwSc=
Received: from CY8PR02CA0010.namprd02.prod.outlook.com (2603:10b6:930:4d::13)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 11:05:01 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:4d:cafe::b) by CY8PR02CA0010.outlook.office365.com
 (2603:10b6:930:4d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 11:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 11:04:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 06:04:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 06:04:58 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 9 Jun 2023 06:04:55 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <michal.simek@xilinx.com>,
        <nava.manne@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt to yaml
Date:   Fri, 9 Jun 2023 16:34:47 +0530
Message-ID: <20230609110447.151235-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|BN9PR12MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dc40a0-26ec-4640-b457-08db68d95e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4QyqiCUNJS/1a3USYsH9fmeT8erBrmxSmjLHCfEnUWE0/SQV4te1lhx/vEAV3QvI1Wvz7uO62ZRaDA8NN0UbdZQif6CHukS8J2od+OuHNR0Bs0bo+WtPKYCxrs/nMq3fZmLo9FgIPhSl/5SwWaw6moDNgZBJrQN8zwk2TScYF51VCQ1mtwtvmlldWfSFncly7IMNpBpyW+Srxk1Obzwpjm+egir5KBTKSLphfXXyFkK8LH6PXrfLfCgql3Hk5zVB2juvJDgw1YHAR3FiPWEoFmqC+s2c4FkuJ5mfw0dWvbPNesiB7L8ydnQN1pRTKHG6vews7DisgwnTLXGx80YM131OVlOz6ijvbVTVLFqzsPdVHICks9Cy9fx7YRju0wvBiR9AYDPJTVYs6gGdqDk1wOCiLUGyy4c4MJeAHwSVNpI0DVD2jss7BCDPO72Zw7LL3/dDeZNxMigrOZ05KcXjru9urzukiP8dv6XueRGe6mghw4REJY3mqw9neUPimAa828b0RFx0lpZFlWNBhaQF77ZAD6glFR6L2uCue9Lj5nsskX1K+0S7e2a/SRWH4tZ9r3TjIq9uXl93Akmgsht5cWA41PuL1ykKbg4oxLYM6RuciTIQ2CTM1V59wqXvNyzOIp1lqZRVWX8zgcQhK8lU9QMQoqxxqdlrH8q4EITIGHzJ1AOSgo7jqiwfQcdeIOKN7HMN9QcEsNFoJLQPyTTvFQBYcDWeg+74IuT9jC9Au2CBoJmDzQZNlJqMljlw6lPMKrdSI+nN+VEmNVbWc7T0ltY8QcMe/2caLQOiY+3mGVTeR8FxOc6g7x0NW3toPYa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(81166007)(83380400001)(82740400003)(54906003)(336012)(70206006)(966005)(4326008)(110136005)(47076005)(356005)(426003)(82310400005)(6666004)(478600001)(70586007)(186003)(36756003)(40460700003)(36860700001)(8676002)(5660300002)(8936002)(41300700001)(2616005)(40480700001)(2906002)(316002)(44832011)(1076003)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 11:04:59.9037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dc40a0-26ec-4640-b457-08db68d95e28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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
- Addressed the Krzysztof review comment:
 - Update DT binding to fix the dt_binding_check warning.

Link: https://lore.kernel.org/lkml/168612336438.2153757.6000360498539992409.robh@kernel.org/T/#m4abfe6287177d5fd09f781d298dd19d56aae5e27 
---
 .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 ----------------
 .../bindings/reset/xlnx,zynqmp-reset.yaml     | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 55 deletions(-)
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
index 000000000000..a39b17599e05
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/xlnx,zynqmp-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zynq UltraScale+ MPSoC and Versal reset binding
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
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+
+    firmware {
+        zynqmp_firmware: zynqmp-firmware {
+            zynqmp_reset: reset-controller {
+                compatible = "xlnx,zynqmp-reset";
+                #reset-cells = <1>;
+            };
+        };
+    };
+
+    /* Specifying sata reset control of devices */
+    sata {
+        resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
+        reset-names = "sata_rst";
+    };
+
+...
-- 
2.25.1

