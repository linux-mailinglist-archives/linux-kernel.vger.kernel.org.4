Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21896C5BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCWB3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCWB3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB50D273A;
        Wed, 22 Mar 2023 18:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFr1nVrdts13vduWo8uAi90jUbVwD7W84AXyMWC9xRLtnEbkfEbplTZfz3jHUvY2pf8xIOsvaTwpe4yZ8hHlBP8CaPfmQU38lxNh39H6T3SAvmOWcCLw3nuK5vSO7skEcIYHqdigKNT6qFZgacYVSMei3MOlQk//2iulC12B3790hNDc41i1Wp/UCRRZiQt0ncBtFaf7a8whvo4RNH6xpkuDRnSBiRciUCFyqUCfwkEHiypsy+CpLrpchofeogB7YwfLVcSZlHEfXnd2QSqjn1bNU0lW8pOwISbygoFeaxyVfsvkxBxKA+MCZZISq1OtWyeGbH9Af0ozpk/B8OKPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlA9g0A4n5Satm01GjYMSCCtDWKkSXyGLyU7mVW5rz8=;
 b=ShOqecPi9WyH/ewIebMZcnopMJXrG33EBjYlyR+TaVyh1mTAvcWvN/mMxuN/karjiA1vmw/aDfaFqbzEFBFBbJgC8K2Lnc+sSZtM+Knp/smvuLcJP1j5DnE5YSOGaI9hFq+BAA+XRaArWgSOG4TbfFj80cgZuLKN0lufgfKrTeyRiHggYRG9UhSxlwaWDYRTR0eugBun2ks7ctrvj8y3Fh8k0+myq7rllMqFWDMgo6ykyKtA+ZRW7TvXJJcg8uHjQv5yCIFIYDpaOIneLhhhcQo9ph6M3eagsJNA1WPDJWcaFPjdGFGBhELuC2ib669AYpRL5fqPdr7/IlUDKAv6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlA9g0A4n5Satm01GjYMSCCtDWKkSXyGLyU7mVW5rz8=;
 b=oXat+LjZ0VQ49AYFueH09/DM5V96rflcOQ5QAFWLQ+2l7HgePsgMnedc3lc66ytsxCWtWKWCeVAX9B0IshRUZcYDx9pz84VRHv7c3JNpnT3jw/bCUXb0IYhNEtMEWosdfhjATc6/fDIeP68ow9oz0/mlAhajtM55lGfWH105rF1SQHRB2T1Y6qS9EtwueOdvkPaN1yVuVJkxsZDuTNLu1QUZzQSE1KjC9WXn9zq6Gz2E4ZD+uPLWt5H8uZ3ZQqlrCvSolc2B5hvNW3godjZrsgw2S/7fnzwDI6zz2ejOrBqo+lF1ATHLko6CwGMW5Or0qc8VWmdw0HSjDExGUU5+6g==
Received: from MW4PR04CA0201.namprd04.prod.outlook.com (2603:10b6:303:86::26)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:29:40 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::9f) by MW4PR04CA0201.outlook.office365.com
 (2603:10b6:303:86::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:32 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:31 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 00/10] Add Tegra234 HTE support
