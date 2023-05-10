Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9196FDFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbjEJOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbjEJOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:23:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4CB7AAF;
        Wed, 10 May 2023 07:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPEWAORub1ZPXg3tIGXrcRxbvArMEjELNZLPTE8WuepUtmlk3iD887L+dNY+KRTndFUHC2NauDiM8+LYfesdhqdUg22WSvmAz00JcNJPe4KBW82VVkZAe8ZLPH2zv3pzufXwjggK2Is/DVUVKupqgeOf4pw21BWxANBZgAQ3eP2wDWIQqTOZ1hCB60nHXrDDKN4tfHuVzh9Yx4Ed7eMvvkSEFodTro52zlnFjkz5XQw+5sOj/1h+qiPS6DCdPOmV2ARy0E/F0GtV31XuTALpMPHJNU4X0c03VB7ZRacyGMZa/xLOEy7qLCfOpBlOZf4WXvXvHaSVwPmH8LibGK1pUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Feczrr2+uBF6/PORe0BIL4OGJgk2raXwAMu6n/xV8YE=;
 b=GfEO755Zg+ZBo7NdOsgX06mluFPZEobEa4mwQSzcqR2j6PYg3v63yxrQVP13D/OYQikMkuUgmTbpz74HpnjmZIUN+gy1Nv2RXqRT7uOKLdgwezBCt1nSVD85mdeANXNS4+d2+pN1SYq4JZXrIGhUdDsqXdZKxMofa858JGlNl5WLyvyTF5aYy45IEpbhOtRkkbIOoTaYbC+6htAPrBT6bp1Z2fcG9jqquHkcq6A4UggLFseALuJ6pH0KOTNz92z2wdPF7o/m4Q3s4+/tBDwerpLdvH6fL/3NBwekjT0Cskqy8mu1OX48d85ctVJOBTD/0UaTuNTVd22C2QwWV0+JyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Feczrr2+uBF6/PORe0BIL4OGJgk2raXwAMu6n/xV8YE=;
 b=VyfGnKNI3Fl/rWqbKMkQ83XKRqTeNP70XF1bt2oG+UgXgwTOHwFIEt6w+ckv/McS8EhOdnpZH5yqZrrj8kt3wyk0cFXL1OhE82HpFmJfJGycIbaxXQh72bq5OmHG3NLDYDhMP7/OdLwrj/Op1gCWnqewIMMOhubPIlY60iZ5G+oSwQeukWz7Qr6UQlzNmT0NkD19iFFrcEDHcSq6SMEvbNHnJ7PqZwSF5lbKDbzJRIvTEgpeXBD9Vle2Ev9TKdSPVy8Hh9HvX2JekimowiWTPwr2XsiyIzFQ2Tl/Ch6ntIbB0Q5eJPIq2oNrRQDsjSD1RHus5p7b7pFn1p66HXlagQ==
Received: from MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 14:23:08 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::ca) by MW4P220CA0001.outlook.office365.com
 (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 14:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 14:23:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 07:22:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 07:22:57 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 07:22:55 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>, <stefank@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 0/6] firmware: tegra: Add MRQ support for Tegra264.
Date:   Wed, 10 May 2023 17:22:42 +0300
Message-ID: <20230510142248.183629-1-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a50c83-fffb-4e55-f90f-08db516213a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0OLRvm0Zyhx7ngWfHPXyYVTzDBUaCICwi7G7XFIdvYqNcoxV2UFHA5KQCPWvORsStPmwBzJXREsoLrjDiVX+zj2hnzWi+pJNmA8UY2C7m/WDwI0gq4pJr+dj7DevlYuQkTH+UW/+5E33kgr0Br9vN3l+Io7qlQhG1QpgIGmipPtcRkZpcWXafo3EuWI+lJTWwHtM7rEXrkC4le9Y/qR9dLYmm/uAf/NEgXWiKU1zIUaLRwWYi+BeU3fy/moTNPRrDGV3pCwq25X0QGn8AR+KwLARBPLUwa6DrMKtuKZ58LByZ3u7Y2FX0C3RIQQiZ6GNwIZBi8CsoOEExCX05mRVhxu4OwZDBh266aVWotBdg88il2Ax/gRnPnuArFIIX7WFx5yh6oND2TOtJth/GmeZkFQ37+RywCoxDpSj4QCq/T04Lra+J6Jsko9TmGscdB5ez8C+KFk/iPsR302ZGDOni1T5Yp6grMoaWHtjoyUZJJpsZr4MyI2+v0tWnkDYDTynYdAw5YoGz1y9Ig5OI/yVGbGkECMc7nI4iquOZDByTW7cRl7WOluw7i+pnTlxHFwUPOcinNr5JkLT47qAVpuZjM9umz3YV5m5lQ0FKf3YazeFZSVjstEbFTZ7vLZUMNv+vyIqlXO5URsCBkOtj+PH+aBI0tK8QGh39MPs5TXDexUi0h6x2Ow2as6XGMATGfg8RaelIq+E+qoN7+rDBfZAB5PjV+un9dFNVaTsd57GQncTYLu85hJKfvhU432+7Rt
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(54906003)(70586007)(7696005)(356005)(316002)(7636003)(47076005)(36756003)(5660300002)(186003)(6636002)(4326008)(70206006)(82740400003)(2906002)(41300700001)(6666004)(426003)(36860700001)(336012)(86362001)(110136005)(1076003)(26005)(82310400005)(40460700003)(2616005)(8936002)(8676002)(40480700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:23:08.0081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a50c83-fffb-4e55-f90f-08db516213a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
  dt-bindings: Add bindings to support DRAM MRQ GSCs
  dt-bindings: memory-region property for tegra186-bpmp
  firmware: tegra: bpmp: Add support for DRAM MRQ GSCs

Stefan Kristiansson (2):
  mailbox: tegra: add support for Tegra264
  soc: tegra: fuse: add support for Tegra264

Changes in v2:

- Added signoff messages
- Updated bindings to support DRAM MRQ GSCs
- Split out memory-region property for tegra186-bpmp
- Addressed sparse errors in bpmp-tegra186.c

Changes in v3:

- Add #address-cells = <2> and #size-cells = <2> to
  nvidia,tegra264-bpmp-shmem binding example.

 .../firmware/nvidia,tegra186-bpmp.yaml        |  37 ++-
 .../bindings/mailbox/nvidia,tegra186-hsp.yaml |   1 +
 .../nvidia,tegra264-bpmp-shmem.yaml           |  47 ++++
 drivers/firmware/tegra/bpmp-tegra186.c        | 214 ++++++++++++------
 drivers/firmware/tegra/bpmp.c                 |   4 +-
 drivers/mailbox/tegra-hsp.c                   |  16 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   3 +-
 include/soc/tegra/fuse.h                      |   3 +-
 8 files changed, 253 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

-- 
2.34.1

