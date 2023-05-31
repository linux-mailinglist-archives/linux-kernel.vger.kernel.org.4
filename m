Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECE717EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjEaLsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjEaLsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:48:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E76E5
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4+wY3SjhpXkB68UBpbCC9jdTdgd2xADgubyQ/h73QBk/2ymfebFQ6XFPbgYkRn7iV+EMhDHLba6gqHBeAe5PTNeJuhSPNTAaApFbzKpjBa2VyBOb/+cu+bLKGLA/yNITpHMccOAyIoJM8Gr0RV8Cst7QknBgfbxRVbe5gyUhgBbVqvOVK+rjVSZcMR9sh128gZwgVwVQynv0ljYWI1PfuMF40XM6UBIeb4Gfa8XmfOPComJBc6ZXIN3SZUtsj7YT6TwpvA1tJWJs9QrjRa1DPDk8TaEb6PVpp1CmhISuiXakqs75Kh9rf4l6tDF0SkD3ulzVp4ztfxbyzRBQBC9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsndmcED6E8ESJ4SF+a8BwQWyhDHB01MRjPU/if6Fes=;
 b=in9IwPM4wBUXiQVePkRcSRDPBW6V1EF8fwuM7Y/INkK6o05x7t+gJ81pVEQ/W7PNFkKWZ1cNK/hSvd0oqK5uNXU+kh+OjwHqCJP+oL8eo8URitC363dAVrBWU+ih9akCG7YmMLSGo7pUk7Y7VJM5NrEriLzO1RBaIBKBpnKX/Y8MkDVygPchI/8woHIZBf4dOqJYrCSYLtt1ez0TZoTVuHdtwz8MUsflI3uY74Iw82hrbsUBlb+DcMh7XWRrkAtkwmCyK10DEU1aVjd1aLH8qnrOFAkjxxqz2Apzlyg2XlEiM+UKTMWhxq0/drN73/o3ekkgDHFvBn7BR2bNysY30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsndmcED6E8ESJ4SF+a8BwQWyhDHB01MRjPU/if6Fes=;
 b=hZQZVbKt6ODX6cTd0g5I2h7u+hmDxkRdSfkVhzlA1fShunlhUCrd2y3gegX4m8cc1BVo6DsfoCxeb2JITwLt1xKZt/gqOQn8ozSs1WrbAZJX+mhDYMYR5xc7vfGnUaYTUbQ3OPQOlxmFk/dwLZ3Ccu6CQXXixHlKJ2/NDKLObOk=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 11:48:07 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::54) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Wed, 31 May 2023 11:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 11:48:06 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 06:48:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 04:48:05 -0700
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 31 May 2023 06:48:03 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <harpreet.anand@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <nikhil.agarwal@amd.com>,
        <michal.simek@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH] cdx: add support for driver managed dma
Date:   Wed, 31 May 2023 17:17:59 +0530
Message-ID: <20230531114759.6173-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 1986f9a1-e180-428b-aefe-08db61cce65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwqoYEa9v3Zzk3Yr/QslIWQwmd3Q98a/taJ2teD49vopR4gFFfxxcpJZDnrMJYy11uU+a/i3McYKWq6a5ihgVmlaBiOsP6Azi+mA+JLYyRBQMHlerp3qxyonxhPL6CBcGIDCKQ9fp6robFw+lSQRD1F0WWezk3JAZ2ocyoBYAXT3mKzIhJHYvtk1X16AUsk29C0RN/ylooqaoCfkI96Qq2AJxwye0C+PHDVtcEyk1Yk3QfjAqqCT28mXUE4Dls17SuPhjN38VntZmzPuLTwHjA8Df/f/mgGLqGUc0mcYt87Usv6kAlHxGtUSBjNQM8EfKZgZmRXkQ5wI2wL8M+BxqL/H/fw8nyo9NfbEHpy+paVypi29Gk0C2A5UkG2x6fAzlSPK6uwD6VRL6itqfz/aqqIRuhXifSlg+Sf3k/QK6Nayg6hgdhVDyvknZ5Jp+qeiwBgB/hb3deJTkeGrGaA1ZiZsOwLnBipqZwrinoVeec4sBloPdT5DJ1zvPZmAsvnhtbq/b4565KkNk7mqGLyoEBzzDGDQvg0BelkKQLWLvMbiS+NYL5fnqWajMEJIDCfL1CExz0CQZSjU65Yd7Z9LfWHBHLIkosCgO1IPlVjnWN7aK+yOvsgrUUVTmAdSiY2eewLSmSeXicXByIbAySibop6MPKdIY9WmFd6HghPDlOGF5+3mG1bfry4+uij0iWXx2AVDqhL7zvCGzYJM/3W375oqplN63ozcMp3GsYWaHgd7N7w7ABbNVNNACgMkO9c2yRdnFhYcfxVNM/aiR3BqkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(44832011)(8676002)(8936002)(86362001)(316002)(41300700001)(70586007)(70206006)(110136005)(5660300002)(2906002)(54906003)(478600001)(6666004)(82740400003)(356005)(81166007)(82310400005)(40460700003)(40480700001)(47076005)(186003)(1076003)(26005)(36756003)(36860700001)(2616005)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 11:48:06.7682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1986f9a1-e180-428b-aefe-08db61cce65e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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

The devices on cdx could be bound to drivers with the device
DMA managed by kernel drivers or user-space applications.
As multiple devices can be placed in the same IOMMU group, the
DMA on these devices must either be entirely under kernel control
or userspace control. driver_managed_dma flag should be set by
the driver which assigns the devices to be controlled by
user-space.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/cdx/cdx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 38511fd36325..d2cad4c670a0 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -62,6 +62,8 @@
 #include <linux/mm.h>
 #include <linux/xarray.h>
 #include <linux/cdx/cdx_bus.h>
+#include <linux/iommu.h>
+#include <linux/dma-map-ops.h>
 #include "cdx.h"
 
 /* Default DMA mask for devices on a CDX bus */
@@ -257,6 +259,7 @@ static void cdx_shutdown(struct device *dev)
 
 static int cdx_dma_configure(struct device *dev)
 {
+	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
 	u32 input_id = cdx_dev->req_id;
 	int ret;
@@ -267,9 +270,23 @@ static int cdx_dma_configure(struct device *dev)
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
@@ -405,6 +422,7 @@ struct bus_type cdx_bus_type = {
 	.remove		= cdx_remove,
 	.shutdown	= cdx_shutdown,
 	.dma_configure	= cdx_dma_configure,
+	.dma_cleanup	= cdx_dma_cleanup,
 	.bus_groups	= cdx_bus_groups,
 	.dev_groups	= cdx_dev_groups,
 };
-- 
2.17.1

