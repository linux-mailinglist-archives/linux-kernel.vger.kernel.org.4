Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2656179A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiKCJR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiKCJQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:16:44 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E437DE8F;
        Thu,  3 Nov 2022 02:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDAdunosqZD6+QyOzMSg6bHuJ5du+nuTljXW+yNhtXfpM7Jr2h0oWYcjALhRmCmBtYogd4xM1FOKrFiOBkT8FH1v+6G7rkJkqJBlyBuUtsGD0dBBfCBE6zlqvErx+kp/ocUf9BKUDCo2NWEOqBaIyMk0/Q72mvk4mwY1RW0PrrZLoDdr2e+msToh0jd23DogCGjeeVJF2RvjjVXA2Mt3fvA7VKp4EdgbPWQPzl4PzhsUW6Wbk3/v13JjijarQOxP50Pj7Hre6ZKnhiANqy26GonDr9xqEUaqjCdv0N99kqOphjuMiK62i5uGmfaL9maajy8IOXrnZ9FdkInFa7609A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHtMISjAUh88XQJ+Sbf7Q/fUipkib6inFp5wFiXb/KY=;
 b=i/MGhRJV+LpcbCW+hWDCcP3A7Z5vhmYr8CIoO+JrbfXwRJCXtIZbCdoA7uV8Buibtp8QghvRHB5KXd5pB0j4XY7geH7fKoLXC8LoyJBOJCExjHRz25QKwK+u3W64WID5Pupx5hfcrHMh1y9nlTeBLKU2m8brD0EII+9Lrz7X0SSrNGB1TrhUoP/LwCmFaKMK2xbVmeannJe2rVSQzCRrRubE702vKovhIvGJgV7TUH3GCjPD7MuxIZImEmrY93/DBVGUgmdsqJ/RCiKDBty3Fj8d3GXs29tHtcX9LGPfP0/kkzDPWgZRkZ2Rg6CD+LlbSUrcBsfSSJtgWJRq1TMiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHtMISjAUh88XQJ+Sbf7Q/fUipkib6inFp5wFiXb/KY=;
 b=c3co4+HVBKYPQDYTaudNi2d1Rd+HppuE9q86GmqK8+91SHZCYVAXa85nSwpsz3QF9r/6itAx01JW39C0DmeEtFb2xbV0evK4V9Sj5ob+tezM5oBvZ1kJBEnCk841uhAS/quFlPl3V8iRDw5kZ48dPihlNm3RFfy7ne7zXzCJTK0=
Received: from BN8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:ac::32)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 09:16:04 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::21) by BN8PR07CA0019.outlook.office365.com
 (2603:10b6:408:ac::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 09:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 09:16:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 04:15:59 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 3/4] dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
Date:   Thu, 3 Nov 2022 14:44:59 +0530
Message-ID: <20221103091500.3022212-4-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103091500.3022212-1-appana.durga.kedareswara.rao@amd.com>
References: <20221103091500.3022212-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: b24357ea-8797-4e7a-7c64-08dabd7c086d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaXucxfu/3hoiPXnhjhHacusGikcWk1/Go5fwhr7A+pJj/5VbIxhjFA7tthovul8y7Z4giW19L1SHzT6/tZZctHtREF0cKlR68Un7kMcKd422kzNOSrIvkCFwN35awk0IIMJl3g9PzctyrPPiL23TCZCxO7Bnb9VVbmXCMMpLtGLIZnFAgBFlv7H/psqOMfMi3c+wISFERQ9jo0mOfltj8fO9dF3ZdEzTTokFNsQfqQsTZWaiGTK7R1Ucjpvdyae3JCIajNQz7PKD/lEUECpM9hj+Yl6GpR2Ei3XFCT0q5Fg/G3eG5h2zzU3xaevxWO/6et7Wl8ofCnXQEatlciXiPLcjyoSF8SepvBaNOlwjTGwKMY0UjQwQRktfUFy3BZ4qsKIpf3FiPWyoriQIJHHOqCid3Bf4c8kcJU52QYxfvHFqLTrmBWDgO2VTKZxRUfVroh6xM29k+MU317b0AhUG/S5/Li1QrXztcxtPeNss5zYJ2RsFJuy5NAvm98xresVwEBzdt7eivGaRHYmZcx6uKSRh7lwUtGOPNPXcfTytIdplYK8FeUs5UnT+s6LanLtjwV2kfFaoZy+f7AKeMF7KB9dQy0TfU4VhFfrUnNA8+YBlyPE+MIShwykw9Fr+csCATpvVmiLGkWuNru9u6Xlldl8m1nHx9NJY29suYPkIO9Vezm9DbaVyTRVOLb+6yNRhgijZwavwXfKwg6vQrUOiq01qSroHEijcer2eyRyYMBjBV+dmPophOO8cQnrgtRhMisJ8pFf3ZCsSCgCuyH/JLZ/lXKb2OY8obRsui6WPFo6ZQBvaUbW9wguXIfbVlkqWfOJ1pI3SC3+TM32OlMGmeDhHDYonbxlea2OKlMo+6GrPJzk15gytULDHn8ayWqVwl0pUN4/U1E+ZBRy3MFGLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(26005)(8936002)(86362001)(186003)(1076003)(16526019)(40460700003)(2616005)(5660300002)(478600001)(336012)(426003)(47076005)(966005)(4326008)(70206006)(70586007)(8676002)(82740400003)(110136005)(81166007)(356005)(83380400001)(36756003)(41300700001)(103116003)(316002)(921005)(54906003)(36860700001)(82310400005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 09:16:04.0865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b24357ea-8797-4e7a-7c64-08dabd7c086d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Triple Modular Redundancy(TMR) Inject core provides functional fault
injection by changing selected MicroBlaze instructions, which provides the
possibility to verify that the TMR subsystem error detection and fault
recovery logic is working properly.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v6:
--> None.
Changes for v5:
--> None.
Changes for v4:
--> None.
Changes for v3:
--> Added Krzysztof Reviewed by.
Changes for v2:
--> Added minimum and maximum values for xlnx,magic1 property as
suggested by Michal.
--> Fixed 80 char limit in description as suggested by Michal.

 .../bindings/misc/xlnx,tmr-inject.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
new file mode 100644
index 000000000000..1b6020e4ec27
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,tmr-inject.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Triple Modular Redundancy(TMR) Inject IP
+
+maintainers:
+  - Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+
+description: |
+  The Triple Modular Redundancy(TMR) Inject core provides functional fault
+  injection by changing selected MicroBlaze instructions, which provides the
+  possibility to verify that the TMR subsystem error detection and fault
+  recovery logic is working properly.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,tmr-inject-1.0
+
+  reg:
+    maxItems: 1
+
+  xlnx,magic:
+    minimum: 0
+    maximum: 255
+    description: |
+      Magic number, When configured it allows the controller to perform
+      recovery.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - xlnx,magic
+
+additionalProperties: false
+
+examples:
+  - |
+    fault-inject@44a30000 {
+        compatible = "xlnx,tmr-inject-1.0";
+        reg = <0x44a10000 0x10000>;
+        xlnx,magic = <0x46>;
+    };
-- 
2.25.1

