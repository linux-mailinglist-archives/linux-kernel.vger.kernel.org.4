Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBE6F8D7D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjEFBYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjEFBY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:24:29 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1F07297;
        Fri,  5 May 2023 18:24:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QCqbC714mz4f3mLL;
        Sat,  6 May 2023 09:24:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7NHrFVkfh1lIw--.56086S7;
        Sat, 06 May 2023 09:24:25 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de, Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v2 3/4] md/raid10: fix wrong setting of max_corr_read_errors
Date:   Sat,  6 May 2023 09:23:14 +0800
Message-Id: <20230506012315.3370489-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230506012315.3370489-1-linan666@huaweicloud.com>
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7NHrFVkfh1lIw--.56086S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWDCFWruF13uF43uF4kJFb_yoW8urW3pw
        4DAasxZr15J34UAr1DJFykua4Fyw1FkayjyryrAw4fWa43Jr98ta4UGayjgr1DWF1ft3W3
        XFZ8KrWDCa18tFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU1U73PUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

max_corr_read_errors should not be negative number. Change it to
unsigned int where use it.

Fixes: 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable read errors.")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c     | 2 +-
 drivers/md/raid10.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fd5c3babcd6d..4a1e566d6bdc 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4486,7 +4486,7 @@ __ATTR_PREALLOC(array_state, S_IRUGO|S_IWUSR, array_state_show, array_state_stor
 
 static ssize_t
 max_corrected_read_errors_show(struct mddev *mddev, char *page) {
-	return sprintf(page, "%d\n",
+	return sprintf(page, "%u\n",
 		       atomic_read(&mddev->max_corr_read_errors));
 }
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4fcfcb350d2b..4d615fcc6a50 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2727,7 +2727,8 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 	int sect = 0; /* Offset from r10_bio->sector */
 	int sectors = r10_bio->sectors;
 	struct md_rdev *rdev;
-	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
+	unsigned int max_read_errors =
+			atomic_read(&mddev->max_corr_read_errors);
 	int d = r10_bio->devs[r10_bio->read_slot].devnum;
 
 	/* still own a reference to this rdev, so it cannot
@@ -2743,7 +2744,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 	check_decay_read_errors(mddev, rdev);
 	atomic_inc(&rdev->read_errors);
 	if (atomic_read(&rdev->read_errors) > max_read_errors) {
-		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
+		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %u:max %u]\n",
 			  mdname(mddev), rdev->bdev,
 			  atomic_read(&rdev->read_errors), max_read_errors);
 		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
-- 
2.31.1

