Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693EB67E983
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjA0Pd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbjA0PdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:33:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58D7C704
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674833558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJQRlyLqASk+uXdbQGFsiJ2d1fNp4UuhBEQ/arPq7Lc=;
        b=MrH7wwDKxc2H5aSs+8wC3RSre+/RZTmkAFUdsYqRlz8uB7lSloxhNk0CBn+iShngU3enhP
        monH51mYjWN/KEwdxb+HNnIY6sNeo4yTD1cjdQMoqQUhTNLEiPjgmhfG8MKmBJTPGnJLHH
        pImxRSQkYKsKaec9v3hz3xC0NhKvQjs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-rA1wc0zIOmmD68TKMfO4Cg-1; Fri, 27 Jan 2023 10:32:37 -0500
X-MC-Unique: rA1wc0zIOmmD68TKMfO4Cg-1
Received: by mail-qv1-f70.google.com with SMTP id i17-20020a0cfcd1000000b005377f5ce3baso2744155qvq.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJQRlyLqASk+uXdbQGFsiJ2d1fNp4UuhBEQ/arPq7Lc=;
        b=ixB18js8+Zd9aCYRspudW/zxdN/roAdDjh7O7oiGlLYWULjhU+zS51emXaEwUV5iw+
         3COYN+goPSBt1bLyAuGDabaGm+r506WBX3K3qyoWFG74c6/Ur5BdqSJ+FgQzxDnfToNJ
         ZwKaEpJKcCFQTrPBvK+qycHAstspgbuJYtdF6F3YSGM2raFlFlMr74kyLNNzItmewZ+4
         JFdLstJ38UIoDCLQ7FpBnxe/CR1z0ad9cII5UgmA5LH0rvBdHhFN1/MK0Zpt1+E933VV
         tIEqqX5h5Imx9Jkb9SE9zYRIn4//N90J6Zn4NjyB3ar1GOaqfuoNKpjpm7zXkn40/hrc
         xSeg==
X-Gm-Message-State: AFqh2kqVKsj7waPLIgquECrJOWy4a2wkbb1KBTYWH5lkO7/2DS6JGKdQ
        s7Y4JcPE5r7Acvqc5sqRQ4ZagamHXe4tFQuHL9jR3nP6LbLcQ3C2my9vsSDx4y32rzAxYCtx81i
        kCTnhLiHg0g2EbIHHyI+QLFGN
X-Received: by 2002:ac8:45c4:0:b0:3b6:34b0:fc9c with SMTP id e4-20020ac845c4000000b003b634b0fc9cmr54937846qto.42.1674833557019;
        Fri, 27 Jan 2023 07:32:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt0k4/DU6oVKnRtGvExXLnbSo8VJTo48yXrLbOJjyyP3PKeDnkAkB1/MMIbIrafuBgbyw9qpA==
X-Received: by 2002:ac8:45c4:0:b0:3b6:34b0:fc9c with SMTP id e4-20020ac845c4000000b003b634b0fc9cmr54937805qto.42.1674833556730;
        Fri, 27 Jan 2023 07:32:36 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id j18-20020ac84052000000b003b635a5d56csm2821434qtl.30.2023.01.27.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:32:35 -0800 (PST)
