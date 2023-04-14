Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD76E194C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDNApl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDNApP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2217.outbound.protection.outlook.com [52.100.167.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F262719;
        Thu, 13 Apr 2023 17:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdzvvdBHGuW/td+A42cyM1ENeDzTJ2L/vp+a/klReeRX7t9mjXPdEgsp20mnvXYneFD3obEp3EJZJdDYThfxlO7a+s3AX15BxWghfLMDnGDi8H+YFecQW/SMXxCWjvRJLv+R9OtLTIh5SynzWwzYOkRz2LxcJ7lGMcbDOOBfXIH1Ef9Foc1If6d67umEnnRolsTZ687d6sQfGi7A3Vhx87UQ+V+0Tna4Jb+p7me1/EzkHkLTXbzffFromkTNaIfK9oC2J4Qj3ubLN2AfKSkNBXxHpVVA63PJw9HyDtCtMn5f672ZI7s3dsi3E+U3XvLVlDhARBzP+b0dIP/pYvzh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP5kJ/vC5AJs62jqKAJ+brtcGkn+r0lWkhnYvZGCnX4=;
 b=chvprc/kvYw8oSL6JgkqpzujGX1lJ5NKKSv9Sh+74mRwJ6OswhtLzVClGismo6tYTaBdoByxRENFSUjfKhGJEeUH2dScCXifTlfw0ICSogzlRgfSLI8R6xjW8P43y4vQFTq2UfISuF5D5bqorxEtmQsfSJDJtmu5KnoS9Ol//WpfnsGldpiy2ofKX2RBtuWO0SQXYOsaps68n7MTYjdGXWbWKNKvv7/wNQKIaCqOLH2xHyz8lKwFAu7BLQJI70JTTQZJk4wwHZTfBIARLI9zJXR6Rj9cTEJLNk5A9xmrNL7cr61G/P2IStzD+BuVSPQ379onPN9+2BHP381S8h7Umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP5kJ/vC5AJs62jqKAJ+brtcGkn+r0lWkhnYvZGCnX4=;
 b=lR2FH5au8tkFpVa0rqtzbfjFTEX5q+5gJ8ESh5+gCY972ULyQqmGRbLB/Ca3TKxbSzH7YtWom0VbnWEYO6ieQiiA1RricNa9ytkCFjrrvEyi81K4+Jd9TwS4Ea405KNdA8NvTJxixRKBfslv15b86c+//IyA+sVD/mF19HHn3HKSRbI64KLoDXGTKhSm4w9xf4ElUnvy5PV6dWGrggiX3D2LioXRASxZKSGLf8M6d/rjS+L1WCGNPU9ewrh1da6of6uyDUsaYfu3TjwWA86pwzAoNZL1LywumGMmkArKw52bK/yqKwRswrY/r8Tcfa0VSAxBI9HgARRhV2ngbvhoFg==
Received: from BN0PR02CA0024.namprd02.prod.outlook.com (2603:10b6:408:e4::29)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 00:45:11 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::a5) by BN0PR02CA0024.outlook.office365.com
 (2603:10b6:408:e4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 00:45:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:45:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:45:00 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:45:00 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 5/9] hte: Re-phrase tegra API document
Date:   Thu, 13 Apr 2023 17:44:51 -0700
Message-ID: <20230414004455.19275-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414004455.19275-1-dipenp@nvidia.com>
References: <20230414004455.19275-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: f02c7130-b1f0-4370-84b0-08db3c818098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61TUu064aiQEDiBqo+PpvOf9JLpvNsS4Iyioqg8S7tyKgFBnY7HPzSzks2bKrIOJMcrZcfD90Z1e6wqwPRqur5qXACxuLZ0PXLu30H2ptT6HRGzOXCt1SFr0WnhJaKJ35zaaiyu5JyVu2gpTmLWUO6rjKi2peOIwDkQMnKEKdZdJcMyS9MXIR0i061pDDcjrQUdVZ7y/H8Suq9qIB1hxAw+fV91cCIm6I7dT5+UYBEq26lZ0btJ99dFCC+bRU3oT17jmzaINDBclts95BvhcBnDFjHVEetRQOrIyBLBSBNO6tYvenTQI1OvxTmYYwUpfSng2NB3OWgyv2lKvn0q118nkiAecEv6H3YyN2nwRgjQg4j7WicN27SItSLVh72Pmdrjj+mDijfntftq+7jRaukaF0xWDPU1JazL+XhGlp9rID/kvIq2AsruwJS2hGgKIH5VabVKtXMcuA6H3c6WSiXb22CzDBLoHHkVCUXpsVtwNAhrNi8n3IqFK8Hty6NptNzaROwwu3uM4oMrkJ+GU54fMLEwF7Jji85FqgVDV298JUNipzHm09wlNdp2/C1aIVi4QzTK0udbhCBP/BKBkx6SlNzU35CwPqLJeH6qJdcYdna9J6wgrrFfk/AjqyPo/zGVSmxi7C4tn2oFGmVYPyapAkWR+Pignod5ModHaKzUJXD6i7I3YiZcUYcv5meaIuliLDIv2ynuulGCcx6eFOvbKVq35B0iv0GgIIHlH80+Wgo1pTJaWzJPMiOlpGJiQYVrpT/uOi8IgfqN7KGF2/Z1wLhtdOjKLRQKQyZqKtIyHp4hh25A1skXk91KUYxVMPnWgfQ2//wZ4w3EdvFu4DsWXmrQbB8rbsr5gTweLWSg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(5400799015)(36840700001)(40470700004)(46966006)(6666004)(7696005)(40460700003)(4326008)(36756003)(70586007)(70206006)(110136005)(2906002)(7416002)(86362001)(356005)(7636003)(41300700001)(5660300002)(8676002)(8936002)(82740400003)(82310400005)(921005)(316002)(34020700004)(478600001)(40480700001)(1076003)(336012)(26005)(426003)(2616005)(36860700001)(107886003)(186003)(47076005)(83380400001)(83996005)(2101003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:10.6952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f02c7130-b1f0-4370-84b0-08db3c818098
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make Tegra194 API document generic to make it applicable for
current and future tegra hte providers.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
v5:
- rename tegra194-hte.rst to tegra-hte.rst

 Documentation/driver-api/hte/index.rst        |  2 +-
 .../hte/{tegra194-hte.rst => tegra-hte.rst}   | 33 +++++++++----------
 2 files changed, 17 insertions(+), 18 deletions(-)
 rename Documentation/driver-api/hte/{tegra194-hte.rst => tegra-hte.rst} (50%)

diff --git a/Documentation/driver-api/hte/index.rst b/Documentation/driver-api/hte/index.rst
index 9f43301c05dc..29011de9a4b8 100644
--- a/Documentation/driver-api/hte/index.rst
+++ b/Documentation/driver-api/hte/index.rst
@@ -18,5 +18,5 @@ HTE Tegra Provider
 .. toctree::
    :maxdepth: 1
 
-   tegra194-hte
+   tegra-hte
 
diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra-hte.rst
similarity index 50%
rename from Documentation/driver-api/hte/tegra194-hte.rst
rename to Documentation/driver-api/hte/tegra-hte.rst
index f2d617265546..85e654772782 100644
--- a/Documentation/driver-api/hte/tegra194-hte.rst
+++ b/Documentation/driver-api/hte/tegra-hte.rst
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

