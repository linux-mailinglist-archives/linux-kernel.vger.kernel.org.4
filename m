Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865A1719220
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFAFWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFAFWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:22:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1D129;
        Wed, 31 May 2023 22:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE+B8+c5Wh4jy4WP27NIJAggDurAjqu+nDUoqRzLljRPqnFiB94Q6vH4zSp9jUpEd8KNsK2OOzIOusKVbGbc51pfnTcJGoDxkPCreTno5NL9k87BtmHxgU1qW1pGtqYxVVri72QhPsaRnDlV9BjaPr+5AhR0K6JqCzRCWuh3NWufrylWPACtjW4I85HoOu6Q0f0sE6NOREVryyMfyTXioRmCNDeDGgWTR3LOmmpCgFATkjsGAF5vk9OmWwA+rfWwUSq91/jOXUgU6l2rvaZNV3HfMR3IKPa+9ULx8RJ6pU4xjeztQ8VAtgqSBAm/o66BIYj3dgFmEaRYOJcHP0C9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCyWc38GkGMKO0jYrgFNsPU3Cum+iixvamrPaW/lKLk=;
 b=hzETGwpYHz2ZC/0IijOc/Sh9lUODjEoV81e0pqDYwJ5S7Fo1mdPJUvU3Nw8R/a3BaCZ46mqE0gwPM7z9F0BX0LHu+rxKIzrlX04LLANOGigbXoK14Wv/im1xL9zX6gAvv0g5QEXKioX8a1aFzGxhVfLk+UxbtYtAyBzGsvxww1ZWjhFCovDp6sHpb6bWBcttrqw+Ykf/85YpPLjWQ/ykUvn4i+MifemExwmZRhDrEmr3ex7c3hJoUhPWZkF0oRXjIkq9zKDUwKMlu88nsZTYXRdQdBuMMqk4Tn2fJDjRDylbNd7y0ppGZDZVlPhA0cispoKtV3EIryfM0yPSvWqL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCyWc38GkGMKO0jYrgFNsPU3Cum+iixvamrPaW/lKLk=;
 b=K4XuXXMW8viB3NxinmIrchfM8xxidxXFcjUiUvSPBpsOYOYHq6QyjYQc066bCPPpQz+6PvGG6ds7f2N5Sxg8UqOSU/etHr1gMVRAASlIZTL/51BD1olrIjuDFMNhWtXeHdDU2YCs98eSfXmmVy7PhXa0gTfXyFehZebI0Azbk8Q=
Received: from BN9PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:fb::18)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 05:22:42 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::3f) by BN9PR03CA0043.outlook.office365.com
 (2603:10b6:408:fb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 05:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 05:22:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 00:22:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 22:22:41 -0700
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 1 Jun 2023 00:22:38 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.neeli@amd.com>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <radhey.shyam.pandey@amd.com>,
        <git@amd.com>, <neelisrinivas18@gmail.com>, <srinivas.goud@amd.com>
Subject: [PATCH V2] dt-bindings: watchdog: cdns,wdt-r1p2: Convert cadence watchdog to yaml
Date:   Thu, 1 Jun 2023 10:52:37 +0530
Message-ID: <20230601052237.2604997-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 953d07a6-f5b4-4d83-c472-08db62603950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zpp3r8ObLEQ3ZOpPBaSCtvVV1wjiYxO55h8GV9vAdNbTkGmRE6AcposJnay6V7VB+7ZQNjMK88YNRlLtm2JLQNHjVMxxd6DeLq7pR1t40QheLo8WVXRaRAPEKRlKYR6hp+xyXZgT6MSc6lhPsg1yk3pxnPC+nlT/zw33ioRP05uEewOIg+PYq/OC0X5DfIHvKKhatzr82Kyu8y0pxEKvXO1xi4pPpdd2cd1Qif9u9BkbGDUKYfRh68uBNl2197ehAgyclcHuGIzv5yjq3LbEYoRSW0VC/BfdPh4KPWG2MpSzt0nzTjNXdySEhbf+lle2jSgFJG9R8+sJrb2e236u9lsBO1OUBWjoIVcL5crOjwkKhDBxz+Z6yYCdJmayJ6XubTqA9mLEGMFWzRYc8FqAz9g2S6/HBhEIR93P3z6WVRgzRLX/YXF3TdEzWqRopm2Fng3rp0lK+MiyUyE3mw4bIwq7wiEfIValD3JrhSY6vWEfN2IEF1VNpNHv+9aC3z3BaJpvixHaZ3ycDDGOk/Rf3mrV/evn0cuzbUzt5m38OSzAS2Njz76k0kFv9sbUYjPdyq6FBugiAq/OqJ5nzBPBprNQFXjv0LazrtM+nRkPiQn2SCyeBOD1hmeL7dk+/tDvCgGbWm1C3DiUT9DNw2NkGQZA/JuBsX12SzeK0M7bX+J0v1bHdTj1vyNI3hrU7AKKxU070kfEV95jQgJgsBfDx0uPd1WrR/eufzTZ1QSHriXf3sZP+Omh4f7yCpRzxg0YJUWBTHM/m6rIpxVbCS6Xcw4mVFspQNm5BR94q+FaAMM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(81166007)(356005)(82740400003)(36860700001)(110136005)(47076005)(2616005)(83380400001)(70586007)(70206006)(426003)(54906003)(82310400005)(4326008)(336012)(86362001)(2906002)(316002)(186003)(1076003)(26005)(7049001)(44832011)(36756003)(5660300002)(478600001)(8936002)(966005)(41300700001)(8676002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 05:22:42.0565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953d07a6-f5b4-4d83-c472-08db62603950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert cadence watchdog bindings to DT schema format using json-schema.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in V2:
- Added missing mailing list emails.
  Conor Dooley <conor+dt@kernel.org>
  devicetree@vger.kernel.org
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

