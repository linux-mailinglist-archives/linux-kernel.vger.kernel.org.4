Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C7469DBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBUIQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjBUIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:16:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3920062;
        Tue, 21 Feb 2023 00:16:39 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PLXBm2hMHzKq1X;
        Tue, 21 Feb 2023 16:14:40 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Feb 2023 16:16:32 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH RESEND] scsi: sd: Update dix config everytime sd_revalidate_disk is called
Date:   Tue, 21 Feb 2023 08:10:26 +0000
Message-ID: <20230221081026.24736-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
is connected. In this patch, we fix the issue by with changes:
1. Remove check first_scan when call sd_config_protection().
2. Unregister block integrity profile after DIX becomes to 0.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/sd.c     | 3 ---
 drivers/scsi/sd_dif.c | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2aa3b0393b96..774414d129a4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2254,9 +2254,6 @@ static void sd_config_protection(struct scsi_disk *sdkp)
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

