Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DEA714B30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjE2N4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjE2N4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:56:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34151AB;
        Mon, 29 May 2023 06:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkoFD6SokLDzL1TaV68kFFvUCuqg/DdGxb7c/e+WMzgggcfl/8OORXu/2EKyHFxdT6gPyJprtFY81ScflAMCfPQfNI79HofR1nuM3i2IytQYmbPhjYb6e1a3RBL4safMx+GZoaTp2w0CM2EM06xHErW1trwwfGJI6teHXVCImEJLk9CVwUwOpq6UOG3dGjgDT46k+pd7FCJFpUsRHiMXFr2U2ssWH0WKG1Q0T7f7pMec3hT1JLK1VBudPunldvICDlVHHVZuMg0wuj7Y8hZqnHGINAimKVUxDISNRQYu25VKwUsaO61YTL8oOnZYbDFQCyiPPMsmiXfAxpdL5gLY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9gtc2VhbWCIZy47243+8XCQwEjfXDrJuuOv8yLB//4=;
 b=JswYpQqeBmvM3Muu4NKe3wysRlWxS5w+RMcHg0d+uCZMUFSRIRVGK2ug7VVDlHF2tCAU7VRVShO/BF+swAlrTsRR6ILRbBsa4NuA2NTguQ/aqwveEDLOC+yD+A38pq6thcMWFalu+rUitJ5e3lf5LEKpaZ7I/xlmvOn183hNF/BRMRnpuVF9iBLx3miYNLR1KkL72W09eVu4hiPfUDMKWozmbI4IzIHVMReyEAY7cyT1pJLKnghKFxv7AXf0WAXpUbt4SGZB7bwo/3wpl2DTU5a/2Xk018RQxgepfsaUbzsiBNdOo1tzPp8eHtIvMbaD3/y3+wg+pcJsgpqDs/WpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9gtc2VhbWCIZy47243+8XCQwEjfXDrJuuOv8yLB//4=;
 b=BUDd7KSQL575s5w09YzT5yOcnPfzRIQU5vWQzbxDHqCHe6KtJbquS1kz6vIu+dyN1+uvLRJBI72p4gFPQpR7FeK2MpUNIW9lYkCyLz5ZZ889/8vWzrJUmEsetMgDAFU+AI+G1yjQqZwqdfoIqw55Xjhkc/Ap1UKqSmq+VBwvGEMyh/QtEu6xm18hWQXNWD4Jl8CIR94oi4hk/5JcxZGYO5PNQXaUlv0GH740EAQLOHRqYK2vOwW8EsWarDVpuhRSrb7ISLfa5I1+IlQ4xs4WlE2f7EeNbCCsOHJpWUpui525RPDzpglX1EZKSqpGJ6pdE6+yGmkxO7ilSMp/LuRAzA==
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 13:54:50 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::42) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22 via Frontend
 Transport; Mon, 29 May 2023 13:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 13:54:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 29 May 2023
 06:54:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 29 May
 2023 06:54:34 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 29 May 2023 06:54:31 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>, <stefank@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v5 0/5] firmware: tegra: Add MRQ support for Tegra264.
Date:   Mon, 29 May 2023 16:50:40 +0300
Message-ID: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|MW3PR12MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b435e42-bf1a-49ba-6b18-08db604c455f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQRlKAzKXaBMpM8FuVcnpG6x6ukJ2sGVu34pGP1BkHc3qlpeVbOcUMHqzaKNOYF720Ishw03Vp+Zl4xp8igYKysWLt2m0QFlGdiQ3XrXTGvo/q4oClKoucHoKJmtRjFTPH1Ccq4mCADH/3R2JH6qH5SoFgy62YsxrGvLkLw2832hCn6fivDbDtGwhEKnPue/2Xh4c1rud1TZcGFTI2eJx7us4rsso74/ltFCFnPDdi3+5q2wfkkht1ST3RPa7bvZH3saRtCsyf6vxKJ+Qfx1MpUvMCJO3hzO61PpWpcp7Pe+7TBul3cVMokJ1UMA4cF/2wAZEQUmWIFoHW/jBeuyWWStIiUYQ+RzGpkq0S2S0MWW9n7E/uIhJqKlKuf9TP4RJGvUlGDq/c5UZHgvudIGyK4765vLDOZdUURb9KynpDKczgiJ/gCOePmks5EBmij/V43tky5M5IZsyZRc075prh1CPHiSJB8ql+8tTp5Ui4HDwwwUk2O9o60hbb7QvQNB115Oi+fbzmiWp41Nf4qu/iM5ZHtXlTCvNtm6ZW8Fh7aVk1qmeJLXalRya0NJZyBtyJ8+mEV8XMHL9Ow39wFcj+9U/q3rIMGX4+mCCPnm02htBMp7J7rlVJ7k1orpyKhzISDY62hDD5RGI/LEY3RGd0s/SqLRygSEKrvbkbla6Em4SiGSmdUD77H9lzz3r39qQzCmqzvbEmyd2uM2lgVEajKh+UFT+sETLDzzKtgcBmhUvY5H2ocHUO7JBkFBttsb
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(186003)(2906002)(2616005)(54906003)(110136005)(426003)(336012)(478600001)(26005)(1076003)(47076005)(83380400001)(36860700001)(40460700003)(86362001)(7696005)(356005)(7636003)(8676002)(82740400003)(41300700001)(8936002)(40480700001)(5660300002)(6666004)(70586007)(70206006)(316002)(82310400005)(36756003)(4326008)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 13:54:49.9157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b435e42-bf1a-49ba-6b18-08db604c455f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Changes in v5:

- Small formatting fixes in patch 2 and 3.
- Add a comment to patch 6 to clarify the purpose of the enum.

Peter De Schrijver (4):
  dt-bindings: mailbox: tegra: Document Tegra264 HSP
  dt-bindings: reserved-memory: Add support for DRAM MRQ GSCs
  dt-bindings: firmware: Add support for tegra186-bpmp DRAM MRQ GSCs
  firmware: tegra: bpmp: Add support for DRAM MRQ GSCs

Stefan Kristiansson (1):
  mailbox: tegra: add support for Tegra264

 .../firmware/nvidia,tegra186-bpmp.yaml        |  39 ++-
 .../bindings/mailbox/nvidia,tegra186-hsp.yaml |   1 +
 .../nvidia,tegra264-bpmp-shmem.yaml           |  47 ++++
 drivers/firmware/tegra/bpmp-tegra186.c        | 232 +++++++++++++-----
 drivers/firmware/tegra/bpmp.c                 |   4 +-
 drivers/mailbox/tegra-hsp.c                   |  16 +-
 6 files changed, 264 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

-- 
2.34.1

