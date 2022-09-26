Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED71B5E9EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiIZKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiIZKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:15:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8013D481C7;
        Mon, 26 Sep 2022 03:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrnjUa2bVqvyQs+v/kYJfHxibmH0ZdbMZhi61nv0y18pjSgJgibwuqnE/kYcQHYn4oH+DhYuvBqBGjw7Y3bPvwSQJq/RxEwm0quF7VgkBJxntFBXGogH2Y619he0BAqkq2vvh+Px9ItLR+qvAN/X8Qg02t/QhOIQBLKC7SBn0lUsIsbM+bAYLg4l4KLnaKF3zuK6YPPM7tqHJ4X9iU+UI+pQXzFbcSVCt5IBDvmMLlMdUDmqD3bFHam1Uq5Kv7dm4uLCzN7nhozWBPgbrlNblVaLRNlOl6nnlArxx8pCPhmlrG8+qlscEsdhzazEbi2p602kjS9XVyKvcs6oNKXRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0glP/0nIs/nLD9xItcKJd3m+haoxVBho7FsTDRMjF0=;
 b=Ui6krop/KxAeEClzF+XCIYkUCleLBXufb8AUcEITBKY/rtwG0FIUY93Knbj7HKOCcBhjEOcVz5XJsn/EDutyEMV8TmLIZWauYD2M1+01c2RLy2wRl8FXcVyvXBMY+zOd5YFUw4HkXOOd1OFKb2vtRaZl57ZI1YhMvod8KfgLverd3gTV/TXA+1ivKIBaCh8ssbc5x/wUchDG36aOlWEwljVnYN0htkftTyhCyUW/mxmNGrbZ82hYUeoSAjx8Nt1MaI+KkBG4n0Zl5TO+3Pm3iBO2w6bRP2hK60Cfc/V5spk6qrVgXOqfu4BciRzDjblvJQk8pB2Hx6bNBH0AbuuVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0glP/0nIs/nLD9xItcKJd3m+haoxVBho7FsTDRMjF0=;
 b=cKsTgaJCQSbx8ka+wwz31EVnmALefNzq242YDy83bpL0fS+NhquNIbmbX4SyTRvtpu+Y+0T4o8LPsEQ//IXealcppCdwPTQInDxMrZgNA0vxq0ZdvChBbSs7LbIeV83uEmie96oambHWcF4KAK4zqz+zK6fDgWevNa8e8682uUM=
Received: from MW4PR04CA0235.namprd04.prod.outlook.com (2603:10b6:303:87::30)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 10:14:07 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::5f) by MW4PR04CA0235.outlook.office365.com
 (2603:10b6:303:87::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 10:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 10:14:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 05:14:01 -0500
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
Subject: [PATCH v5 1/4] dt-bindings: misc: tmr-manager: Add device-tree binding for TMR Manager
Date:   Mon, 26 Sep 2022 15:43:43 +0530
Message-ID: <20220926101346.272720-2-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926101346.272720-1-appana.durga.kedareswara.rao@amd.com>
References: <20220926101346.272720-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fa44f7-1141-457a-ec89-08da9fa7d8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fDpiT6Bx7NkOZfihE8AY5Y5P/7yOnTZPq6OroEKPsMJPCWcc5X6JjiBQXm2t6VWXIX9UJkrZEXZh2Y/K3lySqSWowncHRUVUXchb0kcIr+NZeO+yb3o6k1Cwz0FHykSI9FXDLSaOlRKV2XCLm4QL8+O2LtlILP3avKsGKqWuNBHRwxUh6V73VHQigke/cXMbH1Zhi8kf3zuVAaSq5gBJvKaX1sLSlWSSqlyg2OjIRlWNBDqFi/yH4vtJJdcIuiu4hJx9pKYZj4r0yOcBlko0wmBbLcLbwZMvDVmYPg3bhwuacV64540tUj3SU3exdFNY/j0FNAN/Uw1JVf+7b16isTHVROI4/oGIHZVLWijkAV0hKZizbN+N/BUQKzYwLr/4q4aHqaGBGIdMJsHa7kTS+IR3Z+GC0lyWaIb1Tr01Wai2OXz9J3XxhHE7otHBmwX4PydVP7g5cMVTqWhIt5Md9kiHXxKMYcHi7XQU9k+pPXsbKSK9mah1DSRe1rjzilAwHMINbsGtWX8QP48kIhzlhbU2lLqeIRYBG/4iHpMqkWMFpaAC7FUWNYG87B98ilsYYzJMcXuMIUhvXjnD+v3ZpUtT9y1DUMFOChHBDFnR7taW89uQPw/4riH21LkO5N96cbZ4H2mjGmnQWtF6Q4YCAsr+7veemOT6osbEF8Xttnz3PzJo6IjBC1gS8ASAaQ7tdLT3UpkEKAejPd3jniqQsBHdw+CbMoIkKi3BynYjMEzMYErwA9TLkCukfIPunB7Itee/bB5IXLtdEb/zfrWCr8X/QVFR8xe7R5l0BH7oGIC6iTVnxz4DqHSp/04rZrKC6beFcgCUKmo98ZLDqrgVN69jJnKX6mARnZcZnhM4I3TVXMbIX7uqAPwHtw0iT366/Gnwe5tT0rQD94LaycK3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(1076003)(5660300002)(186003)(81166007)(40460700003)(26005)(40480700001)(36860700001)(6666004)(110136005)(8936002)(2906002)(103116003)(336012)(16526019)(47076005)(86362001)(426003)(36756003)(82310400005)(82740400003)(54906003)(316002)(966005)(83380400001)(356005)(921005)(41300700001)(70206006)(70586007)(2616005)(8676002)(4326008)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 10:14:06.8799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fa44f7-1141-457a-ec89-08da9fa7d8ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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
Changes for v5:
--> None.
Changes for v4:
--> None.
Changes for v3:
--> Added Krzysztof Reviewed by.
Changes for v2:
--> Added minimum and maximum values for xlnx,magic1 property as
suggested
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

