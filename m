Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A02610CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJ1JCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJ1JCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:02:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC41BF85F;
        Fri, 28 Oct 2022 02:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ctl3GxuA18GripVvFjsm58FLzkumfi2SGPV69bJh5ru7AgVDHHJTfeMcFSdpCl0FkZ2+LdTzqo4eZjR/nVEPNE/oCBRoGo81Op9Bee2MM3Raj4XSOFgRf3LLIPm34SXNYFd8JvX09OuZsvqO+Na8Z3ODRpgMFzi2kb5rx3Up3wJnVPwe6v3LHgvvEO06Bq0WskLIpRUay/k2qS/3vdeYDXaon1m93dkPproax0QIJBeJC22hdI3CfJtLGCCcf4PkzWNiq+fVG00MmuPlx96cqWF1CW4WjCjW2EmCEtbYHlceic9S33xLrI4SFkc4bUASIj8CUXtCDoIhzSWf2NC5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5t6qjFmP045OWPl3Ah/l2TYsr2RqiQzpewzkLa/tr0=;
 b=Sj9a1hbllv65qkY4Zse+DB9PZ9nqma2LBhtCS2De5c9+F7i5Hz2aoZe1g0e5pG1Yk/E6ZrkPG7qG5qhRlEjT6GrMFwqsnc+sP76nqlFttFg5+ulUxXdJSXi9zm7ZQaCFYopiSFvSjhDQVxJbP4cHfoQEgVK3SIDqK+grfqLDE3K50pKZmik/jr3a7WGPh/Lz1nTbCOD5Bm0E1dYAk7naWtsgH066C45jhwxcO43GW8c3mZ5s5Xv/esu8eH7ckUGKH9ejPpWvNi+6CgPPY3O26PLWsA5eDHHlUZvhO3hABVM7o7kWdpL4dBJFWHJEtt7XcZkDKPA7/9DVBwd7ZjKVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5t6qjFmP045OWPl3Ah/l2TYsr2RqiQzpewzkLa/tr0=;
 b=TCrHrKM6gvP7Pbu0XDNxml7who0D8lVzWT5F6i4z1yvE8PyC+/6K/0XS64hYwxOZXiSMdZLUCtKOo58QgSxRgtx+zSsSEpddLPw+JJTHs1NtWrc8SirU1NR08bAnWHUoCGapJj7UOkyBTMHniq0QH2h7lSWUhZqASc6X0rYwi8U=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 09:02:13 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::67) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 09:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 09:02:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 04:02:07 -0500
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
Subject: [RESEND PATCH v5 3/4] dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
Date:   Fri, 28 Oct 2022 14:31:05 +0530
Message-ID: <20221028090106.1456940-4-appana.durga.kedareswara.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ac1ba9-8f19-4c54-b660-08dab8c31a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NasPAvj0W6u3xaf+sz5IM1PR7ZX9VT55LF45OMwSSlxSKQfA9jTk0V6PxNIB/XUk8l2rMPiQp0ARCX2/YWLlI+3LzXpVdHOYV4rR2ZvBxSTVgoD+HlsfGekLS8o9bfEUHJvyHR76NKOMfj+U8V4ke1evVJACNze2OvCHtvA4omSC8AQw4eIgvm+7dg46RfOHOBL66v/82DV7kzuDpBRauzWBd3DENorAGQLhM4/eekAGy2e7nYhapsuYK0ZndnOdEfV979GHclbw9iTptKg6Qe7uA3ecuHdh3YmfNvSqqTrputk5RQYsJJY8EWuWIsNW83tTJmWtXeiE0wwTK6OYDXUfpf+STqaIJftxd9m76DsUzyBG4Z6vR/AqyXV8jW02hxs9INHvPHl/dueB1vWwUbcR9YbHKzksqn+cdHlVcZlyZ/JrLIL/peq33y96frIvroTAlqFIco6SOsKkolZzK7m7+QJpZIWcD7oQ3iN3JsLqA13vqJCs9pbSMy19+9YTsI1YfNO/zgrkn1yMQiz9YK20rI831zfG6QqZpYzLFe6owklyfQOJqepOb7h+5aJtXVr6aOJn1TWJrnn8vF0eD5EmplQfww5SI78PyaKO3ZGKgKoUYV/C/YWAYKP5PtDQqrDqHNmc/qgdo0FHhj6c7y8IubEW2EEt757nZnJLpXI85zda+Uy1ibwIGfZR1wE3emgSnrISUTAiqg2MKsJZ2VJGZGKyem08ZMSdVsfWJA50LA4ccuB2i0ENmgvS1lTwDG4FkB7vsm39alIE2KZhGsA1RLomM5iDm0Q76m1WVcnsrJIZpXWyfnsOj1h7CmPTWyoFD8QAsWH5qNDEDO0RynWEiQIMB9CdQHsxSnqQG5KZLkanBwsUNLnmNoRfHEud2Q8XHN/RDYTSZ7qIKrbdTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(921005)(70206006)(2616005)(1076003)(47076005)(426003)(36756003)(4326008)(81166007)(8676002)(16526019)(186003)(356005)(41300700001)(86362001)(2906002)(70586007)(82310400005)(336012)(54906003)(966005)(40460700003)(478600001)(82740400003)(40480700001)(36860700001)(110136005)(103116003)(26005)(316002)(83380400001)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:02:12.9309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ac1ba9-8f19-4c54-b660-08dab8c31a8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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
--> Fixed 80 char limit in description as suggested by Michal

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

