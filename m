Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C1F6962C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjBNL4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjBNL4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:56:10 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB18B761;
        Tue, 14 Feb 2023 03:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzOFYvMKc1p5O/AtRhlM58xhKarxD5bNMdXkP0F69rbiG3BTpxRXzGAz6uHtxodXdL+eFp+T7SwYykl524ea2e45/8sI8/SamJW47IC35FhNbl1Qx+27ogCJE+B2JRFg3DN/oz83PFsYqMFtWN6DveUYKAApXyeFGhaOI+Rv7y7KB3aug3XGAW0USipj1mVIG34sRHOshnVyNvHHDplJBEjl0vCgzwGEvboeO+EqCx7HzG/Zb8GAfvEp8PnHkpugJ6SMAxc85WQ3SUUScCfAaBU8dv3MCFuA+UEffW34MPFH254vTdGF4SUjCtHl8H3NaKOvcjMmKcL1knIapym/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/bIqGIBEeUXK6p8nYtsw7fN8M+djAOqsKobKwmnTFQ=;
 b=Mw/bv4+IZ1JyQ5vdtZpxQ+B23u856J93bbL+wcQlBSzIiJiF+xfvnLiEJOIRivDTJFdHKfHeTdz2wsPGKnkNDg0lLarjD9N1mmEP0RHArcxw8NHdQZ0dFZTG0aFpKAXN/cv+AqwIHqm6iArEIjnpy8yF7it9FTqksgkMFniAuIpehCq4LhYtwL+EtZzl/Q2GtsE7hLV/4jnPGLvTFcG4l36l3EY4K4MDEMZmq1TPmeCfMZ60gHrpGuA6Dt7YNW5b/V0izhhj1WTWlCUuuJlEfraX5vKbjIS4hi/U38YMOIuciNXN5N1FbLeJNyJDXg5+vtIy5Eay+JSOWGCYlv9UeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/bIqGIBEeUXK6p8nYtsw7fN8M+djAOqsKobKwmnTFQ=;
 b=CETuclUA8kIZluw6pptMbnWDiOJM0cjAd7j0mH008HHQQxPUO55EwLYESUWg+pZzndkHTdnhA2yE2obvmFmyciiQYhsn0CPEUSJXeAabSkbej+V3B6Amq00yixBuSw7EzwNoFxsZOMknp2kguhJdu+u+BBiVMC1JLX1J8sKFWLL9Im/y+YDQnQdHX8GA7gzzel4iJ4c0ktSm1e3RS3fqAcR9i/uBy6lW6QW2OPF5wgjDWJdO5W6R1djJAOdgXLIhqFHAdKgfJ/KYlQqdm0kaTUVLmCNRWAgEpAmrBFIzL3xFv0tFpAyv+KXfdjEy8EU11mvU2w/FZeM9VHfQXLQwHQ==
Received: from MW4PR04CA0064.namprd04.prod.outlook.com (2603:10b6:303:6b::9)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Tue, 14 Feb
 2023 11:56:07 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::d) by MW4PR04CA0064.outlook.office365.com
 (2603:10b6:303:6b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 11:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 11:56:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:55:59 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:55:59 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 03:55:59 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V2 0/6] Add Tegra234 HTE support
Date:   Tue, 14 Feb 2023 03:55:47 -0800
Message-ID: <20230214115553.10416-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0229ce95-98e4-4cf2-7ebf-08db0e8274f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84avv/5FS6AFhw38rI/WubT1SJ1kA9sE+krcccqYOpVqCfndtZXcRHn7iqaclVl7Kf+URaf9NYv/UHVIz+A29pTLxKuk/4qNkTN3YL+6dNNWQ+PNIJ9GHu6aJluDbMNTbDZs/unXlYKcywi7VucH17k5OJB0np9T5EU/kfKMKK+iWinKMH00SYaPOvvZcMnZD3U3KrLnbp8apQSRLbGIgSJJ+HUVvCTxP0BCmVUclilo1oSY8GJV5XeOEXgiglk4M6i3eMRstXngXq6jt+liGmUCgwFp0aBBNalLv00rjM/UpaAZ5xlGZqu9F/EoLIsNZzBOZFdk/nbv//yVHh4Ogr0pCvNsRLFXNB9g5jIHW6kI6WP3FdF0jJhQ8fbvyAM0ptb8QnkNcfBdUIBJ2cTnn48xvhpilZL3K9Xn+JJW06cx/ZxiO8RWZ+kfPN5VFuhEOzVIuSPfhmmgFYrsrJwDyPe3QxmCjPubMQLfQNRNlFqhSoUNEMypKnebn+rAQA9nTD3vGiKe0xtcaoiVtQZvgaFXzrFvjTbtXEpjoHiKuBupzGEOhnsKAnTc0NVKHbcY59QaqCWxXaIsVdJGdoKb/K+/Lcf6VD1enWcbqo84RfLJpqN+T1urJH6krylFbu4MGa1V/a6hpJAbV9KoSTExT6G/HrXrowSJKmAI0wx3gtzr+zM5vbmiopmkViVQvCAXSsv/p/pJer5mXU6D/5fQQxDl2KIAPvbDtG9HQ2rhCOnzfUJsC/lETkRgE9ZE3ILRDDSozzfd7OLQaBcDQzvUDg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(7636003)(82310400005)(82740400003)(40460700003)(86362001)(40480700001)(356005)(36756003)(921005)(4326008)(2616005)(8676002)(70586007)(110136005)(316002)(70206006)(478600001)(1076003)(6666004)(186003)(107886003)(26005)(7696005)(2906002)(36860700001)(8936002)(426003)(47076005)(41300700001)(336012)(5660300002)(83380400001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 11:56:07.2303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0229ce95-98e4-4cf2-7ebf-08db0e8274f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Dipen Patel (6):
  MAINTAINERS: Add HTE/timestamp subsystem details
  hte: Add Tegra234 provider
  gpio: tegra186: Add Tegra234 hte support
  dt-bindings: timestamp: Add Tegra234 support
  hte: Re-phrase tegra API document
  arm64: tegra: Add GTE nodes

 .../timestamp/nvidia,tegra194-hte.yaml        |  30 ++--
 Documentation/driver-api/hte/tegra194-hte.rst |  33 ++--
 MAINTAINERS                                   |   3 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |   3 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  19 +++
 drivers/gpio/gpio-tegra186.c                  |   1 +
 drivers/hte/hte-tegra194-test.c               |   2 +-
 drivers/hte/hte-tegra194.c                    | 153 ++++++++++++++++--
 8 files changed, 198 insertions(+), 46 deletions(-)


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.17.1

