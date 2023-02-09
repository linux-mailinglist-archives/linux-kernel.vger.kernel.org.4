Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10C690951
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBIMxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjBIMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:53:40 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F75A9E6;
        Thu,  9 Feb 2023 04:53:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLk3bNLOVWul6l9iIgjzIU7r3EcbrDmUCXSB4CMUYIA86wLI13piOd2Sl0r7KmoHsjwvmmceywAJwwIjn0k72o9ZuKOGcl+4d18JEHD3v5Tu4y78vPEOSyOw34Nrk4aH+sDIIfNxOeG81kLKsslf1IUyAihps2ghu46wtqsZO1wznnMlmYAnKuCIL+oj3NaS5O2rBKQl9Q1xrlXQo4HVdbAnoHPIp/WrLAFHDvC4W7B+5I1hk32XhUAwlaOiMPJLBaFQKWF64VWXslLkRVBoW1OTK/zbBdaLh84KP1m9jWEFA0BdSYj5qAbOszvQHpqYMHDE2YGlDRIuEotTC6/N2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN6N28OXHwIGQo1XBKMtM9T2/1gLTCB7D3ZzFKZrIUc=;
 b=LYEt3kqSOAVr83y3EeHJTbNY5P6WRwH+7ehRpKAtSOwHY5tdKDKhkeI8Fpl0QVHkVZa3cbEkex8WeX2wwrhT+7OHaAsaM3tDWMRbwMfBpz9NmCkpSerw1qIf6tQ4K6B/+Ng3S/BnjV9+T4R+PJxMVazgcWXdCYOEUjPlZ/M7RcGlAFveqkM+Wm7WC5sgU4Oh8SxwRgjf61ghvGTHL5qkCoKl5BVzW5EH3bHXd9A5r6JwE+xsFl8DnGECGRXkOknj0yBotL77nMNt1RGfhDEF23gySiwyU0aqyi9sGkLWgtZKdu3I+Ssbwes+XNZFR3vOAecTtsI1yT6DfmqN3GQiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN6N28OXHwIGQo1XBKMtM9T2/1gLTCB7D3ZzFKZrIUc=;
 b=Xc7N6L1U7KdGCpefwy9ZToDmYGvFDaUjPfKiavHziOTB4AASD5ORhbCJ2gBhwzYfiURcwRDCiHz3FXP8RjQddYV4QrQJ4i3hbQnV/jUVrrLa1cFh9nKy9Ib+nraozfsOeWRdt2FFMYmgPS3DSSUfRP+6MS3XKZ74+lYJL2SQJgTCgSYppEF+3o5qgz8xfJjSphMzWLdKQkldQ0nMkP2su4ZefCYpfeobhQzHc5W+fBjxa+VGgFHPXnjlJXRJguFeRw0EJEwaZ3+aqq0ZnzpsMhNmJiOSJhwki5HneBtaGhYQegjJ+GtRB+qvVMnBvT7qAAf+p6alw78DGJe0V6eLUg==
Received: from MW4PR03CA0133.namprd03.prod.outlook.com (2603:10b6:303:8c::18)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 12:53:35 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::24) by MW4PR03CA0133.outlook.office365.com
 (2603:10b6:303:8c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18 via Frontend
 Transport; Thu, 9 Feb 2023 12:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 12:53:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 04:53:23 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 04:53:23 -0800
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Thu, 9 Feb
 2023 04:53:21 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 1/2] usb: gadget: u_ether: Convert prints to device prints
