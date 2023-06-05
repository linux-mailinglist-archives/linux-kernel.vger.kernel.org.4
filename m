Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD8D722702
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjFENLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjFENK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:10:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C3115
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5/2jcoXHDuD+IMIPCYdT5W9CnFy3QANJTluA6ySruaWnnQbI9KqWMBKq8VGXVhR7YPi2Mk8eOCpYOkUgvh09//UGJw8kEt4JXXlltDjk56rXhFF809f44GvATb/3BTJ2HFZLwaZ5AP3iMttcjUM165ypQbJORF9uei9/RNjHTk+iqq5Nlb/dmxtEV9Se0Qa3Bbxibdr39k6bzuaXRmzqBI7Y+VP8KKCXBYAue7wcZ40qySSuQ2mfeSPWfzmQID9LvNWboODbGv2VIXi8VwZqv2wRcevw/BjjARsvPaXwJdTLYWv0XfKH60Bgnu9lA3wEuIE5IMh9MTokeoFJEtkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZMBBVqnsex25k5zU/seiso1HWO+lAZIfk9uVG2Tm7Y=;
 b=GU1MI+0s6pIC03UBJPSJWEfZsHZywIlegKjjRGDiq+8fjNgO/czuLmyJVRs96I6gDi0nBtEAMdr4/LDyBIfgwJ+0bZEOxquzjZzwZkf1LUf+hAgOrNlA1lY2gfetSeVKxCVaCxreXc+M1iVztr91WrViaw0R4UZq4Cf7eMS6aozECoZX2DL9OpZxYB+pvc64A9Q+EpqTPBBztyfst+AAZL4mnPaoDFgBvqtk1wPwyLXMv38+CZQVnkETf3dTrmOqamSSiHquSiNdCLdwpAH3IC8Tsh43K9FXhdR/qMOYKBWUIejfdYvlRV3Uqmg9Wnv8xohTiR2J9zRnft5jKs3ErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZMBBVqnsex25k5zU/seiso1HWO+lAZIfk9uVG2Tm7Y=;
 b=PlXBqPuCgf6/+/tLsGnUlcsm1gui58BfeUkLPIuv2s9Std0C4UPbS4gB3S8ubhxpGEfZhXZuuR4LzWstZe7eZ2+Y25JY8U7rpLmNYGtYt/v+cVpTNEkAYshAMxhCTjruVdRsZ6MQvsMuHAIYhee/TkHkZd0VMhUCUGR41aQJHCw=
