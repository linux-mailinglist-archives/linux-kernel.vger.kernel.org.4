Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6AC64E6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLPEVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLPEVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:21:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7E8D4;
        Thu, 15 Dec 2022 20:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Unm/MhVigUczVlIt9a5AgXR2V3jaVUmmK81vlrjYjZOOY7eas0OypxTnad7E28IGuQDtxH+L16mcXL4CaNx6hV7JJR5udcTHfx3mQW1AGYR1wTh7wMSnfudQgkjEsChnhVwNXPKoKsm3MgG466HI67tyA+W2ZG7kxryXtahN2v0m7dY6pEzGIww/6sKxNQVIr2oobxp4r5+NcCHfw8Fp74hOBMUWVdntXgn/YMaqQyLVh8GKJHw6OcTeJAuXz504XVv2O9xVFvDRvQy9dlENMM1aaJRKeJP76YjomQkMJyVxp7db+kPVJis87dymeQCx3Z2Rka1yByfTSIwzesTaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF1eDrEq4aohZB6XFWrNwbnhzlg0r02RG5IhWRM8Zhg=;
 b=JINBGhWm6IJ31UpDqqcVcb3j6itT/xYqrbOsDanlsw+c8yf47VFrG+bXVpO6q8rKnv2i8W+2eGstYfdoKSkHJJqbayCbygwn9NszYdY+dNOQvRoCN54o4ysysOpID/S7bTDZCP8yB89pqH5OC3zPxn++WgkHpjyksqr/5V7UJNqpU2sMHzVtX6a3+iTd8PqiSncsAa0TTOTwTAYX1tvq17DhIENXp2blQy4a/gvy6VIdJ+KPzBKgnTqQwgXwUCAiL13dE6wcKxBlgzUqTBny6INCUrE5k1mlPuHbauyain0bVjBEQz9xxxOVfeHHCcc1MkgEAS6Cp+hr465bcIz8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF1eDrEq4aohZB6XFWrNwbnhzlg0r02RG5IhWRM8Zhg=;
 b=LzqfLhWF2V30tsjGc/DLpSLImiTxyoyfsQlYDXKHMTa4rdCK7TTYomydFwmNb/Sc/45/J+QvJVtIiYVcSoBMyjGZU8Ot7nuyNgky2KUCPLiHay4KZYdvc/XfVVeH35YGDKkQ/IBq96CtzNmN8oEIGdYtTFw6m0QmiZZITuCuD1X/k1RdOuhNpBuAjDGa7T+CC7bUgiL8iRj8M5lQTZpucpDcR2zZKR6zCuHP2M/5icbxVXrDY2GhMhzc0kwlryOU5Jp5wDuiMq8yo5yfQ2X/D1vtmWK1aJ+BUq7qIcobqdDiKsVoeEzfbn2kuNs0cyd+R3VE1s4IU3p3KxMDr3bStw==
