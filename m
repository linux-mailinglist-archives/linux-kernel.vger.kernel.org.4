Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5685E62A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiIVMl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiIVMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:41:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD1AE7E0A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:41:53 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYFDg0TGfzWgy7;
        Thu, 22 Sep 2022 20:37:55 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:41:52 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:41:52 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>
CC:     <dvyukov@google.com>, <andreyknvl@gmail.com>,
        <akpm@linux-foundation.org>, <elver@google.com>,
        <bigeasy@linutronix.de>, <nogikh@google.com>, <liu3101@purdue.edu>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next v2] kcov: Switch to use list_for_each_entry() helper
Date:   Thu, 22 Sep 2022 20:38:10 +0800
Message-ID: <20220922123810.227015-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
v1 -> v2:
- Forgot to change pos as area, fix it.
---
 kernel/kcov.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index e19c84b02452..6c94913dc3a6 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -133,10 +133,8 @@ static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
 static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
 {
 	struct kcov_remote_area *area;
-	struct list_head *pos;
 
-	list_for_each(pos, &kcov_remote_areas) {
-		area = list_entry(pos, struct kcov_remote_area, list);
+	list_for_each_entry(area, &kcov_remote_areas, list) {
 		if (area->size == size) {
 			list_del(&area->list);
 			return area;
-- 
2.17.1

