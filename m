Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1061B62EFB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbiKRIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiKRIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:38:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294EF643D;
        Fri, 18 Nov 2022 00:38:27 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND97b0ZZMzqSYk;
        Fri, 18 Nov 2022 16:34:35 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:38:19 +0800
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
Subject: [PATCH for-next 4/5] scsi: hisi_sas: Fix SATA devices missing issue during I_T nexus reset
Date:   Fri, 18 Nov 2022 16:37:13 +0800
Message-ID: <20221118083714.4034612-5-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
References: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
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
when I_T nexus reset and revalidation are processed simultaneously.

The issue comes from:

- Revalidation can remove SATA devices in link reset, e.g. in
  hisi_sas_clear_nexus_ha().

- However, hisi_sas_debug_I_T_nexus_reset() polls the state of a SATA
  device on an expander after sending link_reset, where it calls:
   hisi_sas_debug_I_T_nexus_reset
    sas_ata_wait_after_reset
     ata_wait_after_reset
      ata_wait_ready
       smp_ata_check_ready
        sas_ex_phy_discover
         sas_ex_phy_discover_helper
          sas_set_ex_phy
  The ex_phy's change count is updated in sas_set_ex_phy(), so SATA devices
  after a link reset may not be found later through revalidation.

A similar issue was reported in:
commit 0f3fce5cc77e ("[SCSI] libsas: fix ata_eh clobbering ex_phys via
smp_ata_check_ready")
commit 87c8331fcf72 ("[SCSI] libsas: prevent domain rediscovery competing
with ata error handling").

To address this issue, in hisi_sas_debug_I_T_nexus_reset(), we now call
smp_ata_check_ready_type() that only polls the device type while not
updating the ex_phy's data of libsas.

Fixes: 71453bd9d1bf ("scsi: hisi_sas: Use sas_ata_wait_after_reset() in IT nexus reset")
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 62080d0fad6f..41ba22f6c7f0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1694,13 +1694,15 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 		return rc;
 	}
 
+	/* Remote phy */
 	if (rc)
 		return rc;
 
-	/* Remote phy */
 	if (dev_is_sata(device)) {
-		rc = sas_ata_wait_after_reset(device,
-					HISI_SAS_WAIT_PHYUP_TIMEOUT);
+		struct ata_link *link = &device->sata_dev.ap->link;
+
+		rc = ata_wait_after_reset(link, HISI_SAS_WAIT_PHYUP_TIMEOUT,
+					  smp_ata_check_ready_type);
 	} else {
 		msleep(2000);
 	}
-- 
2.30.0

