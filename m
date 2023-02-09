Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3A690954
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBIMxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBIMxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:53:44 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAD15A9E6;
        Thu,  9 Feb 2023 04:53:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdcz6e0LuhYvDgYpsEQePqfvD+JA0ATZIp74X2arRgqH+BauqLZN5WMPizTE66IJ7rgiJWllbFqTE6+ZJpTKzdWwVPXiFDZeJpkzvkKROK6qdw+uGG4pOTfw1doo7C6qcGraHK0V3UmS13iweRHdygphQZpi72Y8kDOHgL0MKE45yKn1dxx3w+DD+8IlVLasPx7lK7JDtqzuWGmt0csDVH8X4Q7i2Mq4gbizqmu+5ym7PDMnLE6Flcvh12b8i4fkAtxqxSuYWIKBnW8kIUlRuu+H4WRFntFUwT4ICQ9rfAtM1xLKesnr2EYaltHVUp8GEMMA+xcYbf43QOzpWhtjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNWJmQuOIWF+yExhdo5VyG87VdMBXaMUfNLXx0B13a4=;
 b=GziUhZNwnpj2BxrM55t1t9Grq47S6gHpPkwvGyEsv6o9zO/BsCIkPw65REyAaIfMux8fIjs9T41chNfnxw5xHqN5vVknsNPiFCuyyVdbqKjN9b2H301kMMFCHZWeUrvm25vPKtX35p6C4GER/k7PsNQvsUFC+uwdu3wokN8bL3UGdDHY/DycMqpIj7wwmA/xXN7CKTe4wBdShpVHz0GY099AoQgLQ+DzUzZ3G5rKtzQsafiFLwxg9dl01YMH0dxOE5vcdDvq983Ww/lfelt3Y2tt46P2kPEn/Pe/b+Y9ZNW3WEpSHK99E40Gx3FKQCI8aSFyKPgqq45/SsxdHqIZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNWJmQuOIWF+yExhdo5VyG87VdMBXaMUfNLXx0B13a4=;
 b=e80FdHPxJNC/2DfS/BAUUsfyPv0LIB7O5ghAgzVS7ryekXrUg4w4bIBDEbJgN8U7TGSuWVhILaTOEBsgQZPS2cInYnLiWvv9v0XD/iq8Oofjjp5PhnkDc4kZOf7IBS1mpSfOC6JkXti4ZS9g6DpLYkSTCbDxNSndYhzm77h9IB2wVsgyi1azfSMnllzF2Veyr7eQT0AmnWsmhDrYumrVKTQTAfyADqZIBKjPmbbJSDVvPz6cmr1ZktBkYWaOUXEO7PmOqIPlYERh1q5/RN2VVFXpFqZ88Zy+Gxnc0yk3aUEjSP8DT8HMXYhN3teLl0dYrabOPvHFy5U74Bphxbs/RA==
Received: from BN9PR03CA0157.namprd03.prod.outlook.com (2603:10b6:408:f4::12)
 by BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 12:53:41 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::bf) by BN9PR03CA0157.outlook.office365.com
 (2603:10b6:408:f4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 12:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 12:53:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 04:53:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 04:53:25 -0800
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Thu, 9 Feb
 2023 04:53:23 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 2/2] usb: gadget: u_ether: Don't warn in gether_setup_name_default()
Date:   Thu, 9 Feb 2023 12:53:19 +0000
Message-ID: <20230209125319.18589-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209125319.18589-1-jonathanh@nvidia.com>
References: <20230209125319.18589-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|BL0PR12MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2b72fd-0249-40f6-4734-08db0a9cab9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNk4Rx8xZs0PtWU2e9oZNZR/JA97lAHj5HyfpybVbknc7ZLwQVC9fDgXBjOF80vcby2wspz4oeM2kDn7BM/3BIQB7nSj2xEpFERrEkgtLJe0uP6F/XcBFer6Hq35MLVZD/LHAXJzTtYTOVM4IYMYaPT6f4J6YxsPYGwczzBFzyyJNdmr2gNjbqzJbe6tFVtfEy4M3jTPKF+JAmx2OH1N1c75ZKeDCpauH5S0twaBSTVE7Flg/L2lhJk3YP2Bin5wMLo/jbIw96WuOnDx4yJl4yif44MODC4EVGx9Gyegz9sBnOdjyZOENPMndOQ+nvQ9VXux64xqMfXRcO2PG+Ovc7gAfjk/n/h9UOJk0L/LTA5f0l+Ic6JV/XH5XqtmsoymWQ8gZajahxfid7CVo3nW8oomSuSUU6bOjMvViL8qu7eesSEKx7ieoZS/CDWEMsP8lqFuYRprI7gIYqrba0a0xA/bA470hHtY/gXCfbByO9EjZs6hDGJdAlTAPv3dDUEgz9+2TwAZXTEFHI3cjcjdTEMEzWnQjKp6V2m9uMOa8m3Pc8LkT+8M+d5558IWiPXlq7yy35R0SMrTlCeLL13gI+1VJ0D5YlUDiCW3Jp28ZvnC1KLzuuH1fqeTieiGVclzI8bqJBfDSozWBmCkRH3uCmQkzn45Eqe/FZAEFZI5vNY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(36840700001)(46966006)(4326008)(6916009)(8676002)(426003)(70586007)(70206006)(47076005)(41300700001)(336012)(82310400005)(2616005)(82740400003)(7636003)(36860700001)(26005)(186003)(2906002)(40480700001)(478600001)(1076003)(356005)(107886003)(316002)(6666004)(8936002)(86362001)(5660300002)(54906003)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 12:53:41.1544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2b72fd-0249-40f6-4734-08db0a9cab9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916
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
ethernet gadget drivers. Calling this function will select a random
host and device MAC addresses. A properly working driver should be
silent and not warn the user about default MAC addresses selection.
Given that the MAC addresses are also printed when the function
gether_register_netdev() is called, remove these unnecessary warnings.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
V3: Updated patch to remove the prints completely.
V2: Changed print to debug instead of info.

 drivers/usb/gadget/function/u_ether.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 740331882e8d..953d936fbae6 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -811,13 +811,11 @@ struct net_device *gether_setup_name_default(const char *netname)
 	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
 
 	eth_random_addr(dev->dev_mac);
-	pr_warn("using random %s ethernet address\n", "self");
 
 	/* by default we always have a random MAC address */
 	net->addr_assign_type = NET_ADDR_RANDOM;
 
 	eth_random_addr(dev->host_mac);
-	pr_warn("using random %s ethernet address\n", "host");
 
 	net->netdev_ops = &eth_netdev_ops;
 
-- 
2.34.1

