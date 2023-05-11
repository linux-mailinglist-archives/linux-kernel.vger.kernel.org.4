Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F01D6FF2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbjEKNXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbjEKNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:23:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0581E1156E;
        Thu, 11 May 2023 06:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0Pn5xbm+13b3G81eBijLbb8eeA/2qclvMC+u5bJT+0vZ33F/dNzdUgAKNym7POaD4X2f8pIi/3+cn04Tf98LARhpiyqKLXsRr8CnvFRtNwrYlkPNXE1VtmflnpASP/mD/nsVkibcBfDHfaFcTdZ0K+9imQOY4BX5ntwPR23T57zz7+libFMkig82TIEnBWIsAqNUTbo7xCwmF4FEZlH2/rzGW9CmP5qRHg9DB670ZpuR9V1nrTTOhLEZbhp5jqH1TDRBLaW3v1OUYZlpLNGihIKsAduc8kF4AtkZsSz6k+XtPJ5tWRMO58QTv1y4grWugyCzYx5/yCQCzWqul4ckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfhl/x456Z0+bof5Xjz+ifSeihLynjC5Ax7DJkb+6Jw=;
 b=Dxhn8HBlbpzw/UFkyeou8RIJjEKUBJIJ+qgRpIBZXKwzWPJVkJgSGR6ZyPSJCOwhXdrKbJfnxoVPhPFji807za+GGerpHY2lyzHpzZFFkP36QGO/4mgKQTPiN8iFDITjV3K+g+q0ypvHy02U4ilwsPTHViuYzew++J6wgrWEzsIKA4wbhFboRd6EqneYIWDhHv1ysYdITnsffdASlX2OC0ZWu+XMYyQsllEGhw1PuKwq36Ulah4Qht/eu2LkZqfMGlnG22w9R/1YjIcnLusbtxOR702IJt4dnA4v+VoVY758+kQG7nuPWc5M5fP6c085F9KEvkles9B9j0p+RWXRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfhl/x456Z0+bof5Xjz+ifSeihLynjC5Ax7DJkb+6Jw=;
 b=BHB1Je1PhoFyWWljWBDcs7xgwETwW9EtZjsMFhTeabKvhk7T7CGWMtSERBXv68JGz014l83oJhLXgJU47cl700W/MOGlhW7DH0ai4wbimZsJA3qfjIde6XcJGiR5eh29/CvfM/DPs/As67LsGvB8Su4zu64oavrAd/gb0RZDPnfbNcuwkBF0Y2sSgYVdF4E0MsiKLfTNcpXxaA1r2wWlRGVAst+PVb3elexVjZv4ZVwTt/NPPS13P9fNvYRe8IdEeWLlsF/j6tnV62FrLaZ/S76C8wy+BHePpyMjXJgbEVR4cQ51J0mMOApxQVmzGsHsgB0zKunBOfToL9icm2Hs5w==
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 13:21:10 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:217:cafe::26) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Thu, 11 May 2023 13:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 13:21:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 06:20:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 06:20:57 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 06:20:55 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>, <stefank@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <krzysztof.kozlowski@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v4 0/6] firmware: tegra: Add MRQ support for Tegra264.
Date:   Thu, 11 May 2023 16:20:42 +0300
Message-ID: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3cae5f-3f13-4d34-8d89-08db52229609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bo6Ed0h9dqlre57cHTD/b5SlrrImOTnJmwumgjLUY3pVvY8yfBNv/uSojQzPwhgaZO3LiME3hvtG+0ysYatZTvpiZBSSq+XehKke+DM9X2V7K8j8LgyQmKJC99rWcgg+K7bEBvo8G2ZvoLXO9Fr1dknAJ4NqBSi61StI0+UiefmJCSWXcgD5wQi+ukq300LtZWKAv6dz3mTlLzs6fwp2uI2ami1qNg++VgylJfy30ZRaZFUhfmc43M4Z57q5VO0AdY7+PuccV447EjmzsEIBQ8hANbLEBioIx/KWxH2ZUk/XMMt6jwz9dgD3a5a3nTGY0qdo0kNfgjYvBlrxpREo77AYD0+glSVJv/UUXZAvm3m+HRaJ7aVhpiTMeY++iA+vzxctm2MvIF1mls3e+mXolrVj9aFnmFhABpQ51ihtosBbWyU4r02QoNxWgFEgMyEV3M+WCLjh/QEJ713xCoQIasu3X4wIErZz5n0d0hI8YN3Hmqh3xHoZ7/NTxNXH6Le60VNmiCVvdt3vMO5vMtKVuGzONL71xIcVPveVB33zKqk5gCUrtNZYYzq0bULp94u075cDesOrXHtYgSncvDrLFv0iR8A0EfnGrQPG/jus5OVTVsjcitxSMmFbmp9SlgUQYttHrz6m2/XktkmaUgIKCgcdjPOnChb4c9gZ40aDPcl5Br/MgBshUxFLz+HYhcN9DYQ06Kel2w1PxLHmBfWuGPuugv9DcWu+FZaL12qspsgHwnsP64xXdQpsiNVto0Q7
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(110136005)(54906003)(6636002)(70586007)(4326008)(86362001)(316002)(82310400005)(478600001)(70206006)(36756003)(40460700003)(2906002)(2616005)(83380400001)(336012)(186003)(7696005)(426003)(40480700001)(6666004)(36860700001)(26005)(41300700001)(356005)(7636003)(82740400003)(8936002)(1076003)(8676002)(5660300002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:21:10.1225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3cae5f-3f13-4d34-8d89-08db52229609
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Tegra264 the carveouts (GSCs) used to communicate between BPMP and
CPU-NS may reside in DRAM. The location will be signalled using reserved
memory node in DT. Additionally some minor updates to the HSP driver are
done to support the new chip.

Peter De Schrijver (4):
  dt-bindings: mailbox: tegra: Document Tegra264 HSP
  dt-bindings: Add support for DRAM MRQ GSCs
  dt-bindings: Add support for tegra186-bpmp DRAM MRQ GSCs
  firmware: tegra: bpmp: Add support for DRAM MRQ GSCs

Stefan Kristiansson (2):
  mailbox: tegra: add support for Tegra264
  soc/tegra: fuse: Add support for Tegra264

Changes in v2:

- Added signoff messages
- Updated bindings to support DRAM MRQ GSCs
- Split out memory-region property for tegra186-bpmp into its own patch
- Addressed sparse errors in bpmp-tegra186.c

Changes in v3:

- Added #address-cells = <2> and #size-cells = <2> to
  nvidia,tegra264-bpmp-shmem binding example.

Changes in v4:

- Added lost Acked-by tags to patch 1 and 2.
- Updated topic for patch 3 to 'soc/tegra: fuse:'.
- Updated topic for patch 4 to 'dt-bindings: Add support for DRAM MRQ GSCs'.
- Updated topic for patch 5 to 'dt-bindings: Add support for tegra186-bpmp DRAM MRQ GSCs'.
- Removed unneeded include statements in patch 6.
- Renamed some functions in patch 6 for more consistent naming.
- Improved handling of void * vs void __iomem * in patch6 .

 .../firmware/nvidia,tegra186-bpmp.yaml        |  37 ++-
 .../bindings/mailbox/nvidia,tegra186-hsp.yaml |   1 +
 .../nvidia,tegra264-bpmp-shmem.yaml           |  47 ++++
 drivers/firmware/tegra/bpmp-tegra186.c        | 232 +++++++++++++-----
 drivers/firmware/tegra/bpmp.c                 |   4 +-
 drivers/mailbox/tegra-hsp.c                   |  16 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   3 +-
 include/soc/tegra/fuse.h                      |   3 +-
 8 files changed, 268 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

-- 
2.34.1

