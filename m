Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C95F4F22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJEFAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJEFAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:00:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC51B4151A;
        Tue,  4 Oct 2022 22:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBlB8v8MvB2OLvCJFck/ubtBzNA6/0qFSv4xa5ClYvnGm+papciHxd5X8UHVjzbzPCy5EXP5j9WM8KZ0KsIgA9CzkbTOFrdchDmRXqr8EPzSxNVFPWiy8nWPx4uuaRmUnbw9TuEBAa6mkqZYtVa/eCCzfjuECHuE8ZOT03vgF36iyJW27ghhO/PQkapiBa3giMmXpAEj6eYBOEbBLz36iYXVaG4SCSWaeB3/Vy25hj2JXjmq7T7SQqXDJdv/JQz9Swz+61cY+EoyOpHcpQHRUmVFROMT6m7vvrSKh7rzNjA+2dQ0ratKwjpojKFMh1fJD8MWb3h51PhjLGcGmTlyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWZ4g3Nzks+DPTWYEhUVlBTxMG/yhcQVZgaKGwSjVSU=;
 b=ita31/RY7VUxXtLCNQjBHO6RFAV3YhzDi6p3OL3hZrgvj3CKaapxqfDd4qovNCU2c0xQLucRFRPIUkHIjBWWER/HmuxJfxQifM7T7A2g2nAwX+QgvDpeR/2g2EH/9mAtHGBoKiz+pCl1ZbaAqboqNbQRq+a+GcGfxJtHIxWJDWDT9w041Vjn+lylHvz3Y0RvRI9kVJhY6Lu6OuVYfm+DWkdNIO7teQ0WiJuALGG98XrxmqtMy1YL3Lb+vbX1J9ygRq/rF0WyTs2KNGugECtTbnKNZDcpItSK4lBtvHQF0vV9zp/h0wMsqP8ATwlZoCLJuWICV8xlZJXQg7jJvKICZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWZ4g3Nzks+DPTWYEhUVlBTxMG/yhcQVZgaKGwSjVSU=;
 b=qJ0UABMCrjBdzxFxWl5oQ1vZugaeuDXk7NHC5riWblK5lUeqxkM9OQlLf95c5YKyQxO3PNrBYMDZYK4Z3sGxi56FMqb+pQ2HGjJXHL7sueTaT44HI/oYMCoP1v0Nh9v3d8gDSfl1VsF4v28bAXtpodbjuh91kqHVVxeCbKQ3gN2N5pZIFU2nrp6mS17GjX2bAaCcVybPSkHqMVVN4RO0Jt6bdIh/SEOPTHPVhxdoYDfLKGAOJiEnYuWDimW4gxoARsdWh5nS4HKcWBcfemauUfHtbWYdLmvYmP/FygCZssl9iogwkCFVgvqqgrTWPPP2S58fErlYRDQ1gL55HWKgLA==
