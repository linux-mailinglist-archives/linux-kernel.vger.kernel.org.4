Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0124668CA74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBFXV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjBFXVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:21:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2491B24103
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675725639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yed7vlW23Rtkj3ppRtIt/2CzIqU6z5er4Ia6Ux7MVHk=;
        b=I4OHrHK8fUKsSh9pTPcqpyVLVXHArfFgR6GXCroUNCx/FhItgyb7XqoysDeTcAey/vmmue
        IPzpvKR9H4uDAw+jsWiDGiwBtZ5LJy2otIrqDNcihKei0eXMynm6oWmVTmcWfTvgEZ1BMw
        c0a0HoMJaADey270jgR8T65zjmGFPE8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-PuMqDgsYMWiP0DqzfkT5pQ-1; Mon, 06 Feb 2023 18:20:35 -0500
X-MC-Unique: PuMqDgsYMWiP0DqzfkT5pQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC9FA800050;
        Mon,  6 Feb 2023 23:20:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98E2C40C83B6;
        Mon,  6 Feb 2023 23:20:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2811508.1675724572@warthog.procyon.org.uk>
References: <2811508.1675724572@warthog.procyon.org.uk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Need help tracking down a bug in the bio-FOLL_PIN patches
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2812962.1675725632.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 06 Feb 2023 23:20:32 +0000
Message-ID: <2812963.1675725632@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For reference, here's the debugging code I'm using.
    =

Enable the followng:
    =

        CONFIG_DEBUG_PAGE_REF
        CONFIG_DEBUG_PAGE_MARK
        CONFIG_DEBUG_PAGE_REF_ONLY_MARKED

and then enable the page_ref tracepoints:

        echo 1 >/sys/kernel/debug/tracing/events/page_ref/enable
	echo 1 >/sys/kernel/debug/tracing/events/block/bio/enable
	echo 1 >/sys/kernel/debug/tracing/events/block/bio_endio/enable

David
---
 block/bio.c                    |   50 ++++++++++++++++++++-
 fs/iomap/buffered-io.c         |   10 ++++
 fs/pipe.c                      |    1 =

 fs/splice.c                    |   23 +++++++++
 include/linux/bio.h            |    4 -
 include/linux/blk_types.h      |    2 =

 include/linux/page-flags.h     |   12 +++++
 include/linux/page_ref.h       |   34 ++++++++------
 include/linux/uio.h            |    1 =

 include/trace/events/block.h   |   95 +++++++++++++++++++++++++++++++++++=
++++++
 include/trace/events/mmflags.h |    9 +++
 lib/iov_iter.c                 |   28 ++++++++++++
 mm/Kconfig.debug               |   17 +++++++
 mm/page_alloc.c                |    3 +
 mm/readahead.c                 |    8 +++
 15 files changed, 276 insertions(+), 21 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fc57f0aa098e..ae0997688e08 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -20,6 +20,7 @@
 #include <linux/blk-crypto.h>
 #include <linux/xarray.h>
 =

+#include <trace/events/page_ref.h>
 #include <trace/events/block.h>
 #include "blk.h"
 #include "blk-rq-qos.h"
