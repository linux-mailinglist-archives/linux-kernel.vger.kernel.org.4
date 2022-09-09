Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4FF5B3C66
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiIIPxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIIPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:53:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170CBF10C0;
        Fri,  9 Sep 2022 08:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzBVIWgXYyhXrgVL8E1OziWh7IWmixDhDFe8Yt/wIs7nDo7VjdHf3/fIN+sOLZvyke3q4jzXafhMh3mPjZvuFxmEb72Lx6nd19Nv9Re49hdjvA3iGxAwYQyJUjBXlUYH+uly3oHEGX+GAVicEOfwhfZd3P9fcs5rmwmMOxZkzclZFnjRvh14+7R+Arj7+fenL8fzmfSRt0f7gEWYaxuOiF7A0kZYJ6+rGgQibKcZvYBMEhBANCxwRHX+g2Z9YHmUj2DwoBzw95PQpIky8Iqdk1wyrSFvYERNEcvHgc8aTJvDB4vie7PV6u+NAbuXtFruGBSGaEhWS7Tl1Ib763uTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7e5aYif3+TO875+K8rZuOF1tBqfEdWIfVvUsBrWnd4=;
 b=DF9DkXTcWY29r04VpY52gSELFE4lyMdZCajjFxM0XDaVOW7DmNz2opVlkCsv4ShUo6ZWqDyX2d+X+YTkbECe2sDHmnQ/jGijzyKOFBl8SpyRGevR1acUJOizOLpCSDQ5mmChFXvHHGPCqCxgA06aVrlIhy9WQMxXFUHA78coPHdwaVTunVsw54oxhyzRxymr+B/5hh/Bfj0YKsXbVu+esrbo8867ATt7+VMqloMXU4Jiabux0CCH0K1/Cvhkz18PQOkQ03o3CIi8Z2OapyzuiLsDYLbFWvS7Bf6W7uvwqf5rJu0riIht1oQ6RzJweaH5PKXYdBPFTJNzCVrLZjZGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7e5aYif3+TO875+K8rZuOF1tBqfEdWIfVvUsBrWnd4=;
 b=qRPO2KyP2gghiTQzm8LYKwPiT9bEWDkfuJd9AE6G52wl7jc6bQUv2r0Pn8VCbcTn/XHwdmVnDYf9kAi6nAIYQ1GWeNNJwAqXI/TbU9mdsDOxyKrkjJ1sNEH6tJT/xba8eO6STW0okYr+zPKJRKDPGr62UXL0v6C6x0fcXpVaPIvCmb8NOzopiWM3QjPiM1R9FxZqvz8X9d4/iFzedKpSh43xvmJ7ieKi0gWH9q7bHMdPNQc8nm+kh0M6iud5QdfwmFswggQgzAXkYMo/2u/NCBRzlb7xsFyXHCYBz7+I/SgTbNOUboaKBAD/FCxcMRRZn35JeKHPZg8IAUkd5Nz54Q==
Received: from BN0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:e4::34)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Fri, 9 Sep
 2022 15:53:04 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::ef) by BN0PR02CA0029.outlook.office365.com
 (2603:10b6:408:e4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Fri, 9 Sep 2022 15:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 15:53:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Fri, 9 Sep 2022 15:53:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 9 Sep 2022 08:53:02 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 9 Sep 2022 08:53:00 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH] dt-bindings: pwm: tegra: Document Tegra234 pwm binding
Date:   Fri, 9 Sep 2022 21:22:56 +0530
Message-ID: <20220909155258.17908-1-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd00ea4-a5d9-4ff5-f75f-08da927b61d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIC/s6Dd54rPP0ko/EcBhVMcd2I5RUhjs24+7/AgwQ2PMv5abMQ5H/VczGBCxClESyLep6bvcWcnUaRAXIK0fljItaS8zVwJn6jflbaX99z1m2M3EIQq3PEGV4r+Ml8IG4A9zgM00HObrpUuI5FcNnizAK5rZATwyhd3PkrJACVBllkH4MOZgRKKkl3auCkhSNzIaFI+dhxxynG3zPJhQ5x4P0fOch2LQLauJWGxu5dT5oeYcvfk4OXpMYmgfFlzXyCBzp12ErMMYL25QlYvBR3TVByBcU+ld3Dr+OhfjOlNuqQOSVJ5pWNh0+P9xrSZPAKbdZVG1XgLZKjZ/MfOExx1j59RYJBqIgexkXdm+YfHxOBXDxG/6o+O3qoeox6wRjmBZ9z5AhTXmvnfWA5RFH9QGixwdtUSUwe2ZsojRAxGBqiclCfV/Gt5UIcIfKZEt3vIoZo28izxvVFUEoHWupmtJoDKGqoYWAnK9G2V32cJ1352i2nNDeNWqN2J99TuxDdSmTAtt1phURG+AUsalaBvaysirOl3XiFag+8D+NTYECmEWBdNsK62kJFahBm8K4GQ7hFnCUN6fIsTKsJhvVnqOPY9M/SC3gg9SU7uv1POl6MAcLvduFuJeWhxVtziSMO8gpZkdFVMobypxxuj80U270eeLFUdAps/vJFD6jIaFif9/aLhzXg8bbcrHveJYvIhRn1UAlQWBb+T/h/T4geExBoM2MQU+Ha0HElRAKc3eorAkt5rwErmEDT07Pzvwa5v7ypkRyVwQL3UiVd32Sqp53OjgaLp2/h7xXxLA8GR2TBCAeHijXzRG1Fb9btC/0qcj6224mjQGkAs/Qu7hw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(47076005)(2906002)(1076003)(2616005)(426003)(8936002)(83380400001)(36860700001)(186003)(336012)(86362001)(81166007)(356005)(82740400003)(5660300002)(36756003)(7696005)(6666004)(8676002)(54906003)(41300700001)(478600001)(107886003)(4326008)(316002)(82310400005)(110136005)(70206006)(70586007)(26005)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 15:53:04.4713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd00ea4-a5d9-4ff5-f75f-08da927b61d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM controller blocks are identical to ones found on the
Tegra194 SoC. No driver changes are required and compatible string
"nvidia,tegra194-pwm" will be used as a fallback.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
V4: Mention fallback compatible

 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index 74c41e34c3b6..331c1e66e8fa 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -9,7 +9,7 @@ Required properties:
   - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
   - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
   - "nvidia,tegra186-pwm": for Tegra186
-  - "nvidia,tegra194-pwm": for Tegra194
+  - "nvidia,tegra194-pwm": for Tegra194, Tegra234
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
-- 
2.17.1

