Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3465073BD6B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjFWRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjFWRID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:08:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A3F30D1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=02timQVtu6aTaDZlo3R3D4w+fsAbkYRbfC53CEOsKBw=; b=e5lTG91llhH4wWPjAixCgHASoQ
        gEle+9UxZ6FBfNOKYQG5tbXufVqeX2JO/BNMifZCSCFBf+Eu+u6KxoYOmP7zTnftJyD/f7PuJAfO+
        GhBUJKrVqcLzsJzVrH2HyzuFShUiMSqkikpXxPKcT0/0caDupaOYyKzNzwb6w6jCU7dOb1+brYkY2
        WgmpzocQzziisZKh986bzrE0Vz6Cn7SfuzwKH0EFww5gkSfJGjAPX7lddtAAIOiWrC4NxRFfVr8/r
        XNf1aSU/OI5IhQuHwb2yQL9iaD+fQ8BY8EYj4gBjtT1CVumUxqG7z9c0fWEkomcqJIrJSgJGZ7Pcd
        xd38NNSw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCkG4-00GdfI-Oa; Fri, 23 Jun 2023 17:07:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Fix sparse warnings in backing-dev.h
Date:   Fri, 23 Jun 2023 18:07:37 +0100
Message-Id: <20230623170737.3965705-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a context imbalance, and indeed _begin() returns
with the RCU lock held and _end() releases it.  Reassure sparse that
this is fine by adding appropriate annotations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/backing-dev.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index fbad4fcd408e..69bb13412a3e 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -284,8 +284,9 @@ static inline struct bdi_writeback *inode_to_wb_wbc(
  * can't sleep during the transaction.  IRQs may or may not be disabled on
  * return.
  */
-static inline struct bdi_writeback *
-unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
+static inline
+struct bdi_writeback *unlocked_inode_to_wb_begin(struct inode *inode,
+		struct wb_lock_cookie *cookie) __acquires(RCU)
 {
 	rcu_read_lock();
 
@@ -311,7 +312,7 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
  * @cookie: @cookie from unlocked_inode_to_wb_begin()
  */
 static inline void unlocked_inode_to_wb_end(struct inode *inode,
-					    struct wb_lock_cookie *cookie)
+		struct wb_lock_cookie *cookie) __releases(RCU)
 {
 	if (unlikely(cookie->locked))
 		xa_unlock_irqrestore(&inode->i_mapping->i_pages, cookie->flags);
-- 
2.39.2

