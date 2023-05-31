Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093CF717627
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjEaF2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEaF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:28:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F26EE;
        Tue, 30 May 2023 22:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a25uP4x3XJaJY1uGSU6WKF/obITm7Tzf64HZsQbFHALNIVAFVlV7pgnZ5g7CFtM/qZQ5f8QHgYhqorVJLtex8rrtjQxnLTvx8H4a0N4AxXlEPE7Ib1rIDs+p5bSQKQg5+HkoRuwbXiko+gdoK4gjXYwdaJ6eE2dMEK1u3cEuCcIxiFe+X26+abq7LShyyHava6xfmbr+opvtV8vgpcIudblhJbBRCVqpxnGrF7TTPQTWfU+CsKnxSFtN20pL9bTPS8R15J5W6GBGtSs3PSzxVTU9Cls345LIDh5YzpFmtWheceIPUpLBRWaLmNYirUJ6ScNrS58PtDMv9sH8rMhlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBOwiNiTPw55RgGAXCyXPDsgaSTypmIAbqLUe/h8Kkc=;
 b=lwSJo1WVON64hI/s5eCCc8icp7Fu4oLK8X66cz3Inv9LZWHuLxnwwjD8+VN3UEdcYXP+gSq6zgyUfjB3R4r/v8xJlhdW/fiX1HSsYhoRNnGgz1nfLSyKYbHJmGTRTZmO/VMQ3LAIPK0JuGLd+0/54qc/P8LbH4khOptDetiww9oI1K7akdT6mp5YnjiL9fJhv8AC0xpm3vxZa0uLSfQbBAbFiaJsvA1uX9LcRYTqSa7lYjNvYsoN49K+ioDyiwSKRTOHMObzpWiFBONUrxlfRkN/u2G6E9EGb7dqlI9bue8UCOmHizPFg+B8PLG9Q8B8T4l7+k96QWcWiAZQ/gH/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBOwiNiTPw55RgGAXCyXPDsgaSTypmIAbqLUe/h8Kkc=;
 b=Yjs4yaCZstV2ekWW43YS8SSH8Snh+FgMTy8gRbG2PTEbqi9D84SQmh3/8qRJ947EX8vXJseIHYIbwf35vLQzfiQt+6cnJmCImj9sT133lUA2L9SXsRIIKcvebAoU+3xAUY1HPuTFkCnp6OyTJDmfzXWglkoNOsc81mKP91Qca/4=
