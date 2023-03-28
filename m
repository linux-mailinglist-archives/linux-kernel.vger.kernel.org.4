Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB07C6CC228
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjC1Ofb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjC1OfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:35:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57E6CC0D;
        Tue, 28 Mar 2023 07:35:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PmBzd13tZz4f3rNB;
        Tue, 28 Mar 2023 22:35:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R8X+yJkk4bgFg--.7384S5;
        Tue, 28 Mar 2023 22:35:10 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 1/3] scsi: forbid to set scsi host state by sysfs
Date:   Tue, 28 Mar 2023 22:34:40 +0800
Message-Id: <20230328143442.2684167-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230328143442.2684167-1-yebin@huaweicloud.com>
References: <20230328143442.2684167-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R8X+yJkk4bgFg--.7384S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW3XF4UZFWkJF1kZw47urg_yoW8AF17pr
        ZxJa4ag3yUGFs7WFsruws8W3sxKr18Gr9rt398twn7CF18AF9xKanrJay8Za4rJFW8Wrn7
        JF4DJr15Cay8tF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8JwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUOWlkDUUUU
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

Actually, set scsi host state by sysfs may lead to functional issues.
So forbid to set scsi host state.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/scsi_sysfs.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index ee28f73af4d4..903aa9de46e5 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -195,30 +195,6 @@ store_scan(struct device *dev, struct device_attribute *attr,
 };
 static DEVICE_ATTR(scan, S_IWUSR, NULL, store_scan);
 
-static ssize_t
-store_shost_state(struct device *dev, struct device_attribute *attr,
-		  const char *buf, size_t count)
-{
-	int i;
-	struct Scsi_Host *shost = class_to_shost(dev);
-	enum scsi_host_state state = 0;
-
-	for (i = 0; i < ARRAY_SIZE(shost_states); i++) {
-		const int len = strlen(shost_states[i].name);
-		if (strncmp(shost_states[i].name, buf, len) == 0 &&
-		   buf[len] == '\n') {
-			state = shost_states[i].value;
-			break;
-		}
-	}
-	if (!state)
-		return -EINVAL;
-
-	if (scsi_host_set_state(shost, state))
-		return -EINVAL;
-	return count;
-}
-
 static ssize_t
 show_shost_state(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -233,7 +209,7 @@ show_shost_state(struct device *dev, struct device_attribute *attr, char *buf)
 
 /* DEVICE_ATTR(state) clashes with dev_attr_state for sdev */
 static struct device_attribute dev_attr_hstate =
-	__ATTR(state, S_IRUGO | S_IWUSR, show_shost_state, store_shost_state);
+	__ATTR(state, S_IRUGO, show_shost_state, NULL);
 
 static ssize_t
 show_shost_mode(unsigned int mode, char *buf)
-- 
2.31.1

