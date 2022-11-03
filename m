Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0ED618662
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiKCRpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKCRpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:45:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017541A817;
        Thu,  3 Nov 2022 10:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy4g+5jQD52RGhcP+cd9PP2yDpS9UMWy9mGogwPDKmG1z7gaL4VCKHDDIPJ1cn0KGO0JU+sjW9V/g2wK3vh7W453r1exOU4DUHqc0SatM9P/Ao1eSv+qR2W8KC9MMLR4xjidv7rmk0wGo9k3w7GUrU12uM31w9DD+uzBN82W3nOrvo+cciHIR5iMVfBHju4tVW7WdPBzvgLSnLHrbFqA9q6rgjlULcL93zFHTvVdr4hpM4dnSaLYBbMTwDdQ+OKFA5lRQAvkFfEUbA/L7se3rKv3SKQJXalF8dNeHnNrqUoGaZNjmKsN5z6HbYT+NXOS7Euz3yRnCyetSVj+Qnoigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFMcM6zkYTuVUd1a/CBtfjvHFg7ShWtG0G/3juEsix8=;
 b=NwrNIaByNgizwxwLMXPjPvPUAiSxcDWIzj9zHyr3SCOkeXHuIB9PJgPvrsTsqohRuwrUK5JaJUMoCk4v4IN9IJKb/hFEa9LYYTGTTMdYjEnZiZ5nP/E5byhZPi4eXG9wu8wC0NamMR68Uo1fFR//JrW+KJjjnRM1DPblbTMcd4mHUxo9hhOlvl9ewOlU6p6b4zVBtewXTDYQ6pDZMSNRA8w9Wp9xySOWMG3GyEsPM/3T7q5koiRYwXaqqYK/nM+RPW+FjjYIHnGqUg5dXgBkOy1mYjkvev2RIJ+UVy4MQ0q9UN2XY/HGSib95/EnppzGovyqjI2dID4t4xnpov4xEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFMcM6zkYTuVUd1a/CBtfjvHFg7ShWtG0G/3juEsix8=;
 b=rodWmkkDiWaWUsAJb1Nr5AkihPADgYNjPeehX0QxlzyVRIIm0r8lrALnfM2VjbmZ9CrjSdnFgrEZMBq3aYiUCRJ/tKoXNhQro5MYo+ZIOZ/IQVzx0rA0b0IL/p98dxPoIM1jzTEnQbvkptHsy2wBeV/jvlNZ59LrFFJ3hwohe11Gz4eijPtWBRaaUNN+8gAB706Rc7ji2+nmxphHu+LXB2y3FAKMSHu0lIVfS4nR9Q9zz8prBQoqlVM/RZ0lHsS6rR9N7budoXYGrmR0cwJwUK+82qhTkBY2cXF7YZ8+cHOIwKogQsD7jOlbJ/FCSfoWJDCC6Gsl6+VROPZz78w+6A==
Received: from MW4PR04CA0077.namprd04.prod.outlook.com (2603:10b6:303:6b::22)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 17:45:44 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::bd) by MW4PR04CA0077.outlook.office365.com
 (2603:10b6:303:6b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.21 via Frontend
 Transport; Thu, 3 Nov 2022 17:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 17:45:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 3 Nov 2022
 10:45:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
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
Subject: [PATCH 0/7] Add Tegra234 HTE support
Date:   Thu, 3 Nov 2022 10:45:16 -0700
Message-ID: <20221103174523.29592-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|CH0PR12MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4c0e5f-e578-42ee-dc61-08dabdc33b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOZdpGIH0CrxtvoBmgjG/MicHXnJyJMUZv6S9Vb5L/VN6ZZdZHIR0nOaT6aWSEDEJ/i2uxRQ1uEQdBg3oVzltwrkTHJrCb+TWuDO1UyjikFLCcAVQCDuYaoTbkLU3UvcvGp76ktJLJ1G+0ym8Mv/sntmp2uK4NQq9h9GZbiqZAeKoNV8JhTfp0+aHWER1YtkMSY4fsPkIBTtwHfp/TpsAQZmY6L+ci+qTW7c7jxR9uu+TyT/6OnDePJ3CoblfeOgRNjZCAu8/dJ2ZEfy/XoQayUgdcnQkaFRPbAB6jk56rf3iRMiJ95wt/BndiBWwTZtzGu4Rngb2fk/FZBNe6h5ZqfStxD1CJVXEDxX9bbo+U6FRHPRDw/IgnJvJp/aFUqgS8+fD6XYQIPB/qlAJmu3PFmBrevp5b+2cM7VPHF4cd0xMvHaytrAHp/eKX/UFxlvIjjuDFw11TC2o1yT17lfXmtSV1Jvw1v0CXRmtSGoFlVtwc5hNNehC3R6VoUbdqjliTqatRpx0mwUYEB+xXSUz15Fv/onPxe0rGqOmN2csiKa0EGTlUbwQw6GoMEpFvFM8hx0ZooRioQV50mDACCWsK7jucXyNZpocA5RLAaO2OAe5fkWhdI8PETT28VjUWfdGMj2rAi8zhtGeuWxvVrCXXf2jU0Y8MzjAmY/lX2kS0HE6d+Uxr7inviI4LR6SHAKLLOAIsIvUqIGqecAMBRKDmxYPuonTl2wUimLwWoqYdw0IgycWHiTdmluLje8601r/FJGcezQExC8gUj+ETlEj+7o8oqabSgNQBW4QvImHKI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(40480700001)(82310400005)(36756003)(86362001)(356005)(7636003)(107886003)(82740400003)(8676002)(40460700003)(316002)(6666004)(70206006)(70586007)(7696005)(4326008)(110136005)(5660300002)(478600001)(2906002)(47076005)(426003)(8936002)(2616005)(186003)(336012)(1076003)(83380400001)(26005)(41300700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 17:45:44.1751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4c0e5f-e578-42ee-dc61-08dabdc33b9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series:
- Adds tegra Tegra234 HTE(timestamp) provider supports.
- Updates MAINTAINERS file for git tree, mail list fields.
- Updates devicetree and API documentations.
- Enables HTE subsystem, Tegra194 and Tegra234 HTE providers
by default in arm64 defconfig and dts files.

Dipen Patel (7):
  MAINTAINERS: Add HTE/timestamp subsystem details
  hte: Add Tegra234 provider
  gpio: tegra186: Add Tegra234 hte support
  dt-bindings: timestamp: Add Tegra234 support
  hte: Re-phrase tegra API document
  arm64: tegra: Enable GTE nodes
  arm64: defconfig: Enable HTE config

 .../timestamp/nvidia,tegra194-hte.yaml        |  44 ++++++-
 Documentation/driver-api/hte/tegra194-hte.rst |  33 +++--
 MAINTAINERS                                   |   3 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  20 +++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  20 +++
 arch/arm64/configs/defconfig                  |   3 +
 drivers/gpio/gpio-tegra186.c                  |   1 +
 drivers/hte/hte-tegra194-test.c               |   2 +-
 drivers/hte/hte-tegra194.c                    | 124 +++++++++++++++++-
 9 files changed, 224 insertions(+), 26 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.17.1

