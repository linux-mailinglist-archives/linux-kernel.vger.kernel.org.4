Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC31E6B50A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCJTHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjCJTG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:06:58 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B04131330;
        Fri, 10 Mar 2023 11:06:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YePONIdmBl9/8Ch6EtVP3j6O42Bvz5DAXCpaZwwVA05nbEj5AkyfdbnqO8mF//CiXwjxfEkSWFd/Nm1ydjjEokxEwTZul36z/qSYBWaq4ZOLEGa6W0yX+nhHc07B4dVnY+3ezxe1RqaQM5Mb3aHDUvBjZyP2xuy1WJQroKKEt7EzU5duxIyCbpqVeiNJJ795NJVtI+XSqOWJkMeBrgnbaeaf/I+Q8CK6++bFshW2HTAfLFTpNO8fYSa0lv7oSq2g5vJPHPUHMmYvTgEiFTCDoF/GbeVOzkLdML1DUN+oFTrkrIQmkg1LDluVsPSQKdfJ9tTOr6frJKdubK8M8vjgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjbHZfAEXm7Tpt9u32Vn9q9T4Up+3nN7WFwlqHYtLGs=;
 b=L2Bj93+UQzt37gnk+FM4cmTosVWg/YBT+XaoEiyYTMZf4OpLeHemOW7hQNg5DFCXlJmKUMTwa5doQUkm8DvTu+siuA7yaW3o6Mp5N8d4RR+cqlfRVskGsz158+k35J/NWBRrqeV+8mBVXZRs5zeXC8hm5T81lGXwQofVmYee394btUU0VqR/9FoqpJ8lkVP3JCrt/FYhavSdDy7zOr4QfPuN34nPbwWk4l9m6DZXvD6NeROLEVy9OGKYjNF0E8HDKEmNxLgA7zALRn2ZcRHUYiKiiiJP4zDqD06woe6uxrZcWFhaT+DedmQ5v523c40djOGf/j2Atota1k8iWJSkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjbHZfAEXm7Tpt9u32Vn9q9T4Up+3nN7WFwlqHYtLGs=;
 b=K4B721c7HSZUUNaSTZz4z7zvUEJdjhemmIdGP9M9SpMCjCFeehoZ7sZ/rMLuJdmtZA2EnLIs49/3rnpIbBvXdeRG/2GNmB1gaCqfE4V2yLp7g+KaVwvHsX0UmmJechWykrb1FKD5whkj508NpJd7ca8jsHHVROYt994yoB4HRYQwklL9/Vk6MfXuKDFXaXV3l5tne+DZ++vCqnTdmUv4tVG2f7kqXB745o5h3n9+00tqvaF5ixiOHqu723V5xhR7h2i/TRcGi/JW7P54jtT7ko3u25L3or09NYV+MjuotmUsfIwkB0RPgcaPiwSuJSQq71cWeQTNVLNK5o60O3X/tg==
Received: from MW4PR03CA0320.namprd03.prod.outlook.com (2603:10b6:303:dd::25)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 19:06:53 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::60) by MW4PR03CA0320.outlook.office365.com
 (2603:10b6:303:dd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 19:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 19:06:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 11:06:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 11:06:39 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 11:06:39 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V3 3/6] hte: Re-phrase tegra API document
