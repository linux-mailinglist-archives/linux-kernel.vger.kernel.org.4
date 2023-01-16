Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034CD66C497
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjAPP43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjAPP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:56:07 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B2622782;
        Mon, 16 Jan 2023 07:56:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFBA2+EHQAA7opCX/sdwgLgGRpRVpk0T6qdV6azH/dQmyT18ZPBngG9sghh2EGk6t3TLHIryIn+cHmsDJRYRF9Q8JRwgBaccAA8F/4kxeR9rF6sFN9/hd51pG6lJMq7ZhQSjraQ4UBMINL3WbDeelWd2WVqSgLxLTbveOtK7hAh4BvYfVcTEk26eEFiZltQOeUhZoghiUpv1m1XleDd7tukRGUYoeMLCzREMWZ25BccHYSHY1g5ytd4uwzSdfkyRkIMB5rVJRwxXKOwjb4ZoRnTPy72MycnyFpLgbVaO5Ya3oQjZH/Nqd8kpQqv3mZpgrUOEjO3DAobE2cLANLJzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJlGCrFindnrP86Yx31IkXOhdrg5/x8/FrFAYEHjShU=;
 b=aqxDhuhpjVJnBZ9bkSFcpJ9o0rHTulxuDtyT/+xpRcAS4VVub3d7PFTYhdH6wkq5Xvq1Js4l+6H6FAjrdkURwcf2EHS7+tnw+H6dlHDlLR6i06Vn4OrkOPfF9AqlcPobfzvYqGsJYpVS4C1iSx8Wx7YJdChQ7r93u+NWIHUyhS4JyZZp1DjAZqV5dL7BJVfObyhVjsyNg7gt1OrCyFQfDCMCgRBMn6HVLyJoVCfiaGRogHPyp6fHZbiWejq3Mp1R+G5ClB2c+yqR4DcNhcHuYHESBnfbAwQW9olWBza8hORhALbl3IW38wCY4FQlXgd+HRHm0VzKie+Ek/ekd10DAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJlGCrFindnrP86Yx31IkXOhdrg5/x8/FrFAYEHjShU=;
 b=sDu5nlnmIhBRkcQFpagFol/2TgsIHeM3l2Uychs3JkoSK7uJkORzAEz2L6LEbdglpcnmR0LW3QEDf9eH+nuedxz1EmYs9u8sMEprIXgCeo+dFnMt/QCDf+XGFg1AwM0nhAFAzAMaTZEuiNID1I9tAKoZ83fVSoZshfUUEjeZq53hDWOSDrP9XM05JbN9HJ0TQh4EmWd+sLWOaceUDxJ1jgHhpHP9f1jdhJ1N/bH41ep8FlDyH9ml9LTPaxMtefY4aY3OxnT8DOwDS4r6tN0jtIGwgR8q2WYraXis1BRhf3iYUVZHdzecbY00PRT1DUpxwhLBkuzJJzZ2KMKDC7RRmA==
Received: from CY5P221CA0130.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::16)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 15:56:04 +0000
Received: from CY4PEPF0000C96E.namprd02.prod.outlook.com
 (2603:10b6:930:1f:cafe::6e) by CY5P221CA0130.outlook.office365.com
 (2603:10b6:930:1f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 15:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C96E.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Mon, 16 Jan 2023 15:56:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 16 Jan
 2023 07:55:57 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 16 Jan
 2023 07:55:56 -0800
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 16 Jan 2023 07:55:55 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 2/2] usb: gadget: u_ether: Don't warn in gether_setup_name_default()
Date:   Mon, 16 Jan 2023 15:55:45 +0000
Message-ID: <20230116155545.101391-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116155545.101391-1-jonathanh@nvidia.com>
References: <20230116155545.101391-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96E:EE_|CH0PR12MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b555bc7-1e06-415d-4926-08daf7da2c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhAir7NixAxInfbJZQ9J4UK0GkivEzrzG3Dx8ct4j0D+kuyOfUu9onBmrQ71mTo9Z7lQ12AKjzPeL2l1eYmwhGvluFvBRttcTGXfYLY6RwYjqgIxIS98LVL8fmffJDkeJwnSRfHkwgWhiMWaLNe/u4mCU/AYobvb56mn6VB87JfWEEpKqh3F5PrbKKsprndDaZ/KGr4UWEAUdoYrtBNOFx0iuLAxRka8jThR4Yb7nryQvApnbxndWKmGu4J7KAeMqr5fLI7F3c/ZdVakA3442uuJRRHV9QroP8PW0DS9vUWOV7mD5WQwsR9bVx7KOnoVodlN8L0McR5VyDNHtUnuK7HDOkstQbq1RrZjyNlBJLOmBR7NCwcJD1ibky1wpvn7YoJigxMeC+Pza70/dOf13bJ5LGF/mPqMfDEvNAbUnZpjyzgJE0uI/uiWE9XtR/SSzo4tgEeFNM82p02pkZmnG6GqoityFD132Un/L47vWdBzSsDtVAnKHRLk2lYBHiOamDoIjLNeqB0WTbqugFCa2B140yWsaRLe7brcDdDP8fCFdbJJSgBbD9U+YppTEoGIBdTAmeYgoWD85+a184R1h5ABjwbphC156sgkKGUAYL6pWuXRKV4qLNGzIRdvghfHwzORELKF21qFiari8k7TFZ+fMxUuHoUe4H4qykfbHuRmWr1f8Kc+AevuHcqQj0J1hhoqjsWsx2iAnxcKxY1MIA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(36860700001)(2906002)(107886003)(6666004)(70206006)(82310400005)(5660300002)(8676002)(4326008)(8936002)(6916009)(83380400001)(82740400003)(478600001)(356005)(41300700001)(426003)(47076005)(7636003)(40480700001)(70586007)(186003)(336012)(7696005)(26005)(1076003)(40460700003)(2616005)(86362001)(54906003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 15:56:03.9438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b555bc7-1e06-415d-4926-08daf7da2c17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function gether_setup_name_default() is called by various USB
ethernet gadget drivers. This function always generates the MAC address
for the ethernet gadget device and always prints a warning when
generating the MAC address. Given that these messages are expected, make
these debug prints instead of warnings.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
V1 -> V2: Changed print to debug instead of info.

 drivers/usb/gadget/function/u_ether.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index be8e7b448933..8feb40e38137 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
 	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
 
 	eth_random_addr(dev->dev_mac);
-	pr_warn("using random self ethernet address %pM\n", dev->dev_mac);
+	pr_debug("using random self ethernet address %pM\n", dev->dev_mac);
 
 	/* by default we always have a random MAC address */
 	net->addr_assign_type = NET_ADDR_RANDOM;
 
 	eth_random_addr(dev->host_mac);
-	pr_warn("using random host ethernet address %pM\n", dev->host_mac);
+	pr_debug("using random host ethernet address %pM\n", dev->host_mac);
 
 	net->netdev_ops = &eth_netdev_ops;
 
-- 
2.25.1

