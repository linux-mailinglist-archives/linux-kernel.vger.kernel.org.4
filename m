Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827D46A7258
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCARws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCARwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:52:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EB848E2D;
        Wed,  1 Mar 2023 09:52:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWXeWcXU4OmjD6lsAabyrI5d0ekazUjKpsqREe5g1ikIkR+1Y94Fp2NR107dlPwqSezjJgUVrfEoVnJLqoaGARXGdGStGN8Mh13bt5zmuYPb35kF2ORKvDeqg2ZHL8osc0t05EfKQRQhGicIKmR3aqv9Y+emEJEM5h/yqeucY7/34g0y3n6C5sz1zvbeCtU7igdczaSYa++vdvB0IfVGDDeLZagu5yhbiaOwybbQGoHcjqShrIZ8SJ4ORpOK16C9M/R483hkofVr0vFPqFVEtEzPkptO6QsiM58NPbZXEJtZyzD9qC0U2KkuJk6ic2OzosY1FTN+d2WkAT1IJsDEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ce29QMFAZTKHWaHxc5qWBmknSsMxbIo81qI6CnGI3nU=;
 b=eilFU0TEiwchVXSxZ/B6RQlwxbgY0GFLSOMhtv1obOYhI2vUa5/TF35fNeqnRx12gzr7n5TLQpHKUqDCasJFVM+ZcV4bG9sT9LItuqd56W+nJgK5a2KvkUbccMVlrgxKo1emnok/+dGeLFY5L8X172XCPVIZa2RH+bydsoQxKDSrOFpf5iq121zHuR2e0AKk2EUZRoeO4hjnPatpYwDVsPj4rgPq3O5QguTUDS80lCHihELk9unR2Pt6lTy6CFr6n68TyFtYz+83rDfUuifuCsJXXhbhe3ijz3WiKi2SKBfMaIzkRG0BzkrxGGevV016DUqbJUtZyp9W6arWz2Qx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ce29QMFAZTKHWaHxc5qWBmknSsMxbIo81qI6CnGI3nU=;
 b=fRmzcRKpDVorLcpK6kG/ssvL8FSsy3HIXlkQxgqTCNKZ6miFkjulRnwmz9kavSg0Y7trv78EF6Pkw573kE1GPtCHT5R2CXHwL2xJxwLQ3vEOQrZqiEB6TTcV3yEaQp/MEN7u1HMolZv+NenvlofmXpJeG3DbhdysM9CcdrU61lA=
Received: from BN0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:408:e5::17)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Wed, 1 Mar
 2023 17:52:42 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::d5) by BN0PR02CA0042.outlook.office365.com
 (2603:10b6:408:e5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 17:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 17:52:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 11:52:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 09:52:40 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 1 Mar 2023 11:52:37 -0600
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@amd.com>,
        <neelisrinivas18@gmail.com>
CC:     <wim@linux-watchdog.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>, <git@amd.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 2/4] dt-bindings: watchdog: xlnx,versal-wwdt: Add versal watchdog bindings
Date:   Wed, 1 Mar 2023 23:22:27 +0530
Message-ID: <20230301175229.342004-3-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301175229.342004-1-srinivas.neeli@amd.com>
References: <20230301175229.342004-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: b3825d9e-92c3-4b10-68b3-08db1a7dc138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8fWMIGbK+e9RKPF0f6cOLLO7knOL3BpA7gE5XSxpSTxMzwGLktdJ1lNVSHPqQpQ/M9e8p6kIeaTlTQWvDe73069mW3zLh4B7GUXyLoT+jAtFJANAVq1rPbVQCx+X3rVuj0fEKCKoVXMj1cRYRrMWX7z/TTIUa5dwRQY86v91LyNItN/rDEPG3xIJbMkhPOJdMIfY7Y10aQW6sJEB1NVPkk69hKpOuoW68OCU98OVkVhHKtBrWcBhqaCv4G2mEfVIBuqAPuDJd+nah/lp7iNpJo/PD38cfwPcdmUnbubQHX3LVChdtz87rEHHvn4OIxGL2eSnv/q9SGP7JagnnE6Rhk4rGBT0z95FarNLiyLNVQbSZJjf6uVoq5XpS7M1G7+mZj4X7X64L2OOcRsiqC1+SP+qyqbZ60wLDoGlfPIkM8dWyAB5WNFVNDF+gzb0iJYQnnULWYJizMy85ktLqj8eHemD4gRlnXWtX36n6h1vxYkHA8dctUQeHQvKX0cU7u8ijt5mummvx3SKkOlpBJbAEsfDvRC102hS1+vm4TsMDSEuZ8Kjs/QYrRG/UFmiQmfKyOBw5CwVgx4N9CAcqmuAVW18zqYX1D4cEDvFwyh5sqLI2YIIWlb17Ttnnyhlu9borPkIE4GnBt+/xhsO6e+9hDbuoYmdic6QR6MAmqIXZ1DSjBrsNMdvG6NTefNSzUviWIEMlBni2vfnylYDQ+jbJtF15Ux81EkeybN+RhM4GokMFWsrN/JEpSF4I1U9HyOSzSAApY25limhDlBde341g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(110136005)(966005)(316002)(82310400005)(54906003)(86362001)(36756003)(40480700001)(40460700003)(44832011)(2906002)(4326008)(8676002)(36860700001)(5660300002)(1076003)(70586007)(70206006)(41300700001)(7416002)(426003)(6666004)(478600001)(2616005)(26005)(186003)(47076005)(83380400001)(336012)(81166007)(356005)(82740400003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:52:41.7522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3825d9e-92c3-4b10-68b3-08db1a7dc138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Versal watchdog driver uses window watchdog mode. Window watchdog
timer(WWDT) contains closed(first) and open(second) window with
32 bit width. Write to the watchdog timer within predefined window
periods of time. This means a period that is not too soon and
a period that is not too late.

Updated devicetree bindings for adding versal window watchdog device.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V2:
- Added watchdog ref
- Removed timeout-sec property
- Used 4 spaces for example indentation.
---
 .../bindings/watchdog/xlnx,versal-wwdt.yaml   | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
new file mode 100644
index 000000000000..733de1ac60e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/xlnx,versal-wwdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal window watchdog timer controller
+
+maintainers:
+  - Neeli Srinivas <srinivas.neeli@amd.com>
+
+description:
+  Versal watchdog driver uses window watchdog mode. Window watchdog
+  timer(WWDT) contains closed(first) and open(second) window with
+  32 bit width. Write to the watchdog timer within predefined window
+  periods of time. This means a period that is not too soon and a
+  period that is not too late. The WWDT has to be restarted within
+  the open window time. If software tries to restart WWDT outside of
+  the open window time period, it generates a reset.
+
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml#
+
+properties:
+  compatible:
+    enum:
+      - xlnx,versal-wwdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  xlnx,close_percent:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 99
+    default: 50
+    description: closed window percentage
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@fd4d0000 {
+        compatible = "xlnx,versal-wwdt";
+        reg = <0xfd4d0000 0x10000>;
+        clocks = <&clock25>;
+        timeout-sec = <30>;
+        xlnx,close_percent = <25>;
+    };
+...
-- 
2.25.1