@@ -214,6 +215,8 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned s=
hort *nr_vecs,
 =

 void bio_uninit(struct bio *bio)
 {
+	if (bio_flagged(bio, BIO_TRACE))
+		trace_bio(bio, bio_trace_where_uninit, 0);
 #ifdef CONFIG_BLK_CGROUP
 	if (bio->bi_blkg) {
 		blkg_put(bio->bi_blkg);
@@ -232,6 +235,9 @@ static void bio_free(struct bio *bio)
 	struct bio_set *bs =3D bio->bi_pool;
 	void *p =3D bio;
 =

+	if (bio_flagged(bio, BIO_TRACE))
+		trace_bio(bio, bio_trace_where_free, 0);
+
 	WARN_ON_ONCE(!bs);
 =

 	bio_uninit(bio);
@@ -247,6 +253,9 @@ static void bio_free(struct bio *bio)
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec =
*table,
 	      unsigned short max_vecs, blk_opf_t opf)
 {
+	static atomic_t bio_debug_ids;
+
+	bio->bi_debug_id =3D atomic_inc_return(&bio_debug_ids);
 	bio->bi_next =3D NULL;
 	bio->bi_bdev =3D bdev;
 	bio->bi_opf =3D opf;
@@ -1110,6 +1119,13 @@ void __bio_add_page(struct bio *bio, struct page *p=
age,
 {
 	struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt];
 =

+	if (PageDebugMark(page)) {
+		trace_page_ref_set(page, 666);
+		bio_set_flag(bio, BIO_TRACE);
+		trace_bio(bio, bio_trace_where_add_page,
+			  page_to_pfn(page));
+	}
+
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 	WARN_ON_ONCE(bio_full(bio, len));
 =

@@ -1172,12 +1188,23 @@ void __bio_release_pages(struct bio *bio, bool mar=
k_dirty)
 {
 	struct bvec_iter_all iter_all;
 	struct bio_vec *bvec;
+	unsigned int i =3D 0;
+
+	if (bio_flagged(bio, BIO_TRACE))
+		trace_bio(bio, bio_trace_where_rel_pages, 0);
 =

 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (mark_dirty && !PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
-		bio_release_page(bio, bvec->bv_page);
+		if (PageDebugMark(bvec->bv_page))
+			trace_page_ref_set(bvec->bv_page, 980 + i++);
 	}
+
+	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
+	    bio_flagged(bio, BIO_PAGE_PINNED))
+		bio_for_each_segment_all(bvec, bio, iter_all) {
+			if (mark_dirty && !PageCompound(bvec->bv_page))
+				set_page_dirty_lock(bvec->bv_page);
+			bio_release_page(bio, bvec->bv_page);
+		}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
 =

@@ -1445,6 +1472,9 @@ void bio_free_pages(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 =

+	if (bio_flagged(bio, BIO_TRACE))
+		trace_bio(bio, bio_trace_where_free_pages, 0);
+
 	bio_for_each_segment_all(bvec, bio, iter_all)
 		__free_page(bvec->bv_page);
 }
@@ -1534,6 +1564,8 @@ void bio_check_pages_dirty(struct bio *bio)
 	struct bvec_iter_all iter_all;
 =

 	bio_for_each_segment_all(bvec, bio, iter_all) {
+		if (PageDebugMark(bvec->bv_page))
+			trace_page_ref_set(bvec->bv_page, 654);
 		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
 			goto defer;
 	}
@@ -1583,6 +1615,8 @@ static inline bool bio_remaining_done(struct bio *bi=
o)
  **/
 void bio_endio(struct bio *bio)
 {
+	struct bvec_iter_all iter_all;
+	struct bio_vec *bvec;
 again:
 	if (!bio_remaining_done(bio))
 		return;
@@ -1591,6 +1625,14 @@ void bio_endio(struct bio *bio)
 =

 	rq_qos_done_bio(bio);
 =

+	if (bio_flagged(bio, BIO_TRACE))
+		trace_bio(bio, bio_trace_where_endio, 0);
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		if (PageDebugMark(bvec->bv_page))
+			trace_page_ref_set(bvec->bv_page, 623);
+	}
+
 	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
 		trace_block_bio_complete(bdev_get_queue(bio->bi_bdev), bio);
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
@@ -1612,6 +1654,8 @@ void bio_endio(struct bio *bio)
 	blk_throtl_bio_endio(bio);
 	/* release cgroup info */
 	bio_uninit(bio);
+	if (bio_flagged(bio, BIO_TRACE))
+		trace_bio_endio(bio);
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 356193e44cf0..21790ce471d3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -18,6 +18,7 @@
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
 #include "trace.h"
+#include <trace/events/block.h>
 =

 #include "../internal.h"
 =

@@ -619,6 +620,12 @@ static int iomap_write_begin(struct iomap_iter *iter,=
 loff_t pos,
 		goto out_no_page;
 	}
 =

+#if 0
+#define XFS_SUPER_MAGIC 0x58465342	/* "XFSB" */
+	if (folio->mapping->host->i_sb->s_magic =3D=3D XFS_SUPER_MAGIC)
+		folio_set_debug_mark(folio);
+#endif
+
 	/*
 	 * Now we have a locked folio, before we do anything with it we need to
 	 * check that the iomap we have cached is not stale. The inode extent
@@ -1311,6 +1318,9 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int er=
ror)
 			next =3D bio->bi_private;
 =

 		/* walk all folios in bio, ending page IO on them */
+		if (bio_flagged(bio, BIO_TRACE))
+			trace_bio(bio, bio_trace_where_ioend, 0);
+
 		bio_for_each_folio_all(fi, bio) {
 			iomap_finish_folio_write(inode, fi.folio, fi.length,
 					error);
diff --git a/fs/pipe.c b/fs/pipe.c
index 42c7ff41c2db..56293d706ef3 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -208,6 +208,7 @@ void generic_pipe_buf_release(struct pipe_inode_info *=
pipe,
 			      struct pipe_buffer *buf)
 {
 	put_page(buf->page);
+	buf->page =3D (void *)0xaa55aa55aa55aa55UL;
 }
 EXPORT_SYMBOL(generic_pipe_buf_release);
 =

diff --git a/fs/splice.c b/fs/splice.c
index 5969b7a1d353..fc59b5038f2e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -34,6 +34,7 @@
 #include <linux/gfp.h>
 #include <linux/socket.h>
 #include <linux/sched/signal.h>
+#include <trace/events/page_ref.h>
 =

 #include "internal.h"
 =

@@ -304,6 +305,7 @@ ssize_t generic_file_splice_read(struct file *in, loff=
_t *ppos,
 	int ret;
 =

 	iov_iter_pipe(&to, ITER_DEST, pipe, len);
+	to.debug =3D true;
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos =3D *ppos;
 	ret =3D call_read_iter(in, &kiocb, &to);
@@ -597,6 +599,9 @@ ssize_t splice_from_pipe(struct pipe_inode_info *pipe,=
 struct file *out,
 	return ret;
 }
 =

+static struct page *splice_tmp;
+static DEFINE_MUTEX(splice_tmp_lock);
+
 /**
  * iter_file_splice_write - splice data from a pipe to a file
  * @pipe:	pipe info
@@ -626,6 +631,19 @@ iter_file_splice_write(struct pipe_inode_info *pipe, =
struct file *out,
 					GFP_KERNEL);
 	ssize_t ret;
 =

+	mutex_lock(&splice_tmp_lock);
+	if (!splice_tmp) {
+		pr_notice("alloc splice_tmp\n");
+		splice_tmp =3D alloc_page(GFP_USER);
+		if (splice_tmp) {
+			SetPageDebugMark(splice_tmp);
+			page_ref_add(splice_tmp, 100);
+		}
+	}
+	mutex_unlock(&splice_tmp_lock);
+	if (!splice_tmp)
+		return -ENOMEM;
+
 	if (unlikely(!array))
 		return -ENOMEM;
 =

@@ -675,7 +693,12 @@ iter_file_splice_write(struct pipe_inode_info *pipe, =
struct file *out,
 				goto done;
 			}
 =

+			if (PageDebugMark(buf->page))
+				trace_page_ref_set(buf->page, 888);
+
 			array[n].bv_page =3D buf->page;
+			//array[n].bv_page =3D splice_tmp;
+			//trace_page_ref_set(splice_tmp, 887);
 			array[n].bv_len =3D this_len;
 			array[n].bv_offset =3D buf->offset;
 			left -=3D this_len;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index b2c09997d79c..cafa26637067 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -484,8 +484,8 @@ void zero_fill_bio(struct bio *bio);
 =

 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
-	    bio_flagged(bio, BIO_PAGE_PINNED))
+	//if (bio_flagged(bio, BIO_PAGE_REFFED) ||
+	//    bio_flagged(bio, BIO_PAGE_PINNED))
 		__bio_release_pages(bio, mark_dirty);
 }
 =

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a0e339ff3d09..b4e563595a5a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -302,6 +302,7 @@ struct bio {
 	struct bio_vec		*bi_io_vec;	/* the actual vec list */
 =

 	struct bio_set		*bi_pool;
+	unsigned int		bi_debug_id;	/* Tracing debug ID */
 =

 	/*
 	 * We can inline a number of vecs at the end of the bio, to avoid
@@ -334,6 +335,7 @@ enum {
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
+	BIO_TRACE,		/* Trace bio lifetime */
 	BIO_FLAG_LAST
 };
 =

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 69e93a0c1277..80cbf784239e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -138,6 +138,9 @@ enum pageflags {
 #endif
 #ifdef CONFIG_KASAN_HW_TAGS
 	PG_skip_kasan_poison,
+#endif
+#ifdef CONFIG_DEBUG_PAGE_MARK
+	PG_debug_mark,
 #endif
 	__NR_PAGEFLAGS,
 =

@@ -694,6 +697,15 @@ static __always_inline bool PageKsm(struct page *page=
)
 TESTPAGEFLAG_FALSE(Ksm, ksm)
 #endif
 =

+#ifdef CONFIG_DEBUG_PAGE_MARK
+/*
+ * Debug marks are just used for page_ref tracepoint control and display.
+ */
+PAGEFLAG(DebugMark, debug_mark, PF_ANY)
+#else
+TESTPAGEFLAG_FALSE(DebugMark, debug_mark)
+#endif
+
 u64 stable_page_flags(struct page *page);
 =

 /**
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index d7c2d33baa7f..7bc1a94d9cbb 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -24,7 +24,11 @@ DECLARE_TRACEPOINT(page_ref_unfreeze);
  *
  * See trace_##name##_enabled(void) in include/linux/tracepoint.h
  */
-#define page_ref_tracepoint_active(t) tracepoint_enabled(t)
+#ifndef CONFIG_DEBUG_PAGE_REF_ONLY_MARKED
+#define page_ref_tracepoint_active(p, t) tracepoint_enabled(t)
+#else
+#define page_ref_tracepoint_active(p, t) (tracepoint_enabled(t) && PageDe=
bugMark(p))
+#endif
 =

 extern void __page_ref_set(struct page *page, int v);
 extern void __page_ref_mod(struct page *page, int v);
@@ -36,7 +40,7 @@ extern void __page_ref_unfreeze(struct page *page, int v=
);
 =

 #else
 =

-#define page_ref_tracepoint_active(t) false
+#define page_ref_tracepoint_active(page, t) false
 =

 static inline void __page_ref_set(struct page *page, int v)
 {
@@ -97,7 +101,7 @@ static inline int page_count(const struct page *page)
 static inline void set_page_count(struct page *page, int v)
 {
 	atomic_set(&page->_refcount, v);
-	if (page_ref_tracepoint_active(page_ref_set))
+	if (page_ref_tracepoint_active(page, page_ref_set))
 		__page_ref_set(page, v);
 }
 =

@@ -118,7 +122,7 @@ static inline void init_page_count(struct page *page)
 static inline void page_ref_add(struct page *page, int nr)
 {
 	atomic_add(nr, &page->_refcount);
-	if (page_ref_tracepoint_active(page_ref_mod))
+	if (page_ref_tracepoint_active(page, page_ref_mod))
 		__page_ref_mod(page, nr);
 }
 =

@@ -130,7 +134,7 @@ static inline void folio_ref_add(struct folio *folio, =
int nr)
 static inline void page_ref_sub(struct page *page, int nr)
 {
 	atomic_sub(nr, &page->_refcount);
-	if (page_ref_tracepoint_active(page_ref_mod))
+	if (page_ref_tracepoint_active(page, page_ref_mod))
 		__page_ref_mod(page, -nr);
 }
 =

@@ -143,7 +147,7 @@ static inline int page_ref_sub_return(struct page *pag=
e, int nr)
 {
 	int ret =3D atomic_sub_return(nr, &page->_refcount);
 =

-	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+	if (page_ref_tracepoint_active(page, page_ref_mod_and_return))
 		__page_ref_mod_and_return(page, -nr, ret);
 	return ret;
 }
@@ -156,7 +160,7 @@ static inline int folio_ref_sub_return(struct folio *f=
olio, int nr)
 static inline void page_ref_inc(struct page *page)
 {
 	atomic_inc(&page->_refcount);
-	if (page_ref_tracepoint_active(page_ref_mod))
+	if (page_ref_tracepoint_active(page, page_ref_mod))
 		__page_ref_mod(page, 1);
 }
 =

@@ -168,7 +172,7 @@ static inline void folio_ref_inc(struct folio *folio)
 static inline void page_ref_dec(struct page *page)
 {
 	atomic_dec(&page->_refcount);
-	if (page_ref_tracepoint_active(page_ref_mod))
+	if (page_ref_tracepoint_active(page, page_ref_mod))
 		__page_ref_mod(page, -1);
 }
 =

@@ -181,7 +185,7 @@ static inline int page_ref_sub_and_test(struct page *p=
age, int nr)
 {
 	int ret =3D atomic_sub_and_test(nr, &page->_refcount);
 =

-	if (page_ref_tracepoint_active(page_ref_mod_and_test))
+	if (page_ref_tracepoint_active(page, page_ref_mod_and_test))
 		__page_ref_mod_and_test(page, -nr, ret);
 	return ret;
 }
@@ -195,7 +199,7 @@ static inline int page_ref_inc_return(struct page *pag=
e)
 {
 	int ret =3D atomic_inc_return(&page->_refcount);
 =

-	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+	if (page_ref_tracepoint_active(page, page_ref_mod_and_return))
 		__page_ref_mod_and_return(page, 1, ret);
 	return ret;
 }
@@ -209,7 +213,7 @@ static inline int page_ref_dec_and_test(struct page *p=
age)
 {
 	int ret =3D atomic_dec_and_test(&page->_refcount);
 =

-	if (page_ref_tracepoint_active(page_ref_mod_and_test))
+	if (page_ref_tracepoint_active(page, page_ref_mod_and_test))
 		__page_ref_mod_and_test(page, -1, ret);
 	return ret;
 }
@@ -223,7 +227,7 @@ static inline int page_ref_dec_return(struct page *pag=
e)
 {
 	int ret =3D atomic_dec_return(&page->_refcount);
 =

-	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+	if (page_ref_tracepoint_active(page, page_ref_mod_and_return))
 		__page_ref_mod_and_return(page, -1, ret);
 	return ret;
 }
@@ -237,7 +241,7 @@ static inline bool page_ref_add_unless(struct page *pa=
ge, int nr, int u)
 {
 	bool ret =3D atomic_add_unless(&page->_refcount, nr, u);
 =

-	if (page_ref_tracepoint_active(page_ref_mod_unless))
+	if (page_ref_tracepoint_active(page, page_ref_mod_unless))
 		__page_ref_mod_unless(page, nr, ret);
 	return ret;
 }
@@ -317,7 +321,7 @@ static inline int page_ref_freeze(struct page *page, i=
nt count)
 {
 	int ret =3D likely(atomic_cmpxchg(&page->_refcount, count, 0) =3D=3D cou=
nt);
 =

-	if (page_ref_tracepoint_active(page_ref_freeze))
+	if (page_ref_tracepoint_active(page, page_ref_freeze))
 		__page_ref_freeze(page, count, ret);
 	return ret;
 }
@@ -333,7 +337,7 @@ static inline void page_ref_unfreeze(struct page *page=
, int count)
 	VM_BUG_ON(count =3D=3D 0);
 =

 	atomic_set_release(&page->_refcount, count);
-	if (page_ref_tracepoint_active(page_ref_unfreeze))
+	if (page_ref_tracepoint_active(page, page_ref_unfreeze))
 		__page_ref_unfreeze(page, count);
 }
 =

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 514e3b7b06b8..89272c05d74d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -45,6 +45,7 @@ struct iov_iter {
 	bool nofault;
 	bool data_source;
 	bool user_backed;
+	bool debug;
 	union {
 		size_t iov_offset;
 		int last_offset;
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 7f4dfbdf12a6..7eabf99b4317 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -12,6 +12,56 @@
 =

 #define RWBS_LEN	8
 =

+/*
+ * Declare tracing information enums and their string mappings for displa=
y.
+ */
+#define bio_trace_wheres \
+	EM(bio_trace_where_add_page,	"ADD-PG")		\
+	EM(bio_trace_where_endio,	"END-IO")		\
+	EM(bio_trace_where_free,	"FREE  ")		\
+	EM(bio_trace_where_free_pages,	"FREEPG")		\
+	EM(bio_trace_where_init,	"INIT  ")		\
+	EM(bio_trace_where_ioend,	"IOEND ")		\
+	EM(bio_trace_where_rel_pages,	"REL-PG")		\
+	E_(bio_trace_where_uninit,	"UNINIT")
+
+/*
+ * Generate enums for tracing information.
+ */
+#ifndef __BIO_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __BIO_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+#undef EM
+#undef E_
+#define EM(a, b) a,
+#define E_(a, b) a
+
+enum bio_trace_where		{ bio_trace_wheres } __mode(byte);
+
+#endif /* end __BIO_DECLARE_TRACE_ENUMS_ONCE_ONLY */
+
+/*
+ * Export enum symbols via userspace.
+ */
+#undef EM
+#undef E_
+
+#ifndef BIO_TRACE_ONLY_DEFINE_ENUMS
+
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define E_(a, b) TRACE_DEFINE_ENUM(a);
+
+bio_trace_wheres;
+
+/*
+ * Now redefine the EM() and E_() macros to map the enums to the strings =
that
+ * will be printed in the output.
+ */
+#undef EM
+#undef E_
+#define EM(a, b)	{ a, b },
+#define E_(a, b)	{ a, b }
+
 DECLARE_EVENT_CLASS(block_buffer,
 =

 	TP_PROTO(struct buffer_head *bh),
@@ -552,6 +602,51 @@ TRACE_EVENT(block_rq_remap,
 		  (unsigned long long)__entry->old_sector, __entry->nr_bios)
 );
 =

+TRACE_EVENT(bio,
+	TP_PROTO(struct bio *bio, enum bio_trace_where where,
+		 unsigned long info),
+
+	TP_ARGS(bio, where, info),
+
+	TP_STRUCT__entry(
+		__field(unsigned int,		bi_debug_id	)
+		__field(enum bio_trace_where,	where		)
+		__field(unsigned long,		info		)
+	),
+
+	TP_fast_assign(
+		__entry->bi_debug_id	=3D bio->bi_debug_id;
+		__entry->where		=3D where;
+		__entry->info		=3D info;
+	),
+
+	TP_printk("bio=3D%08x %s I=3D%lx",
+		  __entry->bi_debug_id,
+		  __print_symbolic(__entry->where, bio_trace_wheres),
+		  __entry->info)
+);
+
+TRACE_EVENT(bio_endio,
+	TP_PROTO(struct bio *bio),
+
+	TP_ARGS(bio),
+
+	TP_STRUCT__entry(
+		__field(unsigned int,		bi_debug_id	)
+		__field(const void *,		bi_end_io	)
+	),
+
+	TP_fast_assign(
+		__entry->bi_debug_id	=3D bio->bi_debug_id;
+		__entry->bi_end_io	=3D bio->bi_end_io;
+	),
+
+	TP_printk("bio=3D%08x %pSR",
+		  __entry->bi_debug_id,
+		  __entry->bi_end_io)
+);
+
+#endif /* BIO_TRACE_ONLY_DEFINE_ENUMS */
 #endif /* _TRACE_BLOCK_H */
 =

 /* This part must be outside protection */
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags=
.h
index 412b5a46374c..5f3b9b0e4b53 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -103,6 +103,12 @@
 #define IF_HAVE_PG_SKIP_KASAN_POISON(flag,string)
 #endif
 =

+#ifdef CONFIG_DEBUG_PAGE_MARK
+#define IF_HAVE_PG_DEBUG_MARK(flag,string) ,{1UL << flag, string}
+#else
+#define IF_HAVE_PG_DEBUG_MARK(flag,string)
+#endif
+
 #define __def_pageflag_names						\
 	{1UL << PG_locked,		"locked"	},		\
 	{1UL << PG_waiters,		"waiters"	},		\
@@ -132,7 +138,8 @@ IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
 IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
 IF_HAVE_PG_ARCH_X(PG_arch_2,		"arch_2"	)		\
 IF_HAVE_PG_ARCH_X(PG_arch_3,		"arch_3"	)		\
-IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
+IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")	\
+IF_HAVE_PG_DEBUG_MARK(PG_debug_mark,	"debug_mark"	)
 =

 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d69a05950555..b3b2f1e6dc1b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -10,9 +10,11 @@
 #include <linux/vmalloc.h>
 #include <linux/splice.h>
 #include <linux/compat.h>
+#include <linux/page-flags.h>
 #include <net/checksum.h>
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
+#include <trace/events/page_ref.h>
 =

 #define PIPE_PARANOIA /* for now */
 =

@@ -1331,6 +1333,10 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 		struct page *page =3D append_pipe(i, left, &off);
 		if (!page)
 			break;
+		if (i->debug && !PageDebugMark(page)) {
+			//SetPageDebugMark(page);
+			//get_page(page);
+		}
 		chunk =3D min_t(size_t, left, PAGE_SIZE - off);
 		get_page(*p++ =3D page);
 	}
@@ -1917,6 +1923,9 @@ void iov_iter_restore(struct iov_iter *i, struct iov=
_iter_state *state)
 	i->nr_segs =3D state->nr_segs;
 }
 =

+static struct page *extract_tmp;
+static DEFINE_MUTEX(extract_tmp_lock);
+
 /*
  * Extract a list of contiguous pages from an ITER_PIPE iterator.  This d=
oes
  * not get references of its own on the pages, nor does it get a pin on t=
hem.
@@ -1936,6 +1945,19 @@ static ssize_t iov_iter_extract_pipe_pages(struct i=
ov_iter *i,
 	struct page **p;
 	size_t left;
 =

+	mutex_lock(&extract_tmp_lock);
+	if (!extract_tmp) {
+		pr_notice("alloc extract_tmp\n");
+		extract_tmp =3D alloc_page(GFP_USER);
+		if (extract_tmp) {
+			SetPageDebugMark(extract_tmp);
+			page_ref_add(extract_tmp, 200);
+		}
+	}
+	mutex_unlock(&extract_tmp_lock);
+	if (!extract_tmp)
+		return -ENOMEM;
+
 	if (!sanity(i))
 		return -EFAULT;
 =

@@ -1955,9 +1977,15 @@ static ssize_t iov_iter_extract_pipe_pages(struct i=
ov_iter *i,
 		struct page *page =3D append_pipe(i, left, &offset);
 		if (!page)
 			break;
+		if (i->debug && !PageDebugMark(page)) {
+			SetPageDebugMark(page);
+			trace_page_ref_set(page, 777);
+			//get_page(page);
+		}
 		chunk =3D min_t(size_t, left, PAGE_SIZE - offset);
 		left -=3D chunk;
 		*p++ =3D page;
+		//*p++ =3D extract_tmp;
 	}
 	if (!j)
 		return -EFAULT;
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index fca699ad1fb0..111a946a676f 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -149,6 +149,23 @@ config DEBUG_PAGE_REF
 	  kernel code.  However the runtime performance overhead is virtually
 	  nil until the tracepoints are actually enabled.
 =

+config DEBUG_PAGE_MARK
+	bool "Reserve a page bit to mark pages to be debugged"
+	depends on DEBUG_PAGE_REF
+	help
+	  This option adds an extra page flag that can be used to mark pages
+	  for debugging.  The mark can be observed in the page_ref tracepoints.
+	  The mark isn't set on any pages without alteration of the code.  This
+	  is intended for filesystem debugging and code to set the mark must be
+	  added manually into the source.
+
+config DEBUG_PAGE_REF_ONLY_MARKED
+	bool "Only trace marked pages"
+	depends on DEBUG_PAGE_REF && DEBUG_PAGE_MARK
+	help
+	  This option restricts the page_ref tracepoints to only track marked
+	  pages.
+
 config DEBUG_RODATA_TEST
     bool "Testcase for the marking rodata read-only"
     depends on STRICT_KERNEL_RWX
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..37f146e5b2eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1102,6 +1102,9 @@ static inline void __free_one_page(struct page *page=
,
 =

 	VM_BUG_ON(!zone_is_initialized(zone));
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
+#ifdef CONFIG_DEBUG_PAGE_MARK
+	ClearPageDebugMark(page);
+#endif
 =

 	VM_BUG_ON(migratetype =3D=3D -1);
 	if (likely(!is_migrate_isolate(migratetype)))
diff --git a/mm/readahead.c b/mm/readahead.c
index b10f0cf81d80..458559fd0e67 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -248,6 +248,12 @@ void page_cache_ra_unbounded(struct readahead_control=
 *ractl,
 		folio =3D filemap_alloc_folio(gfp_mask, 0);
 		if (!folio)
 			break;
+#if 0
+#define XFS_SUPER_MAGIC 0x58465342	/* "XFSB" */
+		if (mapping->host->i_sb->s_magic =3D=3D XFS_SUPER_MAGIC)
+			folio_set_debug_mark(folio);
+#endif
+
 		if (filemap_add_folio(mapping, folio, index + i,
 					gfp_mask) < 0) {
 			folio_put(folio);
@@ -809,6 +815,7 @@ void readahead_expand(struct readahead_control *ractl,
 		page =3D __page_cache_alloc(gfp_mask);
 		if (!page)
 			return;
+		//SetPageDebugMark(page);
 		if (add_to_page_cache_lru(page, mapping, index, gfp_mask) < 0) {
 			put_page(page);
 			return;
@@ -832,6 +839,7 @@ void readahead_expand(struct readahead_control *ractl,
 		page =3D __page_cache_alloc(gfp_mask);
 		if (!page)
 			return;
+		//SetPageDebugMark(page);
 		if (add_to_page_cache_lru(page, mapping, index, gfp_mask) < 0) {
 			put_page(page);
 			return;

