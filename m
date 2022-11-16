Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA0D62C63E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiKPRVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiKPRUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA219C1D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668619180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6QdCQc4Q7WGwEMzhuVjowqOBWlPIurFWAoLBRepKmw=;
        b=fRg0hNMJUJ2MfI+MZ91G7kzT1WjHwn8/je9EfspEsXaTlD0xceogyPnmUbrqp9UMrz1jCv
        7atvpFEVzLqqd/DDst7OimdY6j2OiCLwJrS05RfRSuIi6SYUZ1mzxRtWUdcizzEPXOY5GD
        me/tV8cNho3HhnSjT0vaeyeezIU2flY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-NWF-TsD6NoeARnFXvyfcaw-1; Wed, 16 Nov 2022 12:19:38 -0500
X-MC-Unique: NWF-TsD6NoeARnFXvyfcaw-1
Received: by mail-qt1-f199.google.com with SMTP id y19-20020a05622a121300b003a526e0ff9bso13452532qtx.15
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6QdCQc4Q7WGwEMzhuVjowqOBWlPIurFWAoLBRepKmw=;
        b=zAeVEPveJQ6ooP7iLzd2vT5DREFt0J0AQUzA40k/xaRwQSvrPH+ayaayRIxPQVch/7
         q7eqJjfUETC5Fv3gHG+n89NUJJy2q4K1aIzJXr65MZVK3cY7HevzwnAyOwoha0DuTKGx
         mH8iezi9YZDeqkJ6p6MObk8bFXTf0LgfOYl88h/q6p/ZemV7xdOorctreHs5qZhU5Tbm
         FYA97jiOfWuv3p2gBt/JkTOtRZOhAKIF2IHKRu1u56PFx16xJUuDzbELzS1J6YK8m/k3
         wLFUQnSTtX8FedH3wAGygmFcxyqgJ2P+PX2U/Mv6nCRbxkXPqMZpcynsAi8mPmP+fVzQ
         IKlQ==
X-Gm-Message-State: ANoB5pn9yr9mIa2NNDyiGJal78yobiE9xz1Us8s/2hIYm5ALTOCQ3oB1
        I2ngP5gcRDOY1jzs3WOSELfVPreXKocHVBc9JqP2N94gcm8vgyUjooSiuKntA6grpqMKlKz2WV7
        WLyjOYGcJn6i2Frdv0/47ISi8
X-Received: by 2002:a0c:f9d0:0:b0:4c6:40d7:4894 with SMTP id j16-20020a0cf9d0000000b004c640d74894mr12780717qvo.101.1668619178290;
        Wed, 16 Nov 2022 09:19:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4xuArjQ36VAS5S4k1kTkda1B/eVMOFUUqwQzXqDx5B68E8ktPVHWKnokUH0ZGDwlJkksWeqA==
X-Received: by 2002:a0c:f9d0:0:b0:4c6:40d7:4894 with SMTP id j16-20020a0cf9d0000000b004c640d74894mr12780693qvo.101.1668619178009;
        Wed, 16 Nov 2022 09:19:38 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bk8-20020a05620a1a0800b006f9f3c0c63csm10412240qkb.32.2022.11.16.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 09:19:37 -0800 (PST)
