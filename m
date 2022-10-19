Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50524603B68
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJSIYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSIYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:24:14 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF3C7C75D;
        Wed, 19 Oct 2022 01:24:08 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MskGG6qDwzJn1g;
        Wed, 19 Oct 2022 16:21:26 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 16:24:06 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 16:24:05 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>,
        <john.garry@huawei.com>
Subject: [PATCH] scsi: sd: Update dix config everytime sd_revalidate_disk is called
Date:   Wed, 19 Oct 2022 08:18:25 +0000
Message-ID: <20221019081825.20794-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the host protection capabilities are 0x77 and a DIF disk is connected,
the DIX and DIF of the disk are default enabled. Then if that DIF disk is
reformatted as a non-DIF format, per the currently flow, the DIX is kept
enabled which is not correct, which will cause the following errors when
accessing the non-DIF disk:
[root@localhost ~]# lsscsi -p
[7:0:5:0]    disk    xxx    /dev/sdc   DIF/Type3  T10-DIF-TYPE3-CRC
[root@localhost ~]# sg_format -F -s 512 /dev/sdc
[root@localhost ~]# lsscsi -p
[7:0:5:0]    disk    xxx    /dev/sdc   -          T10-DIF-TYPE3-CRC

[142829.032340] hisi_sas_v3_hw 0000:b4:04.0: erroneous completion iptt=2375 task=00000000bea0970c dev id=5 direct-attached phy4 addr=51c20dbaf642a000 CQ hdr: 0x1023 0x50947 0x0 0x20000 Error info: 0x0 0x0 0x4 0x0
[142829.073883] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
[142829.079783] sas: sas_scsi_find_task: aborting task 0x00000000bea0970c
[142829.102342] sas: Internal abort: task to dev 51c20dbaf642a000 response: 0x0 status 0x5
[142829.110319] sas: sas_eh_handle_sas_errors: task 0x00000000bea0970c is done
[142829.117275] sd 7:0:5:0: [sdc] tag#2375 UNKNOWN(0x2003) Result: hostbyte=0x05 driverbyte=DRIVER_OK cmd_age=0s
[142829.127171] sd 7:0:5:0: [sdc] tag#2375 CDB: opcode=0x2a 2a 00 00 00 00 00 00 00 08 00
[142829.135059] I/O error, dev sdc, sector 0 op 0x1:(WRITE) flags 0x18800 phys_seg 1 prio class 2

On the contrary, when a non-DIF disk is connected and formatted as a DIF
disk, it is found that DIX is not enabled. Operation logs as follows:

[root@localhost ~]# lsscsi -p
[7:0:2:0]    disk    xxx    /dev/sdc   -          none
[root@localhost ~]# sg_format --format --fmtpinfo=3 --pfu=1 /dev/sdc
[root@localhost ~]# lsscsi -p
[7:0:2:0]    disk    xxx    /dev/sdc   DIF/Type3  none

This is because dix config is only updated when the first time a disk
is added, in this patch, we fix the issue by with changes:
1. Remove check first_scan when call sd_config_protection().
2. Unregister block integrity profile after DIX becomes to 0.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/sd.c     | 3 ---
 drivers/scsi/sd_dif.c | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index eb76ba055021..3844f469b6be 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2199,9 +2199,6 @@ static void sd_config_protection(struct scsi_disk *sdkp)
 {
 	struct scsi_device *sdp = sdkp->device;
 
-	if (!sdkp->first_scan)
-		return;
-
 	sd_dif_config_host(sdkp);
 
 	if (!sdkp->protection_type)
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 968993ee6d5d..78db8d85f97e 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -39,8 +39,10 @@ void sd_dif_config_host(struct scsi_disk *sdkp)
 		dif = 0; dix = 1;
 	}
 
-	if (!dix)
+	if (!dix) {
+		blk_integrity_unregister(disk);
 		return;
+	}
 
 	memset(&bi, 0, sizeof(bi));
 
-- 
2.17.1

