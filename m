Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBF6F51EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjECHk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjECHkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:40:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980521731;
        Wed,  3 May 2023 00:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CihFxmpGYFAMSKmwAUzsk1aDRS1VAL0yfC5H5lam+iTXiGYoxHj7DBqe4FQs3iT2OO9JuOqBCJfojG02OvLtNC0LRIKdf1QJKGJIHJVkrMAuv4WBgUxMAkOEsdIo1QLrf6Mhq03gC2Er61urVEoNlLYNDYzC1e3TkmXzB4ETFrTPxFjlBxXRg+/fYMYwuxcRShoLG3Xl0+2qytcJyNnHhQK4IxXYwTkBKwyvpnyxjgfQ/ZN4UvcJLALacR34KtYzGrj8pHecqLQKRv8bxIhhOW1VUqBJ/lePMPAPVpMM6jVlfd9rr/RXXCAJ4tJ24KGXBjfAz+7p3rbsC/0uj1mp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyWDiQs1BstjeHWhmBkT1yukbBcC0J8Ri/SQokVwZFo=;
 b=O77LQlhMJd3HbYjkQtb8X/dUy55O2gcEfSykw/7XzxPffMKofEd5quWhTABMitPxqEXXBIS30jVn+xppKMDlfDWcyki8MBV1j+lOAgARYqkCxO7mooUv6Ut1wTq896aEbG5eP8KognrYmHjUG2knLGY48RENAVUdRKGPn4ZNUlyzPqzqdcP7T1cYgBCnjhRHm8I/HbOx3VQ60kJ+OMdAWvh1oxUe9lVFQZIQedRyd8UMMLkB963wlXtZwdh9pu02TWpC3SxEWjaZOXUWr/ZVFK5w9YxmXwdjJEWJZTZJp+Z67EqryRIN7rMcphM9hN+QHlhe9VoF9OVGQsmK5SuN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyWDiQs1BstjeHWhmBkT1yukbBcC0J8Ri/SQokVwZFo=;
 b=4EytN3WpfoNT/Ws9FPPbyUqGZMXJotv6bEbHCeQmrCXCdR4483JDNowcZxmgbNnbzvp8yK3t5yLnrIvBRPLrK7lEJTABuZMeSTd+25Oq5EjmF76HgBZ/oLc4NdBsCzy7LWXw5xYfEwVVNSvuFgQm7Yd9U3SGnBy/KglHFqzzeSU=
Received: from MW4PR04CA0044.namprd04.prod.outlook.com (2603:10b6:303:6a::19)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 07:40:21 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::28) by MW4PR04CA0044.outlook.office365.com
 (2603:10b6:303:6a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Wed, 3 May 2023 07:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Wed, 3 May 2023 07:40:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 02:40:18 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: xilinx: Change zc1275 board name to zcu1275
Date:   Wed, 3 May 2023 09:40:14 +0200
Message-ID: <4ba0eb85629ec5f07902a93fb75d13fff9697eb8.1683099606.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e794c0f-f9fa-4c46-d327-08db4ba9a670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26uYadTXmi6hYFQJU8gkmR9GhBftXj6jc1ASo85a2jSK+i0d4tz1i4w4KAf+3gfmhboSbbtJBsJni+8EEpjX2S/unlNFyF5x0m1lC2zDLfhFOKeyfh4CDVNMg499Hl/Ifu7m2Opuyf241O6breG/uOE9akptYlG52seEEKk9Jtzo3LdyhQy4gm+5rhHec7CCbi/HpAw8VQb5+aaaIP8719ESghkQ61qrEpNW7ZqYY0VCx/AuFdkhsHSTdEGKoCrA3SrNFQrVr/SK399JxRm+JkrgSH8YK6IdDKChtB2h0q/LwCzbxjZME9CcQL08ufgDbv48I7SmV7/waQL52pzIF7r70hz3uoV+LbpLpV67n+sqGhiylllaaiUHb4c3oQffUfuSUVGB+zvLBBgmM5LfJzZYP3ENCN1C/+lpwnDJLhqu3VdBpslEmZUe4crXCXFdlLoc3xO1DwMjpBkw4Y8sIW46D0Sverr586sINyFL+lmaF3xZW2ZsEd+qf2RP1ADSBGU+vy53HTOHQLPZu0HOt+PxIyewE/uuHgkAUJM48ilUn6t/yWAIAvvn/N1sMthA3WAUAbgVTcrwwQmvO8r1v3r+1pzSU+eEbFaB3O/LRcPTJNmFY20yLTgQDY9WQWDhNB+qO2ltfxrSYGWT/ZqMSgOV5SB6DDQG4HjUr4lrRU0heWaPEvTzdpL0fp15xVu7OQRIqYWSlCBzI/8IeaeibZ9Sg9KT+HSaHLVj5tFnJSh08JSo3uEgQny2D+bAwbHR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(336012)(2906002)(478600001)(16526019)(40460700003)(186003)(2616005)(6666004)(44832011)(36756003)(81166007)(356005)(41300700001)(316002)(40480700001)(82740400003)(26005)(110136005)(54906003)(70586007)(4326008)(70206006)(83380400001)(47076005)(5660300002)(8936002)(8676002)(426003)(82310400005)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 07:40:21.5462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e794c0f-f9fa-4c46-d327-08db4ba9a670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal board zc1275 was released also to public which ends up with adding
missing 'u' to board name. Reflect this change by renaming DT files.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Separate binding from DT/Makefile change - requested by Krzysztof

 Documentation/devicetree/bindings/arm/xilinx.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index 969cfe6dc434..b3071d10ea65 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -61,10 +61,10 @@ properties:
           - const: xlnx,zynqmp-zc1254
           - const: xlnx,zynqmp
 
-      - description: Xilinx internal board zc1275
+      - description: Xilinx evaluation board zcu1275
         items:
-          - const: xlnx,zynqmp-zc1275-revA
-          - const: xlnx,zynqmp-zc1275
+          - const: xlnx,zynqmp-zcu1275-revA
+          - const: xlnx,zynqmp-zcu1275
           - const: xlnx,zynqmp
 
       - description: Xilinx 96boards compatible board zcu100
-- 
2.36.1

