Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607925E6470
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiIVN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiIVN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:57:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686D857FC;
        Thu, 22 Sep 2022 06:57:38 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYGyY10v1z67bJY;
        Thu, 22 Sep 2022 21:55:49 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 15:57:36 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 14:57:34 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: pm8001: Fix running_req for internal abort commands
Date:   Thu, 22 Sep 2022 21:51:04 +0800
Message-ID: <1663854664-76165-1-git-send-email-john.garry@huawei.com>
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

Disabling the remote phy for a SATA disk causes a hang:

root@(none)$ more /sys/class/sas_phy/phy-0:0:8/target_port_protocols
sata   
root@(none)$ echo 0 > sys/class/sas_phy/phy-0:0:8/enable
root@(none)$ [   67.855950] sas: ex 500e004aaaaaaa1f phy08 change count has changed
[   67.920585] sd 0:0:2:0: [sdc] Synchronizing SCSI cache  
[   67.925780] sd 0:0:2:0: [sdc] Synchronize Cache(10) failed: Result: hostbyte=0x04 driverbyte=DRIVER_OK  
[   67.935094] sd 0:0:2:0: [sdc] Stopping disk 
[   67.939305] sd 0:0:2:0: [sdc] Start/Stop Unit failed: Result: hostbyte=0x04 driverbyte=DRIVER_OK
...
[  123.998998] INFO: task kworker/u192:1:642 blocked for more than 30 seconds. 
[  124.005960]   Not tainted 6.0.0-rc1-205202-gf26f8f761e83 #218   
[  124.012049] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.   
[  124.019872] task:kworker/u192:1  state:D stack:0 pid:  642 ppid: 2 flags:0x00000008 
[  124.028223] Workqueue: 0000:04:00.0_event_q sas_port_event_worker   
[  124.034319] Call trace: 
[  124.036758]  __switch_to+0x128/0x278
[  124.040333]  __schedule+0x434/0xa58
[  124.043820]  schedule+0x94/0x138
[  124.047045]  schedule_timeout+0x2fc/0x368   
[  124.051052]  wait_for_completion+0xdc/0x200
[  124.055234]  __flush_workqueue+0x1a8/0x708 
[  124.059328]  sas_porte_broadcast_rcvd+0xa8/0xc0
[  124.063858]  sas_port_event_worker+0x60/0x98
[  124.068126]  process_one_work+0x3f8/0x660   
[  124.072134]  worker_thread+0x70/0x700   
[  124.075793]  kthread+0x1a4/0x1b8
[  124.079014]  ret_from_fork+0x10/0x20

The issue is that the per-device running_req read in
pm8001_dev_gone_notify() never goes to zero and we never make progress.
This is caused by missing accounting for running_req for when an internal
abort command completes.

In commit 2cbbf489778e ("scsi: pm8001: Use libsas internal abort support")
we started to send internal abort commands as a proper sas_task. In this
when we deliver a sas_task to HW the per-device running_req is incremented
in pm8001_queue_command(). However it is never decremented for internal
abort commnds, so decrement in pm8001_mpi_task_abort_resp().

Fixes: 2cbbf489778e ("scsi: pm8001: Use libsas internal abort support")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 91d78d0a38fe..628b08ba6770 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -3612,6 +3612,10 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_dbg(pm8001_ha, FAIL, " TASK NULL. RETURNING !!!\n");
 		return -1;
 	}
+
+	if (t->task_proto == SAS_PROTOCOL_INTERNAL_ABORT)
+		atomic_dec(&pm8001_dev->running_req);
+
 	ts = &t->task_status;
 	if (status != 0)
 		pm8001_dbg(pm8001_ha, FAIL, "task abort failed status 0x%x ,tag = 0x%x, scp= 0x%x\n",
-- 
2.35.3

