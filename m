Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F162EFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbiKRIis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiKRIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:38:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA9364F4;
        Fri, 18 Nov 2022 00:38:27 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND97Z64SqzqSYY;
        Fri, 18 Nov 2022 16:34:34 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:38:18 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:38:18 +0800
From:   Jie Zhan <zhanjie9@hisilicon.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <chenxiang66@hisilicon.com>, <john.g.garry@oracle.com>,
        <damien.lemoal@opensource.wdc.com>, <yanaijie@huawei.com>,
        <johannes.thumshirn@wdc.com>, <duoming@zju.edu.cn>,
        <zhanjie9@hisilicon.com>, <liyihang9@huawei.com>,
        <yangxingui@huawei.com>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH for-next 0/5] scsi: hisi_sas/libsas: Fix SATA devices missing issue during hisi_sas_debug_I_T_nexus_reset()
Date:   Fri, 18 Nov 2022 16:37:09 +0800
Message-ID: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SATA devices on an expander may be removed and not be found again
when I_T nexus reset and revalidation are processed simultaneously,
which is probable to happen in hisi_sas_clear_nexus_ha().

The issue came up since commit 71453bd9d1bf ("scsi: hisi_sas: Use
sas_ata_wait_after_reset() in IT nexus reset"), where the ex_phy's
change count is updated in hisi_sas_debug_I_T_nexus_reset(), stopping
future revalidation from discovering the SATA devices after link
reset.

This patchset fixes the issue.

Jie Zhan (5):
  Revert "scsi: hisi_sas: Drain bcast events in
    hisi_sas_rescan_topology()"
  Revert "scsi: hisi_sas: Don't send bcast events from HW during nexus
    HA reset"
  scsi: libsas: Add smp_ata_check_ready_type()
  scsi: hisi_sas: Fix SATA devices missing issue during I_T nexus reset
  scsi: libsas: Do not export sas_ata_wait_after_reset()

 drivers/scsi/hisi_sas/hisi_sas_main.c | 31 ++++++++-------------------
 drivers/scsi/libsas/sas_ata.c         | 28 ++++++++++++++++++++++--
 drivers/scsi/libsas/sas_expander.c    |  4 ++--
 drivers/scsi/libsas/sas_internal.h    |  2 ++
 include/scsi/sas_ata.h                |  7 +++---
 5 files changed, 42 insertions(+), 30 deletions(-)

-- 
2.30.0

