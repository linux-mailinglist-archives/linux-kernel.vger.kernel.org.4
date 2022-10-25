Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EBC60C98E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiJYKLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiJYKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:10:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0283811878C;
        Tue, 25 Oct 2022 03:03:18 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxS8x4xDpz67brF;
        Tue, 25 Oct 2022 17:59:45 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:03:15 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:03:12 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 0/7] blk-mq/libata/scsi: SCSI driver tagging improvements Part II
Date:   Tue, 25 Oct 2022 18:32:49 +0800
Message-ID: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

This is a follow on to Part I in the following:
https://lore.kernel.org/linux-scsi/1666693096-180008-1-git-send-email-john.garry@huawei.com/T/#ta

This mostly focuses on libata changes to queue internal commands as
requests.

This is less complete than Part I series, due to:
- not tested on SATA PMP
- not support for ipr.c, which does not
  support ata_port_operations.error_handler
- Not tested enough - for example, there are prob lots of issues lurking
  in libata qc iter functions now that ata_port.qcmd[] is deleted

John Garry (7):
  ata: libata-scsi: Add ata_scsi_queue_internal()
  ata: libata-scsi: Add ata_internal_queuecommand()
  ata: libata: Make space for ATA queue command in scmd payload
  ata: libata: Add ata_internal_timeout()
  ata: libata: Queue ATA internal commands as requests
  scsi: mvsas: Remove internal tag handling
  scsi: hisi_sas: Remove internal tag handling for reserved commands

 drivers/ata/libata-core.c              | 141 ++++++++++++++-----------
 drivers/ata/libata-eh.c                |  11 +-
 drivers/ata/libata-sata.c              |   5 +-
 drivers/ata/libata-scsi.c              |  76 ++++++++++++-
 drivers/ata/libata.h                   |   3 +-
 drivers/scsi/aic94xx/aic94xx_init.c    |   2 +
 drivers/scsi/hisi_sas/hisi_sas.h       |   3 -
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  82 +++-----------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   2 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   2 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  11 +-
 drivers/scsi/isci/init.c               |   2 +
 drivers/scsi/libsas/sas_scsi_host.c    |  20 +++-
 drivers/scsi/mvsas/mv_init.c           |  13 +--
 drivers/scsi/mvsas/mv_sas.c            |  55 +---------
 drivers/scsi/mvsas/mv_sas.h            |   1 -
 drivers/scsi/pm8001/pm8001_init.c      |   2 +
 include/linux/libata.h                 |  64 ++++++++++-
 include/scsi/libsas.h                  |   8 +-
 19 files changed, 281 insertions(+), 222 deletions(-)

-- 
2.35.3

