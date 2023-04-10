Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018ED6DC2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDJCZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDJCZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:25:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3E54233
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F01061763
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E946C4339E;
        Mon, 10 Apr 2023 02:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681093479;
        bh=4A4DyiocA7iSLRN+kYgk0UYrwVmLr56Y98gdBv7T4VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mx4UEWTYXnX+SvedTlqQ/oWMLdG8xAtkFUZybN8GfM1d6E3CC0YIYGMqUI+j39ZKS
         mF2SzpSv5lRk3MjsIjYWwugztk/+WfRFTODZnmjTdFKHKMHJ0Ycwo23TdQ7VRhQKfs
         zr1PsAaFDNV1pbEWgi78izJqiyWRAwN/l+KN10/ivrwpBEn1PCNpgOeRY4G71iuyBP
         hotGOXlw5JgqiTCljar99yLckXboqKZQhgE1OLnqWURhtlkeByEoAPo0VWRmD0WNgI
         qZxoMe/3bE3kMjWBP/9yjO8E06NECcZsNR/LEbn5N3Les7/EQkqSzlaWVX3bOncv5X
         WEB77LaEHKxpw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: clean up with {attach,detach}_page_private()
Date:   Mon, 10 Apr 2023 10:24:18 +0800
Message-Id: <20230410022418.1843178-2-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410022418.1843178-1-chao@kernel.org>
References: <20230410022418.1843178-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ec8387da7f74..c378aedcadea 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1416,11 +1416,8 @@ static inline bool page_private_##name(struct page *page) \
 #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
 static inline void set_page_private_##name(struct page *page) \
 { \
-	if (!PagePrivate(page)) { \
-		get_page(page); \
-		SetPagePrivate(page); \
-		set_page_private(page, 0); \
-	} \
+	if (!PagePrivate(page)) \
+		attach_page_private(page, (void *)page->private); \
 	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
 	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
@@ -1429,13 +1426,8 @@ static inline void set_page_private_##name(struct page *page) \
 static inline void clear_page_private_##name(struct page *page) \
 { \
 	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) { \
-		set_page_private(page, 0); \
-		if (PagePrivate(page)) { \
-			ClearPagePrivate(page); \
-			put_page(page); \
-		}\
-	} \
+	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
+		detach_page_private(page); \
 }
 
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
@@ -1464,11 +1456,8 @@ static inline unsigned long get_page_private_data(struct page *page)
 
 static inline void set_page_private_data(struct page *page, unsigned long data)
 {
-	if (!PagePrivate(page)) {
-		get_page(page);
-		SetPagePrivate(page);
-		set_page_private(page, 0);
-	}
+	if (!PagePrivate(page))
+		attach_page_private(page, 0);
 	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
 	page_private(page) |= data << PAGE_PRIVATE_MAX;
 }
@@ -1476,13 +1465,8 @@ static inline void set_page_private_data(struct page *page, unsigned long data)
 static inline void clear_page_private_data(struct page *page)
 {
 	page_private(page) &= GENMASK(PAGE_PRIVATE_MAX - 1, 0);
-	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) {
-		set_page_private(page, 0);
-		if (PagePrivate(page)) {
-			ClearPagePrivate(page);
-			put_page(page);
-		}
-	}
+	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER))
+		detach_page_private(page);
 }
 
 /* For compression */
-- 
2.25.1