Date:   Wed, 22 Mar 2023 18:29:19 -0700
Message-ID: <20230323012929.10815-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: f4537cde-d08c-49ad-45a3-08db2b3e1299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qux9c/KpSkPm+b+TBvppeYANbJ4RFfb6v2r5oqiY5ZOx++kqB0ODtWtd29GCKNLaeI5o8jd60+7zR3FJ7DAL2+hhmMeD9kx6Qu637ZMR5bwyoHrowNOQZu0XhP1SkClXDnu1zeiMJnf0zQ7yQlGeWIXXszxS31RAzxS6LnRq76xY0qW2mdbirO4Hgr85LJ+ts6bOpwUmQSUTu5CIwvJlUID/Vch02sKcvfPW6wHPGoRWzdcSfLxWJypUdeeSjPXrf7b4wVvXzXWERGhUW+A4d0hQ5z55oaeOAGzqzvmyzFUDVzJoNAOpviS1JhNn0ZmqTc/XCiWnhui2LQV8+Qxhixv/F7J/U/LsKPh66ouo5mZ+4hqOASUsLBwvApotq9ZGE2iH1NNMOliaiAz3hD01ZHRWv4RwNNUDAZJqvpEv015AojKc0xhKD0tFyHkRusvr9+UYoZs3JlhIWapG8bOLX1SR93OiHiHZhpNqcwGQgejgSiP+1Zi0avi20x/+o/t93Pbqo1mLB0fsAl12k4jYBdD6jYVbhvl6WY/VIDsCaSq5Q8zoIpJXyucKHiEM3Sp6usJQku8Hjm/4es64AuoTiT7PQmHHlLP57vWlSD28akQTbk5ygeZqzcL87JYlN69BrY4+0F8e6tV80xZ73KydUjHQaTjB7hgmTi/JVRnzOQHnGJRGFvEkhcJvAj/mKQAOEvzEjGwC133EGUaQxJAByXVck9IIMwvrxde2MuUDkZ6qzDmN6XefG7KFNs9KRSi/fFy119SKvKK/kNi7+mSnpZn8lCATv//LHx+yRQFEEshKPo+LNF2mVr3zPaTX5dex
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(36840700001)(46966006)(40470700004)(40480700001)(426003)(186003)(7636003)(82740400003)(7696005)(41300700001)(336012)(36756003)(47076005)(1076003)(7416002)(478600001)(2906002)(26005)(5660300002)(356005)(36860700001)(921005)(110136005)(8936002)(70586007)(316002)(70206006)(82310400005)(2616005)(86362001)(83380400001)(4326008)(107886003)(40460700003)(8676002)(6666004)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:40.1496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4537cde-d08c-49ad-45a3-08db2b3e1299
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series mainly adds support for the Tegra234 HTE provider. In
addition, it addresses dt binding comments which prompted code
changes in the existing HTE provider driver without breaking the
Tegra194 provider. The comments raised concern how existing code
retrieves gpio controller node
(the node is used to help namespace conversion between HTE and GPIOLIB).
To help simplify that process, new DT property is suggested which adds
gpio controller node in the HTE provider binding as phandle property. To
conlude this patch series:
- adds Tegra234 HTE provider
- modifies existing provider code to address new dt binding for Tegra234
without breaking it for the Tegra194 chip. 

The V1 patch series:
- Adds tegra Tegra234 HTE(timestamp) provider supports.
- Updates MAINTAINERS file for git tree, mail list fields.
- Updates devicetree and API documentations.
- Enables HTE subsystem, Tegra194 and Tegra234 HTE providers
by default in arm64 defconfig and dts files.

The V2 patch series:
- Changes in dt bindings to remove slices property
- Adds nvidia,gpio-controller dt property
- Add GTE node for the Tegra234

The V3 patch series:
- Re-arranged patches to have dt bindings first before its usage
- Addressed review comments regarding dt bindings

The V4 patch series:
- Logically divides dt binding and tegra HTE provider patches from v3
- Maintains backward compatibilty for the Tegra194

Dipen Patel (10):
  MAINTAINERS: Add HTE/timestamp subsystem details
  dt-bindings: timestamp: Add Tegra234 support
  dt-bindings: timestamp: Deprecate nvidia,slices property
  dt-bindings: timestamp: Add nvidia,gpio-controller
  arm64: tegra: Add Tegra234 GTE nodes
  hte: Re-phrase tegra API document
  hte: Add Tegra234 provider
  hte: Deprecate nvidia,slices property
  hte: handle nvidia,gpio-controller property
  gpio: tegra186: Add Tegra234 hte support

 .../timestamp/nvidia,tegra194-hte.yaml        |  46 ++++-
 Documentation/driver-api/hte/tegra194-hte.rst |  33 ++--
 MAINTAINERS                                   |   3 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  17 ++
 drivers/gpio/gpio-tegra186.c                  |   1 +
 drivers/hte/hte-tegra194-test.c               |   2 +-
 drivers/hte/hte-tegra194.c                    | 167 ++++++++++++++++--
 7 files changed, 229 insertions(+), 40 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.17.1

