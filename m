Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E795B3150
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiIIIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIIIFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:05:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC17B5EDCA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:05:41 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP7k46TzWzlVjk;
        Fri,  9 Sep 2022 16:01:48 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 16:05:40 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 16:05:39 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rusty Russell <rusty@rustcorp.com.au>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm/shuffle: convert module_param_call to module_param_cb
Date:   Fri, 9 Sep 2022 16:39:47 +0800
Message-ID: <20220909083947.3595610-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_param_call is now completely consistent with module_param_cb, so
there is no need to keep two macros. Convert module_param_call to
module_param_cb since former is obsolete and latter is more kernel-ish.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/shuffle.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/shuffle.c b/mm/shuffle.c
index c13c33b247e8..fb1393b8b3a9 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -12,23 +12,22 @@
 DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
 
 static bool shuffle_param;
-static int shuffle_show(char *buffer, const struct kernel_param *kp)
-{
-	return sprintf(buffer, "%c\n", shuffle_param ? 'Y' : 'N');
-}
 
-static __meminit int shuffle_store(const char *val,
+static __meminit int shuffle_param_set(const char *val,
 		const struct kernel_param *kp)
 {
-	int rc = param_set_bool(val, kp);
-
-	if (rc < 0)
-		return rc;
-	if (shuffle_param)
+	if (param_set_bool(val, kp))
+		return -EINVAL;
+	if (*(bool *)kp->arg)
 		static_branch_enable(&page_alloc_shuffle_key);
 	return 0;
 }
-module_param_call(shuffle, shuffle_store, shuffle_show, &shuffle_param, 0400);
+
+static const struct kernel_param_ops shuffle_param_ops = {
+	.set = shuffle_param_set,
+	.get = param_get_bool,
+};
+module_param_cb(shuffle, &shuffle_param_ops, &shuffle_param, 0400);
 
 /*
  * For two pages to be swapped in the shuffle, they must be free (on a
-- 
2.25.1

