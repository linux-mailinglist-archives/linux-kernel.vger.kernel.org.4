Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4776D9E87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbjDFRU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbjDFRTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF3AD10;
        Thu,  6 Apr 2023 10:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq84BQwcuPXjm6e9lA4bP0tzqL94CxnUvJ0bct6ErgB9IJiKbSOqnZ80yXUtd3GBwuXQ+bzJmZ4MJJCp0aezDC1IzL8RJ1sCm3kj3EzckG8XnDKdn0/NVpoP25Op4l0b6ZTUgO1AO4IPMLjvKT75oslE0TRj+uqMLSFFzRC3foNroL9GLz0dztGTOKd8dSlMLFBMNoXes8paZIw5xwcHXhL4/CZLSKZ9gqSY9JWlHIhoVQxC3JcI3VjQzZUKWZ4Ycn5BdrKwbuRK8vS6/pUNaNtDxllhLPx0ERV1Y7QCdvAIptprSk5EtvC4VcqGuxYaSwOE7bNn1EVymaZBTlzYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kStb/h2bxxTnpUoG8mlerqt8YY7TMtzqPvYaHaQ0ccE=;
 b=hy1LHso99YNOUj4measw95WXMaHBafP6xYW1ojhocK9PbMAwnlUk/aTcXH71G61QLt2UgjugT8gyPXW1jvoACuDZ48hHJGuoABstPb6M/nHD/ajANlQVGfbyd9IcThPGXCpWiAlMklyjMeKm8sSGclOXJVuR3XT/JZAwnJ12IUHd61t9WTuyz6YotP9V9S+VcmFKsJXaBBO+iODu0HNnz1o+nCpwvaOVlPYqhCrZeT8Defo0g5Di8517zV3SogYm9zpz2cIbquntIQdWP35+O90MixAZ4bz4D+4Podrwv4s5FQKrLZ7gK/cWjgH0ZQgjbd2q1UpgrUsp+EfkH/hYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kStb/h2bxxTnpUoG8mlerqt8YY7TMtzqPvYaHaQ0ccE=;
 b=U0+YipKG/debeSaDo4CVthKueqf49GBWJnrbyX8ItG5crOA+KjzkcuNqA41ii4iv9NOLT/LbHdcYTMLZpRam2O+ZcZfkErWA020ulIBH4gLHnZZ06JenBNktgBa9dO7mlqjVmwGkQS+sRtWDlRNBMdWrU1dMQtz9QlG4OI0lcNFVqTmfk10Ys6eoDOu1YFoidkQVGCXFJ/pxzckP6johFhywCUU+bhdTDL34m4bezXa48Ur195gF/fz5Cbt1D0+a/Baq0VsvFgjO/8/ILFHAPlGW9ZMTgeV4KsC1nQrn9wG8U9ALf27y2rSt0Ddsj0rmDR6Kf/huSZjZxKg2/vKhAw==
Received: from BL1PR13CA0355.namprd13.prod.outlook.com (2603:10b6:208:2c6::30)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 17:19:05 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::32) by BL1PR13CA0355.outlook.office365.com
 (2603:10b6:208:2c6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29 via Frontend
 Transport; Thu, 6 Apr 2023 17:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35 via Frontend Transport; Thu, 6 Apr 2023 17:19:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:39 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:39 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 01/10] MAINTAINERS: Add HTE/timestamp subsystem details
Date:   Thu, 6 Apr 2023 10:18:28 -0700
Message-ID: <20230406171837.11206-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406171837.11206-1-dipenp@nvidia.com>
References: <20230406171837.11206-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 964bafa3-6ee7-476e-7df0-08db36c30664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ah9a25R64U/NtP3am8up0nzZLBSdvdlo2Ps9QJu+puj89ZXHr9FSltPWidg8Bp7M1LhnTOSl9R2J8/6AJ/zCclpywELNyj+ZTe/oi6FQLQ7FVfTL2X/FlIm393QrxM4j1DUn0F/m7BEyjvbOMGa72yW3rNECV12NvyxtW3o0qwtWX702VwkWl/2ZCMgLQlc4WgGIcLgkGR6bscmbAuMIaZJKbSl2rFgmiV+Vo1tPXWJEqon5KbzQsLzZaog0A54PZ7dpy6IxAqXDtwm6LuHyriX8XqUxEsSTK3PAIkzlileKzR8SHgMg/BJze36JsDTdV8SybmnWbX8nyJvlDAcO1L6Rqpbo8MZxp4M9KdcmlIGCHxmJwgM/NE8YVKo8o5mrICN9kEWmy6bVoTffTNIfOEVu6d2jyWwZ8kcdB7qfYgXhwW8Kf167Yszlqu7gUChlW1V28Ue25LSQF4Vidohubl7ZdCuvUDutrHDoYFCdUCVBTwfCBDL796Z2hBHXGIV0EyTMnApXI5nDIGGIokF7df3Dv61BblB4wp8qz2lsK6FN2HimS0pj89ur3R4Xknl81P4GJPb4yJ5O7BuU1nnZvoa1o0Z5pvw08idDDNPt8FUOBfYKHnWh9r3EB2ZkziQL5t0oPRnF196hGAa9pXYwoFp3C6wP7v9yftTG+D2yqSux9Jg7FSWZW/7BjPNPj9XPUSHCu++v1NV46/4u3sYjSm13WbNRTrDNzdprqJEChoUL/0781MZVf7D+lQkodjBinkT4+VyKWyLxwEsFWHE65R2LVg3ctTxcGKxwFUlxj2+JQUJSkdoVcENSMr8VhU4aCbFYZuzraItVQBBn0NzE9tQsvzEee9Vl7eWdHEOrDmc=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(426003)(36860700001)(110136005)(2616005)(47076005)(107886003)(966005)(186003)(6666004)(7696005)(316002)(336012)(478600001)(1076003)(26005)(5660300002)(921005)(356005)(2906002)(4744005)(7416002)(40460700003)(7636003)(36756003)(70586007)(4326008)(70206006)(86362001)(82740400003)(8676002)(41300700001)(82310400005)(8936002)(40480700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:19:05.4797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964bafa3-6ee7-476e-7df0-08db36c30664
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 8d5bc223f305..65b58963f0d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9425,6 +9425,9 @@ F:	drivers/input/touchscreen/htcpen.c
 
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

