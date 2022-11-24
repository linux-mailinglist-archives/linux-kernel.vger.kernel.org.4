Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4460F63715C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKXECl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKXECg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:02:36 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D001C10F2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:02:30 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowACXnjbT7H5jRa6HAQ--.13010S2;
        Thu, 24 Nov 2022 12:02:28 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] mm/vmalloc: Add check for KMEM_CACHE
Date:   Thu, 24 Nov 2022 12:02:26 +0800
Message-Id: <20221124040226.17953-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXnjbT7H5jRa6HAQ--.13010S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW8ZrWUCw17Gw17uFWDXFb_yoW8Jw1UpF
        W3Gw13Wr4rXwnxCrnxJFW8WF1fKa1ktFy8Ka1a9w18Zw1akF4fZFW5J348XryrurZrAF12
        vF18K3Wrur42qr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As KMEM_CACHE may return NULL pointer, it should
be better to check the return value in order to
avoid NULL pointer dereference in kmem_cache_zalloc.

Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 mm/vmalloc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccaa461998f3..df3e59f614cc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2426,15 +2426,17 @@ void __init vmalloc_init(void)
 	}
 
 	/* Import existing vmlist entries. */
-	for (tmp = vmlist; tmp; tmp = tmp->next) {
-		va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
-		if (WARN_ON_ONCE(!va))
-			continue;
+	if (!WARN_ON_ONCE(!vmap_area_cachep)) {
+		for (tmp = vmlist; tmp; tmp = tmp->next) {
+			va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
+			if (WARN_ON_ONCE(!va))
+				continue;
 
-		va->va_start = (unsigned long)tmp->addr;
-		va->va_end = va->va_start + tmp->size;
-		va->vm = tmp;
-		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+			va->va_start = (unsigned long)tmp->addr;
+			va->va_end = va->va_start + tmp->size;
+			va->vm = tmp;
+			insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+		}
 	}
 
 	/*
-- 
2.25.1

