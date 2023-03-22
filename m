Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311056C5A52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCVX0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCVX0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:26:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC26B1BEC;
        Wed, 22 Mar 2023 16:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A49D9B81E62;
        Wed, 22 Mar 2023 23:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B2AC433EF;
        Wed, 22 Mar 2023 23:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679527599;
        bh=PvIEo4Lf1POS3kVtjH8cLfsNhEYtiLJKFfz0aZKzwSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0PzHbX/kfHRh5+bu7xghczsZa99c+fGo2bnzHhG3i7q13VtDBccPHPNhCatPGTBOO
         y/4F5/pdgZZHabfcHlKj/aP3569ph+JCKXILDvRLMeg0VsOXuXbLqTBvWCdZWpNEz0
         IMzfc8n3mBPxPANIMVnt6+Z7/cPNZ4MCbxA+KE+A=
Date:   Wed, 22 Mar 2023 16:26:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: linux-next: manual merge of the block tree with the mm tree
Message-Id: <20230322162638.d940201434ac3a3a29968979@linux-foundation.org>
In-Reply-To: <82ade7f2-017e-af6b-2fb3-eb1a3f570505@kernel.dk>
References: <20230323100204.0917cecf@canb.auug.org.au>
        <3431084.1679526799@warthog.procyon.org.uk>
        <82ade7f2-017e-af6b-2fb3-eb1a3f570505@kernel.dk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 17:15:48 -0600 Jens Axboe <axboe@kernel.dk> wrote:

> On 3/22/23 5:13 PM, David Howells wrote:
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> >>  +	if (unlikely(iov_iter_is_pipe(i))) {
> >>  +		copied = copy_page_to_iter_pipe(page, offset, bytes, i);
> >>  +		goto out;
> >>  +	}
> > 
> > This bit would need to be removed from copy_page_to_iter_atomic() as the two
> > functions it calls should be removed by the patch in the block tree.
> 
> Maybe it'd be better to consolidate rather than split the changes over
> two trees?

fyi, Lorenzo has sent out v7 of this series.  I'll be pushing this in
an hour or so.  After which I suggest Stephen removes those (now) two
lines and sends out one of his "build fix" emails which can be the
basis for Linus's resolution.

Or I can just steal "iov_iter: Kill ITER_PIPE"...





From: Lorenzo Stoakes <lstoakes@gmail.com>
Subject: iov_iter: add copy_page_to_iter_nofault()
Date: Wed, 22 Mar 2023 18:57:03 +0000

Provide a means to copy a page to user space from an iterator, aborting if
a page fault would occur.  This supports compound pages, but may be passed
a tail page with an offset extending further into the compound page, so we
cannot pass a folio.

This allows for this function to be called from atomic context and _try_
to user pages if they are faulted in, aborting if not.

The function does not use _copy_to_iter() in order to not specify
might_fault(), this is similar to copy_page_from_iter_atomic().

This is being added in order that an iteratable form of vread() can be
implemented while holding spinlocks.

Link: https://lkml.kernel.org/r/19734729defb0f498a76bdec1bef3ac48a3af3e8.1679511146.git.lstoakes@gmail.com
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Baoquan He <bhe@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--- a/include/linux/uio.h~iov_iter-add-copy_page_to_iter_nofault
+++ a/include/linux/uio.h
@@ -173,6 +173,8 @@ static inline size_t copy_folio_to_iter(
 {
 	return copy_page_to_iter(&folio->page, offset, bytes, i);
 }
+size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
+				 size_t bytes, struct iov_iter *i);
 
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
--- a/lib/iov_iter.c~iov_iter-add-copy_page_to_iter_nofault
+++ a/lib/iov_iter.c
@@ -172,6 +172,18 @@ static int copyout(void __user *to, cons
 	return n;
 }
 
+static int copyout_nofault(void __user *to, const void *from, size_t n)
+{
+	long res;
+
+	if (should_fail_usercopy())
+		return n;
+
+	res = copy_to_user_nofault(to, from, n);
+
+	return res < 0 ? n : res;
+}
+
 static int copyin(void *to, const void __user *from, size_t n)
 {
 	size_t res = n;
@@ -734,6 +746,42 @@ size_t copy_page_to_iter(struct page *pa
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
+size_t copy_page_to_iter_nofault(struct page *page, unsigned offset, size_t bytes,
+				 struct iov_iter *i)
+{
+	size_t res = 0;
+
+	if (!page_copy_sane(page, offset, bytes))
+		return 0;
+	if (WARN_ON_ONCE(i->data_source))
+		return 0;
+	if (unlikely(iov_iter_is_pipe(i)))
+		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	page += offset / PAGE_SIZE; // first subpage
+	offset %= PAGE_SIZE;
+	while (1) {
+		void *kaddr = kmap_local_page(page);
+		size_t n = min(bytes, (size_t)PAGE_SIZE - offset);
+
+		iterate_and_advance(i, n, base, len, off,
+			copyout_nofault(base, kaddr + offset + off, len),
+			memcpy(base, kaddr + offset + off, len)
+		)
+		kunmap_local(kaddr);
+		res += n;
+		bytes -= n;
+		if (!bytes || !n)
+			break;
+		offset += n;
+		if (offset == PAGE_SIZE) {
+			page++;
+			offset = 0;
+		}
+	}
+	return res;
+}
+EXPORT_SYMBOL(copy_page_to_iter_nofault);
+
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
_

