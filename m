Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2296A6D9E69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjDFRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbjDFRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE73B450;
        Thu,  6 Apr 2023 10:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWZ9IXSnOtB7IVgjmfaT/PK53dmmqJmFmHZlCK+9jey5J9svUSGOOC9w8oMZO5t6TfJBTXA+VvHr6vZhJrsi4QYM50ryRPsCBIgWq4EvuO2mk4jpIfJOj1nNsPF4icQ62kh8caP/giw/EEJdsH7f9ro/LmPQ+w/h+xBUPJWJth0ARuJtsZ548DztDOysPm9XSGMZDfYvV+Fq9ZY/MFPQ/AzOE78hZbeMKC873mYWWMzx8tyllEUecdiymC72tfggsPoE8tIIieDkVdLy+hbkYxlnd9bAMbIojRwLerkm2wZvS77RNbsgToFiI3NlSDd0h6wSoCO+Wene2QR0PWcoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhWNfg93DvHV7aiZLnirtWk0mA7iojAi2aTm+kONSik=;
 b=mvofTtF3kkc7fkxCUFus3f+uJDS8LWRxgkkNN0BVroysufNjHIFiy9feBADYZOLkZ7//Fo2EPSeSv/eygfa9Q7h554GylVPH/GY4bRy7v/HCXO5Rm9hUKWjD6M3fauYdAf1+jHC17ZYyIwf1M0JjrlYEbicSwRBU+yMk1yyzVA23c4hnYOBQyYc+9mRyf1uo8twe+3qErxbCPrrafR7E+nISTDwll0SUFR4u61lmoST5bM3yHQMqgmj3RNrTvI/InVdOFEFE9f+dwvm8sErgWg6XtvvXxz3pSuy1GedEAQ5iVcGkKKqiLwz6bJ/3giunaGNCbwyTcGkva29joSXwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhWNfg93DvHV7aiZLnirtWk0mA7iojAi2aTm+kONSik=;
 b=UynJvfTr9HzzM4gYmElCuRC9gieHlKAvKzeKPRj0/zTMDrEkZ1QoKKFx3kt77ARLkif2XK773uCG3ADydBBpd5opC4iTGeOwviypVkZxBCTdyux52r5OcJ+IZqB2FgH7laK55lyVnFzhqyyzqsfc/HnDYvRB6MUAQ0OrAitQAmv9o+rgxYRypGkigeewSuH01ELEmKgI1diFGrdogI2IU7hghvgWJdJs9nRBvGYX/Q7/BtgttkiHNclEjONGzDMwrPovY1d0013r//nfc7uvv6COKhSbP/hsiBiJz+W/g6dZlJfZIH18WkcWQ7L1uvY20PqGtKwjzVce4RZWsekddg==
Received: from DM6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:5:bc::44) by
 DM6PR12MB5024.namprd12.prod.outlook.com (2603:10b6:5:20a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Thu, 6 Apr 2023 17:18:52 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::33) by DM6PR13CA0031.outlook.office365.com
 (2603:10b6:5:bc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.18 via Frontend
 Transport; Thu, 6 Apr 2023 17:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.33 via Frontend Transport; Thu, 6 Apr 2023 17:18:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:39 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:39 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 00/10] Add Tegra234 HTE support
Date:   Thu, 6 Apr 2023 10:18:27 -0700
Message-ID: <20230406171837.11206-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|DM6PR12MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: aac2d335-46fd-4aa9-88de-08db36c2fe8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hL6piCaib1Uq9fuFe3DUhKzlfZZviI9Sp3Roe+tAdfJGW9ElZC90oGEDZUixxwWLJMWjJhtEZncCDcnlt4XObi3PdBGnXlhLThdz9sRKpROLFXqPBxWVhE5oWHcktTRId5O7YQId1orLn0o5pgw4Yz0HGChply7RLsgSiGAme0XXrN7RvCgscRakDIuhmtCRGd6j392H9HglDrONf0GdhV0dtGgn1gvo0yL+8V8HeZqsfx2wCElu9tcgEVPgcgp8doxfopFc1jaYl0NpJ5y/qvLJuyCfCxwAh4OVEaJ6m+IXzZ78l2Bod0iUs/tpPXj0bOTCovCwWyvadJY99Bib6FfXHI7B9XaTdN48XvUfYZV0L1TNQu3KsZ9OrUnthHnAE5NW+BjL/75HLZxne4e8nYdFR8H1sSC8OgJKv7Un7c3D0MUqEW8CghxFstA9yJWBgie+w5UU5bOX9uJ9fCaJmHNNrggPfaM7k6azdZQuPQWgQtDHIZWNgHnaBjDgGrNrIBniL+naSfuE6sNgCEA71nQMJs6qf2I/DFG8im7azKJKj84Umv8EAc3qn0o1AaSMmbF0K0/AQCU7TH4NqapDg8OPmdHtdwgEAS81fkrUWER+1MMOneoZvOegCQBVWeQhejB2YYm3Wy8Td/iD0ApwWTZ87Z0hHlmfoliQUJ7p89xR5u4yVtctQl64o+rKueEYPblTzeSc+YGZ6Rqa3Ens8XLLa7i3MFnnmG3263bu4sMB+Q0NeKudjhdaUWm46Il4re7OXMZN2xGO/VHN+0tIuCFkoAyUagbiyhnRRQEwnQUeYm3y+GUwhRe9dDH6Bt3e
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(426003)(2616005)(336012)(47076005)(36860700001)(82740400003)(83380400001)(7696005)(478600001)(186003)(26005)(110136005)(6666004)(1076003)(107886003)(40480700001)(5660300002)(40460700003)(36756003)(4326008)(2906002)(41300700001)(8676002)(356005)(7636003)(70206006)(7416002)(86362001)(70586007)(8936002)(921005)(82310400005)(316002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:18:52.3869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac2d335-46fd-4aa9-88de-08db36c2fe8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5024
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

The V5 patch series:
- Reflect review comments for the patch
"dt-bindings: timestamp: Add nvidia,gpio-controller"
- Documentation changes including renaming of the file

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

 .../timestamp/nvidia,tegra194-hte.yaml        |  76 +++++++-
 Documentation/driver-api/hte/index.rst        |   2 +-
 .../hte/{tegra194-hte.rst => tegra-hte.rst}   |  33 ++--
 MAINTAINERS                                   |   3 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  17 ++
 drivers/gpio/gpio-tegra186.c                  |   1 +
 drivers/hte/hte-tegra194-test.c               |   2 +-
 drivers/hte/hte-tegra194.c                    | 167 ++++++++++++++++--
 8 files changed, 262 insertions(+), 39 deletions(-)
 rename Documentation/driver-api/hte/{tegra194-hte.rst => tegra-hte.rst} (50%)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.17.1