Received: from MN2PR20CA0010.namprd20.prod.outlook.com (2603:10b6:208:e8::23)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 04:21:17 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:e8:cafe::1e) by MN2PR20CA0010.outlook.office365.com
 (2603:10b6:208:e8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15 via Frontend
 Transport; Fri, 16 Dec 2022 04:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.10 via Frontend Transport; Fri, 16 Dec 2022 04:21:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 15 Dec
 2022 20:21:01 -0800
Received: from 74ef364-lcelt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 15 Dec 2022 20:20:59 -0800
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Tom Rix <trix@redhat.com>, Jim Lin <jilin@nvidia.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: xudc: Refactor update data role work
Date:   Fri, 16 Dec 2022 12:20:26 +0800
Message-ID: <20221216042026.98517-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d61e0b-9ac7-418e-c5d3-08dadf1cfa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUsjwGIlg2wnKHymltC3MzcRGQGu54sKL4xtfbtYcKRECcNVyUetIhEUaONf7Jl1fG6rU3ft1qI77zQncNYiNPB3ub4B6S5y63+mBpWsjX6Uyc12A7gG+DuXn9gpPf2MIJo+IkH+iZyUi0TtkcXA1aG7wYP3WrJeF/d13yxBIsGIHZf5o2LgA54cnwOksu8IIErCNbwHYP1PmNCj0ecp4ewuvRrHQ8Tg6TwmqIK/PuiPQi1DJPHb5XSmleOjoSz8X2T2p+VYk688/ORNn6B2GSDeml14zC1ESeD42TXHTWfP7kEtMItGQ8XjOaQDksqlmP55x5CCxgHV1kwNm9IbVpmXb0TICtwVQFjQqZslhLETnCjzrB4o0kokf6Ar29BaGuTqL7hEEWENSqDHFb0C9o6EBR7PTFGKM8Pqr7GFwmhwold/AuxsrURg24j9ATkXYGXOEIfYMqkUwu+jvW4LTS8laxJSkOfBZF5PoMt70+IAZvKKs1CPkvxL/ev02DPLRKo37uOw/ijEnAReeAJSMKkimgMVix5TmQ8J0SZNhc6FsI+PI3OwJ/d+6FxRP/+Q+/TW9BI/JEAJFO2VS8p/d0R/srgCIOa+VfyVT+TDjdh9b2pFHKfuZq/7uP7ohcHeH3dVjMrVBHdHaA5JTx/9Buv10aoT8E+j9rQwIGa0PmN7P17u/xAiR9msRYhNzOr/LqaPkl5QKhasvUu+m9KneQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(356005)(40480700001)(7636003)(36756003)(82740400003)(82310400005)(40460700003)(336012)(86362001)(1076003)(47076005)(7696005)(426003)(186003)(16526019)(6666004)(54906003)(26005)(316002)(6916009)(2616005)(478600001)(36860700001)(4326008)(8936002)(15650500001)(2906002)(5660300002)(8676002)(70586007)(83380400001)(70206006)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 04:21:17.2230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d61e0b-9ac7-418e-c5d3-08dadf1cfa19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wayne Chang <waynec@nvidia.com>

The notification call chain should be registered after the device gets
ready. Otherwise, we  might get errors when setting data roles in an
incomplete system.

This patch refactors update data role work and register the notifier
call chain after the system gets ready.

Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 33 +++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index ff697190469b..2b71b33725f1 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -796,21 +796,16 @@ static int tegra_xudc_get_phy_index(struct tegra_xudc *xudc,
 	return -1;
 }
 
-static int tegra_xudc_vbus_notify(struct notifier_block *nb,
-					 unsigned long action, void *data)
+static void tegra_xudc_update_data_role(struct tegra_xudc *xudc,
+					      struct usb_phy *usbphy)
 {
-	struct tegra_xudc *xudc = container_of(nb, struct tegra_xudc,
-					       vbus_nb);
-	struct usb_phy *usbphy = (struct usb_phy *)data;
 	int phy_index;
 
-	dev_dbg(xudc->dev, "%s(): event is %d\n", __func__, usbphy->last_event);
-
 	if ((xudc->device_mode && usbphy->last_event == USB_EVENT_VBUS) ||
 	    (!xudc->device_mode && usbphy->last_event != USB_EVENT_VBUS)) {
 		dev_dbg(xudc->dev, "Same role(%d) received. Ignore",
 			xudc->device_mode);
-		return NOTIFY_OK;
+		return;
 	}
 
 	xudc->device_mode = (usbphy->last_event == USB_EVENT_VBUS) ? true :
@@ -826,6 +821,18 @@ static int tegra_xudc_vbus_notify(struct notifier_block *nb,
 		xudc->curr_usbphy = usbphy;
 		schedule_work(&xudc->usb_role_sw_work);
 	}
+}
+
+static int tegra_xudc_vbus_notify(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	struct tegra_xudc *xudc = container_of(nb, struct tegra_xudc,
+					       vbus_nb);
+	struct usb_phy *usbphy = (struct usb_phy *)data;
+
+	dev_dbg(xudc->dev, "%s(): event is %d\n", __func__, usbphy->last_event);
+
+	tegra_xudc_update_data_role(xudc, usbphy);
 
 	return NOTIFY_OK;
 }
@@ -3521,7 +3528,7 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 			/* Get usb-phy, if utmi phy is available */
 			xudc->usbphy[i] = devm_usb_get_phy_by_node(xudc->dev,
 						xudc->utmi_phy[i]->dev.of_node,
-						&xudc->vbus_nb);
+						NULL);
 			if (IS_ERR(xudc->usbphy[i])) {
 				err = PTR_ERR(xudc->usbphy[i]);
 				dev_err_probe(xudc->dev, err,
@@ -3873,6 +3880,14 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 		goto free_eps;
 	}
 
+	for (i = 0; i < xudc->soc->num_phys; i++) {
+		if (!xudc->usbphy[i])
+			continue;
+
+		usb_register_notifier(xudc->usbphy[i], &xudc->vbus_nb);
+		tegra_xudc_update_data_role(xudc, xudc->usbphy[i]);
+	}
+
 	return 0;
 
 free_eps:
-- 
2.25.1

