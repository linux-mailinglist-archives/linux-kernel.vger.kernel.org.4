Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677ED6C2CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCUIoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCUIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:44:03 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49CE15C94;
        Tue, 21 Mar 2023 01:43:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PglVT5r6wz4f3nTB;
        Tue, 21 Mar 2023 16:42:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCIRbhlkMJs0FQ--.59469S4;
        Tue, 21 Mar 2023 16:42:59 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] scsi: fix hung_task when change host from recovery to running via sysfs
Date:   Tue, 21 Mar 2023 16:42:04 +0800
Message-Id: <20230321084204.1860900-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnFCIRbhlkMJs0FQ--.59469S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4fAry3ZFy3AFW5Gr4UJwb_yoW8AFy5pr
        WrJ34UGr48uw1Ika1q9F1UKFy5G3yvyFykKFZ7u348ZFy8JFy2q3Z5JFWjqFyUGrW8urn5
        WF1DWFs8Ka1jqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

When do follow test:
Step1: echo  "recovery" > /sys/class/scsi_host/host0/state
Step2: dd if=/dev/sda  of=/dev/null  count=1  &
Step3: echo  "running" > /sys/class/scsi_host/host0/state
Got issue as follows:
INFO: task dd:14545 blocked for more than 143 seconds.
      Not tainted 6.3.0-rc2-next-20230315-dirty #406
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dd              state:D stack:23376 pid:14545 ppid:14439  flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x232e/0x55a0
 schedule+0xde/0x1a0
 scsi_block_when_processing_errors+0x2e9/0x350
 sd_open+0x10c/0x6d0
 blkdev_get_whole+0x99/0x260
 blkdev_get_by_dev+0x556/0xbe0
 blkdev_open+0x140/0x2c0
 do_dentry_open+0x6cc/0x13f0
 path_openat+0x1b3b/0x26b0
 do_filp_open+0x1ce/0x2a0
 do_sys_openat2+0x61b/0x990
 do_sys_open+0xc7/0x150
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Above issue happens as when change host state by sysfs, there isn't wakeup
waiter.
To solve above issue, just wakeup waiter when change state success. There is
no additional judgment here because modifying the host state is more used in
testing.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/scsi_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index ee28f73af4d4..ae6b1476b869 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -216,6 +216,9 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
 
 	if (scsi_host_set_state(shost, state))
 		return -EINVAL;
+	else
+		wake_up(&shost->host_wait);
+
 	return count;
 }
 
-- 
2.31.1

