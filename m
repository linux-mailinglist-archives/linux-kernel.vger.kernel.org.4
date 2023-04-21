Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052416EA073
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 02:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjDUAHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 20:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjDUAHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 20:07:50 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152EB55BC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:07:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b8f5400de9eso1189589276.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682035667; x=1684627667;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MGuqTLjiPjYtlBNhqdrH1HdY7ljldspC0kCw4HQzZg=;
        b=RuILtNevG/QW7wKBesvjAgjkpf/l8JFnV+vsZdG0Mpoj5sh0DLn7u+iNschKtzIkul
         w8BeE0pZRwzfEj2bJy3BW9ltKpQkvFCd5voxc/KDmb7AqDUP6bWtEg97VNJWuagHGP1d
         /gsm00mQxoiofb62d+W/nOQpf+wgaFgXlgYgAlqhAkPFMFWNeTbTuH0CPSPf4qa4cM+/
         gqH9OBtIhFFZDwXyj98i2sStQhnmSQCe5KyHDmS9+4bn3InMIwqDn5kO+4GNBGIAswPV
         hjGjFwsSvVPBy2P+6v/TNXKHL3evoUYE6uAxxwLchG68/qwHFF430507kEYnc6hApIda
         tdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682035667; x=1684627667;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MGuqTLjiPjYtlBNhqdrH1HdY7ljldspC0kCw4HQzZg=;
        b=LgCGLk5uwhZ8JNJ4Gni5CvI2IRUC5vki98DKTqV+FapvHs/2fl5IZMQlCRDjOoKwVr
         K+jzvbMrnmjaHwi+UNfC9uKbYHSR3RmaMrAofLqmQD8KvXpjBr+iOS6TnkVj+7jWE1i7
         fNIrUCJYJIgnjTaVZfv52WD5o7OgbpOZwNFsCw1OFqm9SHR0iJB2qzL85NHB3sE7u4+H
         4tPGJSndtt5oUnsGeFFGBuMnqvFwc3CvYfAae6gyqFrESsLtiqCwxp/l74ykmGw6K72B
         tSr/7yI70k8vcRkRtLocB6qvy/RdTbCAtfrAtWYBIsQxUBCA+A3sDgJbNr20DZV/Ku/o
         P+4Q==
X-Gm-Message-State: AAQBX9cmYRyDpOQNNLXaWHdEWuqvBm67KJBPe7cR+9TaVRr89a7no12D
        JjMp151NtBr/l9P1VwbNVVpDJ/vE0e8+dQAXwUYx5A==
X-Google-Smtp-Source: AKy350bpWTShrcTudEhOS6gdRwxhc4nmr/3zIaI8ruXZl4oXzSoVnY3LNAwP9NLmA8amd7JjLPqoEg==
X-Received: by 2002:a25:dfd0:0:b0:b92:41a6:5637 with SMTP id w199-20020a25dfd0000000b00b9241a65637mr780529ybg.14.1682035666878;
        Thu, 20 Apr 2023 17:07:46 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g16-20020a5b0250000000b00b991ece5946sm25594ybp.25.2023.04.20.17.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 17:07:46 -0700 (PDT)
Date:   Thu, 20 Apr 2023 17:07:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Charan Teja Kalla <quic_charante@quicinc.com>
cc:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, fvdl@google.com, quic_pkondeti@quicinc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
In-Reply-To: <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com>
Message-ID: <2d56e1dd-68b5-c99e-522f-f8dadf6ad69e@google.com>
References: <cover.1676378702.git.quic_charante@quicinc.com> <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023, Charan Teja Kalla wrote:

