Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2D8629DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbiKOPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiKOPiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:38:00 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F913DD3;
        Tue, 15 Nov 2022 07:37:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koZZqvICkxo5wSN2U6IH7sue5ZhIB0LClj302+fnhI/hKpXEHpSsY7Y6Y2W+O/Fa0pnu8BNvWMG36DVuTk+XLOXaP2Ex3HwsQm2maBioRAKJi65kyDH/r7s3GbyEUkqsBRoQpcOfVGBUFB0GoTyHkjGTdXdJ9z3e7Fvh95Jl7hvsHnLUaOzhweGQ9Ve9K4zxWgZTcTfjYu0mmOMWsoa91oHTr4gdgVjwcMyzaheCSoqwwVcrVxabGSZi8MhGhwrF5lS5go/ReJTS3o2n0r/7JfqWaDEba7FAjtcb1lmevwhp9tNXdDCBs3YpG6AluqgUmvKPFlj1WjXfJBvUu0R+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3/ywTAvxs4WWhlYpj7nHZydtnnoBslqYVKjvd6UvcY=;
 b=TomVLbtIouEMUJgoDxNJOJv5zeI8GGjWGckXF/8QVYV78s1BntbcUdkKGkifMwcIWSkY3zyt5w5/FAvKtTycVWOvnCNKq5o2YHgTUv18cXagP+3hLMcQkGbg0S+5/D6hkWCTk4Kgih6ObICocmBKehQE9ecIbiU6rArDaQ30xb3+vV4TZH8y6SslH69PIEdQj+Yd7X1MTI8UPq64n4B84IPodWbFT+gkZ8b0QDx0wAJeaJCNXNn3+uNQO1AMYuS6T5FO6me/Nr5JJeRaEw5KAIOu5WuDrgV/u36T7u800sE6ijqt/3P/w9oB9ZuqbeV73VI1oKDTdOOVID1lsGlz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3/ywTAvxs4WWhlYpj7nHZydtnnoBslqYVKjvd6UvcY=;
 b=nns82++7ojbb/5svH99pNRwvqw6bIGWoy4+AkMXPg+oKmx5KxP0KA/AiskcXPD34rAYmuLKfBHVCTMJiclevYm1lelhLY1NmOmN0TJYxVfuw81WJdg59MRAw3sFhj93k/K8RxggCKqJP3CZhufRTVX9clhci4IaZbMbFtZ1Kn4s=
