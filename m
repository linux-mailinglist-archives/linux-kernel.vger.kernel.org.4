Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512145B2EAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiIIGTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiIIGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:19:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0319E2BED;
        Thu,  8 Sep 2022 23:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9Bixp/eKjIxu4AuH1mWE1NeSh94HjcMPAi3Vl+WDwlq4n1lrT1d88z3qmViPx/SEv6PgCPWvrphSyf8fG+saWdhz4mAKtw7rlQF8eZAvqUAsEhxEW7PFxCho1RWVDKs2vqsXX9jrdaQXrNzH6TKh643q8ZcgUzIEm0R+pWrDv+HvsEUGFQ8ER0CV1pUI01k1fvUVSggqgj/PSwX+b+ipL0MVviWjW7uwnllsZ0WyWqbShPp3fpZIG8RpNWOmfkhrPsCeqagTWNFLunRR59fqARqmrJyrw3gy9qZR+yI++wFEjLEkVMFSdrpgSz92nDYEfflOuc/g7itRYVLjMFCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=137uaIFR9zNEFyrHAr/Rg+sW+9kQQRZVKddw1eDN7aQ=;
 b=OWumzO4ksv9fPLsguhzHfxl0ML16rU/6NmxECjlmUW0Ebt//jQXjguQ3Jg2Smer5d4YbfJzYgWprrxCw/BYINRyJUU5ZyxH7Lq9R/2wUK/a+ItEeAyRwCPfdrkQ+hHM2VJm7wj3/76ieWDYEIA1WCi4fdcuP9Hu9P/TTAv3yHEmbDPOQas+v7r4L8PAm4pkWSHoAr8gDzZeAvO2l/2gFXtO9i7BklFzaVeystqFa4oBinPseFFOUMq2ffarrot3qKqZW2yoh0Xb3rxFPL3khpvqcBzbZJGqVqM2bfcprVFIZzQT+Soy2axJ0ggxuuo+BljUAEUSldBS9v3f+finTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=137uaIFR9zNEFyrHAr/Rg+sW+9kQQRZVKddw1eDN7aQ=;
 b=zwdB9RZGVeXU8t4PJxra7YE4fZe6v5+PnaUFEztIaKsi25fNpGCiO1WAr24mLjOFamKPJn6GHbKJkZzJG83bNvdbGGnEdTh222oiudpd5pYkdpfkz5p4gPc6CFJLWw9WLkqTiJODsK8Ngn7svwHcMKw6P3v5Sc3tm/7R75PenP4=
Received: from DM5PR06CA0089.namprd06.prod.outlook.com (2603:10b6:3:4::27) by
 MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Fri, 9 Sep
 2022 06:19:25 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::fc) by DM5PR06CA0089.outlook.office365.com
 (2603:10b6:3:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 06:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 06:19:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 01:19:23 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: misc: tmr-manager: Add device-tree binding for TMR Manager
Date:   Fri, 9 Sep 2022 11:49:13 +0530
Message-ID: <20220909061916.2935431-2-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
References: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: b890b5d6-b4c5-496b-58ff-08da922b3e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqVhVEpBZEq2TiPpHN9J4GEk4Hqm1uO++c7Z/qaegxp8KFcqRsCCeY8sWeHlhtJAQklpjiA0oGbD7rIwmyY+F5rT19Cqz0YIQ88d14Sq/25f2NO459tnmfqCe9nIO5ctqa6HeYtZyuvUDhJq+Mpk4LlZAiH4UZE+QZRQVBs6SE1tIAAy+AmTZ+Sk0VjMBLtWv2OXcb1VW4DTN4PwoQT5ic3AFT7uhfTEM2viN/jWhKVsMCxuSMqCAO8Q8eg58larSbwATUnV5uYXcp7jhiS/RWmRss2weYdyo1jNrJ4NSmCL31e8dFg/k85Yqt84FSBXtxoeilH9hchJlESBMqh02lj2kZNbrZffiGrwQZGO4sm6whaOrPywLosP08kJeKMLEtLlwD2j67Tgjro1EsELCsnLB1tD7Eu8OVnH15DdsVbyzxcXEDkrH/2O7eA4HmgfooTRDqhpm99t00jdAoFLiE5tApaCyKVAvispwO5UBzSS77YYia6vF9X5Mu/GOCK5r/6dkecpDMWwinHcp1aaWDq9v/M9mhBq6TjEqak5vVpG1Qq3vkoFK4fcKnYQCHIq7kPt3cg4tP9UnufhbQOPruhm0LTiQP99PhihDa+xreiOwNWwxlqL5fkrCnQrzebS5aqbyz5UiORMmSg/XrPYvNMWrV8ETgRfb0nQAhhAgU7d7Xsfoc7Vsp2Gq9HBnMi3W6B16qH2CtEZ9Fne7ZfEJnQz/hYfT2B1jHQgWhLEAQup4i5eYJiH/lSSlYOJGaiCyqEdk0BgF7XMZGfDSIu7Y8Bmzh5rCz/0LALJMkaC8u/l7aEW1BBALZgzkZ11ZLHB/gbuAaj2Seb3afsEtPIxpAywpxdTynVRlyOgteYwtBBVxlzM+rpVYS6pKmFV7/y2n8Y9SYwndWxbSl4hBjJO7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(36840700001)(40470700004)(46966006)(8936002)(2906002)(5660300002)(82310400005)(40480700001)(103116003)(40460700003)(86362001)(81166007)(921005)(356005)(36756003)(36860700001)(26005)(6666004)(478600001)(41300700001)(966005)(47076005)(2616005)(83380400001)(426003)(336012)(16526019)(186003)(1076003)(82740400003)(316002)(54906003)(70586007)(110136005)(8676002)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 06:19:24.9071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b890b5d6-b4c5-496b-58ff-08da922b3e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

