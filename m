Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C90E6F5382
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjECIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjECImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:42:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162C5FF6;
        Wed,  3 May 2023 01:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCY7FTjEW9O5oYl5PiMQ6A7yfdx7Y/dNCVNdK/9LW5kKgDzQwHdxFwBK25Gg2DKOehE+XwVaFaRR6KgaTllhK6uxt7AJBeryY+YAPoNZNNcJjt2ZDwTJynma/5OgT5pC4s/0p2EJzr8Y0UtXmxFF3TKukL2ZG3V19iqNoXb6CQKuFJ7WNh8ZoaW7MDV6eEW6wSvnaEtxq9UU79rm73p79gj23B6N55F2fIYiEzeQHxlNgnG3jykyqPRtLI544PAn9tz7dXcoFXdkary0/V3uOxMZlfzVrPevqOKaV9LOtdLQpZayJUSYlpPDuStnAWGMwSik2pB5TOL8qbqmmsMN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWlDUgdW/AUX69qkcq4WW5WksXoNSCGxVnQOh5K8u6A=;
 b=kUoMoZGS08xFN6gAz5xZNLVkFQIVtPAm9L4s14w5smTvPmE91uqZ9ft5gyEklz/fit8HrYb/mHADk+mfdSrhPvStskLMIaNQICHj/GYOc+YPCsqH9dAEicNtpHK8zzm2CLxX/ocBCsDNQg5raoJ4i1CWfPpEjio3HKcKhRUvrhK9fExY8B+zVWhDU1Ievb36RY3V6qALcZtRDSFW4TkrukDklkHV+ofVq7t8S+5EgX7HfXGxtHk8H4dAdekrhO8YOIdpqCAfO2D2c5uK2KHdrJqkMfcJMUct80LlsehtWZzmMKKEmHCk+YjCVnEkibDhGJ0K0b0So9opEXpYO+LLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWlDUgdW/AUX69qkcq4WW5WksXoNSCGxVnQOh5K8u6A=;
 b=Zz//sXvlmSo4o6Z4XpgdQirMPq1/nrDob8ld4zvEHMdCFm7igHTN3L8mQHN5uDRyCxoSEpQxCfp+YvLK9QwNkPCffEUn+x8hXLaCUZ4W40WQfAABaRsvlFqpprSpCbVUZCgMyRZa/+2xZoWX/gVIsbeBSxAb31K7Ibs49x1sHSc=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 08:41:01 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::9) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 08:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 08:41:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 03:40:58 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>
Subject: [PATCH] dt-bindings: xilinx: Remove Naga from memory and mtd bindings
Date:   Wed, 3 May 2023 10:40:55 +0200
Message-ID: <6b4cdc7158599b4a38409a03eda56e38975b6233.1683103250.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 726caacd-1b02-4c17-bcbc-08db4bb21f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQv5g2Bgt5N4tAXob3hX9txBD5Wn5715qMeCpbMO+PCEUVz3mFt2sVx5EJW7NkUs1/vf+kUJhrl/RN7bhDYNR9NWKKejR/p2iYENpPkoNq9MFRThCLgbIK+EJUgh80uqRlTf30DJFCkYBh0JmKMtIBkXs1y5/HyqOMfXgNOoGZckESuoSkliift0+i4neciJzkL7KtJU9v+8VQybbM3rSIKdM5PHtRyQSN967VccyJhk6e5iex2Kb/pHhpV9N/GC6wOT8SAKURCJU7T3GTBIsRWDpIaUDRKwggOHDMxhCgNdMsPHoCHQXAV6U7bY9YRMciYLnwikU2o2TdMGgK+V3zl0YXFDUJCw096PJG/5AYNM8XeZrdDoXaen5JdAFqoZ06sa2CR7Kx9qGwKbeTKY58CYOC/bgOBb4zc9zEkNNNZBwI2jQRumD64Wo2h22bp+kCkCW9iy1ADP6JyaqztC5FcHiS98TqneI3Xh6bZ8fKa4V/VtemVHTNBFGrXdC3tEdE5JklViRtBbz7RVRK1+rk4klZsQR3/Xq+vprvJ232d5Snyj+g+kASeCTpf37HJsA8uHmk6iM3k18tBCexdtSCkqxmEjnmwGJxC/9+/YufOfeNNcpyXzxmY8dJ8+GXSJf0aTgfDN9oIcOYirBGMlUnW7g9MT84MRonhJVYjPsaocPqtn/ptwa/N+KB+HOPTlZ9iPBAvN/bJnPtJdV0Ule4ImE+zQsjiLTX8sq7AyTHz56rm6hJyoXbN6GsDVs7mm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(70206006)(16526019)(70586007)(4326008)(356005)(186003)(82740400003)(316002)(40460700003)(478600001)(82310400005)(110136005)(36756003)(86362001)(54906003)(40480700001)(6666004)(2906002)(36860700001)(336012)(426003)(26005)(5660300002)(7416002)(83380400001)(8676002)(2616005)(47076005)(8936002)(44832011)(81166007)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:41:00.6246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726caacd-1b02-4c17-bcbc-08db4bb21f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612
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

Naga is no longer works for AMD/Xilinx and there is no activity from him to
continue to maintain Xilinx related drivers. Two drivers have Miquel as
maintainer and for the last one add myself instead to be kept in a loop if
there is any change required.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml   | 1 -
 .../devicetree/bindings/mtd/arasan,nand-controller.yaml         | 2 +-
 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml  | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml
index 6d3962a17e49..05dd6b3a1a3c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml
@@ -8,7 +8,6 @@ title: Arm PL35x Series Static Memory Controller (SMC)
 
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
-  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
 
 description: |
   The PL35x Static Memory Controller is a bus where you can connect two kinds
diff --git a/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
index 2fe53cbfbee0..15b63bbb82a2 100644
--- a/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
@@ -10,7 +10,7 @@ allOf:
   - $ref: nand-controller.yaml
 
 maintainers:
-  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
+  - Michal Simek <michal.simek@amd.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
index f8c0f606f451..7bd7c55a9c15 100644
--- a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
+++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
@@ -11,7 +11,6 @@ allOf:
 
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
-  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
 
 properties:
   compatible:
-- 
2.36.1

