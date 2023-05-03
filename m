Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF36F5385
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjECIoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:43:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54DB180
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvhkTMa4rBMesRKVmW/OtxHmpfLTAZZQ3GeT09PRsI3GDHqsfs36aMk681moEZmsOe0rD6+kgTmAyGLSxmOFAZqSfW44GVeqlwCtdbXDRzW4nF+NH8O8nZgKztPiIvMXxgImf+3nJM5lJpa7DH2rWQchgd/f8D4B7DFC9V9VfPnJhuL+hB6V8M2mPIY7emrbuIwjnBqsTqgoP8asgOJ68HWDkco18YpZdi/EQJsU5mgwdvGfCha2gAJZgxbExrWqQmNoousLlMoCPCOCYdlQmUEE5dE7Kam9jtC+oPSIIkT6YgfKQ76QfmNwNXmlKEnaZBerqq1ikm83YMAssMC8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMggkyOYv7AOWByHiWdEZamJbuZqYABIwFlKTxY2MCs=;
 b=KHd5CpCAzkymEKFAIZn/+a7u72asF/x4A10mfHrGYKkdhgfl2F/xBTgci1cx2Z9DqARrVH0yX4mo3mmOAtqGhfvX23ILCEIIKRQeDhgBvHD9S/5QcliAK+mCGTF9k7nk1soFfyefI8Qoi3nlQ8tU6gfOlxn98RmMaCTnClXVEJB4CgI/Nqz2OwDdLAjm3xgcaVEvi1n7bAek0c6m1f2wjjfop/iVljzYM/MbvCixFanAvq+kV98+Ya3SVMIuMVujCPokM2hwUNhO7eOJTf9LguFrd8jjtcvj2NixS9Vbr1sbIcjjLxGQaH0egcAbO3LSzyTjA5xx8rt4pYV+cS76wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMggkyOYv7AOWByHiWdEZamJbuZqYABIwFlKTxY2MCs=;
 b=aZ2FzV46vAlJ8m2EN2LcpluIGuW8LXRPnO7MfkIuT8VC2YUhqoPoVVggtX1Ibv+V3my0nVdeDPFPtW37CURSew8jww2tCA5Aae7vL2xJqwa1ZH8yRPNWf+WdIWrUHdLCIAFFYn1K0xQd96evRmN5To5ltvJYFg0zwMDmw8vd/80=
Received: from MW4PR04CA0282.namprd04.prod.outlook.com (2603:10b6:303:89::17)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 08:43:43 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::45) by MW4PR04CA0282.outlook.office365.com
 (2603:10b6:303:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 08:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Wed, 3 May 2023 08:43:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 03:43:40 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <miquel.raynal@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <monstr@monstr.eu>, <michal.simek@xilinx.com>, <git@xilinx.com>
Subject: [PATCH] MAINTAINERS: Add myself as reviewer instead of Naga
Date:   Wed, 3 May 2023 10:43:38 +0200
Message-ID: <c3ff76cb5e861500efe784f9f74ed93db08b2eb8.1683103414.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: ce89114f-0b5a-4ab8-38c7-08db4bb28006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iBX/DA6U9f3Mp2liyzK448P6bIaBD7UHDfvHbA0NNGEVdz+z3sPeeLZbF2woZpzaOX0ST0SEFwywevcoPEWWlWR2YhVA5G0NHfii2lXxWeRr03I/AXvKLAZx34JqkEpf+4O7vgdBLBGhXG6mUfkusMZGN95vL9szQeo18WMeVc3tRoYTpBr2gFGsDfRcs7B/Bb9HbihTa4dVd4AiSyVUYB9b4cAm8aT8ZZ5XbIN+BW2kZ+88OPAztgBelHxmtrtXWel7GPE1aqZ1X45KhGvutIEYdQvdcN6VMimQmE/8VRb7Rq8QA3vlwcCKG5n5n/3HBFU+PIxqPmHG4TN2IsZu6TobjAKid0alo/vn35A0spgigv4OXCVS5tqij3qG6Bn8uViVdbzQ9OHD0k0HE37jXdYbQFiG6btxCaIsRHINxy7TlkWPSS2LP9QEr0Y0kVXgwQh2u9OAYUkO80Hyn9TFQd17TXccuK731pYtzKQVXe4whR9K5fKPYqeLedPMNN83kQOQijfJe8rCbzDjidk2Us2Fd8G2T1egC6P073XGR91xKFffzh96O4oK8yX490gZabj5lufLFBNtZMMUP0vP698mc6vU0f6mcBkdCFNM8B432pnooToDzXFzpHoj7DdC8R/jqqcVvNxLi1ajiQ3rESNJxVbmEYZFSiOJv9hPLcUolECnV71o8I7Mon0PDOT3E29yCVNbk6aGDKG/4T8GzcwQ1mpvV2RCLMPSXoXgWh1EGkIAJi/LxSunCrEH7P/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(478600001)(70586007)(70206006)(40480700001)(110136005)(316002)(8936002)(44832011)(40460700003)(86362001)(82310400005)(26005)(5660300002)(36860700001)(2906002)(8676002)(2616005)(336012)(426003)(47076005)(83380400001)(82740400003)(81166007)(356005)(186003)(36756003)(16526019)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:43:42.5804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce89114f-0b5a-4ab8-38c7-08db4bb28006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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

Naga no longer works for AMD/Xilinx and there is no activity from him to
continue to maintain Xilinx related drivers. Add myself instead to be kept
in loop if there is any need for testing.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 643f9feeb09a..104f1b8727d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1600,7 +1600,7 @@ F:	drivers/media/i2c/ar0521.c
 
 ARASAN NAND CONTROLLER DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
-M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
+R:	Michal Simek <michal.simek@amd.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
@@ -1740,7 +1740,7 @@ F:	include/linux/amba/bus.h
 
 ARM PRIMECELL PL35X NAND CONTROLLER DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
-M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
+R:	Michal Simek <michal.simek@amd.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
@@ -1748,7 +1748,7 @@ F:	drivers/mtd/nand/raw/pl35x-nand-controller.c
 
 ARM PRIMECELL PL35X SMC DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
-M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
+R:	Michal Simek <michal.simek@amd.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml
-- 
2.36.1

