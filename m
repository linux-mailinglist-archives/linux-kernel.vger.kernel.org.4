Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9A70D581
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjEWHn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjEWHnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:43:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124FC5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGVEBAcAGTP8SRAiaHiFL1aCLpeCooCHFqrQzTk+Hp2zsap/wY9TtNYnoxXEI6nCu6ib+Qo/l4rn9NSNIJ7M3M3oMM8NFevGQFMTmFCOmo0hPnkuB/RRA5MUDz6xYYmqiVtgJ9hUo/4bhKKxHqqAZ7axJr9jrBlhSOk8dfasqY5qu/WDXCwA1LgnFRM95sr8KNd5tEkrsFO23yoPhTgQ5o+6A3+Y3zfgFhhYdpi+FlJk9S6XOAq2G0eKKNbwyK55uOW4oGzIH1L9WeMDRTyS3mv629frKEpF/VCy0hx0vnUV0KAa3Xz4FKpU+9pSA3+zxm940iLWe4hQ1wG8WiFkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6dli/MtDQI1q9/E1mpkBZraJZ72Z6qPv0pjW8eqkPg=;
 b=j9glTZTXxsIma+zCjBva1eMByX+ucjAhmxC3JNSytg+KoFAdq+O40+bcwwYDl3xMpDQOFp5SkuVlWqcCaQAyQU+iqxEIKNL1TgG5RRStxAnQlo8U9iKpTK5V3EBeY3pZJc08r+zbBihM72OkWBY+AYku36m+FRZsMnF5BUqf9m1HceOT/I5DqcUQeKXPPWrEjTJhjXLe7O5v7a1ydWdBgQ7alIjh1e7Y/C7PN7qvbAILSr8tgG/goxIJ2dowl21OKxcqpDZqPX6xGllbrOqQuXqqjKSiKghyUwwhgJI091cR3Dph0ZTxslMRD6savaTWuRvEdkksU2j/7LrAU2bFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6dli/MtDQI1q9/E1mpkBZraJZ72Z6qPv0pjW8eqkPg=;
 b=NJeAHQE3V7GPvH5KBBAhR5DlenyWhpxvzwfP3obbdZFZyuGpJod95HxbLusGRJsidbJ6UcVl4psp2FX8RPDBoTBo496U0/hN5uzb43rdZIVQgL61mKSvyN8NxAYAUh8WwJ31cio19AgT7OfOGgwdilB7Bq8SFP7j43yxhQSfsI4=
Received: from BY5PR17CA0032.namprd17.prod.outlook.com (2603:10b6:a03:1b8::45)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:43:48 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::57) by BY5PR17CA0032.outlook.office365.com
 (2603:10b6:a03:1b8::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 07:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.8 via Frontend Transport; Tue, 23 May 2023 07:43:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 02:43:45 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <miquel.raynal@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <monstr@monstr.eu>, <michal.simek@xilinx.com>, <git@xilinx.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH] MAINTAINERS: Add myself as reviewer instead of Naga
Date:   Tue, 23 May 2023 09:43:42 +0200
Message-ID: <06df49c300c53a27423260e99acc217b06d4e588.1684827820.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678; i=michal.simek@amd.com; h=from:subject:message-id; bh=ObPLSU1/c7yHnrIxtFwDwdmoIepoMNmu9fNwJeg6nhg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpScvDVBkif1t75bG102bRnX3tJdLZf/ykbP/Jkiv0w5a xWX0+Q1HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiLL4M82ykQ24bV3xu49gW 8/v3BPPAuaukfzDMlU0xnPQgU1p26aODE24f3JvdJ7YhCgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a623fe-3cae-458f-a3a9-08db5b617159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrjHtxH3ExGu1xkRCTqg2SVVWwkLkw+OuGvLGskFi3SVNpm5wyO/OZnHWZ6KKURf4LgYZlSqWCl+D6YdiObliTQHVbQ9A1wWg6ByVjwRDfGDSgzpJq7pmRiR3BU+woB6HFFwfyTky9DORRvnC+ApYSM7eaqZJ12hn0YsbCciQRS+uhxPDrTw7vf5USa1vHCW1z9dQ0fo8SM/GKXcBxLNnYKSROh0UaFvSkMRH+p1qKCaQg6mJQT/9qx56pPP3+K7iA2lNepvvaoSUhiJBUtAGdExSgCrHDQcFpcwI1yCPS08Oik9oCpjhLoplygofsJsbSUgt/ZqDKjI756j02D7vq2c3ecdWY2isSwYsI/wczZBUyRUWBuHcAyxwrGNcutc6rWaZszgd1KE+vu7FBfAFODPa7FH9rXTZHi5ZvsP6V2ujzXpCsh/dtYbnJYdPfqRvWdAi9MrA+KIjK5co3+fgBNyIu4AgiiRIkd5L7TgT6TpSR4XeiajUs/AHImFcI5VXAEN+Y2p6Ydoi9MCAm9XXg7RlHj10geb6lH17IYzc0RBb/isw495Hce4T2EZtVNala/5AGakV8ChZGW4bV0y2rEWpVRPn9eIcJQcsbcrKseHKIVH7h4FNmi4MU7jUaiZD/3vQpdeKkX7AMI8ZGjyh9XKaNR+xYVwIVZ3WdFy6OuH0QKl21WrQYdRV9Yyi9X4oE5DRMH/RgtqhHeWaZUMFkIltVkBT026Kg4K6Wj4H7yQirt0nh9KDD/ITqrPQNO/mfzjHuLDcdb0RPRkFYOIIPJDUhNIQvMOAx/zTVWlNxI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(478600001)(82310400005)(110136005)(316002)(6666004)(70586007)(70206006)(86362001)(5660300002)(8936002)(8676002)(40460700003)(44832011)(81166007)(356005)(26005)(82740400003)(16526019)(186003)(2906002)(83380400001)(40480700001)(336012)(426003)(2616005)(36756003)(36860700001)(47076005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 07:43:47.3306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a623fe-3cae-458f-a3a9-08db5b617159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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

Resend to also include linux-mtd and ARM mailing list - based on my
discussion with Miquel.
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b2ef60a4d01..3dcb54389356 100644
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

