Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2396A70CA37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjEVUBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjEVUBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:01:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3660A3;
        Mon, 22 May 2023 13:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu5pvUEqfgpe1mnZpZoiJtiY2oOytMEzZZ6G2/txTBqIiwu8l3Rf7eRnzUCj6aJZ3plLUce6+z3MDKK3atpiJFC4t+1hU1QEjIpTCNZ0Kk6aF8VOAvgXbDOM/QMJbDesTxsIZtXqwfCpzEjhIca5gswEKJcsuvqSSiqyFdfC0kZFc2bhMbv0o+5qpLOfA+J8G+zYcqqFtpgIkhM+0qf8wbFaQWSTIOQHhE2Cg3Yjjw8hIwwG6Ez1HEWNG01dihIkPaQXixvynoUfXUk05gW1Fulm1BGIqrppTXyHmFfYCJpfMkjN1nEqiZymEPhzSzQ9uRwlcIpTD4YaEoZASIzJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubPxSYLQGxhGoWRcu44ovgwIBi2Oo1TW3ZlBkvAqxpU=;
 b=SD5W2Tfqg5ieESe7Qak+6raTAqmtk4RwIra8WjhL8OVHegXPXhFggXALy6R7RS6JRohCBRNCvw8qgL7KM5QZJJaDbSorTkgIqIV7/zI6NOi2W0Y/d1gGIiqZXK/VKzW5N7CjwYFJBGnYYmH3DlJ3/ZfF7gx3ro4MuNGUMFwScwI+/wvPhVU9TvkPvG2f9gUqKGxDzerDkN6eoGXkPku9qoU+VADXe3Lt/WQGbGHRHYfK9ba3ziQxIj5wzqqNu5WREAZ2NcXTDVXLAehPC2SUm93QJ2jectueAZRk7msRJsTSjrf0FDkU+sMWtqGOH25soJN4x0w08TwaM0yswFwRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubPxSYLQGxhGoWRcu44ovgwIBi2Oo1TW3ZlBkvAqxpU=;
 b=dgikT8MRgjf5ozdDVVeUVwuI45y+p2WRKC0+QkaLvx/qhGlBZkxiprwW8I4QSxatqlanYBpiP73VkOSFIcH+d9b96LS3+z3O5bnnLF80Gv0X6J9gOX4wLWfvR6eCBudt+SnjrevqPQtYGjFbMQAPz2SsfUPObu1OfWcy9DAI9tc=
Received: from MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 20:01:07 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::63) by MW4PR03CA0179.outlook.office365.com
 (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 20:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 20:01:06 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 15:01:04 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/4] include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume
Date:   Mon, 22 May 2023 15:00:30 -0500
Message-ID: <20230522200033.2605-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb469ce-ddb1-4ba6-6f59-08db5aff47ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYWlnN2I89r0gMTnjkhwoS8rjNk+ODi51F3uYt7Z0IhD1D3dIzaRqnIuMk1coXp3tL1f1SkClQmQF0zU3wOA6cvMnhkBfekbXwbybkXN05Lu6mYXXBDflxKzJ8IovwXEBhz4cE+fJyU8LMtNIPOOJIHDUhwNxyw1wHrFcBvnkPh/jIVlvxRNsUVV1yUBJdyiofCgPadPV4ALuEWonACcBdhq67trn3DoKPY8SN8pJwKav51m7waFB/0gGPTMz+S/JucZGIlVYtj5zPcOkZVnP0CvEyPRDhfXWBjYZzZ/t1Eg3xtzrz6XOs0sV4gn0/HuxCHxQmEckAIJ7BUzhYFUnPlo0Jfp4FJboC5dwqV2glIBGdVR9GEoD8P3RugelE5rclTUtWDKFW8bZZom9H0s6YwNfcM+HNHAcSeBiWtD+coObsmRbHkRMHHJrh+Q7+sucxIFvScxbROYs62t6AXjHIGC5SWeP+D/3qZVvi1Mn0Vcs5jC4JhBZNKuk6Gv8YyK0cWFcAfnxZ8Zdqapgp5pJmteG7zs+IzUxmqj7oLDG+lF+WGs71yZ+EVQ29yVZLw3Njsq88hKcwwzSHc9QVNkp30SW0xfAheKtC3I5olzwuLZhqYaCihLH0y+taouM6LeA0HL/jv68r6RZv3jDrA4vJ05NLhMm6FMnwgsRHGIZ5qsKPNi8Y8Qfh+xju4gHLoCmHVjjws6BQ7ytLxwFlFKfMNFTHt5Yf/ovHaUOgM/cQC10oH2OfGIhYVWpnwOkIyp2QTGpTgZ7s47Jy3u+iYf2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(8936002)(8676002)(47076005)(5660300002)(44832011)(36860700001)(82310400005)(83380400001)(186003)(16526019)(1076003)(86362001)(2616005)(26005)(81166007)(356005)(82740400003)(426003)(336012)(40460700003)(41300700001)(6666004)(7696005)(40480700001)(70206006)(70586007)(316002)(4326008)(36756003)(478600001)(110136005)(54906003)(2906002)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 20:01:06.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb469ce-ddb1-4ba6-6f59-08db5aff47ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All uses in the kernel are currently already oriented around
suspend/resume. As some other parts of the kernel may also use these
messages in functions that could also be used outside of
suspend/resume, only enable in suspend/resume path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/linux/suspend.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index d0d4598a7b3f..a40f2e667e09 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -564,7 +564,8 @@ static inline int pm_dyn_debug_messages_on(void)
 #endif
 #define __pm_pr_dbg(fmt, ...)					\
 	do {							\
-		if (pm_debug_messages_on)			\
+		if (pm_debug_messages_on &&			\
+		    pm_suspend_target_state != PM_SUSPEND_ON)	\
 			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 		else if (pm_dyn_debug_messages_on())		\
 			pr_debug(fmt, ##__VA_ARGS__);	\
@@ -589,7 +590,8 @@ static inline int pm_dyn_debug_messages_on(void)
 /**
  * pm_pr_dbg - print pm sleep debug messages
  *
- * If pm_debug_messages_on is enabled, print message.
+ * If pm_debug_messages_on is enabled and the system is entering/leaving
+ *      suspend, print message.
  * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled,
  *	print message only from instances explicitly enabled on dynamic debug's
  *	control.

base-commit: 42dfdd08422dec99bfe526072063f65c0b9fb7d2
-- 
2.34.1

