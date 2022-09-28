Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D245EDD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiI1NQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiI1NQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:16:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00D174365;
        Wed, 28 Sep 2022 06:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+EefYqjAY2QWwByU3Ye4PTjhY49zvEiuPQwJUhciUTJrssJkI9uWR1kzxaQ2SzCr5SSE5yqvsi7sJR7j1OW5eW8mMjzwPrrW9IENjRdHsvXp6lQ5SwPSvOrAk/Td5X4Y5l/DxC1J+iC2Kz9tRDWa55xg6ThwzXuqN6AHxcnxa2VLCOyBuKaTACZCvNUK+mVCu+5EqJanaz3Y5o9Lm19FEQRJnOX2AOD2aEv9yO6dwIMQkzVQyzLSHFZ4LM0Jr7foeWFTQbY0IK/I0wftCPYr2ClZ1WKXzF0DAV3VAMKRhE39JHLNTuNqXBnFYWueTzjohuqqFPsOiWghkBgOVeXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G6wgjvG8gvQaDoHfeHx+kQ39SIQ3gYHPCVAvaUXdNw=;
 b=R2YXwJ6BSIGvlCZmnQEPDROt01W9DQW4ZfJs7U9bjwiC8uRMK8A1wzbYJL/2K5P9BA/XBP2Jokfz8RHEzs2PSehOr0UG370c2a6OUsvtoeal4EqzmkQTGi0VEeMypAI8dsUVJFrHUIEvJA6pO7D9s/nDZAT3Adixef6sCXV2x+cNm34Oqrw7UzEMUBlZo2hxRvQwVWAtcLKo4LvC+ZFPOpCWrBS+iI+wDWvPsYCoDphpxXqLbbu/5h6tDFYmNh+v5G9MBCUOjmOsfow18NO+vJmj7N/b9cU3d5wRiLiUeQ7Gu0Y4BQwd+cvfCIry6uTPcgOQutGqceJfQS8RGKCuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G6wgjvG8gvQaDoHfeHx+kQ39SIQ3gYHPCVAvaUXdNw=;
 b=FNgOTDcVhJ5qlWZIg+353LeWXzm36vgxkkT0fc/rFuUziNNgCZMf0eubBZVCN1N7iKBZ5JXdDeapem6a+fWa0sAYrFhic0JIM1b3KjIb7PaxzkgQxbN1JAgAnQS+g6B8x9LgAo3910QjHOXAGsgF40Esk3f+dCWwfPcOYlLDB+lyGO4C8yAU+UW/wtvQmz1KpaSUrPo90T5lyatyWfGP1bxxTFaaYuFl1O7WXzb5TMeatfmbWyFi2TbmyfFBoPWDx6JHbs70kygQGmHmzQk08sTOtf0sWjaCiRVR6ZtNCCmIBSg1Q2k9gPpVzMCGlZL3Fo1uWrk9sbxHc3WTTtl9HA==
Received: from BN9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::14)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 13:16:39 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::cc) by BN9P221CA0022.outlook.office365.com
 (2603:10b6:408:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 13:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 13:16:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 06:16:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 06:16:23 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29
 via Frontend Transport; Wed, 28 Sep 2022 06:16:21 -0700
From:   Wayne Chang <waynec@nvidia.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <waynec@nvidia.com>, <Sanket.Goswami@amd.com>,
        <singhanc@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] usb: typec: ucsi_ccg: Disable UCSI ALT support on Tegra
