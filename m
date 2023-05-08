Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E2F6FAFCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjEHMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjEHMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:21:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9F324017;
        Mon,  8 May 2023 05:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9HbNINB2IGGDOTTZdC9uLU6mhOQts77G9eHTXOhR13NVwr9yIW4H6lD8p8OmQHAm+arfi3rYH7WpLs9AtKXVGPsr45P/w/8TV2VGg8x12wgHSJvdWPhYeZ7DTnF+gdJ46PCyyMJkobCH0W4Kvrd/GqyeyFRXpEru1pZLaf2G72JpD0pn+MFkvBqjVuQ1RfKwep7qle1MQqUqB7eDTUXQUI6ugQIUw3K+2OFzprK8BkVCQchfL1eHKEX0ZhGugm/6ge7Zih+RKF+u264F4FekMSvll4fpu2BqrAdOC1m/sNxsypY/L8lIvQIvdQf3WPdca7Yb+qhKxu8Ldasc9kf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiGajE/tyfNw2Gj6cNmKQrOCU2LeRVZNZiFrmxuz8z0=;
 b=K8PAXiJxG1Adoidtwg7SRXFqoxqIO11xiDF3pfb9Pjm9I0k/ky2cJK7PluhMSSHKk0A+mY454VD8cA9mRVNh+mFjOC3cop82fct/ALGeQatKwSeqTDjtblZbxy/D5s4OxmOfAOKVw9chb7JCfI3pWVXWYTP6lwH55WcGZiu98O9V9MlHYxNGkcuZXjjr05zXMb9ECQueCHm4FNOLV/Qd9i3I8yI1HBF8hYPu27BwINyx01TJyYZtZTBFalUPrrc0tIRejpdimRpNwW3gfAjoA1udZrNxrV0PjXx9kjKjMhcG6NDew4sKVxT6nXRMcwUUW2Y8RdiCB5PYFl7BgS2sdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiGajE/tyfNw2Gj6cNmKQrOCU2LeRVZNZiFrmxuz8z0=;
 b=oDga4qUSsKVO+y0kYIgWTwH3sMhTNSvzvmCjR4E6FpLdULwPcKoMKlfMmGWqDzjTh1j6pwdRur9OdXYdcAwxaZqQw8KJgwYoj6UgfXThlLBtIADxnCn2GTUJ8Idkelu8DlmWL9HIh5mmxyvVwcmZWbMrY/h5n+n266v/pju2v89y80oUs5WHJqIIIKgoWi10iNtcaA8v7XHBv8oXtY4Jmr5g31qs3nCrTH5/9k9UD8wjKCPxchwzzFB0dXj23kXzG0Z+N1OVTtCxJ/RrNzVzCCgkNAVWb+ZOOGweIN4/8pYD6Ho8vuJbSRQkYzuezEYnsrdrooNCn8EuvXvZXU6Ygw==
Received: from BLAPR03CA0040.namprd03.prod.outlook.com (2603:10b6:208:32d::15)
 by DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Mon, 8 May 2023 12:21:12 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::74) by BLAPR03CA0040.outlook.office365.com
 (2603:10b6:208:32d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 12:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Mon, 8 May 2023 12:21:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 05:20:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 05:20:57 -0700
Received: from mallet.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 05:20:55 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>, <stefank@nvidia.com>
CC:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: [PATCH 0/5] firmware: tegra: Add MRQ support for Tegra264
Date:   Mon, 8 May 2023 15:20:43 +0300
Message-ID: <20230508122048.99953-1-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|DM8PR12MB5415:EE_
X-MS-Office365-Filtering-Correlation-Id: 38edcc5b-926f-44dd-16a7-08db4fbeb5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Ws6VOzsoFMK6oXuT4Vu4NpbzBlkCU9w8Uk+OHUCOfhyUeCBA2wzmm0R6pLEaxJpiYmljb/fMG7rRD4hk+c09PwzEppc4V1wo1hHoI9mJGeCzCX64VCZFdv+faRVHpoSyLXlmhKL0ZelRW3rIkxgwCogjuYtlLjayvAXhp7zEU1XAxr4DSPrOD3xfIiTKaX0nyUf2m3AJZ1WDcSX/y+tPk6AHwNC9YIE/yEFwygXH9CJ2ybSRYSmsTUGU29QMk/C5yWt6lQu04sB4FfC3GreTV/RuaEs1KZgZ9fXtQG0ZLMrq7xuX+ouSky/GPub3hdfZExIb0E3sJ/7uTeHsFTQ5LqW6snE4s0AjvECsB+PbEzqdEg6QW1Avp0bMUjYvfsXun0+4aZ0r7Ke7jUe3bRSsiPAVaoufjd9UKuRuRNOoP2jyuDNnqU2xamazSTUUg+hRZ8X56ODDIWlXZgxHfy5eRYv80yTk4hD6n4dQRELBj6FPoPl2m4ItT1xSz5zxnM+Dlga04AoeSBFPmglLBvfx8uDL0zrEettL7hfRvLp22UtRpEDaN0N/23xNKcGh0LSkQspzeNjlIvD0bBtAXR54CU6ABwI+8vcYXkqyJuJ9m3AZ1HJpTh3jYJiZChZmnJ12zJnY06j1HGZ09LydLKO/N1nwteS99qfXzmnaWMiXcnCoSxh1xoU6p9YS0F7TJ00SE9uCK/B4uKQYYMe/IoO7g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(1076003)(40480700001)(26005)(7696005)(83380400001)(336012)(426003)(2616005)(36860700001)(47076005)(36756003)(82310400005)(86362001)(7636003)(356005)(82740400003)(186003)(40460700003)(110136005)(478600001)(6636002)(54906003)(2906002)(316002)(41300700001)(8936002)(8676002)(70586007)(5660300002)(4326008)(70206006)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 12:21:11.5448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38edcc5b-926f-44dd-16a7-08db4fbeb5e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
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

Peter De Schrijver (3):
  dt-bindings: mailbox: tegra: Document Tegra264 HSP
  dt-bindings: Add bindings to support DRAM MRQ GSCs
  firmware: tegra: bpmp: Add support for DRAM MRQ GSCs

Stefan Kristiansson (2):
  mailbox: tegra: add support for Tegra264
  soc: tegra: fuse: add support for Tegra264

 .../firmware/nvidia,tegra186-bpmp.yaml        |  69 +++++-
 .../bindings/mailbox/nvidia,tegra186-hsp.yaml |   1 +
 .../nvidia,tegra264-bpmp-shmem.yaml           |  40 ++++
 drivers/firmware/tegra/bpmp-tegra186.c        | 208 +++++++++++++-----
 drivers/firmware/tegra/bpmp.c                 |   4 +-
 drivers/mailbox/tegra-hsp.c                   |  16 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   3 +-
 include/soc/tegra/fuse.h                      |   3 +-
 8 files changed, 275 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

-- 
2.40.0

