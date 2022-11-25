Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D114D63838F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKYFmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYFmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:42:23 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B321E22;
        Thu, 24 Nov 2022 21:42:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdZ9NcAITWcfjL8tOQb3vh/HZ3w0t1LS8BDzx68obEggCvobDLA/D7RnHm7q5obCHWbVnQ0+UhXDpgI3bikA0fASZgBnW1vyQEz6KxZfjWrNMwKGIzA7XnGZZTba4y/f35AGPcEzhk/7PRJoeNdtmo0ZgmVd88yfyYOWTxqe++6udrNuczqiIO6EcvGZEIpHsHgAjL78iSFoAUufef8c7156z+nclZ6aVEDOpr9NXVlYWvnE2vgLB83AVVSAfhKaSS/BebvDSPpz0rILwNXAhVJDA1XsHaHyHVx+U2ObRHzGkzZqtIB5HYdlbzwAuLz38ldOh1hMjeEF1u6ook5eeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WxrxkOKAKISdtAr4xOiAUvdT7YfVKyssDi3LHkG5ko=;
 b=ilCWiZQk8IJgQ9ylyXnAlERDU4F1fuO4+NZ27TUDasG8uwkvUHqFcDpwpPV6PbRwm6j1MrLn8iz3eLa3JPcWecnUYGm0LybYl9MFhkXKTTinjAHRI/qBx/7qWxs3qrEdvQ4vYabjq794V+b1KsBpy2bC55wvFPme1djGi3oVisYhl3imxGrLfAf8scU0SV/zVfE/hB+CNjw2h8rtB98MhHqWbKb56z2Mt5o4lzRWU3sFCOnCx/CJ5lbFTaQ5bzq9n2GvhTiGjCr9YIrNUacrakG/Lo+jApDQ5vlREN8cx2QW5zwtEhNz1TGB2zRHMyOzHjjJkVCWwuYezdU/7CZ0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WxrxkOKAKISdtAr4xOiAUvdT7YfVKyssDi3LHkG5ko=;
 b=IXnjXSgJh5nt4LMAECp04S+3rdEDKKstVLiJq6LK9knht3fAbR7m+IQ+HAw8edCvo9vLwnxG88Sn3KSqxj7fXTAx7vsuym+0nEJjgLE+N34VLvW6DqXQ53CC0sAYPOFi84zkyelBCiraL+uS+DuKkHR/ECbNLOTkVn1Cz/8vWNc=
Received: from BN9PR03CA0210.namprd03.prod.outlook.com (2603:10b6:408:f9::35)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 05:42:11 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::4d) by BN9PR03CA0210.outlook.office365.com
 (2603:10b6:408:f9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20 via Frontend
 Transport; Fri, 25 Nov 2022 05:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Fri, 25 Nov 2022 05:42:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 23:41:49 -0600
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/4] dt-bindings: misc: tmr-manager: Add device-tree binding for TMR Manager
Date:   Fri, 25 Nov 2022 11:11:10 +0530
Message-ID: <20221125054113.122833-2-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125054113.122833-1-appana.durga.kedareswara.rao@amd.com>
References: <20221125054113.122833-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fc615c-655b-4733-2e9d-08dacea7c8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcGQxJrOqPW8qSd7khjqBFkTHvPs6wbLsYgeHrOlTYU5bMtv317Voy4ylDGYR19+JgxxpLgZ1pWiZZ9uEf+d9KXzC4M3ETli1BHURf+HnLVeSVXWeac1n/x1rKR5o50otBoHv0nfGaUJaGtft5uiEhJ5TMlCk2VontgBbI5YC7EFk0GA8lW7Cny+dBnayIRBAQlDtLIul41HuOJS7lc17WVgI+KwuZWKX/h+s4NXuZHojnNZRwmSePgllzuC7xjqBD7sTvt0T7zPXPdtggZaHAQwUWRcOHrx6+z3BftXpnJe2xRFVLie060TRist9i7rP1eWKuZrXuvGxRfHjd5LHiyMJSKIS0x5Zp69nR5PSlY5RKFvIiXMHKg7v/UuT11MRRQBI5J3e8TxX1QFk5tWpnLBh6N8FndC/h+tRSu0lEUPdUnVWDC9huiFdpAEIM/RvIUOCOaqhZq30dwP73RVK13mmjFd39JlFYOC51G6Jz5/KMGNXAx7n/YJDIRfwJqWrKgOPIh1dTv4NrFO2B+rbo19+iUgIuc4JSS0uuD/ytA3yJQUe5u6WWvhXQhzvGjOih3llevYA1Tbc7CBBtCH4ZOMhrmm8wIv57JrDjePKHbYTXceL37si3kxawhgQjfC0D2VlDPWIab1sT2iK7kyLZm2xbTIm8LdostS2w+xyGYI9D88NIdodohJ7xUhtixSfdmu43+rBxptMVjl4pmEsJrNrqKvcCSl2MHQ/z1YumGg5OJQ6ISgQOaWzzyzba9cyG4n3JNHrrejctvo3r9zgXqbkV5G/I4GIZbR2JtewIZCp7bHRHJPWZSoUK6TzX7uLaOx/E+qRuvbgg/txjtgUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(966005)(478600001)(186003)(16526019)(82310400005)(426003)(41300700001)(2616005)(1076003)(316002)(54906003)(103116003)(40460700003)(82740400003)(36756003)(6666004)(40480700001)(110136005)(26005)(86362001)(4326008)(70586007)(921005)(70206006)(8676002)(5660300002)(8936002)(336012)(356005)(81166007)(47076005)(83380400001)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 05:42:05.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fc615c-655b-4733-2e9d-08dacea7c8d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
subsystem is fault-tolerant and continues to operate nominally after
encountering an error. Together with the capability to detect and recover
from errors, the implementation ensures the reliability of the entire
subsystem.  TMR Manager is responsible for performing recovery of the
subsystem detects the fault via a break signal it invokes microblaze
software break handler which calls the tmr manager driver api to
update the error count and status.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v7:
--> None.
Changes for v6:
--> None.
Changes for v5:
--> None.
Changes for v4:
--> None.
Changes for v3:
--> Added Krzysztof Reviewed by.
Changes for v2:
--> Added minimum and maximum values for xlnx,magic1 property as suggested
by Michal.
--> Fixed 80 char limit in description as suggested by Michal.

 .../bindings/misc/xlnx,tmr-manager.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
new file mode 100644
index 000000000000..27de12147a52
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,tmr-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Triple Modular Redundancy(TMR) Manager IP
+
+maintainers:
+  - Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+
+description: |
+  The Triple Modular Redundancy(TMR) Manager is responsible for handling the
+  TMR subsystem state, including fault detection and error recovery. The core
+  is triplicated in each of the sub-blocks in the TMR subsystem, and provides
+  majority voting of its internal state.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,tmr-manager-1.0
+
+  reg:
+    maxItems: 1
+
+  xlnx,magic1:
+    minimum: 0
+    maximum: 255
+    description:
+      Magic byte 1, When configured it allows the controller to perform
+      recovery.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - xlnx,magic1
+
+additionalProperties: false
+
+examples:
+  - |
+    tmr-manager@44a10000 {
+        compatible = "xlnx,tmr-manager-1.0";
+        reg = <0x44a10000 0x10000>;
+        xlnx,magic1 = <0x46>;
+    };
-- 
2.25.1

