Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A836C4174
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCVEKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCVEKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:10:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7361C4E5F0;
        Tue, 21 Mar 2023 21:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEiUYZWmv7BjBub/Gx7EXFryxMcACEf2dDyXKZmawp9vyB0catx8zmlhrRnhLGT4Z86FYQ9ZORyu4/A38MOwmK6fwtKSxb1ngXIaFlT+IDaratn0LrWCqsTh/BqwVvF9XmgrbJeWEmbTJ/2gAuYwownBaZM7C1SlXjr1M9ABR86dwm0bl9haUBGzpUWRr6ayioUixi8mtegsa/CQEq3nT/ps4FG3qDlZh27dmk7yJ7LbGl5WIvu6nInJ32LM6XNV3unQ+rcobcea2S+D05bN8dhDIsDJvvEWRc12IHzrGvY5YizVTzhah72FDnFU1DvnKmLHgFcPRVUgA3tMFYVkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IDJdz1gtlGCKa6X2xH2XCQDLw7SPd0NOoZLJrZ6c2E=;
 b=RNCfaHSs9CXMTj0giklq8MLPylBt/qwVORjk/Wa4JEdkKCSxdRwcTW8Z4nBVUZWWMTJA+mSa/kqMizQo45Ijv88TVw23dTBIpIbjl8kEv9IQ7AvQqxdvcZ8cdEGIBbejsLrYdYnQ7bHGHOuyZuPcnzbnZcjeOLUsgLDxRkO/J3K4T5N6MG3CKmCDQphviBtEim/yhaXv3I+KhiITm4JYWt+irKP6tfZj/RQFEqh36NFr7SwhIF76UV9P6R4z8SDcxr71aTCqOxRO7YEYyzD9LMSK0SkLf2UaPq3OdvA0fzNU2LKE4ZXHBY3TV82izGtLr0aaaziAAWS8ED7cWILucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IDJdz1gtlGCKa6X2xH2XCQDLw7SPd0NOoZLJrZ6c2E=;
 b=hNEb0UR1GaPs1j5gLOG4dmYOMFvmL9iubCaYj3KDV+tPvI2/WXD4iHOMk7kj8J/4DR1DfSqcqPQjcOJv3tqgjd/R7lYixc4CgbhgeF3LWJ5djXQFn5rfxFSBixJDuq655s9Eb0s/piomzbjZ9Tne6w1R9gk6IlqJjlvf7MCq1HY=
Received: from DS7PR05CA0069.namprd05.prod.outlook.com (2603:10b6:8:57::21) by
 MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 04:10:31 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::cd) by DS7PR05CA0069.outlook.office365.com
 (2603:10b6:8:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.16 via Frontend
 Transport; Wed, 22 Mar 2023 04:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.26 via Frontend Transport; Wed, 22 Mar 2023 04:10:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 23:10:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 21:10:30 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 23:10:29 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Tarak Reddy <tarak.reddy@amd.com>
Subject: [PATCH v2 2/2] remoteproc: enhance rproc_put() for clusters
Date:   Tue, 21 Mar 2023 21:09:36 -0700
Message-ID: <20230322040933.924813-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322040933.924813-1-tanmay.shah@amd.com>
References: <20230322040933.924813-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 22419b43-55e5-4666-30ea-08db2a8b6065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Dw9CN8XRAO/vJnpN2Bp/7vG6zFJ05Pe8yUAXyWm/JQ2ON6PtdAs9nXgTrLW7el2uvRUcgCrpVmr2QzCbl4oI0qjIyQNuqbaUs1uIBSU3UImqsGIEjmuWQXw9wQl69S9PvIOzc1RlkdXKVoHOYI3OXZNdQKfXgpQNlLctX9Jb0Kc6EVU/tDxKe3/ffttEj43qC3kHB3V6+PSUMKTK8yz2632i0PfQfDL8hUGYGtyq3unPS83dkXotb6Hr7J6aOLuu41SwJhPlVEauX/GACQeCTBsVaPsdSYgkvq4Hw3hSB5OuS+6GHm9YGn3ZQV0bGS6qjm67IbXq4W8n0uF40t+tRn6Y+cTphdMbeFJDh0fsXlJPhLmYVLWU8Xs2FcSmVpA5Xko2gUZ8hUYrnTZT6b0H7HoRelUOukng490HSeZTiU0JTQ+AtFfodz/ZB8aLk6TxPwE05f0/il0j+5Gl0rMSiDk0nY13OASohhtf9VTmSZiys0Fs3+NYdSbwbGnKpDsueAyckT0bHtbkSHixtsXxPP21iGo+TyIOmfCu1LDFWQ6CXK4am9b3iU8Vs9FZK9JaOXPX03KqHcKHe+/eM5TWgjcwea5ROXd24ziOGgIIKQMgIkodNESZs9lZFOFRoa63BlKqzpLZJD5ZtWN4RjtvrFtH224ZOUsWxZA0b/eWO7zJD8+0pXvqqjL1bPi3qgjvGv6dZMr1st9ulFTRn2tsJabSFpHf7QbFJnlNgvOC6E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(426003)(47076005)(336012)(6666004)(26005)(82310400005)(54906003)(478600001)(316002)(2616005)(186003)(86362001)(110136005)(1076003)(8676002)(70206006)(70586007)(36860700001)(41300700001)(5660300002)(40460700003)(8936002)(4326008)(40480700001)(82740400003)(2906002)(44832011)(356005)(36756003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 04:10:30.8341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22419b43-55e5-4666-30ea-08db2a8b6065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enhances rproc_put() to support remoteproc clusters
with multiple child nodes as in rproc_get_by_phandle().

Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/remoteproc_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a3e7c8798381..e7e451012615 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2560,6 +2560,19 @@ EXPORT_SYMBOL(rproc_free);
 void rproc_put(struct rproc *rproc)
 {
 	module_put(rproc->dev.parent->driver->owner);
+	struct platform_device *cluster_pdev;
+
+	if (rproc->dev.parent) {
+		if (rproc->dev.parent->driver) {
+			module_put(rproc->dev.parent->driver->owner);
+		} else {
+			cluster_pdev = of_find_device_by_node(rproc->dev.parent->of_node->parent);
+			if (cluster_pdev) {
+				module_put(cluster_pdev->dev.driver->owner);
+				put_device(&cluster_pdev->dev);
+			}
+		}
+	}
 	put_device(&rproc->dev);
 }
 EXPORT_SYMBOL(rproc_put);
-- 
2.25.1

