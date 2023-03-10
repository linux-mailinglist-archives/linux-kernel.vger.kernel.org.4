Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641B96B3789
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCJHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjCJHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:39:51 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00925F8E46;
        Thu,  9 Mar 2023 23:39:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PXycQ3n94z4f3jqn;
        Fri, 10 Mar 2023 15:39:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+03gpkwSimEg--.34063S9;
        Fri, 10 Mar 2023 15:39:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, song@kernel.org, jgq516@gmail.com,
        neilb@suse.de, shli@fb.com, lzhong@suse.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 5/6] md/raid10: fix memleak for 'conf->bio_split'
Date:   Fri, 10 Mar 2023 15:38:54 +0800
Message-Id: <20230310073855.1337560-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230310073855.1337560-1-yukuai1@huaweicloud.com>
References: <20230310073855.1337560-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+03gpkwSimEg--.34063S9
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWxGw4UXF43tF48uw18Grg_yoW8Kr1fpa
        nxK345Kr47Za9xJryDJFWDua4Yqr1xtayUCry7Aw4rXF4ftrZ2y3W0yrWxWryUuay2gry3
        tFW5KFWruFn8Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

In the error path of raid10_run(), 'conf' need be freed, however,
'conf->bio_split' is missed and memory will be leaked.

Since there are 3 places to free 'conf', factor out a helper to fix the
problem.

Fixes: fc9977dd069e ("md/raid10: simplify the splitting of requests.")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f7002a1aa9cf..bdfa02e8fe7e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4009,6 +4009,20 @@ static int setup_geo(struct geom *geo, struct mddev *mddev, enum geo_type new)
 	return nc*fc;
 }
 
+static void raid10_free_conf(struct r10conf *conf)
+{
+	if (!conf)
+		return;
+
+	mempool_exit(&conf->r10bio_pool);
+	kfree(conf->mirrors);
+	kfree(conf->mirrors_old);
+	kfree(conf->mirrors_new);
+	safe_put_page(conf->tmppage);
+	bioset_exit(&conf->bio_split);
+	kfree(conf);
+}
+
 static struct r10conf *setup_conf(struct mddev *mddev)
 {
 	struct r10conf *conf = NULL;
@@ -4091,13 +4105,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	return conf;
 
  out:
-	if (conf) {
-		mempool_exit(&conf->r10bio_pool);
-		kfree(conf->mirrors);
-		safe_put_page(conf->tmppage);
-		bioset_exit(&conf->bio_split);
-		kfree(conf);
-	}
+	raid10_free_conf(conf);
 	return ERR_PTR(err);
 }
 
@@ -4288,10 +4296,7 @@ static int raid10_run(struct mddev *mddev)
 
 out_free_conf:
 	md_unregister_thread(&mddev->thread);
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf);
+	raid10_free_conf(conf);
 	mddev->private = NULL;
 out:
 	return -EIO;
@@ -4299,15 +4304,7 @@ static int raid10_run(struct mddev *mddev)
 
 static void raid10_free(struct mddev *mddev, void *priv)
 {
-	struct r10conf *conf = priv;
-
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf->mirrors_old);
-	kfree(conf->mirrors_new);
-	bioset_exit(&conf->bio_split);
-	kfree(conf);
+	raid10_free_conf(priv);
 }
 
 static void raid10_quiesce(struct mddev *mddev, int quiesce)
-- 
2.31.1