Date:   Thu, 9 Feb 2023 12:53:18 +0000
Message-ID: <20230209125319.18589-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1c932c-8167-4d6c-adcb-08db0a9ca818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZy+O1OSpaGsPHVDMnLhZNIDkWDH8YnUlTignOSSXAhgpi0AcBhmXtqtCe2itbX2fiWwrjY240bXU8Bqy55zEqzgwThYo8KhiCfeecF0z8VPIKiztJiAP3zNpT8O6PTElz9Lu18IsyQpIIE4zA9szMcLcM92wxjn1SppyjViOQqWzuO9SfvyU+gDp87cb8yfO9mThBwoXmk1VbKRFQdFaXhzKD4Pn5crbwG6gA03wFQK+adpvU86mky8FbOBQ+OzE9deDcq3nZsn2CTJqiamHeCw9verkV8vBwMX3VB0Ry00mX3WAJI9AxWXzqYRMipqwxKUmEZNBdfYA4Y3MNUFR9RpEBoP4/RO9gFdfxrE4RuX4UDCHjDj52xpelUtU9qO47YWOI/oHjm04DH6yFy80j6Gs8HhxhuWHWmZnMbMUZjG2XPP6YOktvEHxb7IfAD9yHJhCUoU8MkqD8WzCbM3vzUPg0TfJHpXYgJik9ZBXe/pnzz9oI1nKq8CoeqBNrbA/b5FivPsV4UDqaaOgOKHn4MDSDH3rP/U9ZKaNBE/CkCl7N2rI8+MhDAcSduVwc/VWK8tmRFyxFW0UkonrydKkEjT1FnM5S9PBdgX/mrTxFXYK47T+wD8moAnHsCyday0JUzGeiweMwUFAnJp120AUfRrwN27BDbWDBexVhkvITuDl7m5VXF2JLRcDfk2b4MVL1vvr+85v1BibDIruGhWZw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199018)(40470700004)(36840700001)(46966006)(41300700001)(8936002)(4326008)(8676002)(70586007)(70206006)(6916009)(356005)(82740400003)(7636003)(2906002)(36860700001)(40460700003)(40480700001)(186003)(26005)(5660300002)(36756003)(1076003)(336012)(478600001)(86362001)(82310400005)(107886003)(6666004)(2616005)(316002)(83380400001)(54906003)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 12:53:35.2860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1c932c-8167-4d6c-adcb-08db0a9ca818
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB ethernet gadget driver implements its own print macros which
call printk. Device drivers should use the device prints that print the
device name. Fortunately, the same macro names are defined in the header
file 'linux/usb/composite.h' and these use the device prints. Therefore,
remove the local definitions in the USB ethernet gadget driver and use
those in 'linux/usb/composite.h'. The only difference is that now the
device name is printed instead of the ethernet interface name.

Tested using ethernet gadget on Jetson AGX Orin.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
---
V3: Added this patch and dropped the patch in V2 that improved some of
    the prints.

 drivers/usb/gadget/function/u_ether.c | 36 +--------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 8f12f3f8f6ee..740331882e8d 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -17,6 +17,7 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
+#include <linux/usb/composite.h>
 
 #include "u_ether.h"
 
@@ -103,41 +104,6 @@ static inline int qlen(struct usb_gadget *gadget, unsigned qmult)
 
 /*-------------------------------------------------------------------------*/
 
-/* REVISIT there must be a better way than having two sets
- * of debug calls ...
- */
-
-#undef DBG
-#undef VDBG
-#undef ERROR
-#undef INFO
-
-#define xprintk(d, level, fmt, args...) \
-	printk(level "%s: " fmt , (d)->net->name , ## args)
-
-#ifdef DEBUG
-#undef DEBUG
-#define DBG(dev, fmt, args...) \
-	xprintk(dev , KERN_DEBUG , fmt , ## args)
-#else
-#define DBG(dev, fmt, args...) \
-	do { } while (0)
-#endif /* DEBUG */
-
-#ifdef VERBOSE_DEBUG
-#define VDBG	DBG
-#else
-#define VDBG(dev, fmt, args...) \
-	do { } while (0)
-#endif /* DEBUG */
-
-#define ERROR(dev, fmt, args...) \
-	xprintk(dev , KERN_ERR , fmt , ## args)
-#define INFO(dev, fmt, args...) \
-	xprintk(dev , KERN_INFO , fmt , ## args)
-
-/*-------------------------------------------------------------------------*/
-
 /* NETWORK DRIVER HOOKUP (to the layer above this driver) */
 
 static void eth_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *p)
-- 
2.34.1

