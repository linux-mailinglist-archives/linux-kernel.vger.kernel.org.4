Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297F613957
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiJaOvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiJaOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866D10FE3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667227792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdnpb1+ttm5uL2tCafgDFfeY+mQZP4DUUVKbd6idQzo=;
        b=e4d2PFMUIHvWR4mkZk58U1FH0BVrdO0WwvCY9rxwBN9q7EsammteeVcX7m9kG7Woqi3KbS
        FQhS1W2+4ibY3sDoduSla9lgfy6nLXXqQJw8LZsnqI2TvZAefvnHkRsSxdOIM4ITtX1MFc
        8qb/lIuEGxjKvH0pwQZ3twkCkBWsp9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-oPCxhf6QOn6TRMM3XE0Yzw-1; Mon, 31 Oct 2022 10:49:48 -0400
X-MC-Unique: oPCxhf6QOn6TRMM3XE0Yzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57643858F13;
        Mon, 31 Oct 2022 14:49:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D0AE35429;
        Mon, 31 Oct 2022 14:49:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 2/2] cifs: Test use of iov_iter_extract_pages() and
 iov_iter_extract_mode()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, smfrench@gmail.com,
        torvalds@linux-foundation.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Oct 2022 14:49:46 +0000
Message-ID: <166722778696.2555743.13577128072475645173.stgit@warthog.procyon.org.uk>
In-Reply-To: <166722777223.2555743.162508599131141451.stgit@warthog.procyon.org.uk>
References: <166722777223.2555743.162508599131141451.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make cifs use iov_iter_extract_pages() rather than iov_iter_get_pages2*()
so that pages get pins taken on them rather than refs if they're
potentially going to have RDMA read into them.

Note that this is only a test and not complete as I think other refs may
get taken on the pages in other places.  Better, I think, to pass iterators
down as far as possible and avoid extracting the pages at all if we can
manage it.

Two things to note:

 (1) The code has to decide whether put, unpin or abandon the page
     dependent the mode (which is stored in rdata and wdata).  This
     probably isn't necessary in all the cases I've made it check the mode.
     Further, I'm very likely not handling correctly the places where wdata
     or rdata records are split.

 (2) There are a couple of places after calling iov_iter_get_pages2*() in
     the upstream kernel where I think the list of pages and all the pages
     it points to are leaked on error.  I've added some comments at those
     points.
---

 fs/cifs/cifsglob.h |    2 +
 fs/cifs/file.c     |   93 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 1420acf987f0..86792b15197f 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1446,6 +1446,7 @@ struct cifs_readdata {
 	__u64				offset;
 	unsigned int			bytes;
 	unsigned int			got_bytes;
+	unsigned int			pages_cleanup_mode;	/* How to clean up pages[] */
 	pid_t				pid;
 	int				result;
 	struct work_struct		work;
@@ -1479,6 +1480,7 @@ struct cifs_writedata {
 	struct cifs_aio_ctx		*ctx;
 	__u64				offset;
 	pid_t				pid;
+	unsigned int			pages_cleanup_mode;	/* How to clean up pages[] */
 	unsigned int			bytes;
 	int				result;
 	struct TCP_Server_Info		*server;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 21d41b3c1882..385599c08572 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2366,11 +2366,15 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 		}
 
 		for (j = 0; j < nr_pages; j++) {
-			unlock_page(wdata2->pages[j]);
+			struct page *page = wdata2->pages[j];
+			unlock_page(page);
 			if (rc != 0 && !is_retryable_error(rc)) {
-				SetPageError(wdata2->pages[j]);
-				end_page_writeback(wdata2->pages[j]);
-				put_page(wdata2->pages[j]);
+				SetPageError(page);
+				end_page_writeback(page);
+				if (wdata->pages_cleanup_mode & FOLL_PIN)
+					unpin_user_page(page);
+				if (wdata->pages_cleanup_mode & FOLL_GET)
+					put_page(page);
 			}
 		}
 
@@ -2388,9 +2392,13 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 
 	/* cleanup remaining pages from the original wdata */
 	for (; i < wdata->nr_pages; i++) {
-		SetPageError(wdata->pages[i]);
-		end_page_writeback(wdata->pages[i]);
-		put_page(wdata->pages[i]);
+		struct page *page = wdata->pages[i];
+		SetPageError(page);
+		end_page_writeback(page);
+		if (wdata->pages_cleanup_mode & FOLL_PIN)
+			unpin_user_page(page);
+		if (wdata->pages_cleanup_mode & FOLL_GET)
+			put_page(page);
 	}
 
 	if (rc != 0 && !is_retryable_error(rc))
@@ -2424,7 +2432,10 @@ cifs_writev_complete(struct work_struct *work)
 			SetPageError(page);
 		end_page_writeback(page);
 		cifs_readpage_to_fscache(inode, page);
-		put_page(page);
+		if (wdata->pages_cleanup_mode & FOLL_PIN)
+			unpin_user_page(page);
+		if (wdata->pages_cleanup_mode & FOLL_GET)
+			put_page(page);
 	}
 	if (wdata->result != -EAGAIN)
 		mapping_set_error(inode->i_mapping, wdata->result);
