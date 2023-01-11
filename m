Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270FB66576C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjAKJ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjAKJ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:28:07 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1B3B1ED
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:27:49 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 204191A00A19;
        Wed, 11 Jan 2023 17:28:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DO63PvYobsTQ; Wed, 11 Jan 2023 17:28:02 +0800 (CST)
Received: from kernel.localdomain (unknown [219.141.250.2])
        (Authenticated sender: lvqian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 1833F1A00818;
        Wed, 11 Jan 2023 17:28:02 +0800 (CST)
From:   lvqian@nfschina.com
To:     cl@linux.co, penberg@kernel.org, rientjes@google.com, kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        lvqian <lvqian@nfschina.com>
Subject: [PATCH V2] mm/slab.c: Delete the if statement 
Date:   Wed, 11 Jan 2023 17:27:44 +0800
Message-Id: <20230111092744.112038-1-lvqian@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lvqian <lvqian@nfschina.com>

	Remove the if statement to increase code readability.

Signed-off-by: lvqian <lvqian@nfschina.com>
---
 v2: Modify the subject content
---
 mm/slab.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 7a269db050ee..713265fe2dea 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1415,11 +1415,8 @@ static void kmem_rcu_free(struct rcu_head *head)
 #if DEBUG
 static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
 {
-	if (debug_pagealloc_enabled_static() && OFF_SLAB(cachep) &&
-		(cachep->size % PAGE_SIZE) == 0)
-		return true;
-
-	return false;
+	return debug_pagealloc_enabled_static() && OFF_SLAB(cachep) &&
+			((cachep->size % PAGE_SIZE) == 0);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-- 
2.34.1

