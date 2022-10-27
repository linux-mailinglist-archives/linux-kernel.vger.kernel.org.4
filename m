Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD2160EF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiJ0FM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJ0FMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:12:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AE6119BEE;
        Wed, 26 Oct 2022 22:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqQj41mmAReL/rGcbqSUWwN+D51vVypWiPd+vI24xE4Vkzp+CH0UxR7wLAMInrMI39wEqq52mC7MiRWE+m9EI5ItwKwGhPHC2h2tUkKD+m0e1xlQI1z77qiR/dSOyZYmhJEBY/+dGmhRLJrDeJqkYjRDwFT9XvoEJZUZ3qcJvre9chEz4oYDemwGmhD42dngkKefWWqi8tB5oqm4533juf5DCYBabL5opcQH9Zj0hNyixdqxx4hSeRTOsbGBPcyMjBin5VFDzGX3xpqBMBrTN3s5CMfYEh/xT3fsj/gm9bQ/CCmbaH3PlOf9MiwVR63IviDrnxSvjgbUAQJ+Ai6oRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRG0Fxu7YUTZWCu9v27AmYrxTqS1a02t275PUvIVG7U=;
 b=PL9sH+rQ5pENoPJA5WXVWsjmFq4Jrh69AfkcUIBDTf+uZ3bHak0BX3rHv8SFgUEM0CMs+Jo9s6z59lQuVNigjns40iJf2dkcXufbs/uZfjClf+9591tWcbDi9nqSxkJbTcfxJy8dpS3GWCC4nl4kDrlmylbTKC71ls/Kp6SopMU+25+MPHYWNXqBYhqcD6eO9vKooNx4apb/4vbcyhSXZByDCndf9JKZNyZFwYGDpixt8NItAXxxlv6iaVur4Y6jpbvohc5htUN0ZBzSF1lmzNU1ljksUJu5gxxNHNq6YyyiPep+KCdADrjNMfBOgHDUlo5/dbGcXagpGVjQSRKI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRG0Fxu7YUTZWCu9v27AmYrxTqS1a02t275PUvIVG7U=;
 b=Ep7c3TdFAsJ9Ehe5eRsz3LZ/c295keHUS/jRo03rTbxnN90zbXds7vWfWhswDa9tf5sKiPh1TcCr7t4JjGkt9lAN1yNuKmrjYjzuzeuVLJEqYNefaFr7p6nRmptqWaK/O2EQHwHZ1E2tRSdvIYXCMAlpBXRUGnIUn0fa8Bc64e7YkX0Kd0QBRoum0v+wFX5qCmHGfvimuLJzHcw0JnlWTzsvLAiYQfUSiJMN2Y4idDQICEfoCC+VsH0iWeLmPS7qEeEir+td9Geq1+QWwCtelcO3fd/jyNamocYj6YHsUT1CsHaalB/yOmr1sFF0z6Xv+01s8+s9jBS4h5puTPZdhw==
Received: from MW4PR04CA0073.namprd04.prod.outlook.com (2603:10b6:303:6b::18)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.40; Thu, 27 Oct
 2022 05:12:23 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::5) by MW4PR04CA0073.outlook.office365.com
 (2603:10b6:303:6b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 05:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.19 via Frontend Transport; Thu, 27 Oct 2022 05:12:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 26 Oct
 2022 22:12:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 22:12:22 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 26 Oct 2022 22:12:19 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1 0/2] Add ECAM aperture for Tegra234
Date:   Thu, 27 Oct 2022 10:42:12 +0530
Message-ID: <20221027051214.22003-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c376ff-69d0-41ca-0c84-08dab7d9d4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gb/IhM8lzzNJSKnSyc+kB1iM34vEFZtwrv8bOrc7Qe8LxWWeYIjLCwwoUroEbwC8CITo6c5da8eZ9KUWohso47ZaOH5wTKWNULRh2cAe5WCAJT1F1L+fNHlsOa8Evygq/2LZnhCmToZNBzfgO8rN6LdtdOGkK7FXADrJbGMU0+Vjn7GwhuzAO6CASy5TNj0xC5orsq50Z9n4Nl32eWgjYgESKtM9G9hYqX3l4jMcyZJnDjsWC03gey3A011Po7oyU84zEd7g/ukpYWVtZRL7epCDBoHGLLd5kyHBof8kZ1oztiGfGgOF2TYhALVA3USxaf9z8mQCzlyqaRyRQaqSZfKRrkJmL5+DmZO/r3feAPjS9deMo5c0sE8sL85mSOH8h8SkYUazk+I5lZVmWDek7eb3q+4ode/r0iHUeTXl/Sm3HE9zdoapMb7cHzA2cVkjvzZephywoq4OBWmG4pRvjJvJTEQ1/KIi6t++xBuqC8qXGOALaLp5PhaGj7UloeRyux6XVPy0vXO1KDP+e3JKkXvzdLByEGoR/9thVIDvMaZRm41oATFAKoIFnvLIuHWlS2arbpjc7v8rszBH2Se9DLsLtWsiTR1aCrIX44twjAVlmwM5IJl3V6IAs8+45DLoEF7qVzMwDqpJzBwTiH28e+jvBMpgILcAAw8quxmqvbOn2ZGe2iQiCLRsf6qCGajyLiTaQPO3P8caOjfI3GNFHqA3sCoZSMGJP4PUsTOiiFQJhn3QQyMZ3aOs5vyHh8b54r+QQV8lpAo4SsFczBfkuA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(82740400003)(7636003)(4744005)(36860700001)(5660300002)(8936002)(70206006)(83380400001)(70586007)(86362001)(426003)(47076005)(356005)(6636002)(54906003)(2616005)(40460700003)(1076003)(26005)(8676002)(336012)(110136005)(40480700001)(316002)(478600001)(186003)(6666004)(4326008)(82310400005)(2906002)(7696005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 05:12:23.1403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c376ff-69d0-41ca-0c84-08dab7d9d4cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds ECAM aperture information in both device-tree and
documentation files for Tegra234

Vidya Sagar (2):
  dt-bindings: PCI: tegra234: Add ECAM support
  arm64: tegra: Add ECAM aperture info for all the PCIe controllers

 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 10 +++-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 55 +++++++++++--------
 3 files changed, 42 insertions(+), 25 deletions(-)

-- 
2.17.1

