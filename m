Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72A652DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiLUINy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLUINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:13:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94071EED9;
        Wed, 21 Dec 2022 00:13:47 -0800 (PST)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NcR4y6C8lzRq4g;
        Wed, 21 Dec 2022 16:12:34 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 16:13:45 +0800
From:   Zhong Jinghua <zhongjinghua@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhongjinghua@huawei.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH-next v2] blk-mq: cleanup unused methods: blk_mq_hw_sysfs_store
Date:   Wed, 21 Dec 2022 16:34:21 +0800
Message-ID: <20221221083421.786849-1-zhongjinghua@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found that the blk_mq_hw_sysfs_store interface has no place to use.
The object default_hw_ctx_attrs using blk_mq_hw_sysfs_ops only uses
the show method and does not use the store method.

Since this patch:
4a46f05ebf99 ("blk-mq: move hctx and ctx counters from sysfs to debugfs")
moved the store method to debugfs, the store method is not used anymore.

So let me do some tiny work to clean up unused code.

Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 v2: changed debuffs to debugfs in commit message 
 block/blk-mq-sysfs.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 93997d297d42..40450e469ba6 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -70,28 +70,6 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 	return res;
 }
 
-static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
-				     struct attribute *attr, const char *page,
-				     size_t length)
-{
-	struct blk_mq_hw_ctx_sysfs_entry *entry;
-	struct blk_mq_hw_ctx *hctx;
-	struct request_queue *q;
-	ssize_t res;
-
-	entry = container_of(attr, struct blk_mq_hw_ctx_sysfs_entry, attr);
-	hctx = container_of(kobj, struct blk_mq_hw_ctx, kobj);
-	q = hctx->queue;
-
-	if (!entry->store)
-		return -EIO;
-
-	mutex_lock(&q->sysfs_lock);
-	res = entry->store(hctx, page, length);
-	mutex_unlock(&q->sysfs_lock);
-	return res;
-}
-
 static ssize_t blk_mq_hw_sysfs_nr_tags_show(struct blk_mq_hw_ctx *hctx,
 					    char *page)
 {
@@ -150,7 +128,6 @@ ATTRIBUTE_GROUPS(default_hw_ctx);
 
 static const struct sysfs_ops blk_mq_hw_sysfs_ops = {
 	.show	= blk_mq_hw_sysfs_show,
-	.store	= blk_mq_hw_sysfs_store,
 };
 
 static struct kobj_type blk_mq_ktype = {
-- 
2.31.1