Date:   Fri, 10 Mar 2023 11:06:31 -0800
Message-ID: <20230310190634.5053-4-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230310190634.5053-1-dipenp@nvidia.com>
References: <20230310190634.5053-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fdef68-452e-431b-da8e-08db219a9bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAzyAvOGVjM/C+UY7DxsmvXJPiDjUuQHDJnSM7BwcT3ZxTfsGJ+oWs0lnYzoSGmoiAl1gpqRTgYr4XlU04Dp8gAaKi/vaV3/FdKLgtAZcL6L2MhNEXdusHyXY5sqdpy7W9ftkmXorrTEpmwtWujDe6+Ijg0ZvsruIQy5TUlcFgQrJqoUTCIIseTME3j+SlAHMunwk2Y8AS4zJz8IgNoScgnelWeScqbLbQK2OSSY5DzapnBP0WX85UuWnF6H+q9MubXRKaW5PFetWJveCR6Vc7ZsAJmJublXJ826lnb6qfM2nyxFHJR2QlcNYwlb4TQJY48Fjak39ZlV/Hrwy+6wYGNTbjvdbl89UzCrEk01tEXfjPJ4E+VyjYhSOd1JgBGli8JalgG5X0WNx28q1mGzxBpKFvsmuvin6kc7pB8Nz8yh1dWfuUi55+xTuiraXe/OV0gCX2IOaGZjmrW+CBYuuFwOZBq8Xdp1gwM5cyVok20KD7haQey1sSwuFJ+jZHmF/TBQB+nPDVNI8cRm2nmiq8VA9CcwPUCIkAJUOYFUz1fNizsuTBmVFnQ8qRdOx+0kgWmiTeYBvar9NAO+CXm2id6IbJvxTnQW4eHuyZMfKlLyYJHcyky8DojifWXm0YLG/VCiA+AfuCOT+PMsS/D1stZhQjp3fLYD/pr25PUQiFxQHhanEqyNf+V4n1rQDVIGy4KiMfWSPrlIskLhA0BX27x+7mMRmUS0H3RyZsldmM0RoRmybtZEahIW++0iO0ida3egfjj0o/kBruHcgO8nEv31mg6PQk4RW4Y85C8pwTigboryHyc+EPi2spYaMpnA
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(83380400001)(336012)(2616005)(47076005)(36860700001)(426003)(40460700003)(2906002)(86362001)(921005)(40480700001)(356005)(82740400003)(70586007)(7636003)(36756003)(70206006)(4326008)(316002)(8676002)(7416002)(5660300002)(8936002)(41300700001)(6666004)(107886003)(1076003)(186003)(110136005)(478600001)(7696005)(26005)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:06:52.7189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fdef68-452e-431b-da8e-08db219a9bfe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make Tegra194 API document generic to make it applicable for
current and future tegra hte providers.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 Documentation/driver-api/hte/tegra194-hte.rst | 33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra194-hte.rst
index f2d617265546..85e654772782 100644
--- a/Documentation/driver-api/hte/tegra194-hte.rst
+++ b/Documentation/driver-api/hte/tegra194-hte.rst
@@ -5,25 +5,25 @@ HTE Kernel provider driver
 
 Description
 -----------
-The Nvidia tegra194 HTE provider driver implements two GTE
-(Generic Timestamping Engine) instances: 1) GPIO GTE and 2) LIC
-(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the
-timestamp from the system counter TSC which has 31.25MHz clock rate, and the
-driver converts clock tick rate to nanoseconds before storing it as timestamp
-value.
+The Nvidia tegra HTE provider also known as GTE (Generic Timestamping Engine)
+driver implements two GTE instances: 1) GPIO GTE and 2) LIC
+(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the timestamp
+from the system counter TSC which has 31.25MHz clock rate, and the driver
+converts clock tick rate to nanoseconds before storing it as timestamp value.
 
 GPIO GTE
 --------
 
 This GTE instance timestamps GPIO in real time. For that to happen GPIO
-needs to be configured as input. The always on (AON) GPIO controller instance
-supports timestamping GPIOs in real time and it has 39 GPIO lines. The GPIO GTE
-and AON GPIO controller are tightly coupled as it requires very specific bits
-to be set in GPIO config register before GPIO GTE can be used, for that GPIOLIB
-adds two optional APIs as below. The GPIO GTE code supports both kernel
-and userspace consumers. The kernel space consumers can directly talk to HTE
-subsystem while userspace consumers timestamp requests go through GPIOLIB CDEV
-framework to HTE subsystem.
+needs to be configured as input. Only the always on (AON) GPIO controller
+instance supports timestamping GPIOs in real time as it is tightly coupled with
+the GPIO GTE. To support this, GPIOLIB adds two optional APIs as mentioned
+below. The GPIO GTE code supports both kernel and userspace consumers. The
+kernel space consumers can directly talk to HTE subsystem while userspace
+consumers timestamp requests go through GPIOLIB CDEV framework to HTE
+subsystem. The hte devicetree binding described at
+``Documentation/devicetree/bindings/timestamp`` provides an example of how a
+consumer can request an GPIO line.
 
 See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
 
@@ -34,9 +34,8 @@ returns the timestamp in nanoseconds.
 LIC (Legacy Interrupt Controller) IRQ GTE
 -----------------------------------------
 
-This GTE instance timestamps LIC IRQ lines in real time. There are 352 IRQ
-lines which this instance can add timestamps to in real time. The hte
-devicetree binding described at ``Documentation/devicetree/bindings/timestamp``
+This GTE instance timestamps LIC IRQ lines in real time. The hte devicetree
+binding described at ``Documentation/devicetree/bindings/timestamp``
 provides an example of how a consumer can request an IRQ line. Since it is a
 one-to-one mapping with IRQ GTE provider, consumers can simply specify the IRQ
 number that they are interested in. There is no userspace consumer support for
-- 
2.17.1

