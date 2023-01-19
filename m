Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCEA673575
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjASK00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjASK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:26:14 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486FD4ED04;
        Thu, 19 Jan 2023 02:26:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgJfsSbzZRmLtlK2hXrZ2dOFUWT2uQQqZE4En2fsYIkhPetK7M8mDjZCkGzeeOxjK4ZvHklkoX942LVRh3aNwqIh43UuPLGprLlNAALibrxJeXGR38CkH8qIAiqUcuoZ6EIpnuY8OBrISDghw2Iq4nAYO6gH0YPEJQiQNza1TWiuO9wP76dER+AQ9jsB3JOTLUm6Nwg2h2MZu5BeGgGcUdDmyWEizYK4HTSaXeQffDh64jQyJO7T2RRys0hkDFKwTkb+Y31Ugd2AILGVp5O+tEeH/2xBkCDmwJtGHgME+SRFKd2TpldSrHHIRVNYO9oBIIQZSxBsLOhx00zBwkWNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAz+/Gxgtj4Y8n31p8RKR30UP0vXoeQ/EhahZQrZr84=;
 b=MU5z5P5qjBlbtkuYiJRoU6KbIpLUl6Qa9vzxDxucdQrQr4MQCHt5XAYSiJ4WW37QqYNfpZ6rwgQx+GxB82TNSD6hTibfJUjn0PhjroHpmTvU7GgjwkH5QIeiQs216q62E46GKSjxPQUyjVyASLvt2Rr60+5yxjjOW8E7oJL0tAm4r4e9lci1ys7nrN/82kcklcK8To1A2iK/Siwh81xzVz3LhaM4hTQyJ9rEm+vWdya5whClZh6OLtGNVXvs/rleXE53QZ31DJagWc7816Vxc8oH+GghCoGl9x/nA4UV9LcDURHRfSv69CHlkStoRcUU5WcbVgrHT4KJaa8mf7ytlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAz+/Gxgtj4Y8n31p8RKR30UP0vXoeQ/EhahZQrZr84=;
 b=p+L7yCsFBiP2wHOn1iMTtZ/utTL9dalTPifmOT/6eea9vtNFRRL48SmWsqjhsLiBqzeUBqhwPZ0SxOGQssdArBWICkFaSFKc7IMr5o5JSYhF++PqiuAc9cPcAqJ/WKmkj+sPWSWUZkwjw73SDJJC3XG5G67qeRG0FBoDU70EXtgQGFES1oz8zPuHXpy0iKDHXrIKfHkvkNYDbW/Ay0pRHVtSYNz/AzWRuyar2iFsC4AQdcGJgsOK4USNnxSLKcWhtmPDVLqoe7Iq3NsBS/vpJSGSPr7R9UsJwNHZ8N0APSl1+uSKmQhwm616Hvb+gzVamKfqHqBWGmW3BZuzUFt+6Q==
Received: from DS7PR03CA0175.namprd03.prod.outlook.com (2603:10b6:5:3b2::30)
 by CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 10:26:05 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::a4) by DS7PR03CA0175.outlook.office365.com
 (2603:10b6:5:3b2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 10:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 10:26:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 02:25:58 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 02:25:57 -0800
Received: from moonraker.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 19 Jan 2023 02:25:56 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrzej Pietrasiewicz" <andrzej.p@collabora.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 2/2] usb: gadget: u_ether: Don't warn in gether_setup_name_default()
Date:   Thu, 19 Jan 2023 10:25:47 +0000
Message-ID: <20230119102547.26698-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119102547.26698-1-jonathanh@nvidia.com>
References: <20230119102547.26698-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|CH0PR12MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: a94bc458-f8d0-4a0b-dc9b-08dafa079299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExvPMmmHyKVJPGJM2GVmMudmOWd7bs0gujUoQFxj5liBSKXUrWlc6OtTwHh2JHFyheTgr2AIkfQZOqL1EwWMcjWnr5GmEiOOziGCv7OTJ4I2Bm4HhiS6OodMCZpvJR2z48ZP2lVCbMxkd77XYwDtaxIhiLJzKyMyYmbsaochrXKYfbC7XGI9VRMA7Mak5Geclf0CD7p6fo4HS05n+ogBMGl6RhYDah0s9RPODMyTt1EoWYGW0kiSBYfb+kL4y6br3mhiZvJCjHzRFXpC/W9cGTnKR9OCCBCMIsCvEHiW9rVYYDDyoVMrc/41RsMID7UG4k/2r338gWGOqD31Cvu2iED0HIVvbIr3Rep9KEXAUbDYEuR/dzCJes0eGitjNH9TsWZKttf3mP3oVdtBzB8jcY4al+KxdeE/9ADOHH60bgsaX39cILsEpAxHIxyI4sBKkg9upVBBVCLTFLWOukle1lJeCfUQWzS9JZ6IGV+gvvc8S2Si5/Z6QFtdsNOeHVrPLLDnuJrinZJ5npU/VauoXNUEDf4jv33j05U1yTzo4UGL0p11mhP2xtE/wd5HWJsxdduEdOO0lCtx+43JqmLroD3DnfZbzT7hyxPsRX1aWh9hhfnKZMs0DkIxyljE7SsTWrr5g2IM3HuqJie3V0rwe1AjQ3dc+qMNXTxPjnHwWjnC/uSV+44qtkbdLd5fx93q0VglDTvLUxzfwkvRIc1Prg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(1076003)(8936002)(316002)(5660300002)(86362001)(107886003)(40460700003)(36756003)(7696005)(478600001)(6666004)(2906002)(82310400005)(2616005)(426003)(47076005)(54906003)(336012)(7636003)(83380400001)(70206006)(70586007)(8676002)(4326008)(6916009)(40480700001)(82740400003)(36860700001)(186003)(356005)(26005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 10:26:05.6210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a94bc458-f8d0-4a0b-dc9b-08dafa079299
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function gether_setup_name_default() is called by various USB
ethernet gadget drivers. Calling this function will select a random
host and device MAC addresses. A properly working driver should be
silent, so don't warn the user about default MAC addresses selection
happening and convert the warnings into debug messages.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
V2 -> V3: Updated commit message.
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

