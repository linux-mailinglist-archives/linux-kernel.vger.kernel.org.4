Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF86F4F25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjECDaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjECDaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:30:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83922680
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 20:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4zh+tyEDTwmodNsBkKHbzN6ZgVLus2FE6c2fA7X8fH5ORe4bM/cKzaMKI6wOekySn/EJ8X4l0OzTu1/kpN2BKPWyUi2TwD9mGyK/fWmr/mlY4G9BmZhYDU6NxO7/IllQJ8+3t6/dG+aTB8xZwv29NONQd9ZRFf3LxKOJT+wYx+AjSIquNiaV/498acuE1fAasbWyhnFG7RL45HdL/Zxf1JzLmQaC5Sak+3JjeMEV61aBehx6XpFwmUpqtK/mmJQ89bfkG/+TsGx/tSo5thTL/oJb675kqY75Vt2HwktMCIcCQWIJ0dd919rV4mbXkKpD7ZI+7kDEt6WVT6T9YxEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpeRA5qlLz2CdUTryD06Stbj2eLrB7bdvoTpsURpzY8=;
 b=IHOT/Uwvi6QIOCjtXTEx3wDpv+vT350h4TiJt0UjKrqEJg4aOzvsF1cq4qPVwSgBbpQHynFuPrvqi55egODJsmj/DINuxz1tSjV8HYBJtnsXSaL3WuPN/NJDsPZlxOZd4yxPaj8yrFKA06hDeXKbuBV7Y+mjJa38q3SsByPYPLGN9ujx0qfAn1IcA86DbL0cHEoOVGB1fTj+rP4cful2z43a3TnNbNDBskHVS8VFq8/6EKa+ZziY+51w2MbxVhkfbYpdkyhdVaWbVwN7JKq61MhSgQTaiAip+p0k18EeGWBA1vwGvMZst6iGHsiXq7Lmxmiy6eES9KZi03sXZL7ngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpeRA5qlLz2CdUTryD06Stbj2eLrB7bdvoTpsURpzY8=;
 b=UgdVXvQK17ex9zk6/hAxtNtHo3y8MM/6HxHAjuWJnw41LLHvcxqc+dDAeWAOAXZcfdSEbEl+QJCN821ODtNQzr6mPwtICeTEyn98ozTlcKnWfc1O1T0JQKB0k3hgkUs3nLyUBv9ZKFlvz1AyynXIE/eOzAnF91BqpntKrnBZkY7rfl5KWUi31l4mJGXkORirkD4KPmB4c3zDOI95z5SVN8C4QAZx+zQxbePn/LHGPXjXi8kU99U4Q+Z5a1x3vPu6H0Wtisx+/oU7nK/21lWKUpY9cqWTQfzLTg5PkaqEPl9kIsRB5y+2FSTh4CZw5wz1tX53oCpiFGOCJix9RDPHHQ==
Received: from DM6PR06CA0061.namprd06.prod.outlook.com (2603:10b6:5:54::38) by
 DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.20; Wed, 3 May 2023 03:30:06 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::58) by DM6PR06CA0061.outlook.office365.com
 (2603:10b6:5:54::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 03:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 03:30:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 2 May 2023
 20:30:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 2 May 2023
 20:30:00 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 2 May 2023 20:30:00 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>, <timestamp@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] hte: Changes for v6.4-rc1
