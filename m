Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E218F5E5F07
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiIVJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiIVJxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:53:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35878D58A9;
        Thu, 22 Sep 2022 02:53:27 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MY9TL4Ff9z689t8;
        Thu, 22 Sep 2022 17:48:38 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 11:53:25 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:53:22 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 0/7] libsas and drivers: NCQ error handling
Date:   Thu, 22 Sep 2022 17:46:51 +0800
Message-ID: <1663840018-50161-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

As reported in [0], the pm8001 driver NCQ error handling more or less
duplicates what libata does in link error handling, as follows:
- abort all commands
- do autopsy with read log ext 10 command
- reset the target to recover, if necessary

Indeed for the hisi_sas driver we want to add similar handling for NCQ
errors.

This series add a new libsas API - sas_ata_device_link_abort() - to handle
host NCQ errors, and fixes up pm8001 and hisi_sas drivers to use it.

A difference in the pm8001 driver NCQ error handling is that we send
SATA_ABORT per-task prior to read log ext10, but I feel that this should
not make a difference to the error handling.

Damien kindly tested previous the series for pm8001, but any further pm8001
testing would be appreciated as I have since tweaked pm8001 handling again.
This is because the pm8001 driver hangs on my arm64 machine read log ext10
command.

Finally with these changes we can make the libsas task alloc/free APIs
private, which they should always have been.

Based on mkp-scsi @ 6.1/scsi-staging 7f615c1b5986 ("scsi:
scsi_transport_fc: Use %u for dev_loss_tmo")

[0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a978@huawei.com/

Changes since v3:
- Add Damien's tags (thanks)
- Modify hisi_sas processing as follows:
  - use sas_task_abort() for rejected IO
  - Modify abort task processing to issue softreset in certain circumstances
- rebase

Changes since v2:
- Stop sending SATA_ABORT all for pm8001 handling
- Make "reset" optional in sas_ata_device_link_abort()
- Drop Jack's ACK

Changes since v1:
- Rename sas_ata_link_abort() -> sas_ata_device_link_abort()
- Set EH RESET flag in sas_ata_device_link_abort()
- Add Jack's Ack tags
- Rebase

John Garry (5):
  scsi: libsas: Add sas_ata_device_link_abort()
  scsi: hisi_sas: Move slot variable definition in hisi_sas_abort_task()
  scsi: pm8001: Modify task abort handling for SATA task
  scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
  scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private

Xingui Yang (2):
  scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
  scsi: hisi_sas: Modify v3 HW SATA disk error state completion
    processing

 drivers/scsi/hisi_sas/hisi_sas.h       |   1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  26 +++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  53 ++++++-
 drivers/scsi/libsas/sas_ata.c          |  12 ++
 drivers/scsi/libsas/sas_init.c         |   3 -
 drivers/scsi/libsas/sas_internal.h     |   4 +
 drivers/scsi/pm8001/pm8001_hwi.c       | 188 ++++---------------------
 drivers/scsi/pm8001/pm8001_sas.c       |   8 ++
 drivers/scsi/pm8001/pm8001_sas.h       |   4 -
 drivers/scsi/pm8001/pm80xx_hwi.c       | 177 +++--------------------
 include/scsi/libsas.h                  |   4 -
 include/scsi/sas_ata.h                 |   6 +
 12 files changed, 143 insertions(+), 343 deletions(-)

-- 
2.35.3

