Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B328743D60
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjF3OW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjF3OWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:22:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6118330DF;
        Fri, 30 Jun 2023 07:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl4Rtm4Wd+QpN3NRxLI0UH7hIX8/VYeJVZIFCgrBQXEmiZxW8mrNKl3d7fNjzqJw8ZTot7Zhw1Xe/10OFUOs8S3uxh/0gKokKkURKkW3Hjhmy5eAxgeoXhbUC/lEG/Bsx0agAyjVwQ8f3kOatYZiic9cwCsSgLq90ajyCbD2OOCqE0DunSZwVBUXm5MxE76p8aZQ4di+u+Z+uEDZdDQNitwiUcD2Y0U0QZF44T9mm4ynIhraE8fvU8aIJhlJYc3I942iuo/jxGhNWTxuyy5ZN+YxO6Lc0yUK+m/ir4xf3mtz/Bx3zZwi0dfZKOWWuwTvteCKNpMEF/c0PY/BiPS/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b6/3GpG30PlTZVAlrUxPDc8takTyZhXdUVzlbrrR7A=;
 b=B6UfsELHm5TwRUfjyeVrqcEhSuE9KGTi9mWmGz4stfX+PEhEC8en2ugruiHEqx+F3nMGX7cnLzEdeUYMZfblNCRBzmWxMi2igIEchdMcN+V1yxwHqkcaWmUEWsJL9kBHboo3RSaLxaMEgl/Ai9OA42sGjzo0i5JhEJwrYMPh/xHZtDYgL+RrO2UCay8HehkzA8Z8seW/rGTmMLBlCNaEz1A1bAVMsw7ACUqrI6488fHaT7WXTNIGPXEbBEimDnKR4c719qg7izWOmUn4Rjje4mQl8BR5r3J4YfeO4HQfEKymTBv8gxy2Vpurfbby80hmkyX1UfQ9iCrrFrH0MyRBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b6/3GpG30PlTZVAlrUxPDc8takTyZhXdUVzlbrrR7A=;
 b=FIFaWct98lQAy5RBBMAHNzg9PVkapiclgw9e8PhwBoJhOB0KAy35SZjyM0lwiv+5WWD0ApigfnoXWs1c33Qkhlc5eRqWRkPZePP8OWLx1UCBiezpgRQMpgJI0sLu8lducmzBJg6OnXGyFs9tCRp5PmZ4M9XxgWiqTh4uV/7i2fA=
Received: from DM6PR07CA0083.namprd07.prod.outlook.com (2603:10b6:5:337::16)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 14:22:41 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::64) by DM6PR07CA0083.outlook.office365.com
 (2603:10b6:5:337::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 14:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 14:22:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 09:22:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 09:22:40 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Fri, 30 Jun 2023 09:22:36 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v4 0/2] mtd: spi-nor: Avoid setting SRWD bit in SR
Date:   Fri, 30 Jun 2023 19:52:31 +0530
Message-ID: <20230630142233.63585-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dba14e-eb7d-4ec6-240b-08db797576f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6R3pDvtpJBRpQ8gAzaQsXLU+1Qv6/mwdQMi9WlXUeck1+KSV7UnbYxnDrEg4ZgH5F1Yl8mywdwyhyhFrVIoViJ6/qkwUBU5oJrrynDDYNbgnRIwP9cswtL/IFDqWU+U2puTGE7md9Hia1Es20Zrj7keQsBePTvPmWJE6tboKGHxpDyO7EBd/tswglXgLRzixua3dXzn3acxcMdaJNDcA2uD8t8+x84S1GFXt0QMu4gmfsEaZvoacbSa09OIVxh5TRUb5srygMe7z6RSWbArz0VGFkjiU/sCSkZ94SympKzcX/i4k2O890ulCth10BbGSMOcUBRlClrbWMmn5uB3sQDcfxqwHZdbIE52eEy+2NgGvQMfQbqLoJOlB6euMhB+AFKdXDA1Z8dOG5SOzNd0QUvgTkjQGSGzcjURF4Cikyh0sq/nfWFq6z/6Go5U/6QQBBvtyeEO5GSjPRUf/x8E2upQMpEVradLyqfChEaYCMOAOmeEO82aWOYyoPnVnaFdH7mlw8gFA2SWuJQ/vmDx9jY1kKKKAJVBT+67oQc0PRlLKnPC9LbnegHZ8qJQq2i1oHOEKxUolbyiSqIpJwPQ15TQE6eUL+UKxh6QFgMPGSdbhG8sebxqE4I3OSl25+f0NIt0b6Hp39wa3pgXa5yuCg/H67RQmd3/Gq70cznLM3CrpvDSHJza3dBEh2u/PFWOPyGhd8E3mo6mcLiVi/ZSxmRIXSwqf6uLH1nnZA+JpQvTk3fJ4LFVYxDDFXJraPgGBAUV9mWw0+6Dok0wknIVOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(336012)(426003)(47076005)(40460700003)(83380400001)(2616005)(2906002)(81166007)(356005)(82740400003)(36860700001)(40480700001)(36756003)(8936002)(8676002)(82310400005)(110136005)(5660300002)(86362001)(54906003)(41300700001)(4326008)(70206006)(70586007)(6666004)(316002)(478600001)(186003)(1076003)(7416002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 14:22:41.6056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dba14e-eb7d-4ec6-240b-08db797576f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the status register write disable (SRWD) bit in the status
register (SR) with WP# signal of the flash not connected or wrongly tied to
GND (that includes internal pull-downs), will configure the SR permanently 
as read-only. To avoid this a boolean type DT property "no-wp" is 
introduced. If this property is defined, the spi-nor doesn't set the SRWD 
bit in SR while performing flash protection operation.
---
BRANCH: for-next

Changes in v4:
- Added SNOR_F_NO_WP flag info in debugfs.c file.
- Updated comments in swp.c file. 
- Added Reviewed-by tags in 1/2.

Changes in v3:
- Updated DT property name to "no-wp".
- Removed Reviewed-by tag from 1/2 as the DT property name has changed.
- Updated spi-nor flag name to SNOR_F_NO_WP.
- Updated DT property description.
- Updated patch description.
- Updated comments in swp.c file.
- Replaced WP with WP# in patch descriptions, comments & DT property 
  description.

Changes in v2:
- Modified DT property description to add information about a
  valid use case.
- Added Reviewed-by tag in 1/2.
- Updated comment description in 2/2.
---
Amit Kumar Mahapatra (2):
  dt-bindings: mtd: jedec, spi-nor: Add DT property to avoid setting
    SRWD bit in status register
  mtd: spi-nor: Avoid setting SRWD bit in SR if WP# signal not connected

 .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
 drivers/mtd/spi-nor/core.c                        |  3 +++
 drivers/mtd/spi-nor/core.h                        |  1 +
 drivers/mtd/spi-nor/debugfs.c                     |  1 +
 drivers/mtd/spi-nor/swp.c                         |  9 +++++++--
 5 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.17.1

