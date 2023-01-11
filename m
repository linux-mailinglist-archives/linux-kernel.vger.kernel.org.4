Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2311D6665DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbjAKVw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjAKVwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:52:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31165FD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673473900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rmQhK16s21vxdj+vsmOp1AcpEH/3VrVvL3h8R46Yfuk=;
        b=eFdTvsyC79OfDM6hAyJMHG8Ykj24Vo99QnhUY6CVpKcv2KkxZVYYnIB2jP3vSqZ1zbJjM2
        FAwIGkaJ8D31zeeI2Av1t0mzoAQBnyJCZT8VF/AG3zDy98MeVN+ZQAUXQeP0aPyVnFG2tw
        wp0JnWvF62rRZFFTMTEd4rgO8t0KZDI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-UQvt00XWOXes1uGJ3PA_lw-1; Wed, 11 Jan 2023 16:51:39 -0500
X-MC-Unique: UQvt00XWOXes1uGJ3PA_lw-1
Received: by mail-qv1-f69.google.com with SMTP id qf9-20020a0562144b8900b004c71efc3528so9078071qvb.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmQhK16s21vxdj+vsmOp1AcpEH/3VrVvL3h8R46Yfuk=;
        b=4ttGYHe6OzkoLHLecM9SFGcXZlG5E+9DIRNtswxrLeS1jUiDvRevNL8/6rdMRZp8t4
         TlxrEaOMb1/GknSl5QE8/iMeSo7p0M72wwsTD28wt7dBq8I6hF7KrsOfM6hFvT6oO512
         hCkhnFkfGLmWfMu+kZnWVGIq/donYcAOkQrKC65ndaZ/PU8k/0P012LIfg2v9Qxv8j8O
         LXC7anF0mfF0MpJAV2PX/A8xFQQRBBOilo9CmXHxxUsuc9CJhe6KeELqZWanRTXbCNWi
         WoIN7y5mPcG4mCz9UHtr/wjG4oUZiRcPd/Z4kqYzvgYAnIj6wAzs4w8XXI/IWsLVojUC
         0wIw==
X-Gm-Message-State: AFqh2kqDJjfGTodW+YtCSO6iIZC69iGv4DbpGXX38kSMN9N8K4oQ+ahB
        UeMmCQvYdkMM5+c7lmDP1APFirEwP6+dtDeVQdQHRVHyCsjYf4luKyBf/A2Fn7HH6eGByRiBtLK
        Xd7W3L1O3AAu5tMsvKlW1J6Mw
X-Received: by 2002:a05:6214:2b94:b0:532:1944:769 with SMTP id kr20-20020a0562142b9400b0053219440769mr29747857qvb.18.1673473899082;
        Wed, 11 Jan 2023 13:51:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu9e84AKdKTSOdZm66j992VQ2/CKaO9nQMHR17/gjpvXtnlgiyK/YZsRNZNiSYFEg4dRdXicg==
X-Received: by 2002:a05:6214:2b94:b0:532:1944:769 with SMTP id kr20-20020a0562142b9400b0053219440769mr29747826qvb.18.1673473898789;
        Wed, 11 Jan 2023 13:51:38 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a289400b006fed58fc1a3sm9728529qkp.119.2023.01.11.13.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:51:38 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:51:36 -0500
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
Subject: Re: [PATCH 13/46] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
Message-ID: <Y78vaNW10X6vUKjA@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-14-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105101844.1893104-14-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:18:11AM +0000, James Houghton wrote:

[...]

> +static int hugetlb_hgm_walk_uninit(struct hugetlb_pte *hpte,

Nitpick on the name: the "uninit" can be misread into pairing with some
other "init()" calls..

How about just call it hugetlb_hgm_walk (since it's the higher level API
comparing to the existing one)?  Then the existing hugetlb_hgm_walk can be
called hugetlb_hgm_do_walk/__hugetlb_hgm_walk since it's one level down.

> +				   pte_t *ptep,
> +				   struct vm_area_struct *vma,
> +				   unsigned long addr,
> +				   unsigned long target_sz,
> +				   bool alloc)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +
> +	hugetlb_pte_populate(vma->vm_mm, hpte, ptep, huge_page_shift(h),
> +			     hpage_size_to_level(huge_page_size(h)));

Another nitpick on name: I remembered we used to reach a consensus of using
hugetlb_pte_init before?  Can we still avoid the word "populate" (if "init"
is not suitable since it can be updated during stepping, how about "setup")?

[...]

> +int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		      unsigned long addr, unsigned long sz)
> +{
> +	pte_t *ptep;
> +	spinlock_t *ptl;
> +
> +	switch (hpte->level) {
> +	case HUGETLB_LEVEL_PUD:
> +		ptep = (pte_t *)hugetlb_alloc_pmd(mm, hpte, addr);
> +		if (IS_ERR(ptep))
> +			return PTR_ERR(ptep);
> +		hugetlb_pte_populate(mm, hpte, ptep, PMD_SHIFT,
> +				     HUGETLB_LEVEL_PMD);
> +		break;
> +	case HUGETLB_LEVEL_PMD:
> +		ptep = hugetlb_alloc_pte(mm, hpte, addr);
> +		if (IS_ERR(ptep))
> +			return PTR_ERR(ptep);
> +		ptl = pte_lockptr(mm, (pmd_t *)hpte->ptep);
> +		__hugetlb_pte_populate(hpte, ptep, PAGE_SHIFT,
> +				       HUGETLB_LEVEL_PTE, ptl);
> +		hpte->ptl = ptl;

This line seems to be superfluous (even if benign).

> +		break;
> +	default:
> +		WARN_ONCE(1, "%s: got invalid level: %d (shift: %d)\n",
> +				__func__, hpte->level, hpte->shift);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Return a mask that can be used to update an address to the last huge
>   * page in a page table page mapping size.  Used to skip non-present
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
Peter Xu

