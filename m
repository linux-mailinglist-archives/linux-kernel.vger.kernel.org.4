Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC25B618682
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiKCRqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiKCRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:45:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1581A817;
        Thu,  3 Nov 2022 10:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMvqQtaxVLK8tSHBb0yy7iZ2IpFwZx8gJytWvpr5YO7WWmI3gRTbCAPuiwxXIdNpqL+rc9UJwcEz0H8vYKKwgB1Lti8iK9qGfvlWmNVp+rLR3uDhUistmF8OrvLgSEcmSDsvV7AAoLlAdT5KTI2Km9WEo6bQs0P8j3Xe4xr/IKWkYB8HyVW3/ZbRzMMHe+lTZC5WO86paBeE+T2gg8xgalm0zkxUWJ2dPQ7EDQpglYnNfJO13BxQeDJNKQSG3onact0NvRVvgnL0VEfEqCTeavWXgOjKcMAhtBB4yBiDZnCCWWRn3GqLN9YWlCCIw113LhE6KWTlsakKSa8hWCRQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj7e8PC2PRaY0H8b3g2ib+VPooBvh+tykCi454oVrTE=;
 b=fhZgXar5WBIeqwoksHaFGwqtKy7Ux49D6WWpo5e4UMGOe35V2zP6ufWEtU0IfLBXIHMsY67pCfnKtD94inxS1St8e2dO+9VYIb9Elmvh1wDtMh0wXWxgHHKvrOO0UxEw1tGVZqGVr3fV3gg5BmmApAoTxF6xJzMDRYJCsWfzCb7bKBsdCGY+E7SR+v0sJL5AvQpCjBgBkii/Ari/Hwf2dTuscr/ae32DiAc83sOgfH1nW3kdd3mNg+NHZ1Uwm+TfKM6HwQ0viyzUOx/0cxiNnFM7EUbT+VFhSHUXIgH+v6nJZUWvlEp3bCyxjAqmOXBZYT1iL9Ng5N5TPsR5aUJCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj7e8PC2PRaY0H8b3g2ib+VPooBvh+tykCi454oVrTE=;
 b=fjNnX+1G3xud3irNWCdMbwxNdN6b17O4V4a/dnRzswxHicVz1Az5w2FU/uonZrmCc6JcwCijXCr+HphUFObg05dJ4kxzVa6mbM48S5YSNy4PL0E0iHEYn8ufOf99/4YSa62qwskN72qegvfIp1TFMNeOLHIVky2qKNNh4r357SEjjKMmaPXtPr2D9G8OUeQYWyqyr+QKj+g1I9hwIBVeZgmYTe6lsJJp7d1R3DR73TXyzE3cIoRP2nL4XbJ8CqQeMr0t/PIK8ZS2JU00/NkwFTwO2SiKx1KiUDVvyeqPa7jAj0gxmfwXQt5ZfNgcxVEGHtL6Xj+oyLkQ7g8NhXobhg==
Received: from BN0PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:143::23)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 17:45:48 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::c3) by BN0PR10CA0016.outlook.office365.com
 (2603:10b6:408:143::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 17:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 17:45:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 3 Nov 2022
 10:45:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 3 Nov 2022 10:45:34 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 3 Nov 2022 10:45:34 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH 1/7] MAINTAINERS: Add HTE/timestamp subsystem details
Date:   Thu, 3 Nov 2022 10:45:17 -0700
Message-ID: <20221103174523.29592-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103174523.29592-1-dipenp@nvidia.com>
References: <20221103174523.29592-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: baee54b0-42fd-4394-c395-08dabdc33e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnscMOozVlBS1yewoBI91gujad+l02EvOEYvjsbbBTCZ+fJN0f0csnmA7VIAeUXH72Zaaligo9+T9/RfdsEahxg4kLY6/aEQsaNg6OUnxhHI7La7B5MWvZqBqXtPpIa7lnZgodsSjcwDkiyouFCaNSzG07v2HMdS7ZnBwnm1X4DVfPyfkydBRm0DCrXuskyVq5TtCiHwfEYbaJUHb7Snd9pNxeiCLJNdW9e1rxUO7nrTNJYnzShG2eDlqFAqzVYv179q0g2cvI9eEZxi/JoWkQX7Z0eas374ddkYM102XX7X++NkpIjNFzxPSMTOG7ovx4cCJGtr0O5YmJq4jqt3uV+eMGGHSeYGqoWt+P8J37Wg+qC15kLH2i6/1+Zm0lJHKzil114IRnYdQZpmfleDzJu+1pL9YY7dxapfSfpToaVXVQ8M4CyRPSkUAgCz9FSmZNgo7p8EXPg+OBRAxoorvOZ3vm13vAJdS2IyrIlxPWWqPzGd3KzI6woJq3Hni3QHWEvrJFsHihU9zrTtOCXqQpVDsmbQBeQ+/TJvdiog81Mjvoo6joHWlVFqhQA4tZqI5zAt9z6OawcrSThJkxpFh9wnn6AxozZ/qwkneT9mN8Xt46xhpQ0u2f3OafLczTpnmOXtU2ZBUnW05KOhjIE3E1dnj49FsR16j0UMsjJsgeTVsHmqCl9OlGlSiqvXqYuy/tt/3QGCnxXIufNeKQo9858y5r2GC7AeGfRDvXpkmKAHRh+OzHezTZKr0YTBoQ6NKjOEvuBSUq7wFgRMpNdK437oE+yI9ADj6iXljF4WDeJBiDVVh0jwOd43q5NSqimLD5LkdR/dQ6RMa9GKEYdYWJGMhgzHOgB6r47BO+A6m9BIJXm0OwzgYI6t/5xpz6ea
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(70586007)(478600001)(41300700001)(4326008)(8936002)(966005)(1076003)(40480700001)(2906002)(4744005)(70206006)(356005)(5660300002)(40460700003)(8676002)(82740400003)(86362001)(6666004)(7696005)(107886003)(36860700001)(336012)(2616005)(47076005)(426003)(26005)(110136005)(316002)(186003)(7636003)(82310400005)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 17:45:48.2085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baee54b0-42fd-4394-c395-08dabdc33e18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tree, mailing list and patchwork details.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..37b17c1f1388 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9414,6 +9414,9 @@ F:	drivers/input/touchscreen/htcpen.c
 
 HTE SUBSYSTEM
 M:	Dipen Patel <dipenp@nvidia.com>
+L:	timestamp@lists.linux.dev
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git
+Q:	https://patchwork.kernel.org/project/timestamp/list/
 S:	Maintained
 F:	Documentation/devicetree/bindings/timestamp/
 F:	Documentation/driver-api/hte/
-- 
2.17.1