Date:   Wed, 16 Nov 2022 12:19:36 -0500
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
Subject: Re: [RFC PATCH v2 08/47] hugetlb: add HGM enablement functions
Message-ID: <Y3UbqFBvN/C82HuJ@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-9-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-9-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:24PM +0000, James Houghton wrote:
> Currently it is possible for all shared VMAs to use HGM, but it must be
> enabled first. This is because with HGM, we lose PMD sharing, and page
> table walks require additional synchronization (we need to take the VMA
> lock).
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h | 22 +++++++++++++
>  mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 534958499ac4..6e0c36b08a0c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -123,6 +123,9 @@ struct hugetlb_vma_lock {
>  
>  struct hugetlb_shared_vma_data {
>  	struct hugetlb_vma_lock vma_lock;
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	bool hgm_enabled;
> +#endif
>  };
>  
>  extern struct resv_map *resv_map_alloc(void);
> @@ -1179,6 +1182,25 @@ static inline void hugetlb_unregister_node(struct node *node)
>  }
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
> +int enable_hugetlb_hgm(struct vm_area_struct *vma);
> +#else
> +static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +static inline int enable_hugetlb_hgm(struct vm_area_struct *vma)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
>  					struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5ae8bc8c928e..a18143add956 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6840,6 +6840,10 @@ static bool pmd_sharing_possible(struct vm_area_struct *vma)
>  #ifdef CONFIG_USERFAULTFD
>  	if (uffd_disable_huge_pmd_share(vma))
>  		return false;
> +#endif
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	if (hugetlb_hgm_enabled(vma))
> +		return false;
>  #endif
>  	/*
>  	 * Only shared VMAs can share PMDs.
> @@ -7033,6 +7037,9 @@ static int hugetlb_vma_data_alloc(struct vm_area_struct *vma)
>  	kref_init(&data->vma_lock.refs);
>  	init_rwsem(&data->vma_lock.rw_sema);
>  	data->vma_lock.vma = vma;
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	data->hgm_enabled = false;
> +#endif
>  	vma->vm_private_data = data;
>  	return 0;
>  }
> @@ -7290,6 +7297,68 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>  
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>  
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> +{
> +	/*
> +	 * All shared VMAs may have HGM.
> +	 *
> +	 * HGM requires using the VMA lock, which only exists for shared VMAs.
> +	 * To make HGM work for private VMAs, we would need to use another
> +	 * scheme to prevent collapsing/splitting from invalidating other
> +	 * threads' page table walks.
> +	 */
> +	return vma && (vma->vm_flags & VM_MAYSHARE);
> +}
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +	struct hugetlb_shared_vma_data *data = vma->vm_private_data;
> +
> +	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
> +		return false;

Nit: smells like a open-coded hugetlb_hgm_eligible().

> +
> +	return data && data->hgm_enabled;
> +}
> +
> +/*
> + * Enable high-granularity mapping (HGM) for this VMA. Once enabled, HGM
> + * cannot be turned off.
> + *
> + * PMDs cannot be shared in HGM VMAs.
> + */
> +int enable_hugetlb_hgm(struct vm_area_struct *vma)
> +{
> +	int ret;
> +	struct hugetlb_shared_vma_data *data;
> +
> +	if (!hugetlb_hgm_eligible(vma))
> +		return -EINVAL;
> +
> +	if (hugetlb_hgm_enabled(vma))
> +		return 0;
> +
> +	/*
> +	 * We must hold the mmap lock for writing so that callers can rely on
> +	 * hugetlb_hgm_enabled returning a consistent result while holding
> +	 * the mmap lock for reading.
> +	 */
> +	mmap_assert_write_locked(vma->vm_mm);
> +
> +	/* HugeTLB HGM requires the VMA lock to synchronize collapsing. */
> +	ret = hugetlb_vma_data_alloc(vma);
> +	if (ret)
> +		return ret;
> +
> +	data = vma->vm_private_data;
> +	BUG_ON(!data);

Let's avoid BUG_ON() as afaiu it's mostly not welcomed unless extremely
necessary.  In this case it'll crash immediately in next dereference anyway
with the whole stack dumped, so we won't miss anything important. :)

> +	data->hgm_enabled = true;
> +
> +	/* We don't support PMD sharing with HGM. */
> +	hugetlb_unshare_all_pmds(vma);
> +	return 0;
> +}
> +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> +
>  /*
>   * These functions are overwritable if your architecture needs its own
>   * behavior.
> -- 
> 2.38.0.135.g90850a2211-goog
> 

-- 
Peter Xu

