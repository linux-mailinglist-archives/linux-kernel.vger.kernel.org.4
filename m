Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029795F0714
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiI3JEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiI3JDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:03:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E92FEE40;
        Fri, 30 Sep 2022 02:03:46 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mf44L688dz6H74h;
        Fri, 30 Sep 2022 17:02:26 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 11:03:43 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:03:40 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>,
        <yanaijie@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/6] scsi: libsas: Use request tag in more drivers
Date:   Fri, 30 Sep 2022 16:56:18 +0800
Message-ID: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
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

Currently hisi_sas is the only libsas driver which uses the request tag
for per-HW IO tag.

All other libsas drivers manage the tags internally. Tag management in
pm8001 and mvsas is currently using a simple bitmap, so use the request
tag when available there. With this change we still need to manage tags
for libsas "internal" commands, like SMP commands, and any other
private commands so reserve some tags for this:
- For pm8001 I went with pre-existing and unused PM8001_RESERVE_SLOT size.
  The value is 8, which should be enough. It is greater than mvsas, below,
  but this driver sends a lot of other private commands to HW.
- For mvsas I went with 4, which still should be enough.

isci and aic9xx have elaborate tag alloc schemes, so I'm not going to
bother changing them, especially since I have no HW to test with.

Helper sas_task_find_rq() is added to get the request and associated tag
per sas_task when it is available.

This series looks not to conflict with
https://lore.kernel.org/linux-scsi/20220928070130.3657183-1-yanaijie@huawei.com/T/#mefdcb7b63b4e6ebc8b77a689b3923571ab3d33ab

Based on https://lore.kernel.org/linux-scsi/1664262298-239952-1-git-send-email-john.garry@huawei.com/T/#t

Differences to v1:
- Rework sas_task_find_rq()
- Rename tags->rsvd and remove tag size struct arg for both mvsas and
  pm8001
- Decrement can_queue for mvsas
- Use sas_task_find_rq() in pm80xx_chip_get_q_index()
- Add Damien's tags (thanks)

Igor Pylypiv (1):
  scsi: pm8001: Remove pm8001_tag_init()

John Garry (5):
  scsi: libsas: Add sas_task_find_rq()
  scsi: hisi_sas: Use sas_task_find_rq()
  scsi: pm8001: Use sas_task_find_rq() for tagging
  scsi: mvsas: Delete mvs_tag_init()
  scsi: mvsas: Use sas_task_find_rq() for tagging

 drivers/scsi/hisi_sas/hisi_sas_main.c | 26 +++++-----------
 drivers/scsi/mvsas/mv_defs.h          |  1 +
 drivers/scsi/mvsas/mv_init.c          | 11 +++----
 drivers/scsi/mvsas/mv_sas.c           | 45 +++++++++++++++------------
 drivers/scsi/mvsas/mv_sas.h           |  8 +----
 drivers/scsi/pm8001/pm8001_init.c     | 14 +++------
 drivers/scsi/pm8001/pm8001_sas.c      | 23 +++++++-------
 drivers/scsi/pm8001/pm8001_sas.h      | 12 ++++---
 drivers/scsi/pm8001/pm80xx_hwi.c      | 17 ++--------
 include/scsi/libsas.h                 | 18 +++++++++++
 10 files changed, 85 insertions(+), 90 deletions(-)

-- 
2.35.3