Date:   Tue, 2 May 2023 20:29:47 -0700
Message-ID: <20230503032947.23384-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: df2b1da3-a0f7-4495-a27c-08db4b86b0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Te1/DHE7x3SFUBkSsiYS+uoOUwRUT542bPujnvFxB4/+6si9LLoempk0Xua+lcEmahI49gwUYY/zlu2LxPyhjbHWY12P/6cMlxH1kRI3CWkJ/3G41iywMQO5R8sm+s3l86FFfqgtPIBz40KvDllcHDiDdAC1hgLv7VjKIP+HmRxQ9kG6TSgTkGKuP7181a39fU+teOCR05/mv9b2/KDdwkK2LtResfnWKn66FUsCYM3HpuynycMkhHiyrLiY7z0Bki4mYJhkFkEwNG5kHhRB08Jv50n70YCrLvZlwGFeu6sYaHfly4tX+DlTDSdnncydLW9QSrog3VdhZwlNpcdnsZ7a5d6cV/sqACl4WTDksghuiczvDQIXeAa42/EvAZm1nXWYNlYevGK3ftRJK0wD5AQO2dm5Zj3XQgI6DgqYmb3dX3QXQEY3G4oZsq2FDeKYMg5vRSBpmsunz8ntkRw27z55A/0YXaBcrQ4lLDhzy8a3yMLlfZkRUChYu5/9ITxEoNoqcWz5NYYOhfn82YuEGSMsStff7FVJsKFKYgje3Jms9/wEcuMcdCOUyHIAoe5eu2Ir7Ag3ogm6z6HWZoCgkOi0xUSS2m0UU21DUbFTTZHyHKhi1Bdpq0u8O1FN2nXAFDmGOSd/oBAjzsiI7hbQpNtkuvDn6eVKoQEKde06nrQ+xWLDC1j66VNDEATKRMHvZANEjoL4tTY8CVQqsElN9w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(54906003)(336012)(26005)(426003)(1076003)(36860700001)(2616005)(6666004)(478600001)(4326008)(6916009)(316002)(41300700001)(186003)(83380400001)(47076005)(7696005)(70206006)(70586007)(5660300002)(8936002)(7636003)(82740400003)(40460700003)(2906002)(356005)(40480700001)(86362001)(8676002)(36756003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 03:30:06.4242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2b1da3-a0f7-4495-a27c-08db4b86b0b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.4-rc1

for you to fetch changes up to ca3d1a4b419acad3fca6828884acb03614f7558b:

  hte: tegra-194: Use proper includes (2023-04-26 15:44:30 -0700)

----------------------------------------------------------------
hte: Changes for v6.4-rc1

The changes for the hte/timestamp subsystem include the following:
- Add Tegra234 HTE provider and relevant DT bindings
- Update MAINTAINERS file for the HTE subsystem

----------------------------------------------------------------
Arnd Bergmann (1):
      hte: tegra: fix 'struct of_device_id' build error

Dan Carpenter (1):
      hte: tegra-194: Fix off by one in tegra_hte_map_to_line_id()

Dipen Patel (9):
      MAINTAINERS: Add HTE/timestamp subsystem details
      dt-bindings: timestamp: Add Tegra234 support
      dt-bindings: timestamp: Deprecate nvidia,slices property
      arm64: tegra: Add Tegra234 GTE nodes
      hte: Re-phrase tegra API document
      hte: Add Tegra234 provider
      hte: Deprecate nvidia,slices property
      hte: handle nvidia,gpio-controller property
      gpio: tegra186: Add Tegra234 hte support

Linus Walleij (1):
      hte: tegra-194: Use proper includes

Rob Herring (1):
      hte: Use of_property_present() for testing DT property presence

ye xingchen (1):
      hte: Use device_match_of_node()

 .../bindings/timestamp/nvidia,tegra194-hte.yaml    |  66 +++++++-
 Documentation/driver-api/hte/index.rst             |   2 +-
 .../hte/{tegra194-hte.rst => tegra-hte.rst}        |  33 ++--
 MAINTAINERS                                        |   3 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |  17 +++
 drivers/gpio/gpio-tegra186.c                       |   1 +
 drivers/hte/hte-tegra194-test.c                    |  12 +-
 drivers/hte/hte-tegra194.c                         | 169 +++++++++++++++++++--
 drivers/hte/hte.c                                  |   4 +-
 9 files changed, 260 insertions(+), 47 deletions(-)
 rename Documentation/driver-api/hte/{tegra194-hte.rst => tegra-hte.rst} (50%)
