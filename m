Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D36C4172
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCVEK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCVEKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:10:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95A74FCF6;
        Tue, 21 Mar 2023 21:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idIfD+V653aD5tWD2WbnFkiyG8+TWPicJe8bia4K1PE1ve8zFoEWyTbpPIje2SX60UPRF4FL3/S7ipXX2hNMwUhRD6468QWG50X/EYlNSTlcqVUFriNY4IkBM4EmmwbKdy8IvzuIqUCZSxgnUAkwRFBPiStXT11KiNBnNHog4xzzrnQAC4U1iimdz37q269552mE0ks0N3C5OKON1B1t3bqEzyDjUmN9ysYQ4pTbk+wMLYZRHJrOmZr1u7Kn258/jB1VlTwaNBP8dw48IxMebk2lWi/li0x65psS9564pZSUVrFW1xNiE73rCdL5TckhYjA+KucW+mKBjIqscgIYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waXwmx6v93/a48giSXE8o8Eupo8VCthQfd07N3Sc3bA=;
 b=AXjS6pqMkga4R00+Z0byFAnSdNdbFtvF7lavoyhS5jYsBFLDZ6K4cEGxkXfrVfapZvpgAZDPFJKCJOXsRLw2DVmVCfNvaJ0e0TyRLQieK6lIIJf+908/Eojt8d+LpgDwD9Ei0p3d/pBqauf8xUoo4hBm7ujtezxLo1YIoG/h7jyKbuncOH0dq78LQxBEXPpDsQk1C8WgrzbmYEnLvs8oPiBahFuJ2VYFRkPexDuWSr7+nu9OecRqirtRBVU5GqE7oy40DXb216PPLsG9yfCsNs34cmA5at1cwXe+IhdXVbB9Rc6vLAjuTY8XUDFjtPeDw1QcXDLQX9WhgabTzvzWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waXwmx6v93/a48giSXE8o8Eupo8VCthQfd07N3Sc3bA=;
 b=AF9sH2v+WibOyre4Llcpg6SgboUyVbwjfD21VN95bcQ2syQ2BJQbJpATKDaCtuypPE262T6wDLNMIN6EZhf94kZE3YpbVEKiAMjfJo9PrMW3cJsJggkpQYDJYCtd8prFl+Siumo6Z/Xvk7zZeR7N3pR4Pk7FMk51sJph3+YoMRE=
