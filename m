Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C246C4603
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCVJQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCVJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:16:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6E5BCBC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:16:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF46E33925;
        Wed, 22 Mar 2023 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679476587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XE710fYEKcswB5J6E1dCWxswIdz0v6nHSjXnchN4Gj8=;
        b=LrZG1I0XHUtH1qcWUzbG1QDdcWEjVFNOyr2gCFPAmcCl55wKwDpZX2lkum1IXuq/bsMtk0
        oXohYQakD4TfmAXfwOLWGr0dghGRvesCE0aGuLXS1INIzdJpRpS/vTLbsxxoSqGurPMgk5
        q7/qli1tIcR4BY5DDCLlRrov+z76jsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679476587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XE710fYEKcswB5J6E1dCWxswIdz0v6nHSjXnchN4Gj8=;
        b=hLNAqJpza2k2pWnvQLRU29P5a9DDqQjlIQTk7qd3mANKiNFpzl9kNHQ2xRx2WGTC6uYhcx
        l/AnOzewWkfw4DCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5F8113416;
        Wed, 22 Mar 2023 09:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ugSKL2vHGmRwXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 09:16:27 +0000
Message-ID: <08b98b4a-c6cf-b1b7-a4f8-2ebf3c3a0c67@suse.cz>
Date:   Wed, 22 Mar 2023 10:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/4] mm/mmap/vma_merge: extend invariants, avoid
 invalid res, vma
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679431180.git.lstoakes@gmail.com>
 <17b6fc3edc46c4b33aa93b9ef17a63a3a76f4b5f.1679431180.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <17b6fc3edc46c4b33aa93b9ef17a63a3a76f4b5f.1679431180.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 21:45, Lorenzo Stoakes wrote:
> Previously, vma was an uninitialised variable which was only definitely
> assigned as a result of the logic covering all possible input cases - for
> it to have remained uninitialised, prev would have to be NULL, and next
> would _have_ to be mergeable.
> 
> We now reuse vma to assign curr and next, so to be absolutely explicit,
> ensure this variable is _always_ assigned, and while we're at it remove the
> redundant assignment of both res and vma (if prev is NULL then we simply
> assign to NULL).
> 
> In addition, we absolutely do rely on addr == curr->vm_start should curr
> exist, so assert as much.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit suggestion below.

> ---
>  mm/mmap.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6361baf75601..7aec49c3bc74 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  {
>  	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
>  	pgoff_t vma_pgoff;
> -	struct vm_area_struct *curr, *next, *res = NULL;
> +	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	int err = -1;
>  	bool merge_prev = false;
> @@ -940,14 +940,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
>  		next = vma_lookup(mm, end);
>  
> -	/* verify some invariant that must be enforced by the caller */
> +	/*
> +	 * By default, we return prev. Cases 3, 4, 8 will instead return next
> +	 * and cases 3, 8 will also update vma to point at next.
> +	 */
> +	res = vma = prev;

Later in the function there's a line:

	remove = remove2 = adjust = NULL;

Now it would make sense to move it up here?

> +
> +	/* Verify some invariant that must be enforced by the caller. */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && end > curr->vm_end);
> +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
>  	VM_WARN_ON(addr >= end);
>  
>  	if (prev) {
> -		res = prev;
> -		vma = prev;
>  		vma_start = prev->vm_start;
>  		vma_pgoff = prev->vm_pgoff;
>  		/* Can we merge the predecessor? */
> @@ -958,6 +962,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_prev(vmi);
>  		}
>  	}
> +
>  	/* Can we merge the successor? */
>  	if (next && mpol_equal(policy, vma_policy(next)) &&
>  	    can_vma_merge_before(next, vm_flags,
> @@ -998,6 +1003,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			adj_start = -(prev->vm_end - addr);
>  			err = dup_anon_vma(next, prev);
>  		} else {
> +			/*
> +			 * Note that cases 3 and 8 are the ONLY ones where prev
> +			 * is permitted to be (but is not necessarily) NULL.
> +			 */
>  			vma = next;			/* case 3 */
>  			vma_start = addr;
>  			vma_end = next->vm_end;

