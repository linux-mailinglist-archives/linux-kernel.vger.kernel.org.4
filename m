Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3796610CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJ1JBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJ1JBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:01:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026D11C5A51;
        Fri, 28 Oct 2022 02:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5Bm1oS9pD28/XhHJrRDKKPfp28x+z8f2KfqKiprIax1JP3Bo7/lf4nkiwGpmV7n6HZailm/uofztQWnwiFgn8s9mkNN7eoBEzdPyd+gkc0lwtl/Q8zSm+D4Ve3HPuP73vmDALkKoAMq2h2WQqwCuZAkLi/ibp6UKhrso8qfXCcP+JGBEiO3s6AlQyZjft5AqrwFIL9GVd0MbxD51hv0PPApdeSQHSleBYnJOqYTCQaM3DfJMzgq/HOPJe26GIBw6dALp0tlF7GKGlwzVqIlct3aDRWTgF2uHLRb9CAb8yr8viB8juGlP5Ctm4YuqA2A4KrMxtCV15laB7cqs2mzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0glP/0nIs/nLD9xItcKJd3m+haoxVBho7FsTDRMjF0=;
 b=kVo+SZrtCZyl56KcxXZHXauW5EVlHpWtp1dhPLtoT0tOPPhQoM9Xxua6RJU0fKIAGmx6dNoGh6Y4DAkmub9RMTOPWV8T99Ce3UvRAag52qlzlP491EtBMRdv+T/K5EXRDXTvMPhYYF3/AjrJDpFiJrwWZkD4FKr7lb9bXtEMS8+Egj5RiuZ1lKPSqLgzx0R5n0lLWIq5zq/exEsCJFLTniIreE/gt22rbf4hTac5T2hleHb52O46yVVjqgEVQdXI9FVQOG2GMtjEc/dmnxcDGUnnjs0ZUmcxRkQGO8FtZSHU9RD18bQllLT2NF9pvDG73Ii2vmeQ544yJiGDZjEwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0glP/0nIs/nLD9xItcKJd3m+haoxVBho7FsTDRMjF0=;
 b=qJym5RrYGyblaZyNPne5AocYJN6fYRyz0Ej426mwymvwvSdunHRBf+mX/tJdL/J3zcu6aV3J1WE6dhe8YEB5sKc6sjgc2ZNGmfHA6LgoI2eLl9GXzN9uXmFQgNo1o3cs6PN8SmbF2h9iOzjbURAS+UrzDqgIU8b8CqyQNbxjQ4U=
Received: from BN9PR03CA0945.namprd03.prod.outlook.com (2603:10b6:408:108::20)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 09:01:39 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::c0) by BN9PR03CA0945.outlook.office365.com
 (2603:10b6:408:108::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Fri, 28 Oct 2022 09:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 09:01:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 04:01:37 -0500
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
Subject: [RESEND PATCH v5 1/4] dt-bindings: misc: tmr-manager: Add device-tree binding for TMR Manager
Date:   Fri, 28 Oct 2022 14:31:03 +0530
Message-ID: <20221028090106.1456940-2-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028090106.1456940-1-appana.durga.kedareswara.rao@amd.com>
References: <20221028090106.1456940-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c888cb-2621-464c-b2f8-08dab8c3061e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdPeUakhcgC36SFBctBOMlFwvfF28hkx9guvuJqb8wEHakWF+Y+JSrEe0hKurv594n5l6fKdvtQ5GUQ0n5MjOrKa3cJ2Or4ZdmhqFP8xF8xyVryXoQc/fmMqLClj6CwHSGzVXmmKj7kb5zmqcZqjJKvh4D6V1AFf59w6jLXWyRBKrqR+5J+L8ntTk8TZb0Q+yvr+1fZZJ1L8dub+h8KYEX4xwI+FuNBvI/kHtFZ+BdooLPiMOi0tki3dloAnFpIwIVTplIU5G3b2RppDK+x/yoczSD594xIA29sHJWTckXZE2lNrzYeoogBdYjM34y9CG832WiP0IJyoPX47k/W3I+Jm1MDDs5FcMnEnIsN+z4vrDwLbzN3z8nPny8K0jCp6Bht9d+ET5d8a2wIyDI8czxC6tc7+XXHlJnv1gFNGwn3bXoaxAXd973eE27+Z68/h2Nbpeti4A7CeV4OIFx4Ax7aStQudBiNsO7uc+GT0ZnSSekMTcurQDOut9GOwCFpAmX765PifgKHbDmuv3yoB2dg64k0lLALcolj0cOQk+9vModM/gVTAExPlGJNKBlGI78r32c8I8LxYanthqfhFtMqKuSC+mGrMMJnqQuWqrEAbbGkclFvStgCVOGvKEpJf5h6HZ+bWKL6VNfYzld333o03NpzS2oQJsK5fEfIx9XLrvKbtzrwbrxJGV4Ese0rFDzJnoZOPUrwLnUekN7fy+DLSLte0nAkIWzFz7MjwUW5lJwI6HcSujpEnfzMRNMRFOJPLxw1JgIJqHqlFLABOa8gv8mDMAQ1wP4le4Eq5RjxfbjidFlfrxThsIKZqb25FIjE6C3/Y4xMSSatMvKKRXC52EReI5vPehEvY/97iegDUOvSDpHx8y0LIW9iqxp5qUPgmFTGJSgglZGgdIaG+jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(26005)(36860700001)(478600001)(6666004)(83380400001)(16526019)(186003)(2616005)(426003)(47076005)(2906002)(336012)(1076003)(40480700001)(40460700003)(82310400005)(316002)(54906003)(70586007)(110136005)(966005)(70206006)(8936002)(5660300002)(8676002)(4326008)(41300700001)(86362001)(36756003)(103116003)(921005)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:01:38.6686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c888cb-2621-464c-b2f8-08dab8c3061e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
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

