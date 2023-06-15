Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFCA73164E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245316AbjFOLRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbjFOLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:17:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE45271F;
        Thu, 15 Jun 2023 04:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRNy4O6IhztfAWU+SPWEDeLtZN396dmE5r/cbh5SRApIh4CAWKIO8oUB3S69parplWQiF4eXZXSFyXEMxVjTzMVuKPyncbpwjztYSXXCYGglBEzTYgS+aWM4mxRExhhFTh4FZiomoMYlUqJsGwEIrwinBj0pKaLHo+NP8sp5lxvVvi2sv0tduGZZem77rxj9KD8nCmnzW/P0SYgaiRtjYzM2iYGAvICNdwd/ozSjTIh1oDSGWh4bcaJEzI90l+UYxd/kK61RMQEJa87UXzgxd0GBm3nbNr1uKsB9SpLX8q4M3fBBOJwQVYVPilcPbBw62RDVpsKC2EI/pSW8W0Frhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwLpsJxkcH49sLPYetklM7Y60KSjKNFkRmtNfEo/TBI=;
 b=CA/Ylz96Yx0AvZ52RdaBLgAppg7jm1hQfjdHM6NDvts554roB4TUA9y143lhQ0pVeh3SDg/hWEJhZekP9WhjExfi/YUCR3D7b7AlEHZ4OD1lAfwO0lcylIDbFvabIfeeO+/EpdX/s3J1IJegNtaYemWwaEy23/m5CzdLrXsf336vXHLPEXzSlBjO5xA1xfSNYb0VRfM5EZnhM0teV5wBAThqqUYavS8ncaaqJGPN9lO9mi3OBFMxZ1ycz7SuSt9XIkpkXZxAH1gBpgd64QDuyLDngUzBe0mKU/JzfcSoFyeCJw22D+gUxnV4qoH7SqzIBVjQf80cltXtLbBso8wvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwLpsJxkcH49sLPYetklM7Y60KSjKNFkRmtNfEo/TBI=;
 b=heFT9ydZ2we9TViikrt71Re611OPsiJgcJL+IlEIuAspcDv2BWwo7HdK+ZO2tCPClekQWijbmedv0WSBDpAYyw95aZVetq+2tXjHTtgjE+uyACQi3fFGowHo6DO+AVLSX01U+nlpINVCyI7D3l1mvgXikr7iUkyAIzMisBE+Xf8=
Received: from SJ0PR05CA0169.namprd05.prod.outlook.com (2603:10b6:a03:339::24)
 by MN2PR12MB4568.namprd12.prod.outlook.com (2603:10b6:208:260::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 11:17:01 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:339:cafe::d7) by SJ0PR05CA0169.outlook.office365.com
 (2603:10b6:a03:339::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.12 via Frontend
 Transport; Thu, 15 Jun 2023 11:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 11:17:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 06:16:59 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Thu, 15 Jun 2023 06:16:55 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property to avoid setting SRWD bit in status register
Date:   Thu, 15 Jun 2023 16:46:48 +0530
Message-ID: <20230615111649.36344-2-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615111649.36344-1-amit.kumar-mahapatra@amd.com>
References: <20230615111649.36344-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|MN2PR12MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: d3423403-08f0-452f-3db6-08db6d920a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2POhLPixx5SY4x7dmV3xDq9hqgT3jvFyRxu2gTLoWjLiaEXSPJ7KnGpz9ewdHe3lLAhaCaoA34sdzWe9hPhsNcBSajaZEABv4Vaz7xgizAL4secGY75vep2B7ModfAwfOyO4RgRKdDwIxjS7854hl5Mfftm1bY5+V1azVO/cOuyQu0meEcrlD/ZpFCM06Y40WymQ1QuJY/M3k0dtxfVdxRv5ukPTM8+im8Yj70F8mq3DFyvRCV8d+1B5k1DfcQvIXLdDwLjJEe5D4dfXJcp/IaU2Io6N2Cg88n8eOFFFcyRwtnFJsMV06lqjbtdyDmjGV2+Z0rFnzbBMFyxveLhCla/9bMosS/amiI6U/OH5ErbU9sRHqemquhmDeYutPHRV8bBWlxSf3L+yNWlHZIWzm6QMOqvsBJq5dTIKLjh73WbRTq3ApEwW3cDZ+c9bmAMKKVumbg5DMZku7f5zqW1xaSFL4qeGgWgCFndLzNqE0Zo/EIqZUaLxJePteP2MMpQTPjsIGSMirrbGJ64HUpBio7V40K/5AJhXUz+ITyYoZn7op10J5wLKu/2+8fVSghudlC8na0zP3GIJUGa7EI3POwBaTC3zwXUXhV5pGroUswoQRghWDFo1uo14E862pZA5N2hjDeN/SDF7W+wFoNS+R5CPn0c5icu7EWV4kACLM0/L8jZOPI1c6WggYKA4lNbWFzCz2kLE7XOBlMEUaNgW0+qNiqN8KBaZm0w3wl7ikijlYT5tcuLPw89dIZ/htItsg775vpsqrHtiee5ttztvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(2906002)(26005)(186003)(40460700003)(336012)(426003)(40480700001)(47076005)(2616005)(70206006)(70586007)(356005)(81166007)(82740400003)(4326008)(41300700001)(8936002)(8676002)(316002)(6666004)(110136005)(54906003)(86362001)(82310400005)(36756003)(478600001)(7416002)(1076003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 11:17:00.5207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3423403-08f0-452f-3db6-08db6d920a26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4568
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the WP signal of the flash device is not connected and the software sets
the status register write disable (SRWD) bit in the status register then
thestatus register permanently becomes read-only. To avoid this added a new
boolean DT property "broken-wp". If WP signal is not connected, then this
property should be set in the DT to avoid setting the SRWD during status
register write operation.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 89959e5c47ba..a509d34f14b2 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -70,6 +70,19 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
+  broken-wp:
+    type: boolean
+    description:
+      The SRWD bit in status register, combined with the WP signal provides
+      hardware data protection for the device. When the SRWD bit is set to 1,
+      and the WP signal is driven LOW, the status register nonvolatile bits
+      become read-only and the WRITE STATUS REGISTER operation will not execute.
+      The only way to exit this hardware-protected mode is to drive WP HIGH. But
+      if the WP signal of the flash device is not connected then status register
+      permanently becomes read-only as the SRWD bit cannot be reset. This boolean
+      flag can be used on such systems in which WP signal is not connected, to
+      avoid setting the SRWD bit while writing the status register.
+
   reset-gpios:
     description:
       A GPIO line connected to the RESET (active low) signal of the device.
-- 
2.17.1

