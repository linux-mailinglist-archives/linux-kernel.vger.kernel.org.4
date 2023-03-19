Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E186C00F0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCSLmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjCSLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:42:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EB823647
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B32FE60FCF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 11:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9254C433D2;
        Sun, 19 Mar 2023 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679226146;
        bh=3Ae5b1cM6n8dUopEW2/hVH5kWClmHMJCBK1/s5YMwP0=;
        h=From:To:Cc:Subject:Date:From;
        b=jpHhyinUPVEMDa7Bt5tUDUQt7uPQvb5YR+li6BaYImkNbTNB9nCB17Bc0d6npSG7H
         cmuw83vRra+IXFNs0Wqb44B2bvoXZPRrXSYHsAd3pxaPTiElPKRNCc2QXRWak00OPG
         8Y/AsZ7gmwKX65vkZsOeQPWF4A6bF89ey4ZNC3UxGjcq9PDJw3bENhEoq/xJurnf3+
         bXxrB5OqDODukOS0mC75E0s/JjNPD7oMTH5899IMPU4mYDmhJudZtojJrCFwmlX8W9
         M5QPhU7GYiVABKK6xnM86y+cCsrT0O6H+SJh33AL77vAXcuTsFt7p1bkqTQdkRJ3e+
         WYDqYPiWMnK5Q==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: move get_page_from_free_area() to mm/page_alloc.c
Date:   Sun, 19 Mar 2023 13:42:14 +0200
Message-Id: <20230319114214.2133332-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

The get_page_from_free_area() helper is only used in mm/page_alloc.c so
move it there to reduce noise in include/linux/mmzone.h

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mmzone.h | 7 -------
 mm/page_alloc.c        | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 96599cb9eb62..8f5a9e2c722a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -108,13 +108,6 @@ struct free_area {
 	unsigned long		nr_free;
 };
 
-static inline struct page *get_page_from_free_area(struct free_area *area,
-					    int migratetype)
-{
-	return list_first_entry_or_null(&area->free_list[migratetype],
-					struct page, lru);
-}
-
 static inline bool free_area_empty(struct free_area *area, int migratetype)
 {
 	return list_empty(&area->free_list[migratetype]);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 87d760236dba..2e72fdbdd8db 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1048,6 +1048,13 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 	zone->free_area[order].nr_free--;
 }
 
+static inline struct page *get_page_from_free_area(struct free_area *area,
+					    int migratetype)
+{
+	return list_first_entry_or_null(&area->free_list[migratetype],
+					struct page, lru);
+}
+
 /*
  * If this is not the largest possible page, check if the buddy
  * of the next-highest order is free. If it is, it's possible

base-commit: 4018ab1f7cec061b8425737328edefebdc0ab832
-- 
2.35.1