Received: from DM6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:100::49)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 05:28:33 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::dc) by DM6PR03CA0072.outlook.office365.com
 (2603:10b6:5:100::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 05:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Wed, 31 May 2023 05:28:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 00:28:31 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 31 May 2023 00:28:28 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.neeli@amd.com>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <radhey.shyam.pandey@amd.com>, <git@amd.com>,
        <neelisrinivas18@gmail.com>, <srinivas.goud@amd.com>
Subject: [PATCH] dt-bindings: watchdog: cdns,wdt-r1p2: Convert cadence watchdog to yaml
Date:   Wed, 31 May 2023 10:58:12 +0530
Message-ID: <20230531052812.2221823-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a6ac65-a525-49ea-dbba-08db6197dfc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdQ2oqYKjyA/U7sWIMzAWNYXTNBlUHEYYNAzlVawE6Hu3qGCkMdN3gn4NgO0SA4kdXbJuBXFbK1C/h8k7Wf6ue1x30QjeIPEm3J94szWT6mYYxyW9y81e9z7EeNAV2mVWYSVxqodF9iyqyOWTyR4qztdNeeRk4PStBXK3RLc9Y3Wu1WdvoqKvhA3YWj04JNtulkKq8egv/gdp1EiXg7FnWiI0hb7G1LZNHzm5vgB1gu2eIon3KNAQ7VcNtyWCbufkCPNV3nQT1idvQvtO3PZ9xfRmUGaAPrDbeZlFVT+nGdcIFHlXlAj1ob66cUGYZywhZOFDBtAx01VHiboqWgJiSZW1Pz+m4hL3s3eEBNn4BR8z6f+XBfJeDF04aa8YSSj729Sn7YFgo6cVEZpdRzEhegJQLppM/zhaI+8sJytBtgEPlRHRifxsSI/GrWcYUjOOczOCuZYGmfdvJwCQPfRixQtZ1pN9HCCgmEq5SCoIj9Wyb3p96aq3tD+0yMnSUjo4GHHgcv4GXDhyi+NDSxE7eugX5e5e8c6K5kir+xsDCY5jMzGIlJnjXRt8GsRCvEnQuM3DHLMNQl1fBVBqdEdZ6JH7PyvLROYdNKCkEQshamWv30o/gkc8JsBP7DNYxZ6PO4qM2nujSseKzL6AoteI+vHmhgdQeLpCgPEtJ/4upVwRnoi+Ly9afr77Jrmka5YoqHfT6Sn7zIzQGKMADdCRsxYEsTcp9ZE/Ei92k2tfWxWBcRFh1Yi3w0HVhPAy+D7ybYmdIRt0Bnou2vtwrQ3VKSxirvx18cpPDYn+wEFzTA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(316002)(6666004)(356005)(82740400003)(81166007)(4326008)(86362001)(8676002)(82310400005)(8936002)(2906002)(70206006)(70586007)(2616005)(36756003)(54906003)(110136005)(44832011)(26005)(1076003)(83380400001)(7049001)(478600001)(336012)(426003)(966005)(47076005)(40480700001)(5660300002)(186003)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 05:28:32.4649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a6ac65-a525-49ea-dbba-08db6197dfc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
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

Convert cadence watchdog bindings to DT schema format using json-schema.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 .../bindings/watchdog/cadence-wdt.txt         | 23 -------
 .../bindings/watchdog/cdns,wdt-r1p2.yaml      | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/cdns,wdt-r1p2.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/cadence-wdt.txt b/Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
deleted file mode 100644
index 750a87657448..000000000000
--- a/Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Zynq Watchdog Device Tree Bindings
--------------------------------------------
-
-Required properties:
-- compatible		: Should be "cdns,wdt-r1p2".
-- clocks		: This is pclk (APB clock).
-- interrupts		: This is wd_irq - watchdog timeout interrupt.
-
-Optional properties
-- reset-on-timeout	: If this property exists, then a reset is done
-			  when watchdog times out.
-- timeout-sec		: Watchdog timeout value (in seconds).
-
-Example:
-	watchdog@f8005000 {
-		compatible = "cdns,wdt-r1p2";
-		clocks = <&clkc 45>;
-		interrupt-parent = <&intc>;
-		interrupts = <0 9 1>;
-		reg = <0xf8005000 0x1000>;
-		reset-on-timeout;
-		timeout-sec = <10>;
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/cdns,wdt-r1p2.yaml b/Documentation/devicetree/bindings/watchdog/cdns,wdt-r1p2.yaml
new file mode 100644
index 000000000000..3c17c5883bce
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/cdns,wdt-r1p2.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/cdns,wdt-r1p2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence watchdog timer controller
+
+maintainers:
+  - Neeli Srinivas <srinivas.neeli@amd.com>
+
+description:
+  The cadence watchdog timer is used to detect and recover from
+  system malfunctions. This watchdog contains 24 bit counter and
+  a programmable reset period. The timeout period varies from 1 ms
+  to 30 seconds while using a 100Mhz clock.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum:
+      - cdns,wdt-r1p2
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-on-timeout:
+    type: boolean
+    description: |
+      If this property exists, then a reset is done when watchdog
+      times out.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    watchdog@f8005000 {
+        compatible = "cdns,wdt-r1p2";
+        reg = <0xf8005000 0x1000>;
+        clocks = <&clkc 45>;
+        interrupt-parent = <&intc>;
+        interrupts = <GIC_SPI 9 IRQ_TYPE_EDGE_RISING>;
+        reset-on-timeout;
+        timeout-sec = <10>;
+    };
+...
-- 
2.25.1

