Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430AD60C8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiJYJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiJYJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:48:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F239127921;
        Tue, 25 Oct 2022 02:47:55 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRsg61Zjz687w5;
        Tue, 25 Oct 2022 17:46:31 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:47:52 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:47:48 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 00/22] blk-mq/libata/scsi: SCSI driver tagging improvements Part I
Date:   Tue, 25 Oct 2022 18:17:54 +0800
Message-ID: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently SCSI low-level drivers are required to manage tags for commands
which do not come via the block layer - libata internal commands would be
an example of one of these. We want to make blk-mq manage these tags also.

There was some work to provide "reserved commands" support in such series
as https://lore.kernel.org/linux-scsi/20211125151048.103910-1-hare@suse.de/

This was based on allocating a request for the lifetime of the "internal"
command.

This series tries to solve that problem by not just allocating the request
but also sending it as a request through the block layer. Reasons to do
this:
- Normal flow of a request and also commonality for regular scsi command
  lifetime
- We don't leave request and scsi_cmnd fields dangling as when we just
  allocate and free the request for the lifetime of the "internal" command
- For poll mode support we can only poll in block layer, so could not send
  internal commands on poll mode queues if we did not do this, which is a
  problem
- Can get rid of duplicated code like libsas internal command timeout
  handling

Series part I contains core SCSI midlayer, libata, and libsas changes to
queue libsas "slow" tasks as requests.

Series part II of this series focused on changing libata to queue internal
commands as requests.

Testing:
QEMU with AHCI with disk and cdrom attached, hisi_sas, pm8001.

Branch containing all patches is at:
https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-6.1-block

v2 was here:
https://lore.kernel.org/linux-scsi/1654770559-101375-1-git-send-email-john.garry@huawei.com/

Hannes Reinecke (1):
  scsi: core: Implement reserved command handling

John Garry (21):
  blk-mq: Don't get budget for reserved requests
  scsi: core: Add scsi_get_dev()
  scsi: core: Add support to send reserved commands
  scsi: core: Add support for reserved command timeout handling
  scsi: libsas: Improve sas_ex_discover_expander() error handling
  scsi: libsas: Notify LLDD expander found before calling sas_rphy_add()
  scsi: scsi_transport_sas: Alloc sdev for expander
  scsi: libsas: Add sas_alloc_slow_task_rq()
  scsi: libsas: Add sas_queuecommand_internal()
  scsi: libsas: Add sas_internal_timeout()
  scsi: core: Use SCSI_SCAN_RESCAN in  __scsi_add_device()
  scsi: scsi_transport_sas: Allocate end device target id in the rphy
    alloc
  ata: libata-scsi: Add ata_scsi_setup_sdev()
  scsi: libsas: Add sas_ata_setup_device()
  ata: libata-scsi: Allocate sdev early in port probe
  scsi: libsas drivers: Reserve tags
  scsi: libsas: Queue SMP commands as requests
  scsi: libsas: Queue TMF commands as requests
  scsi: core: Add scsi_alloc_request_hwq()
  scsi: libsas: Queue internal abort commands as requests
  scsi: libsas: Delete sas_task_slow.timer

 block/blk-mq.c                         |   4 +-
 drivers/ata/libata-eh.c                |   1 +
 drivers/ata/libata-scsi.c              |  49 ++++++++----
 drivers/ata/libata.h                   |   1 +
 drivers/scsi/aic94xx/aic94xx_init.c    |   3 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  40 +++++-----
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   3 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   3 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   7 ++
 drivers/scsi/hosts.c                   |  16 ++++
 drivers/scsi/isci/init.c               |   3 +
 drivers/scsi/libsas/sas_ata.c          |  20 +++++
 drivers/scsi/libsas/sas_expander.c     | 101 ++++++++++++++-----------
 drivers/scsi/libsas/sas_init.c         |  61 ++++++++++++++-
 drivers/scsi/libsas/sas_internal.h     |   5 ++
 drivers/scsi/libsas/sas_scsi_host.c    |  93 ++++++++++++-----------
 drivers/scsi/mvsas/mv_init.c           |   7 ++
 drivers/scsi/pm8001/pm8001_init.c      |   8 +-
 drivers/scsi/scsi_error.c              |   3 +
 drivers/scsi/scsi_lib.c                |  42 +++++++++-
 drivers/scsi/scsi_scan.c               |  29 ++++++-
 drivers/scsi/scsi_transport_sas.c      |  34 ++++++---
 include/linux/libata.h                 |   2 +
 include/scsi/libsas.h                  |   8 +-
 include/scsi/scsi_cmnd.h               |   3 +
 include/scsi/scsi_host.h               |  21 ++++-
 26 files changed, 424 insertions(+), 143 deletions(-)

-- 
2.35.3

