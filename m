Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631C76F4580
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjEBNtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjEBNtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:49:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF91A6;
        Tue,  2 May 2023 06:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgSM6oUK3snH6uNRfjn1KaGOrf7UDdeQqikSU9n4s1Jm5UQkyKcPFRGrCR9qnJs+DKTV2PKiSIYjoWk0mdPFfZxKybahoYdTnjiSldpCdVDa3Zky4GNUyQTAAlRijHW8k26wga4Y9pDfPVvWIBUbX52Ze35DpxD103DWkA3IMj8WbB4cmOd+FbSVNmxcr8is86Hc1Vfmex61A28g/CyM47esADMYwH6Ohso72bGS6l6NZxhNwTteMKvddNxdMhGO0a7U9Z/YqZUAkfsZWQid4ZIjg2nLlfqZsZXTgRa+c2QdLS/wBcsAJGHanQK99yqUq/zZo3sWhlOyULhSd1mx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRCfuFmnlObKnM7edyNCUmwI2OV4CSCIsQt19GZ6qNM=;
 b=bCdTbj0Ckwxqt73db8bl/bPY3ecKylHyUh15C7Ac9QmAZ6niQ5HQP4SwpjA3hjL5Qv+pdMuOwLByp2LUpdtEwryZC3RuywSGBSKQu+s1ZKlgqNgnEgb0VDrNejkdO2u5Z7c6JPeEyqQruLfjySG/Y8Iq9ZCXs9n9878keyx4fXqXt+3LhD7+hylKwW7G2uEWlHNoYmXXnDl9N2bDamj9+MxXAtjCy0Njwwgq/LkK3Qi6O32ivuif+5jLd2WmCExdbHh9NPeE0wMY0X3tAJT+OiFN6N3W8BSq1/TNnih84xtrONjGjS21SYEAKzZDgLGGlkvRglvhhQSSkFfL2boT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRCfuFmnlObKnM7edyNCUmwI2OV4CSCIsQt19GZ6qNM=;
 b=2AMiGN3tB0yMCAHX/BZcJuwMAHYppSyY6r26bsWxJvGeLLvnKOtnjmrBQhSOV9TLsTMzDi5KXywNBwObTo6fVIyTFId7sLkO2x9avIsgNsvxnSPdhTNITpvQsl2blpKc1lnw6EvlHruzt9Ta8yx7j26EQz77+8rUGPBvU2pN41w=
Received: from DM6PR17CA0022.namprd17.prod.outlook.com (2603:10b6:5:1b3::35)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:48:59 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::3e) by DM6PR17CA0022.outlook.office365.com
 (2603:10b6:5:1b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:48:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:48:58 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH] dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries
Date:   Tue, 2 May 2023 15:48:51 +0200
Message-ID: <76a2bbd9fb944dbefdb8d429d0a85937d56a3d6f.1683035327.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ee3211-1139-42d2-2f45-08db4b13fb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M//2Ageb0sinUL1d0KmPuKX/lqMSKPP0SZj6LHflAkq0H55KiKPgpBR8US3SFjJLccUF3v0n+X6KRI739c1R9gPM+QImQGG6YbR6ie5eJ65cnZTbmI2Szmjsg6TP5udl53Mx1/p9VnHmOS94x85KOyQhQ3qg1QCjPQSURreX9IJT5i1CEFL4qvoOklOp+7O5XJBpbRNCjrAqJ0jlWlEKrzoqnxZ/JE0+MqpQ6RuyzbllRQSAwGxKjgplmbfLxirXtAjwwB1r5Z6ny2oAJGOcK8/hvKk9uW13VTDrk95uqzref10y3BQzjHRjY7KQ+YqSk+Wwc2/llFKGJCjNLOQqUY7Y2qiZ/VPn/r4JTT9K8OafgjwhvMF+e2UBrZV6+34QsoaiDx7iurfwW2ztlEmAjs+crhRa1zdUkXQH7/eW7dnEe5S7M7ST1URreOaIOjLJk/jLPCeDSunqK8YVxl5dLmitbIG+40tBJL/I9RTAnuCA6FLKkBvqSM3Y9kQ1bYh5ZpPxvE6s4uVULCDQgUMlfitXq43BimVh+k5RD1Wc3dDF921KpRAVjiUN7lPqPXNPoF3zuRNn2jGuRtYJzMuYJgb/EFXzFL0EM0mI8UZCRhOVvWFsgay8/Zf65zvFHNENyGf9Kcn5AAQXvnSrLAx2gCLgQN86U6geIVru+smvQgl5AI/gDpW5Mi5FDrH1p993rW4QOJXTxFGw60xqSQqheIhx7K7e3aOTQ2RqU9cZKH31xMqv9Iu+U4X/YtkpFiFt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(6666004)(54906003)(478600001)(83380400001)(47076005)(336012)(426003)(36860700001)(26005)(40480700001)(16526019)(186003)(36756003)(81166007)(2616005)(82740400003)(82310400005)(40460700003)(4326008)(70586007)(44832011)(70206006)(316002)(4744005)(356005)(8936002)(8676002)(41300700001)(5660300002)(2906002)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:48:59.7236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ee3211-1139-42d2-2f45-08db4b13fb71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current only one entry is enabled but IP itself is using 4 different IDs
which are already listed in zynqmp.dtsi.

sata: ahci@fd0c0000 {
	compatible = "ceva,ahci-1v84";
	...
	iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
		 <&smmu 0x4c2>, <&smmu 0x4c3>;
};

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
index 9b31f864e071..71364c6081ff 100644
--- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
+++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
@@ -32,7 +32,7 @@ properties:
     maxItems: 1
 
   iommus:
-    maxItems: 1
+    maxItems: 4
 
   power-domains:
     maxItems: 1
-- 
2.36.1

