Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1D6C4655
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCVJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCVJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:28:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5931DB8D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:28:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CE1120BD8;
        Wed, 22 Mar 2023 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679477291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFa3zhQT4J/LBWQwnic5p54Zt3QvRfVUhYwkQWNF/GM=;
        b=NlsA7iPTLBoGME5cAAByo8u3m9Zj9NX/EuXm1LGWLCEf6Osb6uZJdx7x1yjA2kKyb1lPeM
        ju7PEMWMw6Ebicx8RR3L5HCOIE0ixaVaxImgcwTlHIT39rMtEHbqTHB5TFUIlh1ALV5zsB
        ZxnlY0p5YsBhw0lyTfVBKOa6YwuMWAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679477291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFa3zhQT4J/LBWQwnic5p54Zt3QvRfVUhYwkQWNF/GM=;
        b=KoG6RCrlG0N8VAJMeoixkwtPVqhyXHNM7IGZ5dNLizzDFD3D+5Rt9dmm4GG+RB0woCXofF
        f2hH+XCWOeqw/BCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77D0C13416;
        Wed, 22 Mar 2023 09:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id thqJHCvKGmSzZgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 09:28:11 +0000
Message-ID: <256bb98e-4bc8-f094-5ecb-500827fbbfa5@suse.cz>
Date:   Wed, 22 Mar 2023 10:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/4] mm/mmap/vma_merge: init cleanup, be explicit about
 the non-mergeable case
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
 <ae4845250ae9e7d000ca28fe90e64a331f664ce2.1679468982.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ae4845250ae9e7d000ca28fe90e64a331f664ce2.1679468982.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 08:13, Lorenzo Stoakes wrote:
> Rather than setting err = -1 and only resetting if we hit merge cases,
> explicitly check the non-mergeable case to make it abundantly clear that we
> only proceed with the rest if something is mergeable, default err to 0 and
> only update if an error might occur.
> 
> Move the merge_prev, merge_next cases closer to the logic determining curr,
> next and reorder initial variables so they are more logically grouped.
> 
> This has no functional impact.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits:

> ---
>  mm/mmap.c | 57 ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2a4f63716231..642f3d063be1 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -909,18 +909,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
>  			struct anon_vma_name *anon_name)
>  {
> -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> -	pgoff_t vma_pgoff;
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> -	int err = -1;
> +	struct vma_prepare vp;
> +	pgoff_t vma_pgoff;
> +	int err = 0;
>  	bool merge_prev = false;
>  	bool merge_next = false;
>  	bool vma_expanded = false;
> -	struct vma_prepare vp;
> +	unsigned long vma_start = addr;
>  	unsigned long vma_end = end;
> +	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
>  	long adj_start = 0;
> -	unsigned long vma_start = addr;
>  
>  	validate_mm(mm);
>  	/*
> @@ -939,36 +939,38 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	else
>  		next = NULL;		/* case 5 */
>  
> -	/*
> -	 * By default, we return prev. Cases 3, 4, 8 will instead return next
> -	 * and cases 3, 8 will also update vma to point at next.
> -	 */
> -	res = vma = prev;
> -
> -	/* Verify some invariant that must be enforced by the caller. */
> -	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> -	VM_WARN_ON(addr >= end);
> -
>  	if (prev) {
>  		vma_start = prev->vm_start;
>  		vma_pgoff = prev->vm_pgoff;
> +
>  		/* Can we merge the predecessor? */
> -		if (prev->vm_end == addr && mpol_equal(vma_policy(prev), policy)
> +		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
>  		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> -				   pgoff, vm_userfaultfd_ctx, anon_name)) {
> +					   pgoff, vm_userfaultfd_ctx, anon_name)) {
>  			merge_prev = true;
>  			vma_prev(vmi);
>  		}
>  	}
>  
>  	/* Can we merge the successor? */
> -	if (next && mpol_equal(policy, vma_policy(next)) &&
> -	    can_vma_merge_before(next, vm_flags,
> -				 anon_vma, file, pgoff+pglen,
> -				 vm_userfaultfd_ctx, anon_name)) {
> -		merge_next = true;
> -	}
> +	merge_next = next && mpol_equal(policy, vma_policy(next)) &&
> +		can_vma_merge_before(next, vm_flags,
> +				     anon_vma, file, pgoff+pglen,
> +				     vm_userfaultfd_ctx, anon_name);

Not a great fan of this, I think the if() is more readable, but if you and
Liam agree, I won't mind much. Either way could consolidate the parameters
on less lines maybe.

> +
> +	if (!merge_prev && !merge_next)
> +		return NULL; /* Not mergeable. */
> +
> +	/*
> +	 * By default, we return prev. Cases 3, 4, 8 will instead return next
> +	 * and cases 3, 8 will also update vma to point at next.
> +	 */
> +	res = vma = prev;
> +
> +	/* Verify some invariant that must be enforced by the caller. */
> +	VM_WARN_ON(prev && addr <= prev->vm_start);
> +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> +	VM_WARN_ON(addr >= end);
>  
>  	remove = remove2 = adjust = NULL;
>  	/* Can we merge both the predecessor and the successor? */
> @@ -984,7 +986,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  				err = dup_anon_vma(prev, curr);
>  		}
>  	} else if (merge_prev) {
> -		err = 0;				/* case 2 */
> +							/* case 2 */

Move the comment from this now weirdly empty line to the "else if" one above?

>  		if (curr) {
>  			err = dup_anon_vma(prev, curr);
>  			if (end == curr->vm_end) {	/* case 7 */
> @@ -994,7 +996,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  				adj_start = (end - curr->vm_start);
>  			}
>  		}
> -	} else if (merge_next) {
> +	} else { /* merge_next */
>  		res = next;
>  		if (prev && addr < prev->vm_end) {	/* case 4 */
>  			vma_end = addr;
> @@ -1010,7 +1012,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_start = addr;
>  			vma_end = next->vm_end;
>  			vma_pgoff = next->vm_pgoff;
> -			err = 0;
>  			if (curr) {			/* case 8 */
>  				vma_pgoff = curr->vm_pgoff;
>  				remove = curr;
> @@ -1019,7 +1020,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		}
>  	}
>  
> -	/* Cannot merge or error in anon_vma clone */
> +	/* Error in anon_vma clone. */
>  	if (err)
>  		return NULL;
>  

