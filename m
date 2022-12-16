Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF764E6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLPEWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLPEWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:22:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF7D21C;
        Thu, 15 Dec 2022 20:22:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb9TkYDCjF46/jnXv2kk37hFy1taALM5NjqTUcUGBcIBR5OzXFo9jWWTknFuw0xhgNOV30IjLys+wT+s+9oQ9zNo6lGlXymv667OOGIKhncaufoc7Sznypay+KEt5O6N/34YHd97ur+LRk/SPzQHBLc0xKjgmpihkei62VSFtK93mp5fLLmdW8ZXaLwZNtktvXyvrCCneLha+rowlDsEbfCgris+CQxrViK40FIaukIMn3nq3vlfdJyDaPuliOKqiVYJ/Tl6tv2rdBU6uB82jf1HH/Rwb0ftyRj0/4dofvTIyEhJ3b0arTG0W6K6ppweyiIDTlTpNQzyeOIlt+1l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbmktsLRLaxVk40ULnxh944f1+6uFDcgKVWoDt1/bGs=;
 b=aG7Fi0tX4xSNCVPAr0NmEnwYf/1DEKXijb/wNlvC5tkBpjmoOsn19bu/WFxHtvh3CXxAN2dUsa/c1p/p5GvmNBAB/jgVGkXc/gktNobDwipzTAF/G9JvBsOKwMLNAA/zx9kzWAM7z6wm27qaQGeXAx5DINzBTEwhEn47sUWNXZ2+a9Dtw6ASpssogr2NxaZQBdarsr4GsfJb3f6VRcjwZt9qzvMtZeyK5xQ53EUwG5TdJT0MI4NfMX0pYbu5G5Gx7vU2Hi9w8X11qg//gwnp1uFkrsBSBwRZrcy6dPYu8TbZu0G/gocqxYmCQipYF8cfQERoAf+T5rSQDCVJp6nHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbmktsLRLaxVk40ULnxh944f1+6uFDcgKVWoDt1/bGs=;
 b=tZ3DfB9lNZVp2vUEcRFRLi0SKXB6bn3/3DPUxFGv3Hhxot7mvzQ6qj/KXqCszumUmEW4oeWsVdnerRMlf90RdBJoQf/ac4Z3sb5r/2zi7mpp3OtNT/lzErkb4Q1jx/CVnMVpj8bVnoO+M7DKd3HgaexJiiCSgjZKd87Xhr8i6YIK9lSHtAaI/YwF7eTcbRU9Q3QJ7wjii6Yn6S/ze0flMoMFS2ZkFkm/F5XGOtrBtRgZnXiDMvUXPihxmgDxHRJeE2obPqQOJBfzMK4yNEFeNoS+46ZKRbde+ELq87BedI5c2p/O1LrSY5ayIbm3TKiodzOurlKGemsBCwGowuZEgA==
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 04:22:34 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::90) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16 via Frontend
 Transport; Fri, 16 Dec 2022 04:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.15 via Frontend Transport; Fri, 16 Dec 2022 04:22:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 15 Dec
 2022 20:22:22 -0800
Received: from 74ef364-lcelt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 15 Dec 2022 20:22:20 -0800
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
CC:     JC Kuo <jckuo@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH] phy: tegra: xusb: Support USB role default mode
Date:   Fri, 16 Dec 2022 12:21:46 +0800
Message-ID: <20221216042146.99307-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: c36c373e-ae98-416f-ea1f-08dadf1d27d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tgFvyF/XVD+Zpk8uc3kFgoWJJ0clFKpGIdcLkFMk/6XaQ9rJwXnps9g4UdVbXLi9xLa4F9wa+zN3F7gXfW2ZM0YzC8SZVcI9PIiGLyGYo9hNM83wLu7dBeyhKLRFZgXB57a65VpXBlTspM7SSOW6wjpD0h0tcPBj5Z5pKju88f/DGLwiBXbkQTRJXJiDoYO3lbrz1gNnjAVoqGW5yfeX07TDT8pyDOfJP/g2m2sf6JoJmg1wq1bs3IwbHgSdIh7HH2DMYLhl3ULRZG9sysxgi6mhXpVpupaTJ6z8DWX9uryKC9yVEiMpwGgnq702mM9aO9iLzXEoceouZi8BYFcY0qqLRg5U0mlh9chsIGBffXZY5YfS25jUIDziQ36NkauD/HK1vI52t/G3dpnSVTmaEQGwVfV8LkDM/sLl3L8Uf4XfBAL4RauowsZWzBYKUMtZEA26TiXjpC7ZQE9s3ZxL6NYOJAXIqb6ptmpMEDQhNa30SHr6jVhLf5BAn89BlMPL6UGWJOmU3WOB5G2bPUmVw8Lm7sy7oX5zKpsJv9/Zpo5D0y5qf7cmkdQYLuV8PzB53il1vAOp/13z34hET6z9PM/d0PagtntHwBRYvZ6LvkXfPhwX1rv7L7e79E+IufxuA2VcgBZ6oa5fBAbDx4L2Hrbi6uow3SbysOt61s5oCn8vNNXG9lJc4Q9BwF3j0Y45/ZF/SqHfqGEuL9RfBNA7A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(82740400003)(186003)(7696005)(26005)(2616005)(16526019)(47076005)(336012)(1076003)(36860700001)(478600001)(426003)(6666004)(107886003)(40460700003)(36756003)(8936002)(41300700001)(40480700001)(54906003)(4326008)(316002)(2906002)(86362001)(110136005)(70206006)(70586007)(5660300002)(7636003)(356005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 04:22:33.9888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36c373e-ae98-416f-ea1f-08dadf1d27d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support role-switch-default-mode property when usb-role-switch is
enabled.

Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/phy/tegra/xusb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 3707a0b5c1ae..78045bd6c214 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -718,6 +718,22 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 	return err;
 }
 
+static void tegra_xusb_parse_usb_role_default_mode(struct tegra_xusb_port *port)
+{
+	enum usb_role role = USB_ROLE_NONE;
+	enum usb_dr_mode mode = usb_get_role_switch_default_mode(&port->dev);
+
+	if (mode == USB_DR_MODE_HOST)
+		role = USB_ROLE_HOST;
+	else if (mode == USB_DR_MODE_PERIPHERAL)
+		role = USB_ROLE_DEVICE;
+
+	if (role != USB_ROLE_NONE) {
+		usb_role_switch_set_role(port->usb_role_sw, role);
+		dev_dbg(&port->dev, "usb role default mode is %s", modes[mode]);
+	}
+}
+
 static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
 {
 	struct tegra_xusb_port *port = &usb2->base;
@@ -747,6 +763,7 @@ static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
 			err = tegra_xusb_setup_usb_role_switch(port);
 			if (err < 0)
 				return err;
+			tegra_xusb_parse_usb_role_default_mode(port);
 		} else {
 			dev_err(&port->dev, "usb-role-switch not found for %s mode",
 				modes[usb2->mode]);
-- 
2.25.1

