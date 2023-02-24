Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC86A1DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBXOtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjBXOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:49:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A376C1116E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677250090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3Iwur3DaO9qOJlnUw5ODrEZJsIUBj4dSLzn2wwaUV8=;
        b=Goa8GoS/MnDuGTedcWnHgthKccmV1UZH+DqHBbd3B08c4A5cXfTi4lip8+Vqqcg79e3DR0
        Kp07sC/8TbPuuPtxHTWe9pHJu+ssfLBfhtvAc+JseXR7TwD9h2dB0b30l7ru6qJ8kjsf+G
        kQx9E2kiW3g90mel9qe3b9V9OJdtOdc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-p9_Us-HwPMethNlGGb1Kzg-1; Fri, 24 Feb 2023 09:48:07 -0500
X-MC-Unique: p9_Us-HwPMethNlGGb1Kzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7677A3C0E213;
        Fri, 24 Feb 2023 14:48:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DF552166B29;
        Fri, 24 Feb 2023 14:48:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2134430.1677240738@warthog.procyon.org.uk>
References: <2134430.1677240738@warthog.procyon.org.uk> <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com> <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <stfrench@microsoft.com>
Cc:     dhowells@redhat.com, Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] cifs, afs: Revert changes to {cifs,afs}_writepages_region()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2214156.1677250083.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 24 Feb 2023 14:48:03 +0000
Message-ID: <2214157.1677250083@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a more complex patch that reverts Vishal's patch to afs and your
changes to cifs back to the point where find_get_pages_range_tag() was
being used to get a single folio and then replace that with a function,
filemap_get_folio_tag() that just gets a single folio.  An alternative way
of doing this would be to make filemap_get_folios_tag() take a limit count=
.

This is likely to be more efficient for the common case as
*_extend_writeback() will deal with pages that are contiguous to the
starting page before we get on to continuing to process the batch.

For filemap_get_folios_tag() to be of use, the batch has to be passed down=
,
and if it contains scattered, non-contiguous pages, these are likely to en=
d
up being pinned by the batch for significant periods of time whilst I/O is
undertaken on earlier pages.
    =

