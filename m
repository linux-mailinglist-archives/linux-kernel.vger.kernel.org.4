Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7806C5C12
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCWBaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjCWB3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0153E3C25;
        Wed, 22 Mar 2023 18:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EussqS4pgZx+X4nAnLg8oUWh3+gBLJs+gLZI2bHBpbj1a9/vuDhnnMurzM/P81ErVmzLAi9kpi7WxDAoT0QT4WwVCgx1k+jarLoIZCQW8vFzB33VzXbBAZkf1U58emK6UlmDiqIXoHYKCLsWZqEiD9Pm0epjXZZ7+Hx7MXrebR8TBmNn3DtWAdrnYS8KpGPJXgdz+1r7iIBRXFpOtogXDXA7ELzk4lMoSfLR1+iE+7L4y5Vf5zZgtvDgThMol+cEzDftqvjzmqQlDrfxYgQwdDGJJtf37tC8f0kfcRNZexkfwllGNx57H5EJOxxjNHvV2DlscWkg7qiq5beixJot3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjbHZfAEXm7Tpt9u32Vn9q9T4Up+3nN7WFwlqHYtLGs=;
 b=RC/+R5IIm4et48E8Ddah/5V6gLieQNLGYafgQq/zXxXE8Uw54QGVWfIBu8vfbczS5GZpHu4R9fwq+HHr6ynm0N8jGDnEpOqvqw43Uvr0gnTJgnoiZVUDg+QM7jrxALFlo2DyZGT474qv0oRAn5TMWhsZR1/AWaU23/fA6WBPFcDRAzghvZk6DwLBRuCadiea/E3oKz0qINJHaZYJrdpDkRt5CeYjUTP/VqiWrJcImY8ZzKjsCg8prYiCACHFUq3REzIzKlE5OhQezGEhH5+I+ldVdHBs/fF2bfnA+R39yuYx04/x8Mp6CFdwcxj1Ca9b+NonbPXnSg7GdFdcTYGeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjbHZfAEXm7Tpt9u32Vn9q9T4Up+3nN7WFwlqHYtLGs=;
 b=m6OC/xZsXA2IVo8tMDjjdB+69boDz6KfOzqTt26dNa8XPx8efQlGOwjt+5XjfiLI+ME9nRVl5QMhkTWjQG7Q2Cg7DPWJ1zmle21RvXk/TBr/mvP/Xiz6YmUVDKgAE9uyDQOKNb6y2Co/fKue5ymF9+/45dkIjlNle67KbJcjhoCi2cK3HOuQj00pwttn6gVIcm/CVydC2LtW0ppzUSxx3yUFVQaDkcslhhDkvbuDbs6XNTl4yJLsnBGP27aCf/LuJOUgvrnYPDLYa9wQMD0iqlyth6hqkcFXVkzP1dFX7ZsvTS39pkUNjLzsmHAQnTda38XeEdYqPjRhBOQyOD/ZTQ==
Received: from MW4PR04CA0181.namprd04.prod.outlook.com (2603:10b6:303:86::6)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:29:45 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::c5) by MW4PR04CA0181.outlook.office365.com
 (2603:10b6:303:86::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:34 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:34 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 06/10] hte: Re-phrase tegra API document
Date:   Wed, 22 Mar 2023 18:29:25 -0700
Message-ID: <20230323012929.10815-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323012929.10815-1-dipenp@nvidia.com>
References: <20230323012929.10815-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0c8deb-93b4-482c-23ad-08db2b3e15d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/gOKgHhfDLSK6h5ZrhJBgTfKcVzAbANAK1UtZhc4i26m/tSzFY0pySTTI41pYMDHdksIHFN9qbeMnYDeCPPSufeCmXbuCWC80HBLpq7hpdgpVDvQTNB3mlF6VQ9GDuUkwmxboVJLFN7BL1K5ejjcqh4Cbz4Ge3Lj/NtV0cdPHE8ulzSr8QbA0Jg3tbOQQg09jCmeoRikqN/dJSUN5bpfgwMXdtcEjp8akBbnXC9CDJcvCNMYL4bUK/A6vL6bf9LPmGThKVshpVfMfJVNTR3s8YUU/SaNiFm0gEsgvxB4zPG8XtXWsO2dAxSz7N02h0N9x7WOgLWzvo/Ru6L+b7uVGTeU3HVjKrEme36xExKPRjRY8wyBbUyH7DDrThWlzIa9BAHzIQrnH88ujaAHjVkUuaUjQ1/9DOq+YvhAIn28Ucd0HpjHDwVAaBLQfoVbDVrmBefB+gAsQ3ZFSo2SseoCxl7klOVtblsFjBevOjRXfHNOiB1E22WQxiA2UV/QoeKBnkDryu8LIqXV6AM5DcOWQw2nrEDGmUtE57meeK7/RTvgbEHVU1Oqi1QO1wsW2tKf2R7JNyC+9nmFIEnixfIdBp3aexexKFQncanq3zdEbxF9fmeBcC3lHxEvy/tJi0CK7bdC1XFYrAycXns/F07/1fbVmKcwmE5lQei21703Ldg6jVKlk76aTwVxysywQNrPhTbZx7fuEMGb7mCgeKz2vkfunOOUmcmlU1K7+vT1dc+D9VuznRUAUu0kNSNry9txOkLPLHMA1RfWUMSboMkTGM8ofpgEHq+4ERE97rQh3Nbo0guFnZYsmCXbiV2li8rYL613WpFnD1xfAWSYw/BEt9V/CwkrlXhvG8eL1kSQK0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(426003)(2616005)(83380400001)(36860700001)(40460700003)(8936002)(6666004)(7636003)(2906002)(86362001)(356005)(5660300002)(36756003)(40480700001)(82740400003)(4326008)(921005)(41300700001)(70586007)(70206006)(8676002)(336012)(316002)(7416002)(7696005)(107886003)(26005)(186003)(110136005)(1076003)(478600001)(47076005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:45.5554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0c8deb-93b4-482c-23ad-08db2b3e15d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

