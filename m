Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3845164E65F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLPDeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLPDeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:34:07 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9858F379C3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:34:06 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NYF6j3NyVz16LYJ;
        Fri, 16 Dec 2022 11:33:01 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 11:34:01 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH] mm, slub: fix uninitialized variable in __slab_free
Date:   Fri, 16 Dec 2022 03:31:19 +0000
Message-ID: <20221216033119.14159-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

new.frozen is not initialized before it is used.

Fixes: 2cfb7455d223 ("slub: Rework allocator fastpaths")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index 13459c69095a..8628c88875b6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3593,6 +3593,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		return;
 	}
 
+	new.frozen = 0;
 	do {
 		if (unlikely(n)) {
 			spin_unlock_irqrestore(&n->list_lock, flags);
-- 
2.17.1

