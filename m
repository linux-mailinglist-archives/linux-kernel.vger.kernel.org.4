Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51D1600920
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiJQIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJQIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:50:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B6B23EA0;
        Mon, 17 Oct 2022 01:50:13 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrVzD57pQz6HJWT;
        Mon, 17 Oct 2022 16:49:12 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 17 Oct 2022 10:50:10 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:50:08 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <niklas.cassel@wdc.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v6 0/8] libsas and drivers: NCQ error handling
Date:   Mon, 17 Oct 2022 17:20:27 +0800
Message-ID: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Finally with these changes we can make the libsas task alloc/free APIs
private, which they should always have been.

Based on v6.1-rc1

[0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a978@huawei.com/

Changes since v5:
- Change to set ATA_DRDY in sata dev fis for sas_ata_device_link_abort()
  and sas_ata_task_done()
- Add Niklas' tags (thanks!)
- Rebase

Changes since v4:
- Add Jason's tags (thanks)
- Rebase

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

John Garry (6):
  scsi: libsas: Add sas_ata_device_link_abort()
  scsi: hisi_sas: Move slot variable definition in hisi_sas_abort_task()
  scsi: pm8001: Modify task abort handling for SATA task
  scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
  scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
  scsi: libsas: Update SATA dev FIS in sas_ata_task_done()

Xingui Yang (2):
  scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
  scsi: hisi_sas: Modify v3 HW SATA disk error state completion
    processing

 drivers/scsi/hisi_sas/hisi_sas.h       |   1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  26 +++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  53 ++++++-
 drivers/scsi/libsas/sas_ata.c          |  19 ++-
 drivers/scsi/libsas/sas_init.c         |   3 -
 drivers/scsi/libsas/sas_internal.h     |   4 +
 drivers/scsi/pm8001/pm8001_hwi.c       | 186 ++++---------------------
 drivers/scsi/pm8001/pm8001_sas.c       |  14 +-
 drivers/scsi/pm8001/pm8001_sas.h       |   5 -
 drivers/scsi/pm8001/pm80xx_hwi.c       | 177 +++--------------------
 include/scsi/libsas.h                  |   4 -
 include/scsi/sas_ata.h                 |   6 +
 12 files changed, 148 insertions(+), 350 deletions(-)

-- 
2.35.3

