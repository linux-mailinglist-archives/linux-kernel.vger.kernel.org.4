Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCFD5EDD50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiI1M6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiI1M6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:58:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DF79F0FE;
        Wed, 28 Sep 2022 05:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9QP4r9kg3VgMBmKeZIE0+/69V2PGSAuSUscyLJALN3BqvkS6wRN1itiXXwrSr3eiG6CuEZaTbFCOG58zao5Dx0K9un0XjTSCQnf4Omx+sAzdgAaWZb/RWz6B+5NbnNCAvgUZXnT6v6UUmdrsrW8CzsXN52naBroWtcoSmtViOyIWFbw58+aUEGDW2Z3IH4xqPcGK1DTenLVh1O+crPZ9L6x9bfaaYhL7E4qc7yE43XOrjnPkaYnOfmzEi5gxpQQM0o5qjUhjodmOPmfkrxpaxzLMrTPZOYcxuvzcCTlwm5als4/IUtTXeqm6WnI9XZ4DBslr1Q8pfjJohaBIBUzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5WpENSoHSkOvDmiB+hRbOCbAQuqu1C1wXckBlkOlow=;
 b=jdBldvIjomUpgPmrvzTa63knJzcRvmpR0//TLMMPlliwZUyZqhQs6Wi0/ZiYSBLTyJvrJP/t7WrHQTtlJucFGQeOBc4Ud+ZcYf5w45ej3btjdoSGHxpyubnHjyBNEiWPmlOvxiixG5rdxtLCBRWAjsSg0s2nr+kqOUFiricT5AMmqqBUkMIQfrneEOsuDc0w4oXouxZhkZsdLCI45AXGf6xSEvEGu+7ys17IqgOHEFz73RCaMNPt3cnsRQggmkYrBGkLgjGYqOblhjhgR7Ril/dz/yBF/HnOZfqJxPrQxj11LE3pZrwOMf/j/C5ZrhhMrL4wvjef9Gboe6ks2eBeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5WpENSoHSkOvDmiB+hRbOCbAQuqu1C1wXckBlkOlow=;
 b=O+IEz8IWZ0x/xQM/NRCjUOrKp9uGNMFFmoG//eCwSNyN+rzXSCHxp2qEmvMJfzmM9Pk0exh/UT8Ii+paTPIHQHIP6ag+IIoY30t9H1orwyFyyeW/6zVzLoyFc8DTMAIxMpb3j6W2PqKwID7ilHtdQjdwtnieYYdnnu3k/rP3+hrKgVQRmeYIH5SxweObJQR+8MMZcUfgTSllbkzYkAIk4sqzo9GQ71oqvj98jlhwuF4LxtnqQch7uFh6gwTymnV6GA2lYOTBcpqfviuOgGFqu7lMbTYMTKk8YQuWlA8+yFW6IykqTKIGNbJGgG+TinIbxqOBPs9XtnrL8PtZFWhgFA==
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Wed, 28 Sep
 2022 12:57:40 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::6d) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 12:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 12:57:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 05:57:24 -0700
Received: from 74ef364-lcelt.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 05:57:21 -0700
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Haotien Hsu <haotienh@nvidia.com>, Wayne Chang <waynec@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] phy: tegra: xusb: Enable usb role switch attribute
Date:   Wed, 28 Sep 2022 20:56:40 +0800
Message-ID: <20220928125640.2219402-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ef9de7-86d9-4d8a-77b1-08daa1510638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5S/jGDdic46SZTKAlTgt/EUNEVFQJyFho2odV9qeiBQA0k2Yd8XSw81V7uXz2ZJGLcCC45Yn6IlqAekIK/pOEb9CSYMOyMII/S2cjWHZKXreRHXDaecnh13MpUb77YO21nbe+DMdQWmPkh2h8Nx4NXO7wa23FOLkl7oL3vLjGTbtxuqOPfWqtFcXwNETXWscm4d4uCnwFqrrp/ytMbeyiebafrEXLVxAc0eNTBm3OR+X0Eox8MJQYioZD3mb0EvTo9cIFd3110ts+Zy38liESyVWUKY6eJCkcfrdgQyDfOhl6FWvmxCS6t4H+nvXsvxgSzRBTT3s6tNI6X/BEJnIcw4WeQJxLmBVdlKD9R80Tx+/sd6OKHt4gjIi/uILTeS2KF2rlV36/ZSlgdRsazgBgqshT/HluSMK4GHox23pjuZQn+2anM/nkor03a+QZQ12tc5rYjd2Ub1kgltzzwKwH9gB6cGhv0mVWeOQlKMpbU3qCEs/eSsvAkEZgT4Y6xIbHuGB6Abq8WXTVT75+5AM8jj8KOokRFbsIlvxdtf989Z9qxrjV8jhnUd0sQJ5b0EdWYmrO/aPr0JuV/yuwjxAvNpl1wUiBx0+Vrwj8jhG7cf1mah4AnKfLrDCfRgERezItSgSTXfOAoha0cPLtd1pm6JXTORrxDEEzhevcN2jhvTZF2mwVzADKIl1B0Fsxt1JG3A/b+dAdE5ldIDsKwQTxlvTOExKily6Ze1P3mCZNQp+CLXGnnY5mzmnJvJDZ2KoSTXd3e2d5WjwGPIP2vDvw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(356005)(478600001)(36860700001)(7636003)(426003)(40480700001)(86362001)(4744005)(8936002)(36756003)(70206006)(16526019)(6666004)(70586007)(6916009)(47076005)(26005)(7696005)(54906003)(82740400003)(5660300002)(4326008)(8676002)(1076003)(316002)(41300700001)(2616005)(83380400001)(336012)(186003)(40460700003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 12:57:39.4039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ef9de7-86d9-4d8a-77b1-08daa1510638
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wayne Chang <waynec@nvidia.com>

This patch enables the usb-role-switch attribute and lets users check
the current device role of the otg capability ports

Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
V1->V2
- Fix typo and changelog line limit
---
 drivers/phy/tegra/xusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index aa5237eacd29..220ab7719ade 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -656,6 +656,7 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 	struct usb_role_switch_desc role_sx_desc = {
 		.fwnode = dev_fwnode(&port->dev),
 		.set = tegra_xusb_role_sw_set,
+		.allow_userspace_control = true,
 	};
 	int err = 0;
 
-- 
2.25.1

