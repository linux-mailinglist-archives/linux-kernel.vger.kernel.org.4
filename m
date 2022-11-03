Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E661799B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiKCJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiKCJQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:16:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D1610555;
        Thu,  3 Nov 2022 02:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzvSkD2qpi1Sog/8MYJ1fsQqYJbsaDtbd53+EghW5usIqFdnMK9u40k9q+69Y6C7XsM2Wh0omdtorO5hBt5keS3gmQqYioJ+TXAYZ1aJtjQzUez4D7fsXuTAZMyrPKV0O7EhZun1EwxtEMcjx4Q8UAcAmBcF5+rVyb1hD8q/EZ4kXxzMxX6Wtvt/Tx5u6cSM4gQzIjIUuMFxsMKM0WPqCIyTKQa5KA2vkjlrmAvWBTbX5+e5jyvq7MRU5BVw/p5E0jK2n4djEYACIjxMW546742KC53gPz2H6ODm2zgP0eh3hw0MG2nPLoIqTH1S/y4i6zDpka4JRPYhQx3B9ULxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytuDHlCqrE1Thh8WIhqk1S74aVMRZtXhdiqCYvNKfFk=;
 b=IwVzUNBcBN/m1WDbxQd72ncFlcnaamaNU8OI7rRctNnl/29JtnIKQkTHavCkSdSwQ5cGvtsXHKs8Oae1hYOLrGF5oAi23wi74I4EeAX40iO54Ou9BuIiZi+Em/WOEEKywyado3fgW3ux1U9KJ3ryoKbuS2sp2qQ+J8qpDc2gr4zS9lbNEihF0pEqfV5Ny2ejGj+HaUCWCHGXq6d65WuLDXpCvA/xkk3ivECTBk6nLVMkcxYpABMrHE9HJvZdAeXnOrw6rBUtn8zx/ojWiWfcIjOoJnGX+dBKH9Z4/mX9vQ34yYFZzv4hA9uGu8E+qzvJg+rTTiPxriUaXMaJYVD2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytuDHlCqrE1Thh8WIhqk1S74aVMRZtXhdiqCYvNKfFk=;
 b=uBBshaXlOCZXjVy7SyUMrUXb/3zZPpOTn39P6IcV+QZE4asI4HOqk6A+rX1hdeRI9mPqFOvAevMZyFwaHBziW9oGI9LpHNg/kW9lOn/r758QFKXWT3fEKEp3T4sKrlYw6mVlokHIrZz50TCVUa44stLoB0HzU1FAlOmTYOLsPDg=
Received: from BN8PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:70::14)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 09:15:08 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::6d) by BN8PR04CA0001.outlook.office365.com
 (2603:10b6:408:70::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 09:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 09:15:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 04:15:06 -0500
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
Subject: [PATCH v6 1/4] dt-bindings: misc: tmr-manager: Add device-tree binding for TMR Manager
Date:   Thu, 3 Nov 2022 14:44:57 +0530
Message-ID: <20221103091500.3022212-2-appana.durga.kedareswara.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: f4454dc9-5144-49bd-8af8-08dabd7be734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOMLabIQWoxZejZPvwr6WhAQhQTjEPNpTMbuOeKfL3QhdKe/6lpnpY9LAneJ4CWFvVYGZvxM7Re0we7bgw+15j4hPWm6stfSz0b7HpH+g1Tkw980zia15sJfAHLXECP6WUM+wmTcqKw5fkpM4LlsVXb/7M3iUjV3QVPlIkMo9+88gZBo7vglUMTDXTzxuhZL3iDftEAayHErL/ZAG/Gkm6b0UC/MPKN8p7vveM8nkucpPsWSqp8uxlphNC6T1dFKPJhTfn2AZLXexLPA0aPK0fT2UpTI/zEiPMzBRuIBoaWxKS12HLVnyaHL7k1YEi7dhgN60T8oPc1/uNWicUbawMNWtBQ+lMAKuRDzUJ7KXMBBsH9IZvqLtpCdVGNTMx13Y47cACwOaDAFN1VoRCzUc+qMhpyccpd2KOmUXByvVlbbUMVUinZZ3bk5GUvOsrKV1mBZFx85W5LArFOAmfDHU5OAXmMLGW178JFedpR/9RGr7NebWbN0YGzrS4Zz+xM+wOyNLshKIyoLwQ7wbH0cuFfM56BHG3qH7OSBFDr0NIXMnA7xJ+gGXi7Dztw2GYzHx6XtMtzl1ea3AVxkAFUqgF3CweLne7dTO7kLk33cHp5mL4FeZ8CTKDDFGFuTWjNubaxAi+V3CN0bCiL3n+Kn2EJLosBZESe8aw7jxCGSu8poIfm9bpd/9vm74pAP8Qr3fhedHkxuRrsrNlB1q/0mJmkMmqZnHFYzsI5mcvw75akrYZ1emDIdycD1z/8KaKLX6mg+D8beSVAIG70/egaIl81RRtHozCABseESgmd2hw6Uc3omZyVSSbyR5Z1wRK9Z8noeCL7ipT3Ai+ZUuhLUTEzFd1axyZkMVPgnsNnUoQfff+JXvChcj9qzzf/wNzsQUTBJrI13B2RRy7OpGYb/7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(426003)(36756003)(86362001)(103116003)(921005)(81166007)(82740400003)(356005)(6666004)(1076003)(186003)(16526019)(336012)(40480700001)(40460700003)(2906002)(47076005)(2616005)(110136005)(26005)(478600001)(83380400001)(36860700001)(54906003)(41300700001)(70586007)(82310400005)(966005)(5660300002)(4326008)(316002)(8936002)(70206006)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 09:15:08.3485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4454dc9-5144-49bd-8af8-08dabd7be734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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

