Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE25E62EAD1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiKRBSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiKRBSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:18:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB61FC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668734274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2VQywQIWlw8LxZeusGSWX+0k1dWP0sWzZLRZxVp07M=;
        b=H0tQ3xqH+1e6flFVHtz3/ewhZHoUCgXQ6ltMaU6IzlfpjHqabGM8zhJY9daNztKaXl4xK5
        yrrt43ecelhbfoyxpkLCUgWY99Re+bpV/Zrke8vfI/0oVGQb9EJrqOACGg4L35Yom2wzt0
        BOEjQE4eOFW234/tEtSnuW9Owx3gxE0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-To_lJJbrOBmpqJjErbOumg-1; Thu, 17 Nov 2022 20:17:53 -0500
X-MC-Unique: To_lJJbrOBmpqJjErbOumg-1
Received: by mail-qk1-f200.google.com with SMTP id i21-20020a05620a405500b006fb25ba3e00so4442931qko.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2VQywQIWlw8LxZeusGSWX+0k1dWP0sWzZLRZxVp07M=;
        b=EYDHyokpzBy3p9nmF4BkaN25NYhvWpPppy6yPM1Ry0FxSqSOjN2RMnvyep3aqUVptR
         EgfWd01ibQpDUPZUoaKTrUbzsGyP4Dgic0yosEqBhblOMdR+Gc2IU2o9NX/Rg/JNuEum
         ncjxtebLQCs2U4sdLGUAYfj/ykk5HzC48qymJBt3kLuqKbBV9jmk/Jib6g+zRcFqXee1
         3TNeKiVe9EeQuQHL0xbbfKahuTV5EihCM5xsGXS0svsO4oaYv2GLcKl6hjQy14zPGNuN
         Rql9SaS+iNpH69XfV6meJtWvpYvywzW61DMq/UD5LATMSTIrZh/sXMY4aseekjxtu43B
         Ld8Q==
X-Gm-Message-State: ANoB5plzzeP9WTEQYbfWSXyPRDUmSUjYHzEIpD+DLy2V4dcjE3GHd1bD
        VFRBeQuflX2Q4hqtK60CCAqxaADbADofeeTa44crj4nAMpqdvrmhMUoC6EaIe6dAXoTTHfCHpd7
        Jx/boDw2meEWz739t7CaAMMGz
X-Received: by 2002:a37:603:0:b0:6fa:81:6aa4 with SMTP id 3-20020a370603000000b006fa00816aa4mr4309766qkg.148.1668734272491;
        Thu, 17 Nov 2022 17:17:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Ms4iaoqqE6cRnnYtO9svOrWT9cOf9t6bK7uiuSOSBy2IQRImtO7tU2zGzqIWZhdMeP+8I5w==
X-Received: by 2002:a37:603:0:b0:6fa:81:6aa4 with SMTP id 3-20020a370603000000b006fa00816aa4mr4309750qkg.148.1668734272253;
        Thu, 17 Nov 2022 17:17:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id k21-20020ac86055000000b003a50c9993e1sm1226791qtm.16.2022.11.17.17.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:17:51 -0800 (PST)
Date:   Thu, 17 Nov 2022 20:17:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC v2 06/12] mm/hugetlb: Protect huge_pmd_share() with
 walker lock
Message-ID: <Y3bdPuRR8Oq1Kexx@x1n>
References: <20221118011025.2178986-1-peterx@redhat.com>
 <20221118011025.2178986-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221118011025.2178986-7-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:10:19PM -0500, Peter Xu wrote:
> huge_pmd_share() is normally called with vma lock held already, it lets us
> feel like we don't really need the walker lock.  But that's not true,
> because we only took the vma lock for "current" vma, but not all the vma
> pgtables we're going to walk upon.
> 
> Taking each vma lock may lead to deadlock and hard to order.  The safe
> approach is just to use the walker lock which guarantees the pgtable page
> being alive, then we should use get_page_unless_zero() rather than
> get_page() only, to make sure the pgtable page is not being freed at the
> meantime.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 61a1fa678172..5ef883184885 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7008,6 +7008,13 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	spinlock_t *ptl;
>  
>  	i_mmap_lock_read(mapping);
> +
> +	/*
> +	 * NOTE: even if we've got the vma read lock, here we still need to
> +	 * take the walker lock, because we're not walking the current vma,
> +	 * but some other mm's!
> +	 */
> +	hugetlb_walker_lock();
>  	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
>  		if (svma == vma)
>  			continue;
> @@ -7016,12 +7023,15 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  		if (saddr) {
>  			spte = huge_pte_offset(svma->vm_mm, saddr,
>  					       vma_mmu_pagesize(svma));
> -			if (spte) {
> -				get_page(virt_to_page(spte));
> +			/*
> +			 * When page ref==0, it means it's probably being
> +			 * freed; continue with the next one.
> +			 */
> +			if (spte && get_page_unless_zero(virt_to_page(spte)))
>  				break;
> -			}
>  		}
>  	}
> +	hugetlb_walker_unlock();
>  
>  	if (!spte)
>  		goto out;
> -- 
> 2.37.3
> 

Will squash this in..

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6c77ae7a3d94..f9abede9de47 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7045,6 +7045,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
                         */
                        if (spte && get_page_unless_zero(virt_to_page(spte)))
                                break;
+                       else
+                               spte = NULL;
                }
        }
        hugetlb_walker_unlock();

-- 
Peter Xu