Received: from CY5PR15CA0231.namprd15.prod.outlook.com (2603:10b6:930:88::16)
 by BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 04:10:20 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::41) by CY5PR15CA0231.outlook.office365.com
 (2603:10b6:930:88::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 04:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.2 via Frontend Transport; Wed, 22 Mar 2023 04:10:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 23:10:19 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 23:10:19 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ben Levinsky" <ben.levinsky@xilinx.com>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: [PATCH v2 1/2] remoteproc: Make rproc_get_by_phandle() work for clusters
Date:   Tue, 21 Mar 2023 21:09:34 -0700
Message-ID: <20230322040933.924813-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322040933.924813-1-tanmay.shah@amd.com>
References: <20230322040933.924813-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|BL0PR12MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 297400be-68f6-44d2-b03c-08db2a8b5a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZEy4VrUjAp2Z4MQiSi43EkoH7D97cRu5BaSx4O1ys+rHJC4Tz8O15f6wIqZBzb+PCQZ5HOb1CbNWbgv98qNskk4kMqbnbFDQeqoFbbiTGKAe40k+x2qt6GwYYFESjqYdmWlUj4GCd3pm24DJfGTEG8Zp1wBzZt0VVugQinTe8KZfY4JlMEDE5efkCvml2zvrzdyKn1cP0VuIt9R96dM5IZ1Q6TOcT3Tcz5o2NqbvyU6U6fPJ84oanV4pGPOJD91E5dK33pIEv1AA2lwmpP+ugf63T8o6k5oPYcFwWHyt+J1m1HXYPVyzR1LIYxuXHja+HWpnKUzHAtJoKr6JSfGJILwL3WRUG1Zkxb49kGHAyjn1ObMie85CfsQbchmcWwo95gg4CHXo5fkgGjXruemZLR5iJOdOW7YsLNloVyEL7hG66AiqyK7bYUZFhxh+RzUHH/T6K8/76uf+1l05MdkhVxocKlrWWHIImQ1vGAqzORtKryOib3ECusdLLl3kb87AingZxTPLxNlx9bIANzQ21oz5knC1aEZYVYJ6GxKeQvB+BRfiutmRrL60l9o6hpQVVcpeu7vMo3EN3awARltvnF2+HhkPprcmdIFkJbONno+aQ0GgeVO/RDEGgPPE9GqTM6vjx2NxkC6wFW8uATmjRhDlFUOcxfavfleXz7g/aZuiSVLa7aea2fsPDjvMfQKXwKkIqI+YYG2XXMIa3MLsLkNfmEv01BHXhro0PDxgyg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(2616005)(41300700001)(186003)(426003)(4326008)(47076005)(83380400001)(478600001)(6666004)(336012)(316002)(110136005)(8676002)(70586007)(70206006)(26005)(1076003)(54906003)(36860700001)(44832011)(8936002)(5660300002)(82740400003)(81166007)(2906002)(36756003)(40460700003)(82310400005)(356005)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 04:10:20.3228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297400be-68f6-44d2-b03c-08db2a8b5a23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Multi-cluster remoteproc designs typically have the following DT
declaration:

	remoteproc_cluster {
		compatible = "soc,remoteproc-cluster";

                core0: core0 {
			compatible = "soc,remoteproc-core"
                        memory-region;
                        sram;
                };

                core1: core1 {
			compatible = "soc,remoteproc-core"
                        memory-region;
                        sram;
                }
        };

A driver exists for the cluster rather than the individual cores
themselves so that operation mode and HW specific configurations
applicable to the cluster can be made.

Because the driver exists at the cluster level and not the individual
core level, function rproc_get_by_phandle() fails to return the
remoteproc associated with the phandled it is called for.

This patch enhances rproc_get_by_phandle() by looking for the cluster's
driver when the driver for the immediate remoteproc's parent is not
found.

Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 80072b6b6283..a3e7c8798381 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -33,6 +33,7 @@
 #include <linux/idr.h>
 #include <linux/elf.h>
 #include <linux/crc32.h>
+#include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
@@ -2111,7 +2112,9 @@ EXPORT_SYMBOL(rproc_detach);
 #ifdef CONFIG_OF
 struct rproc *rproc_get_by_phandle(phandle phandle)
 {
+	struct platform_device *cluster_pdev;
 	struct rproc *rproc = NULL, *r;
+	struct device_driver *driver;
 	struct device_node *np;
 
 	np = of_find_node_by_phandle(phandle);
@@ -2122,7 +2125,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 	list_for_each_entry_rcu(r, &rproc_list, node) {
 		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
 			/* prevent underlying implementation from being removed */
-			if (!try_module_get(r->dev.parent->driver->owner)) {
+
+			/*
+			 * If the remoteproc's parent has a driver, the
+			 * remoteproc is not part of a cluster and we can use
+			 * that driver.
+			 */
+			driver = r->dev.parent->driver;
+
+			/*
+			 * If the remoteproc's parent does not have a driver,
+			 * look for the driver associated with the cluster.
+			 */
+			if (!driver) {
+				cluster_pdev = of_find_device_by_node(np->parent);
+				if (!cluster_pdev) {
+					dev_err(&r->dev, "can't get parent\n");
+					break;
+				}
+
+				driver = cluster_pdev->dev.driver;
+				put_device(&cluster_pdev->dev);
+			}
+
+			if (!try_module_get(driver->owner)) {
 				dev_err(&r->dev, "can't get owner\n");
 				break;
 			}
-- 
2.25.1

