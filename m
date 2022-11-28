Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC78963AC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiK1PXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiK1PXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:23:30 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E8525EA;
        Mon, 28 Nov 2022 07:23:29 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLTk223r5z15MtB;
        Mon, 28 Nov 2022 23:22:50 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 23:23:27 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 23:23:27 +0800
From:   Li Nan <linan122@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linan122@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next 2/8] blk-iocost: improve hanlder of match_u64()
Date:   Mon, 28 Nov 2022 23:44:28 +0800
Message-ID: <20221128154434.4177442-3-linan122@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221128154434.4177442-1-linan122@huawei.com>
References: <20221128154434.4177442-1-linan122@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

1) There are one place that return value of match_u64() is not checked.
2) If match_u64() failed, return value is set to -EINVAL despite that
   there are other possible errnos.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/blk-iocost.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index fd495e823db2..c532129a1456 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3202,6 +3202,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
 		int tok;
+		int err;
 		s64 v;
 
 		if (!*p)
@@ -3209,7 +3210,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 		switch (match_token(p, qos_ctrl_tokens, args)) {
 		case QOS_ENABLE:
-			match_u64(&args[0], &v);
+			err = match_u64(&args[0], &v);
+			if (err) {
+				ret = err;
+				goto out_unlock;
+			}
+
 			enable = v;
 			continue;
 		case QOS_CTRL:
@@ -3238,8 +3244,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			break;
 		case QOS_RLAT:
 		case QOS_WLAT:
-			if (match_u64(&args[0], &v))
+			err = match_u64(&args[0], &v);
+			if (err) {
+				ret = err;
 				goto out_unlock;
+			}
+
 			qos[tok] = v;
 			break;
 		case QOS_MIN:
@@ -3374,6 +3384,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
 		int tok;
+		int err;
 		u64 v;
 
 		if (!*p)
@@ -3399,8 +3410,13 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		tok = match_token(p, i_lcoef_tokens, args);
 		if (tok == NR_I_LCOEFS)
 			goto out_unlock;
-		if (match_u64(&args[0], &v))
+
+		err = match_u64(&args[0], &v);
+		if (err) {
+			ret = err;
 			goto out_unlock;
+		}
+
 		u[tok] = v;
 		user = true;
 	}
-- 
2.31.1