Date:   Fri, 27 Jan 2023 10:32:33 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 1/4] userfaultfd: Add UFFD WP Async support
Message-ID: <Y9PtHUONh2ImQyKF@x1n>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-2-usama.anjum@collabora.com>
 <Y9MHM+RVzvigcTTk@x1n>
 <1968dff9-f48a-3290-a15b-a8b739f31ed2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1968dff9-f48a-3290-a15b-a8b739f31ed2@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:47:14AM +0500, Muhammad Usama Anjum wrote:
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 4000e9f017e0..8c03b133d483 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3351,6 +3351,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >>  
> >>  	if (likely(!unshare)) {
> >>  		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> >> +			if (userfaultfd_wp_async(vma)) {
> >> +				/*
> >> +				 * Nothing needed (cache flush, TLB invalidations,
> >> +				 * etc.) because we're only removing the uffd-wp bit,
> >> +				 * which is completely invisible to the user. This
> >> +				 * falls through to possible CoW.
> > 
> > Here it says it falls through to CoW, but..
> > 
> >> +				 */
> >> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
> >> +				set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
> >> +					   pte_clear_uffd_wp(*vmf->pte));
> >> +				return 0;
> > 
> > ... it's not doing so.  The original lines should do:
> > 
> > https://lore.kernel.org/all/Y8qq0dKIJBshua+X@x1n/

[1]

> > 
> > Side note: you cannot modify pgtable after releasing the pgtable lock.
> > It's racy.
> If I don't unlock and return after removing the UFFD_WP flag in case of
> async wp, the target just gets stuck. Maybe the pte lock is not unlocked in
> some path.
> 
> If I unlock and don't return, the crash happens.
> 
> So I'd put unlock and return from here. Please comment on the below patch
> and what do you think should be done. I've missed something.

Have you tried to just use exactly what I suggested in [1]?  I'll paste
again:

---8<---
diff --git a/mm/memory.c b/mm/memory.c
index 4000e9f017e0..09aab434654c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3351,8 +3351,20 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)

        if (likely(!unshare)) {
                if (userfaultfd_pte_wp(vma, *vmf->pte)) {
-                       pte_unmap_unlock(vmf->pte, vmf->ptl);
-                       return handle_userfault(vmf, VM_UFFD_WP);
+                       if (userfaultfd_uffd_wp_async(vma)) {
+                               /*
+                                * Nothing needed (cache flush, TLB
+                                * invalidations, etc.) because we're only
+                                * removing the uffd-wp bit, which is
+                                * completely invisible to the user.
+                                * This falls through to possible CoW.
+                                */
+                               set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
+                                          pte_clear_uffd_wp(*vmf->pte));
+                       } else {
+                               pte_unmap_unlock(vmf->pte, vmf->ptl);
+                               return handle_userfault(vmf, VM_UFFD_WP);
+                       }
                }
---8<---

Note that there's no "return", neither the unlock.  The lock is used in the
follow up write fault resolution and it's released later.

Meanwhile please fully digest how pgtable lock is used in this path before
moving forward on any of such changes.

> 
> > 
> >> +			}
> >>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
> >>  			return handle_userfault(vmf, VM_UFFD_WP);
> >>  		}
> >> @@ -4812,8 +4824,21 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
> >>  
> >>  	if (vma_is_anonymous(vmf->vma)) {
> >>  		if (likely(!unshare) &&
> >> -		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
> >> -			return handle_userfault(vmf, VM_UFFD_WP);
> >> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
> >> +			if (userfaultfd_wp_async(vmf->vma)) {
> >> +				/*
> >> +				 * Nothing needed (cache flush, TLB invalidations,
> >> +				 * etc.) because we're only removing the uffd-wp bit,
> >> +				 * which is completely invisible to the user. This
> >> +				 * falls through to possible CoW.
> >> +				 */
> >> +				set_pmd_at(vmf->vma->vm_mm, vmf->address, vmf->pmd,
> >> +					   pmd_clear_uffd_wp(*vmf->pmd));
> > 
> > This is for THP, not hugetlb.
> > 
> > Clearing uffd-wp bit here for the whole pmd is wrong to me, because we
> > track writes in small page sizes only.  We should just split.
> By detecting if the fault is async wp, just splitting the PMD doesn't work.
> The below given snippit is working right now. But definately, the fault of
> the whole PMD is being resolved which if we can bypass by correctly
> splitting would be highly desirable. Can you please take a look on UFFD
> side and suggest the changes? It would be much appreciated. I'm attaching
> WIP v9 patches for you to apply on next(next-20230105) and pagemap_ioctl
> selftest can be ran to test things after making changes.

Can you elaborate why thp split didn't work?  Or if you want, I can look
into this and provide the patch to enable uffd async mode.

Thanks,

-- 
Peter Xu