> Currently fadvise(2) is supported only for the files that doesn't
> associated with noop_backing_dev_info thus for the files, like shmem,
> fadvise results into NOP. But then there is file_operations->fadvise()
> that lets the file systems to implement their own fadvise
> implementation. Use this support to implement some of the POSIX_FADV_XXX
> functionality for shmem files.
> 
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the clients who may want
> to manage the shmem pages of the files that are created through
> shmem_file_setup[_with_mnt](). One usecase is implemented on the
> Snapdragon SoC's running Android where the graphics client is allocating
> lot of shmem pages per process and pinning them. When this process is
> put to background, the instantaneous reclaim is performed on those shmem
> pages using the logic implemented downstream[3][4]. With this patch, the
> client can now issue the fadvise calls on the shmem files that does the
> instantaneous reclaim which can aid the use cases like mentioned above.
> 
> This usecase lead to ~2% reduction in average launch latencies of the
> apps and 10% in total number of kills by the low memory killer running
> on Android.
> 
> Some questions asked while reviewing this patch:
> Q) Can the same thing be achieved with FD mapped to user and use
> madvise?
> A) All drivers are not mapping all the shmem fd's to user space and want
> to manage them with in the kernel. Ex: shmem memory can be mapped to the
> other subsystems and they fill in the data and then give it to other
> subsystem for further processing, where, the user mapping is not at all
> required.  A simple example, memory that is given for gpu subsystem
> which can be filled directly and give to display subsystem. And the
> respective drivers know well about when to keep that memory in ram or
> swap based on may be a user activity.
> 
> Q) Should we add the documentation section in Manual pages?
> A) The man[1] pages for the fadvise() whatever says is also applicable
> for shmem files. so couldn't feel it correct to add specific to shmem
> files separately.
> 
> Q) The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
> MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing API
> and this difference will cause confusion?
> A) man pages [2] says that "POSIX_FADV_DONTNEED attempts to free cached
> pages associated with the specified region." This means on issuing this
> FADV, it is expected to free the file cache pages. And it is
> implementation defined If the dirty pages may be attempted to writeback.
> And the unwritten dirty pages will not be freed. So, FADV_DONTNEED also
> covers the semantics of MADV_PAGEOUT for file pages and there is no
> purpose of PAGEOUT for file pages.
> 
> [1] https://linux.die.net/man/2/fadvise
> [2] https://man7.org/linux/man-pages/man2/posix_fadvise.2.html
> [3] https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-kernel/-/blob/gfx-kernel.lnx.1.0.r3-rel/kgsl_reclaim.c#L289
> [4] https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.10/mm/shmem.c#4310
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

I'm sorry, but no, this is not yet ready for primetime. I came here
expecting to be able just to add a patch on top with small fixes,
but see today that it needs more than that, and my time has run out.

Though if Andrew is keen to go ahead with it in 6.4, and add fixes
on top while it's in rc, that will be okay: except for one small bad
bug, which must be fixed immediately - "luckily" nobody appears to
be using or testing this since v5, but it cannot go further as is.

Willneed is probably fine, but dontneed is not.

> ---
>  mm/shmem.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 448f393..1af8525 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -40,6 +40,9 @@
>  #include <linux/fs_parser.h>
>  #include <linux/swapfile.h>
>  #include <linux/iversion.h>
> +#include <linux/mm_inline.h>
> +#include <linux/fadvise.h>
> +#include <linux/page_idle.h>
>  #include "swap.h"
>  
>  static struct vfsmount *shm_mnt;
> @@ -2344,6 +2347,118 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
>  #define shmem_initxattrs NULL
>  #endif
>  
> +static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
> +				loff_t end, struct list_head *list)

loff_t? They are pgoff_t.

> +{
> +	XA_STATE(xas, &mapping->i_pages, start);
> +	struct folio *folio;
> +
> +	rcu_read_lock();
> +	xas_for_each(&xas, folio, end) {
> +		if (xas_retry(&xas, folio))
> +			continue;
> +		if (xa_is_value(folio))
> +			continue;
> +
> +		if (!folio_try_get(folio))
> +			continue;
> +		if (folio_test_unevictable(folio) || folio_mapped(folio) ||
> +				folio_isolate_lru(folio)) {

There is the one small bad bug.  That should say !folio_isolate_lru(folio).
In v5, it was isolate_lru_page(page), because isolate_lru_page() returned
0 for success or -EBUSY for unavailable; whereas folio_isolate_lru(folio)
is a boolean, returning true if it successfully removed folio from LRU.

The effect of that bug is that in v6 and v7, it has skipped all the folios
it was expected to be reclaiming; except when one of them happened to be
off LRU for other reasons (being reclaimed elsewhere, being migrated,
whatever) - and precisely those folios which were not safe to touch,
which have often been transferred to a private worklist, are the ones
which the code below goes on to play with - corrupting either or both
lists.  (I haven't tried to reproduce that in practice, just saw it
in the code, and verified with a count that no pages were reclaimed.)

> +			folio_put(folio);
> +			continue;
> +		}
> +		folio_put(folio);
> +
> +		/*
> +		 * Prepare the folios to be passed to reclaim_pages().
> +		 * VM can't reclaim a folio unless young bit is
> +		 * cleared in its flags.
> +		 */
> +		folio_clear_referenced(folio);
> +		folio_test_clear_young(folio);
> +		list_add(&folio->lru, list);
> +		if (need_resched()) {
> +			xas_pause(&xas);
> +			cond_resched_rcu();
> +		}
> +	}
> +	rcu_read_unlock();
> +}
> +
> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
> +				loff_t end)