Received: from MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41) by
 MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.24; Wed, 5 Oct 2022 05:00:48 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::38) by MW2PR16CA0028.outlook.office365.com
 (2603:10b6:907::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 5 Oct 2022 05:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 05:00:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 22:00:37 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 22:00:36 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
        <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
        <drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
        <linux-mtd@lists.infradead.org>
CC:     <axboe@kernel.dk>, <philipp.reisner@linbit.com>,
        <lars.ellenberg@linbit.com>, <christoph.boehmwalder@linbit.com>,
        <efremov@linux.com>, <josef@toxicpanda.com>, <tim@cyberelk.net>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>, <kch@nvidia.com>,
        <mcgrof@kernel.org>, <hare@suse.de>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <vincent.fu@samsung.com>, <shinichiro.kawasaki@wdc.com>
Subject: [RFC PATCH 00/18] block: add and use init disk helper
Date:   Tue, 4 Oct 2022 22:00:09 -0700
Message-ID: <20221005050027.39591-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d23086-9198-4ac6-46ef-08daa68e9144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5s7pu54P8aV1skv3l4/6V409OMbS9JLn3hoDy/ter+2h7fkAO875SMGgCmDOrXxLihxCHnE2nN6vPPq6NuKwz5+YPAuk9jCyKWHuhKpetUggABEsV8wZJEuLzYy1g0CMTD9EZPbsW4bfT34pPPMFag+eVLwSOUVow5Go/P0AgjqP6sxBF8RmrZ/jrdU30op3m7c6Dy+AMVmusJ2ZGSKRA5RtuRd2jYmzjGKE3euhSjwQ+dlxnuFJ2TP67es0yzvK8gxxBvJT7KTxmpxk1C4J8Ja95nvNJVgp6vLTbFC0Y+2MJ61/r6FSvIgVJI0x5+ZoLf0shRd0CpP0gM0VYqY29k9pDnE7krCw1jog7/jKsVZuaQO0ei5OKr5dcvsiJLd6ylrt0J3hNRjFEYnCF14YjxUFxPovn8bVBSGoF+MxqVJZuVO2m3CG6qYa3b8CZMLPWwLVsYEv1fYUz+GTJJmH0dZ1iehM7vi9AsKzK+9zqmJEhhGPgC0N+tREcg1ODWlpvIQZDN+fhNlOggSQ59A55F5gUOVLELxjQ1yOC+pxOkWiSxaSP+HcApl9GfUf4cQfrUNMAyTZYXX0uEUoV12YLY6BnbIrPZA3UmhGGz1Ex5hYhTyai941GUEayT4016piq9Q6RVYVM/ZJgbyN7fGu3q40EpJ5iPwx5ChBwpInWEAFcX5fgB/HA5CouI5nA8FuESlxkqHQC0JWHMICZp6+aPGNYfPWD424p89DDjaj/Ix0/eml0/v1szP7b8LbtplLfwcsSARWVc0cwgtyy5FufHle8Rzy8q/V+sPtHciXDz8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(110136005)(4326008)(8676002)(356005)(41300700001)(40480700001)(426003)(36860700001)(5660300002)(478600001)(7416002)(47076005)(82310400005)(36756003)(70206006)(54906003)(70586007)(336012)(2906002)(2616005)(26005)(83380400001)(16526019)(7696005)(8936002)(1076003)(186003)(316002)(6666004)(7636003)(40460700003)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 05:00:47.8146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d23086-9198-4ac6-46ef-08daa68e9144
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Add and use the helper to initialize the common fields of struct gendisk
such as major, first_minor, minors, disk_name, private_data, and ops.
This initialization is spread all over the block drivers. This avoids
code repetation of inialization code of gendisk in current block drivers
and any future ones.

-ck

Chaitanya Kulkarni (18):
  block: add and use init disk helper
  nfblock: use init disk helper
  amiflop: use init disk helper
  brd: use init disk helper
  drbd: use init disk helper
  floppy: use init disk helper
  loop: use init disk helper
  n64cart: use init disk helper
  nbd: use init disk helper
  pcd: use init disk helper
  pd: use init disk helper
  pf: use init disk helper
  pktcdvd: use init disk helper
  rnbd-clt: use init disk helper
  swim: use init disk helper
  swim3: use init disk helper
  z2ram: use init disk helper
  ubi: use init disk helper

 arch/m68k/emu/nfblock.c        |  8 ++------
 block/genhd.c                  | 13 +++++++++++++
 drivers/block/amiflop.c        |  8 ++------
 drivers/block/ataflop.c        |  8 ++------
 drivers/block/brd.c            |  9 ++-------
 drivers/block/drbd/drbd_main.c |  6 +-----
 drivers/block/floppy.c         |  8 ++------
 drivers/block/loop.c           |  7 ++-----
 drivers/block/n64cart.c        |  4 +---
 drivers/block/nbd.c            |  7 ++-----
 drivers/block/null_blk/main.c  | 12 ++++--------
 drivers/block/paride/pcd.c     |  5 +----
 drivers/block/paride/pd.c      |  8 ++------
 drivers/block/paride/pf.c      |  6 +-----
 drivers/block/pktcdvd.c        |  6 +-----
 drivers/block/rnbd/rnbd-clt.c  |  9 +++------
 drivers/block/swim.c           |  7 ++-----
 drivers/block/swim3.c          |  8 ++------
 drivers/block/z2ram.c          |  5 +----
 drivers/mtd/ubi/block.c        |  6 +-----
 include/linux/blkdev.h         |  5 +++++
 21 files changed, 52 insertions(+), 103 deletions(-)

-- 
2.29.0

