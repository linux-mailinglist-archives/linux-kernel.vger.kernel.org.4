Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6868C326
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBFQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjBFQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:25:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B64012060
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nF6VemGYIMnYuGIHOUFNbRptyFqb1wpSr8JOeBMchwA=; b=JE08NReqM+L8JNrJTSlKV36WgV
        brl6e/hTgH3unVH/VHUnnBP+gnb2HnmY9YhCJjHxuSe+glqLFFsi4Czrmsid6uvwYUmhoGCLqBjZ7
        bMsuY1FH+siGfDtQoY8o3sh766KqFqwc6MfJ6DRGlXlXz8gkpIlVxLAyStjcK3v6ayquUDkSXaFQx
        D1K8LzLDsOGz0IIJWpNq89Mz72tlhWFkT9+L03QegIsi10xF9o7qVJefZhxDG+zwcBlhlYwp0XuN+
        JRF5DdVhRZDbdSQgEx0WEq6MldHmE0LLV5ThXMj8onAHSF0RyO029DIp3kugg4uqGBraOdSRLQoZS
        +GuwyxhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP4JG-00Gu8d-BT; Mon, 06 Feb 2023 16:25:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, mhocko@suse.com, vbabka@suse.cz,
        quic_pkondeti@quicinc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH 1/2] filemap: Add mapping_read_folio_gfp()
Date:   Mon,  6 Feb 2023 16:25:19 +0000
Message-Id: <20230206162520.4029022-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is like read_cache_page_gfp() except it returns the folio instead
of the precise page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 47069662f4b8..cf0677419981 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -758,6 +758,8 @@ static inline struct page *grab_cache_page(struct address_space *mapping,
 
 struct folio *read_cache_folio(struct address_space *, pgoff_t index,
 		filler_t *filler, struct file *file);
+struct folio *mapping_read_folio_gfp(struct address_space *, pgoff_t index,
+		gfp_t flags);
 struct page *read_cache_page(struct address_space *, pgoff_t index,
 		filler_t *filler, struct file *file);
 extern struct page * read_cache_page_gfp(struct address_space *mapping,
diff --git a/mm/filemap.c b/mm/filemap.c
index 992554c18f1f..2ebcf500871d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3585,6 +3585,30 @@ struct folio *read_cache_folio(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(read_cache_folio);
 
+/**
+ * mapping_read_folio_gfp - Read into page cache, using specified allocation flags.
+ * @mapping:	The address_space for the folio.
+ * @index:	The index that the allocated folio will contain.
+ * @gfp:	The page allocator flags to use if allocating.
+ *
+ * This is the same as "read_cache_folio(mapping, index, NULL, NULL)", but with
+ * any new memory allocations done using the specified allocation flags.
+ *
+ * The most likely error from this function is EIO, but ENOMEM is
+ * possible and so is EINTR.  If ->read_folio returns another error,
+ * that will be returned to the caller.
+ *
+ * The function expects mapping->invalidate_lock to be already held.
+ *
+ * Return: Uptodate folio on success, ERR_PTR() on failure.
+ */
+struct folio *mapping_read_folio_gfp(struct address_space *mapping,
+		pgoff_t index, gfp_t gfp)
+{
+	return do_read_cache_folio(mapping, index, NULL, NULL, gfp);
+}
+EXPORT_SYMBOL(mapping_read_folio_gfp);
+
 static struct page *do_read_cache_page(struct address_space *mapping,
 		pgoff_t index, filler_t *filler, struct file *file, gfp_t gfp)
 {
-- 
2.35.1