loff_t? They are pgoff_t. And why return an int which is always 0?

> +{
> +	LIST_HEAD(folio_list);
> +
> +	if (!total_swap_pages || mapping_unevictable(mapping))
> +		return 0;
> +
> +	lru_add_drain();
> +	shmem_isolate_pages_range(mapping, start, end, &folio_list);
> +	reclaim_pages(&folio_list);
> +
> +	return 0;
> +}
> +
> +static int shmem_fadvise_willneed(struct address_space *mapping,
> +				 pgoff_t start, pgoff_t long end)

pgoff_t long? That's a new type to me! Again, why return an int always 0?

> +{
> +	struct folio *folio;
> +	pgoff_t index;
> +
> +	xa_for_each_range(&mapping->i_pages, index, folio, start, end) {
> +		if (!xa_is_value(folio))
> +			continue;
> +		folio = shmem_read_folio(mapping, index);
> +		if (!IS_ERR(folio))
> +			folio_put(folio);
> +	}
> +
> +	return 0;
> +}
> +
> +static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
> +{
> +	loff_t endbyte;
> +	pgoff_t start_index;
> +	pgoff_t end_index;
> +	struct address_space *mapping;
> +	struct inode *inode = file_inode(file);
> +	int ret = 0;
> +
> +	if (S_ISFIFO(inode->i_mode))
> +		return -ESPIPE;
> +
> +	mapping = file->f_mapping;
> +	if (!mapping || len < 0 || !shmem_mapping(mapping))
> +		return -EINVAL;
> +
> +	endbyte = fadvise_calc_endbyte(offset, len);
> +
> +	start_index = offset >> PAGE_SHIFT;
> +	end_index   = endbyte >> PAGE_SHIFT;
> +	switch (advice) {
> +	case POSIX_FADV_DONTNEED:

This is where I ran out of time.  I'm afraid all the focus on
fadvise_calc_endbyte() has distracted you from looking at the DONTNEED
in mm/fadvise.c: where there are detailed comments on why and how it
then narrows the DONTNEED range.  And aside from needing to duplicate
that here for shmem (or put it into another or combined helper), it
implies to me that shmem_isolate_pages_range() needs to do a similar
narrowing, when it finds that the range overlaps part of a large folio.

Something that has crossed my mind as a worry, but I've not had time
to look further into (maybe it's no concern at all) is the question
of this syscall temporarily isolating a very large number of folios,
whether they need to be (or perhaps already are) counted in
NR_ISOLATED_ANON, whether too many isolated needs to be limited.

> +		ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
> +		break;
> +	case POSIX_FADV_WILLNEED:
> +		ret = shmem_fadvise_willneed(mapping, start_index, end_index);
> +		break;
> +	case POSIX_FADV_NORMAL:
> +	case POSIX_FADV_RANDOM:
> +	case POSIX_FADV_SEQUENTIAL:
> +	case POSIX_FADV_NOREUSE:
> +		/*
> +		 * No bad return value, but ignore advice.
> +		 */
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
>  				     struct inode *dir, umode_t mode, dev_t dev,
>  				     unsigned long flags)
> @@ -3942,6 +4057,7 @@ static const struct file_operations shmem_file_operations = {
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= shmem_fallocate,
>  #endif
> +	.fadvise	= shmem_fadvise,

I'd say posix_fadvise() is an operation on an fd, and shmem_fadvise() and
all its helpers should be under CONFIG_TMPFS (but oftentimes I do think
CONFIG_TMPFS and CONFIG_SHMEM are more trouble than they are worth).

Hugh

>  };
>  
>  static const struct inode_operations shmem_inode_operations = {
> -- 
> 2.7.4
