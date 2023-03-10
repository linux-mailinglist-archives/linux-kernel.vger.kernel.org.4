Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB56B4E63
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjCJRVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCJRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:21:10 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5668910F854;
        Fri, 10 Mar 2023 09:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJkKJ7Ry0uK/VoxPdyG+TVrZ+0JMkjyFA5P2NAs/kTGc3X0ODj2pGrMMeEJ7qvo+7qxgVa+1y0SaCGeDh8kjgXOyQgFFvwX4dWgEUrCOxT0po9Xig8da/4FW//A/yMDcgEbq3zel6OOj9IuPLswXGZhEqDNHn0OhCPG87HgtDkoDiJlGC64MfAO7mXLx+hk3P946CZPThdsH0c1sSKpJE/tgiuZZindVcgbjS4RMfBYpW7QyS+6+34+FxXLNb9JR0kQMyiB+STK+rJ8eQKShWtThTGOvu6DlfLuPP1OnNouoSUZ6CUMvBGFve4xRgf9QcUr9g6BtTkb0lEAfk3gtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODg/tlJuZ84SaKcq1ZM6ioVe4eMxSgqBdAVLJIRn12U=;
 b=Ilfo2BBmBCvUDjDcL+P2dV2R+/xqf4Oy6BEMNt0dymbDKzy4x6aWUrVd585hO1rY3qeESlZ94oG/JROJKkTep5i9Mg4BAPUo/r4lPGC/YN9VjEEyUyxD/fd+dBa4OEih55ZW0PEj9VKNpawdK6wQ3/571+71RGhM8y8frF/jxobrIPGvESSthztfghkfV7msY4aqledIHosIs1gcI4GAjNnv0Sy7XF9zRbnAmmGGMlNDJ4a3HTL4oGGpyNRQqJbMvy8VRpKjdwt0dFuEeS4kbQ7CtkygLCu3tjzvCRb6ZXOOO/0Gz1tuZKQxkZVW9U02GAdcfGjTI9QdPCppHsJ9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODg/tlJuZ84SaKcq1ZM6ioVe4eMxSgqBdAVLJIRn12U=;
 b=Wo9n5hrDrZadxYLagLNqrBVROVwv656FKoK4SmP9TdMJzMSlyb8sbMYFAKT+XixfsMyZzU/hY7HD3iBbvir099EboL6+gaKiPHQ5irx98Wscx95dc1MdehaWK8Xo/RheMkM+yRa00fNHZR68T7TBED3uPNUqrptu5ufpV5tYf9Q=
Received: from DM6PR06CA0075.namprd06.prod.outlook.com (2603:10b6:5:336::8) by
 IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:21:05 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::22) by DM6PR06CA0075.outlook.office365.com
 (2603:10b6:5:336::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 17:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Fri, 10 Mar 2023 17:21:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 11:21:02 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
CC:     <anson.tsao@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Sanju Mehta" <Sanju.Mehta@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] thunderbolt: Use const qualifier for `ring_interrupt_index`
Date:   Fri, 10 Mar 2023 11:20:49 -0600
Message-ID: <20230310172050.1394-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310172050.1394-1-mario.limonciello@amd.com>
References: <20230310172050.1394-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: b8903eac-c44c-4688-9cea-08db218bd477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29IxnS6aY3HEaRE+2gT2XIwjYe+o15EJAATg8knXe90RPXSL0tS8WGutqjXna56O47h8GGIQ6X7YsLh684uIZq4eHgnZF5jd9iNBXqNd6RqePqQuLLjCnlcyG9G+55RUMQUKIgE3kdPGxrFQW66YaqC3UvPU2m1PUeaMeYZAIJmKU+3T83bBBsVwTze/HF62goGR5tkXmlGIA12FqgQX3ONm+RcxrVq9r/+6HkJ9Qe5wQ20Sm9jXsX+qoHH4dEqDC6Bkcm0fMhDynkXcZfVzSGXWVD65HpYB2/LCGpdUwUq0d/g9HZXXcZLI56mqkal2OYD9bbV1eT2Io5SgHCAivJUHpDwoL/dfblHBZugqlMYdNMitYkDbNw+E6mA5QGy78ACGPLjLo4nJJpibyp+zeFYEkgrD5ZTG9rUy6BRRE7AFYJm7urR7iUindKSefwxwhefKatHBKJeHQxuoq/5QHbVF8G5U57wYIhmGOC78USw0Mq99YTvgoH3NbzIRhBT9YpgD+n+ovBmtTLo3QcmmslgsFpjlwlU1DIPpZv0L1D5BFjx+Bd8K9YNWGJ7Mjm3+x6uPgeSSOJJjMRIMa5tFylgPfUI9TJ4b86/fc0jq5bMB/NsYn6CReqr6bT1xSijohN6V/twhNSYj6uPls/9JXcIXuq5LsgwWbs6LBrigkdigLeaZVuD9vOJPuL6cJ0siIL1+LHT3s35gTnJTKf4MmvFLI0PfB5+2aizcU/4ZVaM5NKjcqLH/QRS5T3qI1i6/bmTAYyHRcw3M1x5tTRRYrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(36756003)(47076005)(83380400001)(426003)(82740400003)(6666004)(36860700001)(16526019)(1076003)(26005)(186003)(7696005)(336012)(40460700003)(2616005)(41300700001)(70206006)(8676002)(8936002)(86362001)(4326008)(5660300002)(70586007)(2906002)(44832011)(4744005)(356005)(81166007)(316002)(54906003)(110136005)(478600001)(40480700001)(82310400005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:21:05.1054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8903eac-c44c-4688-9cea-08db218bd477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`ring_interrupt_index` doesn't change the data for `ring` so
mark it as const.

Cc: Sanju Mehta <Sanju.Mehta@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/nhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 4dce2edd86ea0..fdc0c3ba2ef01 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -46,7 +46,7 @@
 #define QUIRK_AUTO_CLEAR_INT	BIT(0)
 #define QUIRK_E2E		BIT(1)
 
-static int ring_interrupt_index(struct tb_ring *ring)
+static int ring_interrupt_index(const struct tb_ring *ring)
 {
 	int bit = ring->hop;
 	if (!ring->is_tx)
-- 
2.25.1

