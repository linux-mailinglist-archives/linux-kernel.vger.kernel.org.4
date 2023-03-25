Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E846C89E9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjCYBSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjCYBSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:18:40 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE36F1A950;
        Fri, 24 Mar 2023 18:18:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pk1Rt3QHsz4f3mLW;
        Sat, 25 Mar 2023 09:18:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUiDpSx5kmy0NFg--.49234S7;
        Sat, 25 Mar 2023 09:18:36 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH 3/5] scsi: limit to set the host state
Date:   Sat, 25 Mar 2023 09:17:32 +0800
Message-Id: <20230325011734.507453-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230325011734.507453-1-yebin@huaweicloud.com>
References: <20230325011734.507453-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUiDpSx5kmy0NFg--.49234S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWfKFy7WFykXFy5Kr47CFg_yoW8GFWkpF
        WDJa4agw4UWas7Kws3Wrs8Wr9xK348WryqgFZ2g34ruF18J3y5Ka1kCa45ZF45JFWfCFn7
        JF4qqF98Cay0yFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2PEfUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Now, we can set the host state with any value. Actually, it doesn't
make sense. As previous patch introduce SHOST_BLOCKED state, set this
state, it will blocking IO. So this patch limit to set the host with
running/blocked state.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/scsi_sysfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index b14f95ac594e..42c5936c7711 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -203,6 +203,7 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
 	int i;
 	struct Scsi_Host *shost = class_to_shost(dev);
 	enum scsi_host_state state = 0;
+	enum scsi_host_state old_state;
 	unsigned long flags;
 
 	for (i = 0; i < ARRAY_SIZE(shost_states); i++) {
@@ -216,8 +217,13 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
 	if (!state)
 		return -EINVAL;
 
+	if (state != SHOST_RUNNING && state != SHOST_BLOCKED)
+		return -EINVAL;
+
 	spin_lock_irqsave(shost->host_lock, flags);
-	if (scsi_host_set_state(shost, state)) {
+	old_state = shost->shost_state;
+	if ((old_state != SHOST_RUNNING && old_state != SHOST_BLOCKED) ||
+	    scsi_host_set_state(shost, state)) {
 		spin_unlock_irqrestore(shost->host_lock, flags);
 		return -EINVAL;
 	}
-- 
2.31.1

