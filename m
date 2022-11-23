Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCC636130
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiKWOLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbiKWOLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:11:11 -0500
X-Greylist: delayed 1803 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 06:11:08 PST
Received: from m126.mail.126.com (m126.mail.126.com [123.126.96.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F290B92
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=x8W5f
        h9VbHoZWZ6ymIAUg8ezurxWq9/jC6mUoLoDw1Q=; b=MYXMqZXeTIN/UKn+cnY7R
        AtqJQvqhloF4QjKVbTHXCt8qSfGIDZ9DLvX6BrZ651SLJJuKxjvV1rFB/2gis/af
        9bVQDWnrTmUKwVVUufy9twX5G9gdgA7fuV7+MPv9YkKvvBpB9TP1WuMlgBaS2a8A
        O9GvVBW6sO/rSkGXtZvR+E=
Received: from localhost.localdomain (unknown [221.228.128.183])
        by smtp12 (Coremail) with SMTP id fORpCgAnN0TjIn5jjy+BAA--.33586S2;
        Wed, 23 Nov 2022 21:40:53 +0800 (CST)
From:   wonder_rock@126.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Deyan Wang <wonder_rock@126.com>
Subject: [PATCH 1/1] mm/page_alloc: merge two get_pfnblock_migratetype() into one
Date:   Wed, 23 Nov 2022 21:40:43 +0800
Message-Id: <20221123134043.33896-1-wonder_rock@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: fORpCgAnN0TjIn5jjy+BAA--.33586S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr17tFWrAr1rKFyfGF1fCrg_yoWDZFg_ua
        nFvrs7Cr43tF9F9r47Awn7JF97t3Z5CFyxWa1rJrsxAFWUXFn7tF4DJrs3CrZ8WFsIgry8
        C3WvvFZIkw1IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtZ2a7UUUUU==
X-Originating-IP: [221.228.128.183]
X-CM-SenderInfo: xzrqvv5ubu0ubn6rjloofrz/1tbiuQXCgVpD-MRFVAAAsP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deyan Wang <wonder_rock@126.com>

It is safe to get_pfnblock_migratetype() in critical section,
so just call get_pfnblock_migratetype() once.

Signed-off-by: Deyan Wang <wonder_rock@126.com>
---
 mm/page_alloc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6652df1f5cc8..c7ba9d65d1c0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1704,13 +1704,8 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	if (!free_pages_prepare(page, order, true, fpi_flags))
 		return;
 
-	migratetype = get_pfnblock_migratetype(page, pfn);
-
 	spin_lock_irqsave(&zone->lock, flags);
-	if (unlikely(has_isolate_pageblock(zone) ||
-		is_migrate_isolate(migratetype))) {
-		migratetype = get_pfnblock_migratetype(page, pfn);
-	}
+	migratetype = get_pfnblock_migratetype(page, pfn);
 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-- 
2.25.1

