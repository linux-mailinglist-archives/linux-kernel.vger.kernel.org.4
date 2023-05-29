Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8FE714A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjE2NY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjE2NYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:24:21 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D90C7;
        Mon, 29 May 2023 06:24:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVGTB5xgzz4f455B;
        Mon, 29 May 2023 21:24:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbB9p3RkWVPoKQ--.23397S7;
        Mon, 29 May 2023 21:24:15 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 3/6] md: add a mutex to synchronize idle and frozen in action_store()
Date:   Mon, 29 May 2023 21:20:34 +0800
Message-Id: <20230529132037.2124527-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbB9p3RkWVPoKQ--.23397S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJryUWFy7Zw43WFW7ArWUurg_yoW8KFyUpF
        WxJa95Ar4DArsxAr17Jan7uay5Xwn2gFWDtry3Ca1fG3WfAr4qqFn0gFWUuFykCa4fAF9F
        q3Z5XF43ZFy8Wr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
        1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUCXdbU
        UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
might starve in progress frozen. A mutex is added to synchronize idle
and frozen from action_store().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 5 +++++
 drivers/md/md.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 23e8e7eae062..63a993b52cd7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -644,6 +644,7 @@ void mddev_init(struct mddev *mddev)
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
 	mutex_init(&mddev->delete_mutex);
+	mutex_init(&mddev->sync_mutex);
 	mutex_init(&mddev->bitmap_info.mutex);
 	INIT_LIST_HEAD(&mddev->disks);
 	INIT_LIST_HEAD(&mddev->all_mddevs);
@@ -4785,14 +4786,18 @@ static void stop_sync_thread(struct mddev *mddev)
 
 static void idle_sync_thread(struct mddev *mddev)
 {
+	mutex_lock(&mddev->sync_mutex);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev);
+	mutex_unlock(&mddev->sync_mutex);
 }
 
 static void frozen_sync_thread(struct mddev *mddev)
 {
+	mutex_init(&mddev->delete_mutex);
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev);
+	mutex_unlock(&mddev->sync_mutex);
 }
 
 static ssize_t
diff --git a/drivers/md/md.h b/drivers/md/md.h
index bfd2306bc750..2fa903de5bd0 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -537,6 +537,9 @@ struct mddev {
 	/* Protect the deleting list */
 	struct mutex			delete_mutex;
 
+	/* Used to synchronize idle and frozen for action_store() */
+	struct mutex			sync_mutex;
+
 	bool	has_superblocks:1;
 	bool	fail_last_dev:1;
 	bool	serialize_policy:1;
-- 
2.39.2