Fix: 3822a7c40997 ("Merge tag 'mm-stable-2023-02-20-13-37' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/akpm/mm")
Fix: acc8d8588cb7 ("afs: convert afs_writepages_region() to use filemap_ge=
t_folios_tag()")
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/afs/write.c          |  116 +++++++++++++++++++++++-------------------=
------
 fs/cifs/file.c          |  114 ++++++++++++++++++++----------------------=
-----
 include/linux/pagemap.h |    2 =

 mm/filemap.c            |   58 ++++++++++++++++++++++++
 4 files changed, 165 insertions(+), 125 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 571f3b9a417e..b04a95262c4f 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -704,87 +704,83 @@ static int afs_writepages_region(struct address_spac=
e *mapping,
 				 bool max_one_loop)
 {
 	struct folio *folio;
-	struct folio_batch fbatch;
 	ssize_t ret;
-	unsigned int i;
 	int n, skips =3D 0;
 =

 	_enter("%llx,%llx,", start, end);
-	folio_batch_init(&fbatch);
 =

 	do {
 		pgoff_t index =3D start / PAGE_SIZE;
 =

-		n =3D filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					PAGECACHE_TAG_DIRTY, &fbatch);
-
-		if (!n)
+		folio =3D filemap_get_folio_tag(mapping, &index, end / PAGE_SIZE,
+					      PAGECACHE_TAG_DIRTY);
+		if (!folio)
 			break;
-		for (i =3D 0; i < n; i++) {
-			folio =3D fbatch.folios[i];
-			start =3D folio_pos(folio); /* May regress with THPs */
 =

-			_debug("wback %lx", folio_index(folio));
+		start =3D folio_pos(folio); /* May regress with THPs */
 =

-			/* At this point we hold neither the i_pages lock nor the
-			 * page lock: the page may be truncated or invalidated
-			 * (changing page->mapping to NULL), or even swizzled
-			 * back from swapper_space to tmpfs file mapping
-			 */
-			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
-				ret =3D folio_lock_killable(folio);
-				if (ret < 0) {
-					folio_batch_release(&fbatch);
-					return ret;
-				}
-			} else {
-				if (!folio_trylock(folio))
-					continue;
-			}
+		_debug("wback %lx", folio_index(folio));
 =

-			if (folio->mapping !=3D mapping ||
-			    !folio_test_dirty(folio)) {
-				start +=3D folio_size(folio);
-				folio_unlock(folio);
-				continue;
+		/* At this point we hold neither the i_pages lock nor the
+		 * page lock: the page may be truncated or invalidated
+		 * (changing page->mapping to NULL), or even swizzled
+		 * back from swapper_space to tmpfs file mapping
+		 */
+		if (wbc->sync_mode !=3D WB_SYNC_NONE) {
+			ret =3D folio_lock_killable(folio);
+			if (ret < 0) {
+				folio_put(folio);
+				return ret;
+			}
+		} else {
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
+				return 0;
 			}
+		}
 =

-			if (folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				if (wbc->sync_mode !=3D WB_SYNC_NONE) {
-					folio_wait_writeback(folio);
+		if (folio_mapping(folio) !=3D mapping ||
+		    !folio_test_dirty(folio)) {
+			start +=3D folio_size(folio);
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+
+		if (folio_test_writeback(folio) ||
+		    folio_test_fscache(folio)) {
+			folio_unlock(folio);
+			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
+				folio_wait_writeback(folio);
 #ifdef CONFIG_AFS_FSCACHE
-					folio_wait_fscache(folio);
+				folio_wait_fscache(folio);
 #endif
-				} else {
-					start +=3D folio_size(folio);
-				}
-				if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
-					if (skips >=3D 5 || need_resched()) {
-						*_next =3D start;
-						_leave(" =3D 0 [%llx]", *_next);
-						return 0;
-					}
-					skips++;
-				}
-				continue;
+			} else {
+				start +=3D folio_size(folio);
 			}
-
-			if (!folio_clear_dirty_for_io(folio))
-				BUG();
-			ret =3D afs_write_back_from_locked_folio(mapping, wbc,
-					folio, start, end);
-			if (ret < 0) {
-				_leave(" =3D %zd", ret);
-				folio_batch_release(&fbatch);
-				return ret;
+			folio_put(folio);
+			if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
+				if (skips >=3D 5 || need_resched())
+					break;
+				skips++;
 			}
+			continue;
+		}
 =

-			start +=3D ret;
+		if (!folio_clear_dirty_for_io(folio))
+			BUG();
+		ret =3D afs_write_back_from_locked_folio(mapping, wbc, folio, start, en=
d);
+		folio_put(folio);
+		if (ret < 0) {
+			_leave(" =3D %zd", ret);
+			return ret;
 		}
 =

-		folio_batch_release(&fbatch);
+		start +=3D ret;
+
+		if (max_one_loop)
+			break;
+
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 =

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 5365a3299088..121254086e30 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2857,92 +2857,76 @@ static int cifs_writepages_region(struct address_s=
pace *mapping,
 				  struct writeback_control *wbc,
 				  loff_t start, loff_t end, loff_t *_next)
 {
-	struct folio_batch fbatch;
+	struct folio *folio;
+	ssize_t ret;
 	int skips =3D 0;
 =

-	folio_batch_init(&fbatch);
 	do {
-		int nr;
 		pgoff_t index =3D start / PAGE_SIZE;
 =

-		nr =3D filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					    PAGECACHE_TAG_DIRTY, &fbatch);
-		if (!nr)
+		folio =3D filemap_get_folio_tag(mapping, &index, end / PAGE_SIZE,
+					      PAGECACHE_TAG_DIRTY);
+		if (!folio)
 			break;
 =

-		for (int i =3D 0; i < nr; i++) {
-			ssize_t ret;
-			struct folio *folio =3D fbatch.folios[i];
-
-redo_folio:
-			start =3D folio_pos(folio); /* May regress with THPs */
+		start =3D folio_pos(folio); /* May regress with THPs */
 =

-			/* At this point we hold neither the i_pages lock nor the
-			 * page lock: the page may be truncated or invalidated
-			 * (changing page->mapping to NULL), or even swizzled
-			 * back from swapper_space to tmpfs file mapping
-			 */
-			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
-				ret =3D folio_lock_killable(folio);
-				if (ret < 0)
-					goto write_error;
-			} else {
-				if (!folio_trylock(folio))
-					goto skip_write;
+		/* At this point we hold neither the i_pages lock nor the
+		 * page lock: the page may be truncated or invalidated
+		 * (changing page->mapping to NULL), or even swizzled
+		 * back from swapper_space to tmpfs file mapping
+		 */
+		if (wbc->sync_mode !=3D WB_SYNC_NONE) {
+			ret =3D folio_lock_killable(folio);
+			if (ret < 0) {
+				folio_put(folio);
+				return ret;
 			}
-
-			if (folio_mapping(folio) !=3D mapping ||
-			    !folio_test_dirty(folio)) {
-				folio_unlock(folio);
-				goto skip_write;
+		} else {
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
+				return 0;
 			}
+		}
 =

-			if (folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				if (wbc->sync_mode =3D=3D WB_SYNC_NONE)
-					goto skip_write;
+		if (folio_mapping(folio) !=3D mapping ||
+		    !folio_test_dirty(folio)) {
+			start +=3D folio_size(folio);
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
 =

+		if (folio_test_writeback(folio) ||
+		    folio_test_fscache(folio)) {
+			folio_unlock(folio);
+			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
 				folio_wait_writeback(folio);
 #ifdef CONFIG_CIFS_FSCACHE
 				folio_wait_fscache(folio);
 #endif
-				goto redo_folio;
+			} else {
+				start +=3D folio_size(folio);
 			}
-
-			if (!folio_clear_dirty_for_io(folio))
-				/* We hold the page lock - it should've been dirty. */
-				WARN_ON(1);
-
-			ret =3D cifs_write_back_from_locked_folio(mapping, wbc, folio, start, =
end);
-			if (ret < 0)
-				goto write_error;
-
-			start +=3D ret;
-			continue;
-
-write_error:
-			folio_batch_release(&fbatch);
-			*_next =3D start;
-			return ret;
-
-skip_write:
-			/*
-			 * Too many skipped writes, or need to reschedule?
-			 * Treat it as a write error without an error code.
-			 */
-			if (skips >=3D 5 || need_resched()) {
-				ret =3D 0;
-				goto write_error;
+			folio_put(folio);
+			if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
+				if (skips >=3D 5 || need_resched())
+					break;
+				skips++;
 			}
-
-			/* Otherwise, just skip that folio and go on to the next */
-			skips++;
-			start +=3D folio_size(folio);
 			continue;
 		}
 =

-		folio_batch_release(&fbatch);		=

+		if (!folio_clear_dirty_for_io(folio))
+			/* We hold the page lock - it should've been dirty. */
+			WARN_ON(1);
+
+		ret =3D cifs_write_back_from_locked_folio(mapping, wbc, folio, start, e=
nd);
+		folio_put(folio);
+		if (ret < 0)
+			return ret;
+
+		start +=3D ret;
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 =

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0acb8e1fb7af..577535633006 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -741,6 +741,8 @@ unsigned filemap_get_folios_contig(struct address_spac=
e *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *s=
tart,
 		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
+struct folio *filemap_get_folio_tag(struct address_space *mapping, pgoff_=
t *start,
+				    pgoff_t end, xa_mark_t tag);
 =

 struct page *grab_cache_page_write_begin(struct address_space *mapping,
 			pgoff_t index);
diff --git a/mm/filemap.c b/mm/filemap.c
index 2723104cc06a..1b1e9c661018 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2339,6 +2339,64 @@ unsigned filemap_get_folios_tag(struct address_spac=
e *mapping, pgoff_t *start,
 }
 EXPORT_SYMBOL(filemap_get_folios_tag);
 =

+/**
+ * filemap_get_folio_tag - Get the first folio matching @tag
+ * @mapping:    The address_space to search
+ * @start:      The starting page index
+ * @end:        The final page index (inclusive)
+ * @tag:        The tag index
+ *
+ * Search for and return the first folios in the mapping starting at inde=
x
+ * @start and up to index @end (inclusive).  The folio is returned with a=
n
+ * elevated reference count.
+ *
+ * If a folio is returned, it may start before @start; if it does, it wil=
l
+ * contain @start.  The folio may also extend beyond @end; if it does, it=
 will
+ * contain @end.  If folios are added to or removed from the page cache w=
hile
+ * this is running, they may or may not be found by this call.
+ *
+ * Return: The folio that was found or NULL.  @start is also updated to i=
ndex
+ * the next folio for the traversal or will be left pointing after @end.
+ */
+struct folio *filemap_get_folio_tag(struct address_space *mapping, pgoff_=
t *start,
+				    pgoff_t end, xa_mark_t tag)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio =3D find_get_entry(&xas, end, tag)) !=3D NULL) {
+		/*
+		 * Shadow entries should never be tagged, but this iteration
+		 * is lockless so there is a window for page reclaim to evict
+		 * a page we saw tagged. Skip over it.
+		 */
+		if (xa_is_value(folio))
+			continue;
+
+		if (folio_test_hugetlb(folio))
+			*start =3D folio->index + 1;
+		else
+			*start =3D folio_next_index(folio);
+		goto out;
+	}
+
+	/*
+	 * We come here when there is no page beyond @end. We take care to not
+	 * overflow the index @start as it confuses some of the callers. This
+	 * breaks the iteration when there is a page at index -1 but that is
+	 * already broke anyway.
+	 */
+	if (end =3D=3D (pgoff_t)-1)
+		*start =3D (pgoff_t)-1;
+	else
+		*start =3D end + 1;
+out:
+	rcu_read_unlock();
+	return folio;
+}
+EXPORT_SYMBOL(filemap_get_folio_tag);
+
 /*
  * CD/DVDs are error prone. When a medium error occurs, the driver may fa=
il
  * a _large_ part of the i/o request. Imagine the worst scenario:

