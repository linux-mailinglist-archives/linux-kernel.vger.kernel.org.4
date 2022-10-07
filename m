Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60E65F7681
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJGJwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJGJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:51:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82404CF85E;
        Fri,  7 Oct 2022 02:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr52aEIryugCWCTJyQjbs1kTiU6KluArZIorrHaZlAqsnkcVV5CRxCWpPGfd29LFNKg90vmOZ44EknaNW1AUl+9KV763dfyz4aNmyvYiqnuo2FqqfrDcLJly+/s7remJJdyDM0SlR3xdFDOg6JREO7dWTboDzvmzhKZhUeEWhq1jYvaTm8HHAyrxVZSjo89JFFIGvjF0xf3rrEO2nr5rLfiaXMplLGdzeG4mtgUhXroSg7TC3dh67ln3icFHouOp+2ZRQDlRi9P7Bdy0rhgUltwBqaltbnmXYR71c/EdX5RE/UsCYeD4a14rg3gFCKZ80aEDDf9XVKDlTbTd5+SJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obEyzbemWDE/oImirQ0oefqnwYB4OLKPCLq7DM35DaI=;
 b=igwvlL/UHkIUWLxqUQhedA59LxlsEnl40pT14NktICHzVxaKC7xmyOnINWWjLi2hOeeZwICOLPEYArG8xJjnBvRX4sEqfaX3Ijpoc9itHUZYU/cDnG7FQ1Fpn04dPAnLkVHjZcpqQxHT14sq9PyIeabIC1sgfL6Qw4bxG8kIwswqMJSPCRpdWtnFfoiQ7vog+4W/xRwOBiRQp6YoCuCkzvRPz/XN1o/xoVck7dHkAo9vWurZJOGld738KpAN5/7aiWik/4/Ibzmvjf9Bf0ezV9/7UiDxQWx/901NugYwVsSEVm122gYOv/8pKPu/q9SqN4BbWw0uQyg8Pq+szTNuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obEyzbemWDE/oImirQ0oefqnwYB4OLKPCLq7DM35DaI=;
 b=g1KmVKzhMTPZOeg56hgsocDiNbKC3CSR8FrTCyXS6mB2zKH8stJU7bQ1p84kyoKeAz0p2xwhz8bn95OgBnj0Mhcr1daK92UjJekbV70jxtdIpCqYlALTZerzNtNPtI6PgmYhPTiRQ1azb5bNFzPNBg3lsQQqn9qFfGO/wt+aMmGUpWI45VjKj6UswAMA67q/R1gRroAWm+GdNyYfJ0FBJOZrB6mlGnPL+3w3z75LI6pWeOn4qAL8uMWOusJX0e98kYKJk9SuxPDW5gKsmokJOGtbJ7uaCSLqhRbu6Ia2ztT2Qw/g5c+2de7x2ur0IHESY4dTcJbMPFlB3nCqG/wALg==
Received: from BN9PR03CA0626.namprd03.prod.outlook.com (2603:10b6:408:106::31)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Fri, 7 Oct
 2022 09:51:17 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::87) by BN9PR03CA0626.outlook.office365.com
 (2603:10b6:408:106::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30 via Frontend
 Transport; Fri, 7 Oct 2022 09:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 09:51:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 7 Oct 2022
 02:51:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 7 Oct 2022 02:51:12 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 7 Oct 2022 02:51:09 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <kkartik@nvidia.com>, <windhl@126.com>,
        <ndesaulniers@google.com>, <nathan@kernel.org>,
        <skamble@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Tegra Fuse Nvmem Interface Update
Date:   Fri, 7 Oct 2022 15:21:05 +0530
Message-ID: <1665136268-29494-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: baa5f013-ec8c-4f98-1bba-08daa8497a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JomBCwpyFfdsm+iZTjMwJgQCaEv4lDXNnicIA/MDy1h/uPjK5OAdqEGm1zAdS2w0tE/1sQtnJUqBclQa1LW5d74sf5hKBkrXgNrNMQkGdj6TVnufuIbafkPpw/S6b5K7zfoK0YX9fzUYPAUTz6YlYWhN7jzbMm8csG7cEFt9DRDyjAftfI6ctbNGZGaW1HCraWCtVbBrRI3MD7grlUPZbyCV8hE4dLNx9Hl6kh//gEUAYr21R8eCuwSsa4ByIJdvqc20HMYnW8CFfNbHQPyiCZO41P/fy8S//sErJJQ17rgLoyw5kChghsXfgTzuZ1rBKuw0KI0gl5y2f3fHNsYCXCudVLRh6Wb/EeCx4o/SH1gPcq9ikiImSNhsPhopLBFpKT16aPkKJ4Bs+ANU6hMH4Zz14sanB8R4kKM0W3yHNjtz3NNk0DKGv3zwDUefyCwOOtd6i6AOhQMZuKxgvq3jIrrO1uNnuyp0psx9EOdbTz8arZr+WCoxV9X58xcmOmhPn8eVT63brWk1ZtnD/hAmr/BtVguNhKPWMKSxuozz4zPGog6PMjm3wQBxEG6Hki6iSHXiT5VGzN5/LPW1EuSb3DHuDoDpAdz3BNKMc//mqLuYgoNJJ3WuKeSkjZSUWFYC4iSYgzY2qcu8CgZSmvIjiY7dWtBHiC2bGwxv5VwT/hBf2MPwsd0Cu2c0b4ZpqdpaQkdAwCnuuHeh8s5x65uXUUq7KE1XVMD0biHkXJkIwoU9UjTiPaVy+EYDPdlpktXKokWK1zOJUDbyEI63EPMK0CBsjcnSnWP8AXxF5RHMzc1mFRyB+Q7eb+WHAzD/UJBBbFPzKswUvRTL9CgH7M52zA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(82310400005)(8936002)(41300700001)(2906002)(2616005)(426003)(356005)(5660300002)(478600001)(70206006)(7636003)(921005)(6666004)(15650500001)(70586007)(47076005)(36860700001)(4744005)(36756003)(110136005)(82740400003)(336012)(83380400001)(40460700003)(186003)(26005)(316002)(86362001)(8676002)(7696005)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 09:51:16.6764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa5f013-ec8c-4f98-1bba-08daa8497a94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches make various enhancements and updates to Tegra
Fuse nvmem interface, that includes:
 1. Using per SOC nvmem cells. As, tegra fuse availability and size
    can vary from once SOC to another.
 2. Fixes an issue with nvmem binary interface which could result in RAS
    errors.
 3. Add opt-dla-disable nvmem cell for Tegra234 SOC, this is used by
    Tegra Deep Learning Accelerator driver to correctly identify internal
    and production boards.

NOTE: Patch "soc/tegra: fuse: use soc specific nvmem cells" had already
been sent out for review. Please ignore the previous patch.

Kartik (3):
  soc/tegra: fuse: use soc specific nvmem cells
  soc/tegra: fuse: add fuse nvmem keepout list
  soc/tegra: fuse: add opt-dla-disable nvmem cell

 drivers/soc/tegra/fuse/fuse-tegra.c   | 112 +---------
 drivers/soc/tegra/fuse/fuse-tegra30.c | 294 +++++++++++++++++++++++++-
 drivers/soc/tegra/fuse/fuse.h         |   4 +
 3 files changed, 299 insertions(+), 111 deletions(-)

-- 
2.17.1