Date:   Wed, 28 Sep 2022 21:16:15 +0800
Message-ID: <20220928131615.3286936-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|DM6PR12MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: 5560da4f-0b91-4a9d-0e8c-08daa153ad36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXY6chWuMioVtLgNuY0IG7bH1+2kBaeBGI/OCH1YY6ydgoYRVNdqQFR3YpOJAoq7A/yrfQYgn6AL4r0SfYevXJVKWFqZXG/rWMSas0QJ7LwLD1wuInLSbFxIMSsMMKoQ2YsdGyakCWxsc6vejWkDxffEFL4Y/SlyKnluJB1w4p7RLL4L1J3cITAHVAnNWyGcNfs9d8c5CQp+hhJbL/fCBXj9HhFozt8Zm/eL/RqOsN7frsCZMohg/UbKqk2v/up8ZS2qPtNpvBzYSXlXQs830ZmtkyrFz/m9Togcc5fsDYiddKy4eLJUekhKNdKLqMTMT0mEbGWngK30QLD1303+WZ2+/M1zAyf7OdMz68XCyuH/XPs+iYuGrkSKiYdmizGW8klsDIfZ9XFHAXrN/XN/yPNX4T6za2PZXjcKYLb+ByUIoLB3UxNOWYqOO6h57tF4XgyNdd59SVlNq06DK88TqzdwNxIPrQVh57W07fzpD+bO+oq/cFKS7FXunWUHK7D3XDyNLrj8chVlmgqsBBob1dDUGYG0BlJC6ONSbDe4V5DL+DYh52jXc6wtHgiwCWwO2JizzcVIIpW79+ElvXU6ZdXx5FYUG8IqMu/LKsrkIttexbGomA9HKcFLJUcU3OHjqx9sfgWldAIOOEYIdVLozvLk/eLLNnb5b/+lkq7m2/sn8a7KD1be5/5qM0UtqydP0HOS8DI+dccAHKt4PbrSdCb7b/hAEN2CaTp5yhD4L8tOpaH2fS4MK8gIz/mo73NFMpgQyGgchhmF5YaAja1qPQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(4326008)(40480700001)(36756003)(316002)(82740400003)(47076005)(8936002)(41300700001)(70206006)(70586007)(8676002)(110136005)(54906003)(7636003)(356005)(40460700003)(478600001)(426003)(2616005)(86362001)(82310400005)(7696005)(186003)(1076003)(26005)(36860700001)(83380400001)(336012)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 13:16:38.4673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5560da4f-0b91-4a9d-0e8c-08daa153ad36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sing-Han Chen <singhanc@nvidia.com>

Firmware built for Tegra doesn't support UCSI ALT
command and has known issue of reporting wrong
capability info.

This commit disables UCSI ALT support when reading
the capability on Tegra.

Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 5c0bf48be766..fde3da0605f5 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -122,9 +122,14 @@ struct version_format {
  * Firmware version 3.1.10 or earlier, built for NVIDIA has known issue
  * of missing interrupt when a device is connected for runtime resume
  */
-#define CCG_FW_BUILD_NVIDIA	(('n' << 8) | 'v')
+#define CCG_FW_BUILD_NVIDIA_RTX	(('n' << 8) | 'v')
 #define CCG_OLD_FW_VERSION	(CCG_VERSION(0x31) | CCG_VERSION_PATCH(10))
 
+/* Firmware for Tegra doesn't support UCSI ALT command, built
+ * for NVIDIA has known issue of reporting wrong capability info
+ */
+#define CCG_FW_BUILD_NVIDIA_TEGRA	(('g' << 8) | 'n')
+
 /* Altmode offset for NVIDIA Function Test Board (FTB) */
 #define NVIDIA_FTB_DP_OFFSET	(2)
 #define NVIDIA_FTB_DBG_OFFSET	(3)
@@ -513,6 +518,7 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
+	struct ucsi_capability *cap;
 	struct ucsi_altmode *alt;
 	int ret;
 
@@ -536,6 +542,12 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 				ucsi_ccg_nvidia_altmode(uc, alt);
 		}
 		break;
+	case UCSI_GET_CAPABILITY:
+		if (uc->fw_build == CCG_FW_BUILD_NVIDIA_TEGRA) {
+			cap = val;
+			cap->features &= ~UCSI_CAP_ALT_MODE_DETAILS;
+		}
+		break;
 	default:
 		break;
 	}
@@ -1452,7 +1464,7 @@ static int ucsi_ccg_runtime_resume(struct device *dev)
 	 * of missing interrupt when a device is connected for runtime resume.
 	 * Schedule a work to call ISR as a workaround.
 	 */
-	if (uc->fw_build == CCG_FW_BUILD_NVIDIA &&
+	if (uc->fw_build == CCG_FW_BUILD_NVIDIA_RTX &&
 	    uc->fw_version <= CCG_OLD_FW_VERSION)
 		schedule_work(&uc->pm_work);
 
-- 
2.25.1

