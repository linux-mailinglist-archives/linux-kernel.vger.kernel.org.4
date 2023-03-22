Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F776C43C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjCVHBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCVHBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:01:37 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A435B5E3;
        Wed, 22 Mar 2023 00:01:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PhJmn2wC7z4f4394;
        Wed, 22 Mar 2023 14:42:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiBHoxpkI55qFQ--.38915S7;
        Wed, 22 Mar 2023 14:42:18 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 3/6] md: add a mutex to synchronize idle and frozen in action_store()
Date:   Wed, 22 Mar 2023 14:41:19 +0800
Message-Id: <20230322064122.2384589-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiBHoxpkI55qFQ--.38915S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJryUWFy7Zw43WFW7ArWUurg_yoW8KF4kpF
        Wxta95Ar4DArsxJr47Jas7uay5Xwn2gFWDtry3uayfJ3WfArsFvFn0qFWUCFykua4fAFZF
        q3Z5XFsxXFy8Xr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUU
        U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, for idle and frozen, action_store will hold 'reconfig_mutex'
and call md_reap_sync_thread() to stop sync thread, however, this will
cause deadlock (explained in the next patch). In order to fix the
problem, following patch will release 'reconfig_mutex' and wait on
'resync_wait', like md_set_readonly() and do_md_stop() does.

Consider that action_store() will set/clear 'MD_RECOVERY_FROZEN'
unconditionally, which might cause unexpected problems, for example,
frozen just set 'MD_RECOVERY_FROZEN' and is still in progress, while
'idle' clear 'MD_RECOVERY_FROZEN' and new sync thread is started, which
might starve in progress frozen.

This patch add a mutex to synchronize idle and frozen from
action_store().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 5 +++++
 drivers/md/md.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 076936fee65a..223c03149852 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -656,6 +656,7 @@ void mddev_init(struct mddev *mddev)
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
 	mutex_init(&mddev->bitmap_info.mutex);
+	mutex_init(&mddev->sync_mutex);
 	INIT_LIST_HEAD(&mddev->disks);
 	INIT_LIST_HEAD(&mddev->all_mddevs);
 	timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
@@ -4783,14 +4784,18 @@ static void stop_sync_thread(struct mddev *mddev)
 
 static void idle_sync_thread(struct mddev *mddev)
 {
+	mutex_lock(&mddev->sync_mutex);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev);
+	mutex_unlock(&mddev->sync_mutex);
 }
 
 static void frozen_sync_thread(struct mddev *mddev)
 {
+	mutex_lock(&mddev->sync_mutex);
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev);
+	mutex_unlock(&mddev->sync_mutex);
 }
 
 static ssize_t
diff --git a/drivers/md/md.h b/drivers/md/md.h
index e148e3c83b0d..64474e458545 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -534,6 +534,9 @@ struct mddev {
 	bool	has_superblocks:1;
 	bool	fail_last_dev:1;
 	bool	serialize_policy:1;
+
+	/* Used to synchronize idle and frozen for action_store() */
+	struct mutex sync_mutex;
 };
 
 enum recovery_flags {
-- 
2.31.1