Received: from DM6PR13CA0007.namprd13.prod.outlook.com (2603:10b6:5:bc::20) by
 DM4PR02MB9070.namprd02.prod.outlook.com (2603:10b6:8:112::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Tue, 15 Nov 2022 15:37:57 +0000
Received: from DM3NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::48) by DM6PR13CA0007.outlook.office365.com
 (2603:10b6:5:bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 15:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT028.mail.protection.outlook.com (10.13.4.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 15:37:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 15 Nov 2022 07:37:54 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Tue, 15 Nov 2022 07:37:54 -0800
Envelope-to: mathieu.poirier@linaro.org,
 arnaud.pouliquen@foss.st.com,
 bill.mills@linaro.com,
 tanmay.shah@amd.com,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.206] (port=57936 helo=xsjblevinsk50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1ouy0Y-0009M7-1B; Tue, 15 Nov 2022 07:37:54 -0800
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     <mathieu.poirier@linaro.org>, <arnaud.pouliquen@foss.st.com>,
        <bill.mills@linaro.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/1] remoteproc: Introduce rproc_get_by_id API
Date:   Tue, 15 Nov 2022 07:37:53 -0800
Message-ID: <20221115153753.2065803-2-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115153753.2065803-1-ben.levinsky@xilinx.com>
References: <20221115153753.2065803-1-ben.levinsky@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT028:EE_|DM4PR02MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 477d932f-f489-4f20-bf95-08dac71f5e82
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQj2RtxjDQ57xgfUBMIr9nuRDg0c3fIoUxgP33lc6JIEoEaRziLUrnO+CAWZHqot3Szq2aq72s0ZfSA4IGHkkBfyrAqEkbiIybOJIhqGRpqbAvuwdKYPXOo818pKaNDCWAHd320S3IrLo3cq+Rvk9QUM4biErnHrUq+EdcZC+uCB3Y43Jt6eTCsiZu8AckrohS+L8qZCZW1mXO2ZKHoXpc4c9sG2L8rgRSn430m2ypz/Tv7l1rXNvBDuqHDDMNi3LmrjqlGR+HULfpdzvZ75bs7+xZDOBEUGv/P5vFrfh18n2tPHMN4TMzI8yn10OUpPIQ0kCBYXNAUJLaUpNWdiMfdZcgQokFw1qg8T/5okRjZuC/f09lE16UGVBoskz6ju1zZ1bkVNTh0IFVLnirfQSRyzFJDOaSQWpVih/Cj4kvJNsGJ6EAvfh2zuD6XQUgOec4o/8vCkKac3xArF7ElRVXTparMdUBU51wryNsMQjqZqM9tUFbTTdum2Ed1Rj6ZZ58I+pUvY6Q343d0Su/IFApGfokktchKqvWyPENFpffz7dZM9TAcu2TF5N6NV0qspnxpYHO7VJeYPVJNcMvJpCliV/F7kV+LgGwgNICWwb3qXLWp7R6nDwyD2o2M3ycsZan4xKHjCpQvxNM4iEqjA2eYHTfgvWkzd1spCIdfAy7ZrjICxbkQMLhuA4dAtOzUEoyevzyBlvAYhu4OJoAhsJPPoTeIQGJch+h4jpVEIONmDksV/PMo9a853QuqyAvH90GV7SubTrxho7FT5LpB75Ubp15Pjbv1fWDvoLBSUlic=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(8936002)(5660300002)(44832011)(41300700001)(4326008)(8676002)(70586007)(9786002)(70206006)(110136005)(356005)(54906003)(40480700001)(36756003)(36860700001)(316002)(7696005)(26005)(478600001)(186003)(2616005)(47076005)(426003)(1076003)(336012)(83380400001)(2906002)(7636003)(82740400003)(82310400005)(40460700003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 15:37:56.8637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 477d932f-f489-4f20-bf95-08dac71f5e82
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9070
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users of remoteproc the ability to get a handle to an rproc by
passing in node that has parent rproc device and an ID that matches
an expected rproc struct's index field.

This enables to get rproc structure for remoteproc drivers that manage
more than 1 remote processor (e.g. TI and Xilinx R5 drivers).

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
 drivers/remoteproc/remoteproc_core.c | 64 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  1 +
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 775df165eb45..6f7058bcc80c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -40,6 +40,7 @@
 #include <linux/virtio_ring.h>
 #include <asm/byteorder.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 #include "remoteproc_internal.h"
 
@@ -2203,13 +2204,74 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 
 	return rproc;
 }
+
+/**
+ * rproc_get_by_id() - find a remote processor by ID
+ * @phandle: phandle to the rproc
+ * @id: Index into rproc list that uniquely identifies the rproc struct
+ *
+ * Finds an rproc handle using the remote processor's index, and then
+ * return a handle to the rproc. Before returning, ensure that the
+ * parent node's driver is still loaded.
+ *
+ * This function increments the remote processor's refcount, so always
+ * use rproc_put() to decrement it back once rproc isn't needed anymore.
+ *
+ * Return: rproc handle on success, and NULL on failure
+ */
+
+struct rproc *rproc_get_by_id(phandle phandle, unsigned int id)
+{
+	struct rproc *rproc = NULL, *r;
+	struct platform_device *parent_pdev;
+	struct device_node *np;
+
+	np = of_find_node_by_phandle(phandle);
+	if (!np)
+		return NULL;
+
+	parent_pdev = of_find_device_by_node(np->parent);
+	if (!parent_pdev) {
+		dev_err(&parent_pdev->dev,
+			"no platform device for node %pOF\n", np);
+		of_node_put(np);
+		return NULL;
+	}
+
+	/* prevent underlying implementation from being removed */
+	if (!try_module_get(parent_pdev->dev.driver->owner)) {
+		dev_err(&parent_pdev->dev, "can't get owner\n");
+		of_node_put(np);
+		return NULL;
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(r, &rproc_list, node) {
+		if (r->index == id) {
+			rproc = r;
+			get_device(&rproc->dev);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	of_node_put(np);
+
+	return rproc;
+}
+EXPORT_SYMBOL(rproc_get_by_id);
 #else
 struct rproc *rproc_get_by_phandle(phandle phandle)
 {
 	return NULL;
 }
-#endif
 EXPORT_SYMBOL(rproc_get_by_phandle);
+struct rproc *rproc_get_by_id(phandle phandle, unsigned int id)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(rproc_get_by_id);
+#endif
 
 /**
  * rproc_set_firmware() - assign a new firmware
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 3cde845ba26e..10961fae0f77 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -645,6 +645,7 @@ struct rproc_vdev {
 };
 
 struct rproc *rproc_get_by_phandle(phandle phandle);
+struct rproc *rproc_get_by_id(phandle phandle, unsigned int id);
 struct rproc *rproc_get_by_child(struct device *dev);
 
 struct rproc *rproc_alloc(struct device *dev, const char *name,
-- 
2.25.1

