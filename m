Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15BF6E1944
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDNApW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDNApM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:12 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02hn2227.outbound.protection.outlook.com [52.100.158.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390726B6;
        Thu, 13 Apr 2023 17:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5x3rH9NeLocugEPPPJqmIkIrP81i6Ml7Kd2HG7eoIU5nUw2kfogx+91d0Oau2aVAH4FCwbnDhXaTTTM8y2M+ElK6vR2s0ww0fcljD5ouHIvnBKQWHanPNvyBONCC75mukBcp7+M22ObFHgqVkZwrFr/pND2S6duP9rEH0DExoHupWGsFTy7P+YrzEiXtxTEinfikpZ9L/FBxL/4HQDddRK4xo9J05zP4PCsH1IxNDzSgdRqrUjnzARdtiz8S+MsbWe1bZob7nNW18japA4x0MgoEPcfdv4IbfOwzaZEEsT8Yvw7tukIkjRdrOYVV06NNNEtTwSwAKlrmotHS7JhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omwkqvUwEyAzx4/hKV/H5bIpSRNXRePI6OnY2pwvpjM=;
 b=iex74tR296KolFcwL276xh9qp+KVgJjh8hZGptOgmL7xNB8uzmOFyj32vGLAD2cBF2GCw6sLYppddw7Ba9Nv3wGooj33xZnlZqBVSog35iBKTbjgLgAdDA8+GXC27i5LEaFRVkhfj061PZuR10OqWesjptJBJNHlH3qEYZgm/35lOvtjt4RjmRPae+bCPGBorjeErTkpFOZdXInJyDHpBsY98BLoXLS8dF6Btu3YVnM77aX03dIdAaRLQCKvsQxr5KHFH2jC0o+MU3LhpRe6ngkAEUvZANv3ZpVVMNa1r1j/wKMCkK7mcO7Ae23mhJkXGRW4yNvkg4V4z5usQd0sdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omwkqvUwEyAzx4/hKV/H5bIpSRNXRePI6OnY2pwvpjM=;
 b=T37mkAF1iA8Qwmoi4tdRXs2LJtcqqTboJ//rxU/nND+dQ00pAimvxtmjtMrYIyWvZopT76hBz/j4mnrBSPOCiHOEwjRLYbrT3iWPQ6V8BdXDQOXQS5F7PVxZZveFBx3sfiDs+4mI3/3K4gdFR7CaVpCXcNAKG5qnwYOHqgvrOYgVKq1jOFBiQk0+tKCtaLObLBtZKPGevjVukJT/ZDC5QTccONCLDzcwa774lPe1oIkNqATAtU6x11oxVPkAWIL8p1IB2UC40lGk4IZUVshu8tgwwqRgc1PGIV3YMpwgmc5TS5swHqiuuzWZy/2qn5B58DOF5vvJZEmaPmvfCsiVYg==
Received: from MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 14 Apr
 2023 00:45:04 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::7f) by MW4PR04CA0138.outlook.office365.com
 (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 00:45:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:44:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:44:57 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:44:57 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 0/9] Add Tegra234 HTE support
Date:   Thu, 13 Apr 2023 17:44:46 -0700
Message-ID: <20230414004455.19275-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: af9d6247-5865-4074-4e09-08db3c817c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrpCHDn7HYDJEtfsZEkm2Gde2MIhZoTib3XskT61w9nmeOCrWzrqlyorrUIUixRGyZV9Q9/vMNuWM9ul3gghC+dKOblqLFOoqivV7fE3F7QHGqM7xIvIfQdVafn9Ge7rMlWwJAmzmMFZU39ANI2Y2LqFHyjYh0+ENaLSP2x2qE6iPuvC6xP0rdUQlHRgNtVZu+7CmiHKySThTkBvHUkY+Z6pg/9U48by5h6yM7G6GZfz3Jp9yuxY9yCsdCd08GpK03aG+//oduNOgxUbT7Pd2GxTQn00is17TGTN2mdnYyOTN7CFa3/jch7qXWriliDXbdyJrqrpYcmWIm0CGNQtyBnEZsJ6qdri70MQmTI3X/RNs0v0u03eG2ECxE8OFM9rjQC76kZP4Fi5Csdi6U1HGXL0QyzIUydqvbutG4WWmpIVH1n+2DJF/60FPVmoTg6lLeKuGsZRuPtQUadsct61Bm5HlyDAKc2PKQIeRJNp1G+1kUj94AWgiG10M7ZVlk5VUDU2nikVYdqnPvL2l8rj7T0tFdbafJ7C17Y6Nm/xg3q2V5EtiiUCEZtbFfnI9MgDp9Mg1dquYdfRIDAxz6D5Ms+gZWjiG5fp64o9sM8M+YJ3yahWt7OwF6sRDyluBi6i2Dya86egRdfTOCRIwKx934LFN1jOVRfXdeYHz1Do2sIDhcN+Q7sNLyXmxeIbZJYyHmYu3AocFp9YqTEUAnrmaLKvhDSVSrzP3N/Oyq+vHkM0/Fr01qd3A0/1cbooROguBVGf4Dz4mGYlCc6ktzglvmlo1wmgfP9vuhe8HSKcOmfEcj7Uzf5LG5r3+dpf979TS8drqNKi+oRKf8fYASIJzUanO1EhsxZARTtRe1vdf2B+wRUkBUS98+0QTsjdzvVI
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(5400799015)(36840700001)(40470700004)(46966006)(1076003)(26005)(34020700004)(921005)(186003)(40460700003)(4326008)(7636003)(478600001)(316002)(70206006)(110136005)(36860700001)(5660300002)(36756003)(8936002)(7696005)(86362001)(7416002)(41300700001)(82740400003)(356005)(8676002)(70586007)(82310400005)(40480700001)(2906002)(6666004)(107886003)(336012)(83380400001)(426003)(2616005)(47076005)(83996005)(2101003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:04.1382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9d6247-5865-4074-4e09-08db3c817c9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

The V6 patch series:
- Merges patch
"dt-bindings: timestamp: Add nvidia,gpio-controller" with the patch
"dt-bindings: timestamp: Add Tegra234 support"

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

 .../timestamp/nvidia,tegra194-hte.yaml        |  66 ++++++-
 Documentation/driver-api/hte/index.rst        |   2 +-
 .../hte/{tegra194-hte.rst => tegra-hte.rst}   |  33 ++--
 MAINTAINERS                                   |   3 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  17 ++
 drivers/gpio/gpio-tegra186.c                  |   1 +
 drivers/hte/hte-tegra194-test.c               |   2 +-
 drivers/hte/hte-tegra194.c                    | 167 ++++++++++++++++--
 8 files changed, 252 insertions(+), 39 deletions(-)
 rename Documentation/driver-api/hte/{tegra194-hte.rst => tegra-hte.rst} (50%)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.17.1