Received: from SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) by DS7PR12MB6142.namprd12.prod.outlook.com
 (2603:10b6:8:9a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 13:10:40 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::7e) by SN6PR2101CA0001.outlook.office365.com
 (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.6 via Frontend
 Transport; Mon, 5 Jun 2023 13:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.14 via Frontend Transport; Mon, 5 Jun 2023 13:10:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 08:10:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 08:10:20 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 5 Jun 2023 08:10:17 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <harpreet.anand@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <nikhil.agarwal@amd.com>,
        <michal.simek@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [RESEND PATCH] cdx: fix driver managed dma support
Date:   Mon, 5 Jun 2023 18:40:09 +0530
Message-ID: <20230605131009.6869-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3dc142-f6da-49dd-3309-08db65c642aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeiLzTNwnDVtK9jc943MXNRoUK4R59xHf7O//l8Bol3EbWvJ9B9IamlNZs0M9jzPYvmA99x9JRVbduwaf6QxQs6dKNhGmW1V6xmtUfKFP4JaaMS4BM8oWunfuD8bGn9JzUco9FYxzhQMxUjv34Wo0e28lIkFHcH2hADqfbwqiDrEX55G9VkRiFNOeJ9AHVSrtfrwgYPezEj2ZIFZlDjfuQJIOgh1v313XxVEfpqcIpE5DDASY7yMtHCe1jfXkqx49HvEiEIwQahYeeVStcXQ7/KMJeYg2uV0s3NOLDmbjwnnmyL18Gx1V2qhr6EQRMY+BtDtOoiKDJgK4WQVGLuNn9uvFKponGz3iP6y3dmTYugwU79PnLGxGzY7MdkFT9BOVsJZpUtq5GAGSf8ph0a1VoirkSQ0Mu6cWTwVXPd+Ao6qOrcA0EvS5CnlMIUbXh+Ht17sgMOT2QeLjcVf5pNqOUDFnKfSekEJ9lbkPwUSV1XjmFhbpL888W9j92LQpf855hgQgdKA/qxkiINuGC9bUj0Vn1D9kFZnvWeGIftnw/LLweIQEDhFSbSGTDKAqzWnA8Ox9+MitW6x6/f+WzNnL7KnJRZ6b3lEOvDYntesYzfDNY0N/phMwVNefHj6oDI8Sr1b1djnwYrmpLAckFtvl9Qh05o6bMcUFJZNPvCZrfGXGo3Yk+9nuD0xhu/FmD7H5FSxMFBM5SshsH+2HxFwpoy4ECCMUtBrdsxC94TvzkUlvwQf336gB/n12gjI/DFzAJvnSGSA75Ty7+ER84qcXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(966005)(426003)(336012)(82740400003)(44832011)(54906003)(110136005)(40480700001)(478600001)(8676002)(8936002)(41300700001)(316002)(70586007)(70206006)(356005)(81166007)(4326008)(5660300002)(86362001)(40460700003)(36756003)(6666004)(2906002)(36860700001)(82310400005)(1076003)(26005)(186003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 13:10:39.8812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3dc142-f6da-49dd-3309-08db65c642aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devices on cdx could be bound to drivers with the device
DMA managed by kernel drivers or user-space applications.
As multiple devices can be placed in the same IOMMU group, the
DMA on these devices must either be entirely under kernel control
or userspace control. Fix the CDX bus driver to acknowlege the
driver_managed_dma flag and call the appropriate iommu APIs.

Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Closes: https://lore.kernel.org/lkml/20230524134831.28dc97e2.alex.williamson@redhat.com/
---

I have resend this patch to include fixes, closes and
reported by tags. We request that this fix be incorporated
into the 6.4 release, along with the inclusion of CDX bus
driver support.
Original patch was sent at:
https://lore.kernel.org/lkml/20230531114759.6173-1-nipun.gupta@amd.com/

 drivers/cdx/cdx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index dc74fae02a78..42bbe5ed370d 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -63,6 +63,8 @@
 #include <linux/mm.h>
 #include <linux/xarray.h>
 #include <linux/cdx/cdx_bus.h>
+#include <linux/iommu.h>
+#include <linux/dma-map-ops.h>
 #include "cdx.h"
 
 /* Default DMA mask for devices on a CDX bus */
@@ -267,6 +269,7 @@ static void cdx_shutdown(struct device *dev)
 
 static int cdx_dma_configure(struct device *dev)
 {
+	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
 	u32 input_id = cdx_dev->req_id;
 	int ret;
@@ -277,9 +280,23 @@ static int cdx_dma_configure(struct device *dev)
 		return ret;
 	}
 
+	if (!ret && !cdx_drv->driver_managed_dma) {
+		ret = iommu_device_use_default_domain(dev);
+		if (ret)
+			arch_teardown_dma_ops(dev);
+	}
+
 	return 0;
 }
 
+static void cdx_dma_cleanup(struct device *dev)
+{
+	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
+
+	if (!cdx_drv->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
+}
+
 /* show configuration fields */
 #define cdx_config_attr(field, format_string)	\
 static ssize_t	\
@@ -503,6 +520,7 @@ struct bus_type cdx_bus_type = {
 	.remove		= cdx_remove,
 	.shutdown	= cdx_shutdown,
 	.dma_configure	= cdx_dma_configure,
+	.dma_cleanup	= cdx_dma_cleanup,
 	.bus_groups	= cdx_bus_groups,
 	.dev_groups	= cdx_dev_groups,
 };
-- 
2.17.1

