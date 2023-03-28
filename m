Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2486CC87E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjC1Quh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC1Qua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:50:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B943D1024D;
        Tue, 28 Mar 2023 09:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7kdmcgEtKwUHZ3K4U80M5KIGqRmjSCYFZoXRBZFnDuQeLGB1n7pOju+q86VesUdFvukG0Wte+3xs+peguNQ71n7iD0OT9I67JIVyA+8+aJ20XMSvffE+CHjWiyWPCimb56pFZlzDurbcnl/1XKUA9toHy10f6x+9gn4B+pPWrQmknbabUWhS3yz8flGgwQfBUY8w68UaitVgMffa5pdNdXkakmxnuI17M4uARXSHiym5oiyrEjTIAaMm6K43hJlopevFs6+yflnjVnGXT46ZZjRTaguxLTc/AbhVnjHrfDZ8+/olcjWL3NDnYu2c+4e9GHhyDn78AoRi90siYb93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waXwmx6v93/a48giSXE8o8Eupo8VCthQfd07N3Sc3bA=;
 b=WEOQ5Nz4Mwx1FMKBPNjAavHY1xrQgwwsb6IKRUwY39i7UxKTQSi9rVC5W+WuRmvBGjejlN7c79vVhAcqk1kIYk6OdJ9f90913JLZP0sfFqz+XfPgq7TF5TVNKD9xvQjGLW/dlOr4iX6S8RvFo5WE7fNBoba+pUsOSfHqwz4ycZwj16wD5RcvRXnyxcTDlMeEYUOnK0OliArNBE+j7mRk8dspqkjSxjwdBD/389RB9lZOq/2LHEqSZNUUE0NEdT59LMhl4cMwkK47+u6IRIEAdFTGivTq+XCBXmusGzHsGLMn9gtoC2+q2Z4rWTwn9RUpvd+1rYw2gYpiHfAcLgwqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waXwmx6v93/a48giSXE8o8Eupo8VCthQfd07N3Sc3bA=;
 b=Nspit4K3CsfNLjtancyNi+z2TdXVPBifWY+vr/pMmeiwx2ShxZL4TDYv79nQZ6nnynwydtVPfefV7y1GjuhbuScjxTwXOeXDTilamS18XcdYAPTw6/gqGtQT3xbsUMwoyqXotaOEVurTJlm9fxL55hreYIRghUqc5+iHfP/Xpg4=
Received: from CY5PR15CA0160.namprd15.prod.outlook.com (2603:10b6:930:67::28)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 16:49:52 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::87) by CY5PR15CA0160.outlook.office365.com
 (2603:10b6:930:67::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 16:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 16:49:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 11:49:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 09:49:51 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Mar 2023 11:49:50 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ben Levinsky" <ben.levinsky@xilinx.com>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: [PATCH v3 1/2] remoteproc: Make rproc_get_by_phandle() work for clusters
Date:   Tue, 28 Mar 2023 09:49:22 -0700
Message-ID: <20230328164921.1895937-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328164921.1895937-1-tanmay.shah@amd.com>
References: <20230328164921.1895937-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b958f16-41f1-44f2-eebe-08db2fac7360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUESMd3hTrgXQPxb61UYTpz4S7SY/mqCGFIdBK91yGKnBieXugQKKnvTnxtB8YLQhwewXBPY/o4R6/MLQaHEwiycFF9UsHAoNDo06vk5bXeJQiSREa47FRzxKfoJoGNI2MC0KthKabug4qmBaneeKvTMxhR/I0zI8LY26khCMkSWPnsad2UKsKPEkrLXPKJXwDnIY0fG5SAqK8Pavk6bi2cQm31zjL5zkeWWVMJzAabh7Pth1Va8UfSGoF1BEYm952/abAuFB6MFSG473x/SE7j7AgLX6MG8PV7U6jH35DRrIoPsLrH7vFNTufiOCvAvxx54U4Va+92SKbly38NPXjqEgoROhOmKrkgRCZW99Cq+ztg+b3Mxq/ftLw0+V4gLXmLy2tKTe59TfDkXu07k1WL5uA0Y6Z/Un16g55i3CHEzAm8PelbCF2pyvKDHUlPUU1x6QAmZMMRF0GBnF204RiRoJ3OYy8Tizu2bxwmetoaKsq0liz4+C2xBvZCttiY01BfjUUULvAVDFlIzK6Z5Ib43gUabaHa9lXOyu75LMSP99NNHyjoRkShpt9eJ2hFq39/7+Wdf59Pk4zCCwYHU7yWjq3/mA16v+sK4/N3vaX1BzlVyBvIkWYA+z6m24oun3WRLTqVA1Wnh86/4QCXQjtoJZFsziVme7P2caGHRf1gDYC46l7/uZGr5QCUotb0dWh2DkWeWRtWg6mdbbnPe9WnahbpQu+3hV37X22B7/Ds=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(426003)(47076005)(336012)(44832011)(186003)(2906002)(2616005)(26005)(40460700003)(6666004)(356005)(82740400003)(316002)(41300700001)(54906003)(110136005)(86362001)(70586007)(4326008)(8676002)(70206006)(82310400005)(1076003)(40480700001)(36860700001)(36756003)(5660300002)(8936002)(81166007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 16:49:51.8732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b958f16-41f1-44f2-eebe-08db2fac7360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

