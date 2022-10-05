Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C56F5F4E23
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJEDXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJEDXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:23:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AAB719BF;
        Tue,  4 Oct 2022 20:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAnP4nz11d924n5Ea6rkfbTTWZkOcBMR/h7ZkQJ1oHltLxDJaeH/Iez5BS7J79qQ2VcFFwKYgIGmCiYXjOb76HvhXSy2EaAQdXrVxivVboL/NYUst26hybzA8F8XTgXAFdbEcsSJMarnV5z3mvpNv6/2qB++DsmW8q+cjiY5mYdZRhiZtGSYFd3lR+A2iFGBWA/Ij8OWKnFTulTcMU+8KAKsLHdCYRDn4ExerGOo0Cz+trXQUARNz81ypcs8fpGxbeso3FeGPHnm9ypVjlCvgTaHFSZVumbmAN2zpDwlny92lM3GEdkISUQHh9Y61BlOgXREHFsrbzCGQ5y2BJTFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrgGetB/TLOjMS3vQknhv/SINTgMiPk7KqpkdclIcUs=;
 b=Xdz1XM9XgHs5tzhGy60K1VMGf7QyJWaVPAJhDsbnmp5W/XTYb8Bi8f8nb1UQ9e1IMXiPYTTYFi+RlZ3dI4B1Y65Z0QQl37FH3c1C70lf2zoeoThJTzvL5pDhglUPoxYHgg6oC5ZPXVTzZ7fI8eRAMYUPXqTcCbnYF3bAL97S2ILwtM1l2jXOjFCoIw/7vNwUKgtUw5eRwCmMqR8F6tJ6kWA6QAr1QEgGdFMtX9EEuzAUXyUW/5oQ5M9j8wHfEwj0ontzAsr9fQnTHG8LgEDXWpyAJq2jM6WEwKhEfCq2J7ZwlH6dHyJLv/NzzbtfG8MmACbtqAtD5iuTsSetceIsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrgGetB/TLOjMS3vQknhv/SINTgMiPk7KqpkdclIcUs=;
 b=iW3jsrpo9QXt4SmTdh80KE4thGPDh8fejFIagobwIQSERcoWvLGWdLcnqwJhThlAROWm8mvRxQA47EVCi2eq5eIqa5WE0yHiZwRofiP/64oBAIcTBy9/FMHs0x/UhCYe76qnqD/RIxdsnzqz50SrhQQ5XHpX7WIjLrthz2kNv59+A3mkKtYd3h3MQR4rPdtfo4TK1QbuPLEW/MLJ9voFSb02DML6kB8S+aqt7c7YeYtZ6sH/cLX22f9gL/69KTjRMugSIK3H29HTjUPGFQd45Kix5z6Vce1d/4Amspy1WZOvPhvdO4CpC2PD1IOhhn2ZmJ7Dkg4nMNlIVcZcz5zeig==
