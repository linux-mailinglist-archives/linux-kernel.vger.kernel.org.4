Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB294673574
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjASK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjASK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:26:12 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BBE4F353;
        Thu, 19 Jan 2023 02:26:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIx2nYZF7dUC/GBU+NLEeMlJd10xxKzO6tPhnGRj6jfx1ImA/BgV1JuvrSekHXMavjraw8rbyveX/cd0+3qGvAFXRHa1HDgkb0v/c2zSOynMIlxD1eCaQGssJwcUmS6dldE9mOaBX/lCKHHluH0E9SFR576BJQySGQ7lMorX+NtYInKGPJFLw5lWyxTfAar9l03XdwXaqy3d1DHAPPWd/5h6VRHYxHxCWpuUdoJ6NQ6FYUt6VuKDeKvOmeEa3cDYJ7B/ZmugNDrFK7I6qukgJm+I+1pQwucPpoCUKuM1JmRW+qhYKkGguHdz8sfWxm6bl2HJpapeN8ZmC4FzCpt6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=velh6MXn5zEt9u/08R3OwOXuazgHKzTKymFW3uE3S10=;
 b=IW5hTafgZKtOilPZTrobYhREWbgHZV0gKTLyDglP6o9JXeEtYzKDeUKf8BLb6KeVaKVk+751E3/sgCcSRgys/D40a/99H4PtIbMQJ31DaQY1kfeGCDEeT2rSGNvfOyV8+UC7lqeJtW4hM2FnM6SuUlYJ25GixmlIvvzDbMaFw/q901/IaWUcW66bxMZKcpFyl3/v3mNoQfv5wVXOd+K4ytuJEZ0/NG8Er7jS1xdHPZRupoHXGYQtzhkNfvOxfgV56rRm0hbRgbU7RucXcN+bO738xh7TPsgm9IPvhycpJnP47AXocaC8WEN6+WIOdJoSMmX5jhv0ks+0+zfV2o2XIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=velh6MXn5zEt9u/08R3OwOXuazgHKzTKymFW3uE3S10=;
 b=StibGA9W7YVAZMzS5S7HhTW7dNUmz281eeZSDLm5GdHNAEmtwF5nIkLOvTz8TPizXA6ugPmU/A2gePLROBSZrso6i2Ol2b9E77MmAdqPIUcEo6kuMmhegERHQd5RjwdetNu3sJUmXRxGiAYfARyL12ucSzfVmQISx9TPjtYEnJkD1lermYOTTT/NrRSA0QV41r4KSD9gfkJNpDiZLcg15Trl0OZTamswT0KFKvBnyukMNvL1sRoTIieeTnhGJS/BbDWaHmNDrxcBe7A+etgoCzOWnuqdG7TRXQfSfMUWpVLZLnFkK/P2QYF8F7sDcaCPu4t/kXaeNRx04LIGeCI3Kg==
Received: from DS7PR03CA0153.namprd03.prod.outlook.com (2603:10b6:5:3b2::8) by
 MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 10:26:05 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::a2) by DS7PR03CA0153.outlook.office365.com
 (2603:10b6:5:3b2::8) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 10:26:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 02:25:56 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 02:25:56 -0800
Received: from moonraker.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 19 Jan 2023 02:25:55 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrzej Pietrasiewicz" <andrzej.p@collabora.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 1/2] usb: gadget: u_ether: Improve print in gether_setup_name_default()
Date:   Thu, 19 Jan 2023 10:25:46 +0000
Message-ID: <20230119102547.26698-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: ec83e20d-00c1-417b-c6d3-08dafa079229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyCAHqHmmcEIkJQbm4gCscPdZsWiXIbaU9jRSYV6BXMhoE9Xe20WD9K72m5KF+NG7NHP9eQHJKLTu46Xb9t0rw4JSXWoRqjq1Hyb/3C/UGahDJsbJ/Xxk+3/IqhYXKakOSIMxYW0TKtHcyC4goZTnk50iP7N65JBNtFrYaUFcVSJLZIWsi+3jEdm8ZoRdww1GBl7yOoP0Db3pIreeftsa4hf9cvZlzwN6T73KNE2tduq4JXnkbNGb78uzTeP9z9K+/mIjJ+GNnJ5lqMYLqthc2Y1brOYJKATn42USbr1puxxC9X2Qc8437miCCXgYl8dV9bq0Tl7OglIsn1WJEQ7QZMvBcw7oygmcZE/SghmzllZTc+9cfhRDJtlBMXR1GLFvVZczt9p/q69l6VGoXXMLaReBwJzk87UO8pAHJs3NASejqRyKmTecdwyaeScwy0eRKfMq4TpaVZ711733vqoqP66iREPaV89oiJ9iMryCDu9UNxqIGBYCDYVfF0+RK345QlsXyz32ccA8YTLI+ixOCisvk9QZFWHaCyDXcKoSXqxTcT/Fuex5uupbY3alH0D6Dtp9ERrN2xE3UWNo92xpSGrgBl7+L+ZSWrB8cMc+qRPxfpMXvIA7qTTGzlKXkiJamsKhzzcc2K4aMWidCa+/kpoptsr7i8yFDp0m+7EmM0NrK96wMV/I5MmzG5dy4MsQyA4MZFJDqibjUVxBYv2WA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(83380400001)(82310400005)(40460700003)(336012)(186003)(54906003)(7696005)(36756003)(478600001)(40480700001)(47076005)(36860700001)(7636003)(356005)(2616005)(70586007)(1076003)(426003)(82740400003)(107886003)(8936002)(70206006)(4326008)(26005)(2906002)(6916009)(6666004)(8676002)(316002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 10:26:04.8866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec83e20d-00c1-417b-c6d3-08dafa079229
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print in in gether_setup_name_default() does not provide any useful
information because a random MAC address will always be generated when
calling this function. Update the print to show MAC address that is
generated which is similar to other ethernet drivers.

Given that the strings 'self' and 'host' are static, we do not need to
pass these strings as arguments.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
V2 -> V3: Updated commit message
V1 -> V2: Added this patch

 drivers/usb/gadget/function/u_ether.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 8f12f3f8f6ee..be8e7b448933 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
 	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
 
 	eth_random_addr(dev->dev_mac);
-	pr_warn("using random %s ethernet address\n", "self");
+	pr_warn("using random self ethernet address %pM\n", dev->dev_mac);
 
 	/* by default we always have a random MAC address */
 	net->addr_assign_type = NET_ADDR_RANDOM;
 
 	eth_random_addr(dev->host_mac);
-	pr_warn("using random %s ethernet address\n", "host");
+	pr_warn("using random host ethernet address %pM\n", dev->host_mac);
 
 	net->netdev_ops = &eth_netdev_ops;
 
-- 
2.25.1

