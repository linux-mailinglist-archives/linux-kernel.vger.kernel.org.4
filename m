Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5452762C5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiKPRJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiKPRJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12E30F42
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668618493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HqxuMjyuv4ZVgzjzmUzOoU3sDZ8+2sjayvk5TJWhlqI=;
        b=QReta4GYnQDwPFlhBeJyeaBzD8MbpBVUwRBTtrSRQN/nO9UKxyBRq/UhE+NOd9R6/ZJz/N
        pTEFc1pYdIpneW+kpxku7GNUDi+MD/9zNtFY+DOdfZC2ACo4sWkrc0b2f1m1Figa89gs/U
        d01xGlxZckU0r9L/uNf+iaUl8GnTrho=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-dXBVhja8PgSZF3dOgEv1WQ-1; Wed, 16 Nov 2022 12:08:12 -0500
X-MC-Unique: dXBVhja8PgSZF3dOgEv1WQ-1
Received: by mail-qk1-f199.google.com with SMTP id bi42-20020a05620a31aa00b006faaa1664b9so17717085qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqxuMjyuv4ZVgzjzmUzOoU3sDZ8+2sjayvk5TJWhlqI=;
        b=cCKMWrMqtP/XD1KzUzKfXwOdQ87996qgQGVnMECmt+V55czXCKu4GeCCGL1+Tz+biy
         lph5/m3FjGTvK7l8wS/j9ohT2Jg1Sh/ecoHyf0mpN1vgYm/Swao2dJJxIiTpfFNqVyq5
         E4I3nfpsBwbwvCdvWnTskkVIve57RygUo8Ntmzd/gU52U3zPC60++tBivyciLZdISE4R
         38ziKBzKwXBikbf8Mv+mJEm+erqOBPuM+9sFdi1qQmvRqvZjqYpSgkX3yVjZcJ1uPTTI
         qfCUJzL3U2RA4LlTYAEcuydk5Lsi/f5/IW0OZjEOdhYAnpfFLl+VtdddaItf5nBBHyH6
         XguA==
X-Gm-Message-State: ANoB5pkdPYPgLIw4EE0UdWCwwlmsjQz+eD2xQRc8LMrmmtNd/W/GQSNa
        L8mIWE8kI7v++rJXOebYIhEHVpi2mceCuJ3aECV5EKbcbUxk+kc65Ib2yIDSXDN72I63r2Li0xj
        aGlPJ1Uy7Sdt+sHnqNQ92ChIm
X-Received: by 2002:ac8:690:0:b0:39c:f63c:18b4 with SMTP id f16-20020ac80690000000b0039cf63c18b4mr22064075qth.17.1668618492094;
        Wed, 16 Nov 2022 09:08:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4rOP5n0Q/DNXZe7qm0eHphYe40gE/EYhfx2rdQvr+4Me7E9o/jzYLYg4jLPIycPd2brO0uLg==
X-Received: by 2002:ac8:690:0:b0:39c:f63c:18b4 with SMTP id f16-20020ac80690000000b0039cf63c18b4mr22064050qth.17.1668618491817;
        Wed, 16 Nov 2022 09:08:11 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006faaf6dc55asm10492098qki.22.2022.11.16.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 09:08:11 -0800 (PST)
Date:   Wed, 16 Nov 2022 12:08:09 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 05/47] hugetlb: make hugetlb_vma_lock_alloc return
 its failure reason
Message-ID: <Y3UY+XXXwnjDLMPl@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-6-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-6-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:21PM +0000, James Houghton wrote:
> Currently hugetlb_vma_lock_alloc doesn't return anything, as there is no
> need: if it fails, PMD sharing won't be enabled. However, HGM requires
> that the VMA lock exists, so we need to verify that
> hugetlb_vma_lock_alloc actually succeeded. If hugetlb_vma_lock_alloc
> fails, then we can pass that up to the caller that is attempting to
> enable HGM.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 52cec5b0789e..dc82256b89dd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -92,7 +92,7 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
>  static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
> -static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
> +static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
>  static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
>  
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
> @@ -7001,17 +7001,17 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
>  	}
>  }
>  
> -static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
> +static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
>  {
>  	struct hugetlb_vma_lock *vma_lock;
>  
>  	/* Only establish in (flags) sharable vmas */
>  	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
> -		return;
> +		return -EINVAL;
>  
> -	/* Should never get here with non-NULL vm_private_data */
> +	/* We've already allocated the lock. */
>  	if (vma->vm_private_data)
> -		return;
> +		return 0;

No objection on the patch itself, but I am just wondering what guarantees
thread-safety for this function to not leak vm_private_data when two
threads try to allocate at the same time.

I think it should be the write mmap lock.  I saw that in your latest code
base there's:

	/*
	 * We must hold the mmap lock for writing so that callers can rely on
	 * hugetlb_hgm_enabled returning a consistent result while holding
	 * the mmap lock for reading.
	 */
	mmap_assert_write_locked(vma->vm_mm);

	/* HugeTLB HGM requires the VMA lock to synchronize collapsing. */
	ret = hugetlb_vma_data_alloc(vma);
	if (ret)
		return ret;

So that's covered there.  The rest places are hugetlb_vm_op_open() and
hugetlb_reserve_pages() and they all seem fine too: hugetlb_vm_op_open() is
during mmap(), the latter has vma==NULL so allocation will be skipped.

I'm wondering whether it would make sense to move this assert to be inside
of hugetlb_vma_data_alloc() after the !vma check, or just add the same
assert too but for different reason.

>  
>  	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
>  	if (!vma_lock) {
> @@ -7026,13 +7026,14 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
>  		 * allocation failure.
>  		 */
>  		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
> -		return;
> +		return -ENOMEM;
>  	}
>  
>  	kref_init(&vma_lock->refs);
>  	init_rwsem(&vma_lock->rw_sema);
>  	vma_lock->vma = vma;
>  	vma->vm_private_data = vma_lock;
> +	return 0;
>  }
>  
>  /*
> @@ -7160,8 +7161,9 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
>  {
>  }
>  
> -static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
> +static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
>  {
> +	return 0;
>  }
>  
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> -- 
> 2.38.0.135.g90850a2211-goog
> 
> 

-- 
Peter Xu