Received: from BN8PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:70::14)
 by DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:23:16 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::c8) by BN8PR04CA0001.outlook.office365.com
 (2603:10b6:408:70::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:23:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:23:08 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:23:05 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
CC:     <axboe@kernel.dk>, <efremov@linux.com>, <josef@toxicpanda.com>,
        <idryomov@gmail.com>, <dongsheng.yang@easystack.cn>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <mst@redhat.com>,
        <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>, <ohad@wizery.com>, <andersson@kernel.org>,
        <baolin.wang@linux.alibaba.com>, <ulf.hansson@linaro.org>,
        <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>,
        <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
        <sth@linux.ibm.com>, <hoeppner@linux.ibm.com>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <kch@nvidia.com>, <bhelgaas@google.com>, <john.garry@huawei.com>,
        <mcgrof@kernel.org>, <christophe.jaillet@wanadoo.fr>,
        <vaibhavgupta40@gmail.com>, <wsa+renesas@sang-engineering.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <christoph.boehmwalder@linbit.com>, <joel@jms.id.au>,
        <vincent.whitchurch@axis.com>, <nbd@other.debian.org>,
        <ceph-devel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <asahi@lists.linux.dev>
Subject: [RFC PATCH 00/21] block: add and use init tagset helper
Date:   Tue, 4 Oct 2022 20:22:36 -0700
Message-ID: <20221005032257.80681-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|DM6PR12MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: fce348ec-947a-4641-efb6-08daa680f183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FlJpRPPWo/UczTdTCd5SyHamL/pqbpEL/Ib+DcXgEmnGmZ9HEQsxCsQSSaqCQcTZjccDkXjj6u6yhsKWFHSidDTY7fUyBz2KqAnbklpfj1swJc7PjxXCgzNELZVysLo4szooec2ZY8lzfdkSE6HtdY+DtVcTMVjT8/jV+DKt5E6leNDKjVvSwh8EQ+Et7lmmqiT5dBceOsWFEahHF9xDSoPAe8cAus+8SNEDsQM/6NnzlmMJLTqU3TNS2er/HUj3CSYob4ij3EhgCsbqwKE9P/opr4klhGiEvSjB3DqbxFBhoQWFGh3JkLy/bkJIE9ynCNZz144NHMITmR5CHCTeusxffP0uhFo7kUdiQBTkgxqKecyfPQnuhlX/bH6m9Szl15GpW7txUmH/1j62W3KaE9uc5ouAyMtQlwD5YGw+snHXJjYVq7VluiZGSPIx5lNKrFTs9brAjh+oHAqB/n511BLraQb8GC6Uxu2tRGuunDb47VIS8P+D/hbiblfD/8mXucfE4lBfj0SIMlLUoPlKp0fkZ4FwsXtU2X1Gkn+mFFL+PnaG2Bvhazs80UG8ITqBnJHvmm8BR0hiA5I9yOwQqNN/La6BsPmng/IjQ0jXZDQtHd5tXAwu7XpWpAsOHNrnNQejJI1nT3M/dr+3H7VZ902lZCeV4RpYrjbSktdNLt+0q4Qgde1mX3VLGrvRqUzqyMBNIPAnRd4/ehBsgzMWgL1bZOGZzvOa9nJKokVBQEo8fw8n1c1PismK7nqoMDbHtoaNR1b+Woq9GxppbdQ+Uk3j/bTNKU/oQZ46LetuLMSQ2+S8Aek1LfTGwDQtcXmq39TIGsaevKwgzMGZjrTtWGxjjuYVEglp3ZjLIPlBV0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(7696005)(41300700001)(36756003)(6666004)(82740400003)(5660300002)(7366002)(7406005)(7416002)(8936002)(26005)(8676002)(316002)(70206006)(70586007)(4326008)(336012)(40480700001)(83380400001)(47076005)(426003)(82310400005)(16526019)(186003)(1076003)(921005)(356005)(7636003)(40460700003)(2906002)(2616005)(36860700001)(478600001)(110136005)(54906003)(21314003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:23:16.2764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce348ec-947a-4641-efb6-08daa680f183
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
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

Add and use the helper to initialize the common fields of the tag_set
such as blk_mq_ops, number of h/w queues, queue depth, command size,
numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
is spread all over the block drivers. This avoids repetation of
inialization code of the tag set in current block drivers and any future
ones.

P.S. I'm aware of the EXPORT_SYMBOL_GPL() checkpatch warn just to make
get some feedback to so I can remove the RFC tag.

-ck

Chaitanya Kulkarni (21):
  block: add and use init tagset helper
  loop: use lib tagset init helper
  nbd: use lib tagset init helper
  rnbd: use lib tagset init helper
  bsg-lib: use lib tagset init helper
  rnbd-clt: use lib tagset init helper
  virtio-blk: use lib tagset init helper
  scsi: use lib tagset init helper
  block: use lib tagset init helper
  amiflop: use lib tagset init helper
  floppy: use lib tagset init helper
  mtip32xx: use lib tagset init helper
  z3ram: use lib tagset init helper
  scm_blk: use lib tagset init helper
  ubi: use lib tagset init helper
  mmc: core: use lib tagset init helper
  dasd: use lib tagset init helper
  nvme-core: use lib tagset init helper for I/O q
  nvme-core: use lib tagset init helper for adminq
  nvme-apple: use lib tagset init helper
  nvme-pci: use lib tagset init helper

 block/blk-mq.c                    | 27 ++++++++++++++++++++++-----
 block/bsg-lib.c                   |  9 +++------
 drivers/block/amiflop.c           |  8 +++-----
 drivers/block/floppy.c            |  7 ++-----
 drivers/block/loop.c              | 12 ++++--------
 drivers/block/mtip32xx/mtip32xx.c | 13 ++++---------
 drivers/block/nbd.c               | 11 +++--------
 drivers/block/null_blk/main.c     | 10 +++-------
 drivers/block/rbd.c               | 11 +++++------
 drivers/block/rnbd/rnbd-clt.c     | 25 +++++++++++--------------
 drivers/block/virtio_blk.c        | 14 +++++---------
 drivers/block/z2ram.c             |  7 ++-----
 drivers/mmc/core/queue.c          |  9 +++------
 drivers/mtd/ubi/block.c           | 11 +++--------
 drivers/nvme/host/apple.c         | 25 ++++++++-----------------
 drivers/nvme/host/core.c          | 21 +++++----------------
 drivers/nvme/host/pci.c           | 25 +++++++------------------
 drivers/s390/block/dasd_genhd.c   |  9 +++------
 drivers/s390/block/scm_blk.c      | 10 +++-------
 drivers/scsi/scsi_lib.c           | 13 +++++--------
 include/linux/blk-mq.h            |  5 +++++
 21 files changed, 109 insertions(+), 173 deletions(-)

-- 
2.29.0

