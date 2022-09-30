Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C815F09CC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiI3LRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiI3LQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:16:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24C1BE3C;
        Fri, 30 Sep 2022 03:59:40 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mf65z2txyzlXNg;
        Fri, 30 Sep 2022 18:33:59 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:38:18 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:38:18 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <chenzhongjin@huawei.com>
Subject: [PATCH -next] block: Remove unused variable 'added'
Date:   Fri, 30 Sep 2022 18:34:28 +0800
Message-ID: <20220930103428.21823-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Clang [-Wunused-but-set-variable]

'commit 480cb846c27b ("block: convert to advancing variants of iov_iter_get_pages{,_alloc}()")'
This commit converted iov_iter_advance() to iov_iter_revert(), and
not uses variable 'added' anymore but forgot to delete it.

Since 'added' is useless now, remove it for code cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 block/blk-map.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 7196a6b64c80..1d5e609589c0 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -251,7 +251,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	while (iov_iter_count(iter)) {
 		struct page **pages;
 		ssize_t bytes;
-		size_t offs, added = 0;
+		size_t offs;
 		int npages;
 
 		bytes = iov_iter_get_pages_alloc2(iter, &pages, LONG_MAX, &offs);
@@ -280,7 +280,6 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 					break;
 				}
 
-				added += n;
 				bytes -= n;
 				offs = 0;
 			}
-- 
2.17.1

