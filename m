Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB35E9EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiIZKRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiIZKQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:16:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B543F1E3EC;
        Mon, 26 Sep 2022 03:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9PkfzJu7wH6fGCjbK30lzb1BIsFbpKfSm9pD0VmwaGIEbip6rZiFkfNggPWrjFc1B9J3UYntOCtU3DEi9qNmPMcEaGqniwMFv/EDY2cNBuf2aiFng+Z4t3r47MV50TX3OsAUYLJLzrmekziPqpjkMMv9kxdVo++M8JEaV1Wm2FvJQ4WB5h7rshS1+JVAYSHWTKP0XRgvU/WVWgwjbDZMyAqVe9I6iUoSCenrW6vW7Ta1hLAvVF+LHzSW45xa4wyHTLMpRnIwAYZAU/OOjyM7A8jSO5IC8zQPNvlSqREkhUwTsqG/bTcWQWFZfYADAEehPgekuHLX7L0ozOoWp+o5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5t6qjFmP045OWPl3Ah/l2TYsr2RqiQzpewzkLa/tr0=;
 b=MRTkDn5UotHMkGXQamFrqYEftgXqfxoNidw0DpX0SFu6va7Ku6jdxmPv4gYyiQwwQPnej8hU2UoXa1UJbYTcJWhjcDcb7qIgYU4OkrasfsRr8w8BrPhkaZU/7REPaV1iBHVPOfgES/txhAIss3VuAE119lZ9KUf/+aJ/OyIXDZiBWsSRaOsjkTvEmR0b7NKadsqEPM4/TM8RSoEePHBU8l3pR+jxM+Ky2yu4L6X5TM5v9A3q3AwVAcBV8D1enIDRK8BMoHB58Pi9D2LcuCkoXl5IbMalsBa+9FLe3qgT7SkRDP4NPQXJ+4slzA4F8H5fpiAcOJw2Ab7tBlWPiVtaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5t6qjFmP045OWPl3Ah/l2TYsr2RqiQzpewzkLa/tr0=;
 b=xOISuVTkj/ebQvADP/G6MhKJ8FT6L4Qw0DtkvrdwfGGbUFEeCy54tFdktMzXZvQmPMcPeU9s2eOKTGeV7kFCgByT1c+yu8GqA3y1lIqEj+0Aa92RQbtbUftDfYpDWT1jTv4mzl0Ibu07u+kKn6LXQHm98V9gnrB0A3etY/38Hfs=
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 10:14:38 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::8b) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Mon, 26 Sep 2022 10:14:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 10:14:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 05:14:32 -0500
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
Subject: [PATCH v5 3/4] dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
Date:   Mon, 26 Sep 2022 15:43:45 +0530
Message-ID: <20220926101346.272720-4-appana.durga.kedareswara.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: 731e0be5-9b51-40e8-3b9f-08da9fa7eb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTa8A/brsehSlmZbQ8UfoxEnLkbzJWW/YZNuZfK5+wpWaaR5dmbV4vKdJ1KbXWm13q698f67mv5aD2JEPyCC32U5ppYdRklOPqz85rEnWWWQX+uSsGr6xv2tzJEjbIvqdAAbN9nBxsAx8nbao5OcH4i04yDMxlgA5vxjmNu85j7SZYnqyLT5MdpPcsiHemPER4Scxr5sRPCpAiDbRyDO1sEDiAqs4oi21VXez4G8hbZnEFXU7RnEP5qJ1w/rtRUKXOXUbMwEOkppL+TNcwxgqOmXGPIdVTQNIGf1c5APKtyRf4zIgIj5hF2cRLZ/T6B31o5ejDgdqYY0H7adkmJ8sCibC8LZ2S4YGdOP3Y4gPR/s0hAANbBdD2d8OShVfYrxE5WNDq7hUOXiejO7RhS8gkPTBjrF57HvWq6Q40yc1sis25AlD4RIccSFC1CIP9vFcfgawDGJjyYsnN9LOi1CM2XD2hltZzUdWs10bNpR3CDiCFKN5d1V5iaG8xPW/6znJ5xqOXnEzlnkkCfJW8ShUYbHITw1joc60iIfoGRqNHhXK5oRLdmGUCAPF2tf/T+THVlSgFR9BdQMu3KkuBby9JgMjHiGFhCaE2ePXTsV2DuWHUeWTLyOGthjbTNjRsCBkIH+qvDERo8hR8ZBOMKk+KrtFL9hTM37QAPa/Teh+C2TosHbwHamJZ+O3q1nGs9suVqzbAVzkQko6jFKfGMh54/rB6M1HjVgIcxxVMNRCj8SLVEuBxBZrhidd9tzUmzZtsRc1w8XDSzp0qRiCitlZeLvp8LFBApVGa8y+gQ+hL5nEwpX1y+yr55tIRf4l8BvBlEj1IpIesiHoiTTQ1ojyxMh4bY27EKGwKwWZA3ibOApA9xVkHSH5NURFAIyYsvoghJT3MbyPuEIMX1xF4WlzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(16526019)(336012)(54906003)(47076005)(426003)(6666004)(316002)(1076003)(26005)(110136005)(36756003)(70206006)(4326008)(8676002)(186003)(2616005)(2906002)(70586007)(356005)(921005)(5660300002)(103116003)(82740400003)(40460700003)(81166007)(41300700001)(83380400001)(86362001)(40480700001)(8936002)(36860700001)(82310400005)(478600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 10:14:38.3719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 731e0be5-9b51-40e8-3b9f-08da9fa7eb80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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

