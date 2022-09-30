Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7093E5F09BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiI3LPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiI3LOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:14:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED2C13D57
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:54:49 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mf667321QzHqX7;
        Fri, 30 Sep 2022 18:34:07 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:36:26 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:36:26 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next] tracing: Remove unused variable 'dups'
Date:   Fri, 30 Sep 2022 18:32:36 +0800
Message-ID: <20220930103236.253985-1-chenzhongjin@huawei.com>
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

Reported by Clang [-Wunused-but-set-variable]

'commit c193707dde77 ("tracing: Remove code which merges duplicates")'
This commit removed the code which merges duplicates in detect_dups(),
but forgot to delete the variable 'dups' which used to merge
duplicates in the loop.

Now only 'total_dups' is needed, remove 'dups' for clean code.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/trace/tracing_map.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9901708ce6b8..c774e560f2f9 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -961,7 +961,7 @@ create_sort_entry(void *key, struct tracing_map_elt *elt)
 static void detect_dups(struct tracing_map_sort_entry **sort_entries,
 		      int n_entries, unsigned int key_size)
 {
-	unsigned int dups = 0, total_dups = 0;
+	unsigned int total_dups = 0;
 	int i;
 	void *key;
 
@@ -974,11 +974,10 @@ static void detect_dups(struct tracing_map_sort_entry **sort_entries,
 	key = sort_entries[0]->key;
 	for (i = 1; i < n_entries; i++) {
 		if (!memcmp(sort_entries[i]->key, key, key_size)) {
-			dups++; total_dups++;
+			total_dups++;
 			continue;
 		}
 		key = sort_entries[i]->key;
-		dups = 0;
 	}
 
 	WARN_ONCE(total_dups > 0,
-- 
2.17.1