@@ -2529,6 +2540,7 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
 	if (!wdata)
 		return NULL;
 
+	wdata->pages_cleanup_mode = FOLL_GET;
 	*found_pages = find_get_pages_range_tag(mapping, index, end,
 				PAGECACHE_TAG_DIRTY, tofind, wdata->pages);
 	return wdata;
@@ -3089,8 +3101,12 @@ cifs_uncached_writedata_release(struct kref *refcount)
 					struct cifs_writedata, refcount);
 
 	kref_put(&wdata->ctx->refcount, cifs_aio_ctx_release);
-	for (i = 0; i < wdata->nr_pages; i++)
-		put_page(wdata->pages[i]);
+	if (wdata->pages_cleanup_mode & FOLL_PIN)
+		for (i = 0; i < wdata->nr_pages; i++)
+			unpin_user_page(wdata->pages[i]);
+	if (wdata->pages_cleanup_mode & FOLL_GET)
+		for (i = 0; i < wdata->nr_pages; i++)
+			put_page(wdata->pages[i]);
 	cifs_writedata_release(refcount);
 }
 
@@ -3277,11 +3293,12 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 		if (ctx->direct_io) {
 			ssize_t result;
 
-			result = iov_iter_get_pages_alloc2(
-				from, &pagevec, cur_len, &start);
+			pagevec = NULL;
+			result = iov_iter_extract_pages(
+				from, &pagevec, cur_len, INT_MAX, &start);
 			if (result < 0) {
 				cifs_dbg(VFS,
-					 "direct_writev couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
+					 "direct_writev couldn't extract user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
 					 result, iov_iter_type(from),
 					 from->iov_offset, from->count);
 				dump_stack();
@@ -3298,12 +3315,14 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 			wdata = cifs_writedata_direct_alloc(pagevec,
 					     cifs_uncached_writev_complete);
 			if (!wdata) {
+				// Just leak pagevec?
 				rc = -ENOMEM;
 				add_credits_and_wake_if(server, credits, 0);
 				break;
 			}
 
 
+			wdata->pages_cleanup_mode = iov_iter_extract_mode(from);
 			wdata->page_offset = start;
 			wdata->tailsz =
 				nr_pages > 1 ?
@@ -3328,6 +3347,7 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 				break;
 			}
 
+			wdata->pages_cleanup_mode = FOLL_GET;
 			num_pages = nr_pages;
 			rc = wdata_fill_from_iovec(
 				wdata, from, &cur_len, &num_pages);
@@ -3489,9 +3509,9 @@ static ssize_t __cifs_writev(
 	int rc;
 
 	/*
-	 * iov_iter_get_pages_alloc doesn't work with ITER_KVEC.
-	 * In this case, fall back to non-direct write function.
-	 * this could be improved by getting pages directly in ITER_KVEC
+	 * iov_iter_extract_pages_alloc can't work with ITER_KVEC as kvec pages
+	 * must not be got.  In this case, fall back to non-direct write
+	 * function.
 	 */
 	if (direct && iov_iter_is_kvec(from)) {
 		cifs_dbg(FYI, "use non-direct cifs_writev for kvec I/O\n");
@@ -3749,7 +3769,12 @@ cifs_read_allocate_pages(struct cifs_readdata *rdata, unsigned int nr_pages)
 		unsigned int nr_page_failed = i;
 
 		for (i = 0; i < nr_page_failed; i++) {
-			put_page(rdata->pages[i]);
+			struct page *page = rdata->pages[i];
+
+			if (rdata->pages_cleanup_mode & FOLL_PIN)
+				unpin_user_page(page);
+			if (rdata->pages_cleanup_mode & FOLL_GET)
+				put_page(page);
 			rdata->pages[i] = NULL;
 		}
 	}
@@ -3765,7 +3790,12 @@ cifs_uncached_readdata_release(struct kref *refcount)
 
 	kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
 	for (i = 0; i < rdata->nr_pages; i++) {
-		put_page(rdata->pages[i]);
+		struct page *page = rdata->pages[i];
+
+		if (rdata->pages_cleanup_mode & FOLL_PIN)
+			unpin_user_page(page);
+		if (rdata->pages_cleanup_mode & FOLL_GET)
+			put_page(page);
 	}
 	cifs_readdata_release(refcount);
 }
@@ -3845,7 +3875,10 @@ uncached_fill_pages(struct TCP_Server_Info *server,
 			/* no need to hold page hostage */
 			rdata->pages[i] = NULL;
 			rdata->nr_pages--;
-			put_page(page);
+			if (rdata->pages_cleanup_mode & FOLL_PIN)
+				unpin_user_page(page);
+			if (rdata->pages_cleanup_mode & FOLL_GET)
+				put_page(page);
 			continue;
 		}
 
@@ -4015,12 +4048,12 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 		if (ctx->direct_io) {
 			ssize_t result;
 
-			result = iov_iter_get_pages_alloc2(
-					&direct_iov, &pagevec,
-					cur_len, &start);
+			pagevec = NULL;
+			result = iov_iter_extract_pages(&direct_iov, &pagevec,
+							cur_len, INT_MAX, &start);
 			if (result < 0) {
 				cifs_dbg(VFS,
-					 "Couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
+					 "Couldn't extract user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
 					 result, iov_iter_type(&direct_iov),
 					 direct_iov.iov_offset,
 					 direct_iov.count);
@@ -4035,6 +4068,7 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 			rdata = cifs_readdata_direct_alloc(
 					pagevec, cifs_uncached_readv_complete);
 			if (!rdata) {
+				// Leaks pagevec?
 				add_credits_and_wake_if(server, credits, 0);
 				rc = -ENOMEM;
 				break;
@@ -4045,6 +4079,8 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 			rdata->tailsz = npages > 1 ?
 				cur_len-(PAGE_SIZE-start)-(npages-2)*PAGE_SIZE :
 				cur_len;
+			rdata->pages_cleanup_mode =
+				iov_iter_extract_mode(&direct_iov);
 
 		} else {
 
@@ -4228,9 +4264,9 @@ static ssize_t __cifs_readv(
 	struct cifs_aio_ctx *ctx;
 
 	/*
-	 * iov_iter_get_pages_alloc() doesn't work with ITER_KVEC,
-	 * fall back to data copy read path
-	 * this could be improved by getting pages directly in ITER_KVEC
+	 * iov_iter_extract_pages() doesn't work with ITER_KVEC as kvec pages
+	 * can't have refs or pins taken on them - so fall back to data copy
+	 * read path
 	 */
 	if (direct && iov_iter_is_kvec(to)) {
 		cifs_dbg(FYI, "use non-direct cifs_user_readv for kvec I/O\n");
@@ -4563,7 +4599,10 @@ cifs_readv_complete(struct work_struct *work)
 
 		got_bytes -= min_t(unsigned int, PAGE_SIZE, got_bytes);
 
-		put_page(page);
+		if (rdata->pages_cleanup_mode & FOLL_PIN)
+			unpin_user_page(page);
+		if (rdata->pages_cleanup_mode & FOLL_GET)
+			put_page(page);
 		rdata->pages[i] = NULL;
 	}
 	kref_put(&rdata->refcount, cifs_readdata_release);


