Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8AE618684
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKCRq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiKCRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:45:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D6F1A817;
        Thu,  3 Nov 2022 10:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTBJwRyDOxdIBVReF3/A5r7UJS1uZzzWUgzEvQlu33PPY8H2KxMgpcSrU3FiDmBBqT221YoSXqqvaRvM7roF6GdYizXqyQJQfjapWySsvEW9fCYAMJnrc34pfflju7djSYcgfx6mlOTMTGae/pyxgJXLc4vmo++ZrplgoRFuIxhVcKUsSTTGbkC6pfE/0CT2ha7o/NOJJXERkxS3jF65rMckQCnP+kCTZtpIpd7E79VoRUQFQMuUGqwkjuZvLhgFD+u1RUlnv8zvqP9g/8J01b/C+VjO5aULwNU3Zfsq5b/aLk0fo82+TDrO1Qyej/zGlXHdW371PGZGi/EmJdW0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjbHZfAEXm7Tpt9u32Vn9q9T4Up+3nN7WFwlqHYtLGs=;
 b=cynmPRInIduDFY9++a4VevfiyqC4l2FcJjcD2biwvgmCeTNFJpoOBqcVnyNQmwOjqf6PZXAtNxPMA85itkHfya2UmpmgjkmT4HFGJ4ZoIygBWHePz2i86/82JSKtUX16toslRc7Ft9RttMHSQMvmscaOet1HMXunuYSciAllpw6sS7WkYZvEEgGkIu7CRFDh3AsnJKM2iJntaZDHDX7FmgigFjO7OPw8qPxcBKiINephdKpiVMmbud1TZ8iBz1Ahe+u+knUMGZg/I4xhi4vYLgHbp1AcrR6pGhEaiE2TwG0oFan17Lo1isyD4jNOsba9AaoqGoxsD6gUImSHJ1OXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjbHZfAEXm7Tpt9u32Vn9q9T4Up+3nN7WFwlqHYtLGs=;
 b=Cf4mWmmotdNbU+qRPtXgLvNUMZLVUAZbgyCmK1iq8/QX7ZVa/t9e2DHQcv8Cb8jgXJ170Ax6vL88sjJPG6ulVlSnyPBPPGVR3a7TN2OF80xyeeLdkGzofkiJhhv+DuQyx+691ciUWTjhbPUMy+uZ4s5X/fMhSHsARctZynyFNX3r/YCyLhqFLL+tw9zL+xyQ+PD3ofMlviJXr223pcV5csmETHKhbGldocnjDJLXdlGc/fjSuIbAXSnTIFQ/gqrma4is3ar5NQC0InwbDcu48IwxjFrLOljauLM8CL+qRW/J7Q2CnyKJPyqmpMGeaHAllIEEfj/Du//PcjVJvYYS4g==
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 17:45:46 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::db) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Thu, 3 Nov 2022 17:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 17:45:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 3 Nov 2022
 10:45:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 3 Nov 2022 10:45:36 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 3 Nov 2022 10:45:36 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH 5/7] hte: Re-phrase tegra API document
Date:   Thu, 3 Nov 2022 10:45:21 -0700
Message-ID: <20221103174523.29592-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103174523.29592-1-dipenp@nvidia.com>
References: <20221103174523.29592-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f4b3c2-dd7c-4f5c-a0a1-08dabdc33cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxJeRt6HJWwkdNgg/bXp5d1hOoTq51BBGDfRFdNm5uwxCgckgWsjpwJn6hqW6UxVEfCnHFju0sR16PjFWIt2S+P+MSKNHxCBTlto3ZFmU+TBoJqTgSHmvlGTCTjSzbDVhAGFXgI/U+S44bm3G9OeeOT4pyF2m+SKGwJOMooKlhDz+XF8HIYMa7X+ZpRfc/VxbaEMZIZhZKCz1OOqC/XjwOPpA19Ci6LB/+zzJ3PSja9Vcqlh64+bn8owAiKaO5/wNTIk+qxC6vxg3L3hVs4+epRCZM7BEaxk3pHx92HhUrGzepEY88ynIui7xBf8A8uBt5Az/cGE1CNAeVO6tAZ1A99l7TznttXvdiQOZP9JgTLD+RsfwLBhiVihPIQ+lfb2bssyLJucz+mjtgT31Aj7I7Co8kkvg34Y0MqekErjxWqYXOJsnZLT9ULp9alXFWAEMiDkcsfcMeiKvCAIxTORO8PUzh2Htxiw7RTK8DR9i2ZV371p1FLc9S7qgbrfTUrjmeVd6iUETlFqkN+d9OcpCGuIk3u3XkBqR0/bEEhY9kgbAxhFr6mFQ730HFnPPxsg85b6UH8fzSlJJJKN1H4xURCM4mQZN17xhhNpjTA+9kfWeL2PYnfd8sJsCbeC51UWCcE1yBhd51Wy4r7dUD46yGF3FvrKK4ISuTp9wpVOkksZOAMwB/BSCt1pBfiEuD8N23gIOSduYbejYo9/HPHLAloyTJsIEvJSq+wxHkbEKbdrrsjaoTKpi0AH4EkMcobciWHCA6sy5Bb5uKwYO2zxEbLmCdRW4yjWgxwEaL0PuNQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(6666004)(36756003)(36860700001)(82740400003)(2906002)(5660300002)(86362001)(47076005)(426003)(83380400001)(356005)(7636003)(316002)(110136005)(40480700001)(40460700003)(2616005)(336012)(107886003)(186003)(478600001)(1076003)(8936002)(41300700001)(70586007)(8676002)(4326008)(70206006)(82310400005)(26005)(7696005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 17:45:46.0061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f4b3c2-dd7c-4f5c-a0a1-08dabdc33cb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

