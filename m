Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6786962D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBNL4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjBNL4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:56:15 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16BE244BE;
        Tue, 14 Feb 2023 03:56:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEHJZ1HLERsRBBZE51CgFjDeUT1dXt64sq3MddS7xcZb+eixc9pEiEylHXbGWN6qDQUJpSYSVNJZNMhMT21L3LSu5xallMfW9wVpnxpnO+bP62706qJGhmZFqceikeDqNPVbtbZL3ehiPiQFW4+e9e9e53Ya32dgCr/nKN90xrVwhEded5HIE3qLBnN32jFcVbe2vX/AD6eTASt+hy2OKHFv2eYBXQCnlrAocnFW8WyjJp+pJIw8Tf6hhQ5zu/dtJn2pQHdDwKygsnHEielHrqIMBK/wEwxYS1xACvsLm4WjpFv800aI5bUNV1DrfpIJNLs9L5yTj1zjjBDqGFT+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjbHZfAEXm7Tpt9u32Vn9q9T4Up+3nN7WFwlqHYtLGs=;
 b=K6wPbdZ76K75Iskbw/8KImaE7RbfSe5g2OGOiT6Bq94be59PSFkJjSzjpFDiGGws7yeCSwO7buMXvzQWxesPQTUdN2Q/F8DFRtmcD7OIYSQYKopVLJg64mO1hFk1jeWqz7u5XkzjQcz0qvySz1KVGXwSZ2NDy4Q0EqN5jnZlE7Ohw9hcZedYuV5NJGgSxQOiS8/UjXGMN4NHdAfPZ+aKn25xbQfJy2xTfOPKUBP0UNL8IJ4AZsZ3jofl0/QnaEujSWDFasRJSRMw+pDcVQ2gBfkxKoY0XMPN971xl/E0y2ksDNrczjEyqJCF0uZCEtMl/0Tzid4fRytW1WDkV5WkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjbHZfAEXm7Tpt9u32Vn9q9T4Up+3nN7WFwlqHYtLGs=;
 b=BB90t5n4XZlMMOwUMbGZFu45gDDf7vV1X2ZiQoL8807ComUG5kJcX0A045xTDjJXOvTOxuCmMReg4VedHGKm2Hx/77uPGXN9XqAKNpTEjdQW5aucl5KWqzUvIhOMIZV/jiNmJFj5zCkZS6yr8PhlGypbbVkAY9oMTS3PTqXgPvKAdvhBsGaLGeLgtXxp2tmtXtLczmrsvwEYLODB41LF++bAwQAC4F0lzvQ3TgU1CguCpKhGWk9gBu0NJxzWVOkw+2ucAn5VQWnd/Sci3e9b/X4IKzBzEZkiwPJsP8JNUrr1h86tDJLVTZwfXsKXclem8USppv0CVUnqHo9GeTbvFw==
Received: from DS7PR05CA0076.namprd05.prod.outlook.com (2603:10b6:8:57::13) by
 DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 11:56:11 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::b1) by DS7PR05CA0076.outlook.office365.com
 (2603:10b6:8:57::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10 via Frontend
 Transport; Tue, 14 Feb 2023 11:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 11:56:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:02 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:02 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 03:56:01 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V2 5/6] hte: Re-phrase tegra API document
Date:   Tue, 14 Feb 2023 03:55:52 -0800
Message-ID: <20230214115553.10416-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214115553.10416-1-dipenp@nvidia.com>
References: <20230214115553.10416-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|DM4PR12MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 14095c0c-91a8-475c-42fe-08db0e827795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l89zkOHBunfXkZwSAgs/a/iQURIPauYvpbBIusexhwcZUbZShPIcLTKrTdgpZxhSvhrvDYZOvAvxPYvXv+0na6nboBVJD0fqqDlLyYji0sHF7M6pv6Q3Kp9kvsOVkwucZc+QOPIP14NqCDz8ASBHZZJB+ysCaZl/Z4qL0fWgJKotwkZYdWNtCnRWsiz18WEEuOFX+R59XrVrq4NefqxL4lEt0omqMn5VcRz4f+nvoteZS3hTsYZkr76y0vwxClTKZCIYgpIOWcje274a7iUwJ9+6tqG+2fafNwAPKmx+SeTQoAZEl+dQvAXmONEBDSCcjGfuaOpLDbNIAg2ojojg/6vTPAtuqcZg2IuiTixkpITWgxB0ObaXkMLt44KDjyX4JkQTwILZq71YjXOIt5ActCTmNGmgnkneuMZTDQZUSOKjpFz5zCgqtas9CWLCvrGY4mZQtj4PqKM9MZT7P/4ykcRGy6T3m0unLsz2DrUzRX5MWaVy5SDI2MSNrU8Dz2qdNAtxAURScIMVIPqmovkZwj680sSzzxnbR5o5t5hjKafQS5AGQPiDZtjXDY+oVntiyyeehfr5cD1DcJM+slk5pAUrlKYVy6giCeYBOTkCakPKfwVcTdXg7ee7CSs7HE/aj9E7r8MGBL8na8QJM97d36jDztjf+frJawO0cufLDH5chn5F03SXwG0N+qcfJm1d6/GljZgvzugfX/KjB/ByUaTPWnj2ptQ4RJLnP4JfXklRXP1Vir7GJz6m6BQKX0Dm
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(26005)(186003)(2616005)(478600001)(41300700001)(40480700001)(107886003)(6666004)(336012)(7696005)(1076003)(110136005)(316002)(83380400001)(4326008)(356005)(8676002)(40460700003)(70206006)(921005)(8936002)(70586007)(7636003)(36756003)(426003)(47076005)(82740400003)(86362001)(5660300002)(2906002)(36860700001)(82310400005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 11:56:11.6459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14095c0c-91a8-475c-42fe-08db0e827795
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
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

