Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DD95E6038
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiIVKyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIVKyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:54:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BE2D4308
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:54:09 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYBtN48lnzHqKQ;
        Thu, 22 Sep 2022 18:51:56 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 18:54:06 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 18:54:06 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>
CC:     <liu3101@purdue.edu>, <bigeasy@linutronix.de>, <nogikh@google.com>,
        <elver@google.com>, <akpm@linux-foundation.org>,
        <andreyknvl@gmail.com>, <dvyukov@google.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next] kcov: Switch to use list_for_each_entry() helper
Date:   Thu, 22 Sep 2022 18:50:25 +0800
Message-ID: <20220922105025.119941-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use list_for_each_entry() helper instead of list_for_each() and
list_entry() to simplify code a bit.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/kcov.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index e19c84b02452..466d7689de5b 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -133,10 +133,8 @@ static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
 static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
 {
 	struct kcov_remote_area *area;
-	struct list_head *pos;
 
-	list_for_each(pos, &kcov_remote_areas) {
-		area = list_entry(pos, struct kcov_remote_area, list);
+	list_for_each_entry(pos, &kcov_remote_areas, list) {
 		if (area->size == size) {
 			list_del(&area->list);
 			return area;
-- 
2.17.1

