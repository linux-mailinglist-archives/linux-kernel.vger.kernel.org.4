Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A757254D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbjFGGxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjFGGx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:53:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1425019A4;
        Tue,  6 Jun 2023 23:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI0ChnzOCMr8tP/qo28HYExOli3yXGFLV7raPYRfFsUYAYASRez9nSluVuclUoSm4LkFUZxlLMhMrObBRE+Ar/UgGffyvLS+mYeQJ60BRFq+NHXcTR9khLqsUiAxusqco/HyCBRGOp3F0z87HfzcZFtFYAJOtLT2tYBYQUdiCwgqBi6fRQL1I7zcrIn6G0v2uwZSNZ7ng/EPQreGqn2hJU0dfaV5jBgqRhdBvvnfy1JqK0mGK5xzZkgvA2FMY8+2v63LGezWO418X287dVJOeYUaL10qFqQ1wNFs/tV7no4+CqxUflAWrJwN5Ik0jj8ZAhxgqWN4LWVBPSG8XBnHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymyhm60CvwOgMYCndRi33HZTxzkUdAn6YtWVnkATvvw=;
 b=dN7dYm58+idj9KLgYyVD+lQJSkAa9jkzMg8Rkq5DC/FRI+VfMPFlxhNAThFlgT1lKovQTrXUAUhz+t+FJ2yhKnmlYcxKcIeejhmq52/dGcT31L1MSKSFYH9MdXqAIz86GJ9rtilg3vQCs+v90wx5WjY+3PY/1RgZBuY09X6/k79xmEyXXZRL48lFxIa7uk8xuwULHYAUG+eUDpwMMsY3K63q6+YQfsdS2pUl7RYUjJNySGkt20KLN0rXy3lFD+5WFvjSzWvDrwn95phdfRRRQGmlb0FqZDdfLYhrgNwDHyuiUdqD8rMisaEpLiwoFT9VUISB+K6LmeAUe+OA3iQ4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymyhm60CvwOgMYCndRi33HZTxzkUdAn6YtWVnkATvvw=;
 b=I3ycy/18uqiLfKFdZEyKVjcMmSsrfcZhF11lyXKG2h0Svuxq/jmCHHzbrwFyqG/joFMo8psTVfEbsbRSnl6L0IE5uNq8iSbcNknpmsWiYpATImGzEn/IwwJ5Wj+HyjvGWMyGPvE7oPBvDs6HvT2aj/2zFfCyzpf/UzgJHKFc2E8=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 06:53:17 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::e2) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 06:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Wed, 7 Jun 2023 06:53:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:53:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 23:53:12 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 01:53:08 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <michal.simek@xilinx.com>,
        <nava.manne@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 1/2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt to yaml
Date:   Wed, 7 Jun 2023 12:21:20 +0530
Message-ID: <20230607065121.2265076-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607065121.2265076-1-piyush.mehta@amd.com>
References: <20230607065121.2265076-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: be23147f-86c8-4ebd-d53e-08db6723de83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSA4lO83EChucL7gMwjH9vu2KbRfKoOVMW0eqKhTGTpRwD+bZmwY+zRb60XPvgvJqFTWN3Pq6ogpp+kACk9XW56lzAs07YY5N4PY0dknesjzfbUEN44OzQ7ktFwKXCBH9wIzdUOW2lkyEaUBTf4avYxHhwETXuCZiWagPfnkevHj3+hknJdKKJHI771H5LMTTFC/0ZOtCYVR9RvYG9A7ougcyRBBnbsVtDidG/DKf5yzxicKC+NPmpIAmT8H+CObSp7t7xw2ihJCiM5e/8I5vIDIPD4BzpAWJ9f0o57w51MTdB1HDGcQLlZBanHee3X+0Xeta781yvZ/MsRA05npOEyRsldr9ZKhWCFsCNk1tUvU4tTLCaePkg+8GdNhgiOQ6pwXvq9l15wyU0YesDpVdvuGwfyZOWsHmSeevlsO5YOrZ3ynXw4iTD1nWAPjm9vwxmrnMSw8uOVmPGnEHD2wue1iKmPhhKNpdyKCJm/87K9ZdMNNagxnps+W9ViW/f+rISCiXjuv/8Y852hk7rnrgVPn1IBP9qXwj24frWHpbUBHuI05jibHumIq3PkfGeE2P/Z30FUaRi6wn61/F2A5YL6mYCJEeURgaCbGTdu7C2YAgDRx578VTwbH3fW5I4wf0zHbzW1v0E+mQIkQWX0R4xa9VQpE4xjWcBqHBVY6jKY2nYjN9kGlthvtvpiMq66RnFd4FMy+VGp4XO/QUSc2pTeCMsQ3FQ5foZr2fSAiI65ywUWKEFWeYq1KchkDf89+Jgu/N9enZhe28aMLH+b2nmXZYcihPEbltqlQry/UmtTiHgv/59p7BVZTxlUlZWAA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(186003)(478600001)(1076003)(26005)(83380400001)(336012)(426003)(36860700001)(6666004)(2616005)(47076005)(966005)(40460700003)(40480700001)(316002)(8676002)(86362001)(82310400005)(41300700001)(8936002)(70586007)(81166007)(36756003)(356005)(82740400003)(4326008)(44832011)(5660300002)(2906002)(54906003)(110136005)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:53:15.6349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be23147f-86c8-4ebd-d53e-08db6723de83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
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
Note:
The 1/2 patch introduced a warning related to the dt binding check,
which was subsequently fixed in the 2/2 patch. This warning is a
conversion warning due to a dependency on firmware dt binding.

Warning:
  DTC_CHK Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb
/scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb: zynqmp-firmware: 'reset-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

Please suggest to me, if it's fine to make a single patch instead of the
separate patch 1/2 and 2/2.
---
 .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 ---------------
 .../bindings/reset/xlnx,zynqmp-reset.yaml     | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 55 deletions(-)
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
index 000000000000..df207ca22990
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
@@ -0,0 +1,67 @@
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
+            compatible = "xlnx,zynqmp-firmware";
+            method = "smc";
+
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

