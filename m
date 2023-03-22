Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D456C4617
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCVJTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCVJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:19:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71761913E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:19:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74CC433935;
        Wed, 22 Mar 2023 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679476785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EChfgy37fr4GWr9eZoipNMqUs51/fVt96h5C7/x84K8=;
        b=X6Rkq2zz7r+8uqbHrYHtv03Kebo1ORUYKOpjX+mtYj+2PjsJUWiQemsiGgnIrHe5E369ip
        Tf0quc6Tc+6NTbcgfEdZTKmcD9ow00ySKEcB5bLVzAJ40/5sBmvEOgGq6W+B3uvzQHtPOY
        IUKnZdG5hvwQNR055bjH659J2ykapr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679476785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EChfgy37fr4GWr9eZoipNMqUs51/fVt96h5C7/x84K8=;
        b=W39bgPCwjlNd2sXy1KS0mAvPmKafThNfz1NabrFVkR+3QZ53Zs1RtdY4In0X4E2PrNTsfW
        Gz0jo7YCDt0RTODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57C5E13416;
        Wed, 22 Mar 2023 09:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5S/nFDHIGmTKYAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 09:19:45 +0000
Message-ID: <7a63f275-be11-30b3-8281-fcfc1b1fca9c@suse.cz>
Date:   Wed, 22 Mar 2023 10:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/4] mm/mmap/vma_merge: explicitly assign res, vma,
 extend invariants
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
 <a88bff4cee88232027bf6356a6c3e265600521d4.1679468982.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <a88bff4cee88232027bf6356a6c3e265600521d4.1679468982.git.lstoakes@gmail.com>
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

On 3/22/23 08:13, Lorenzo Stoakes wrote:
> Previously, vma was an uninitialised variable which was only definitely
> assigned as a result of the logic covering all possible input cases - for
> it to have remained uninitialised, prev would have to be NULL, and next
> would _have_ to be mergeable.
> 
> The value of res defaults to NULL, so we can neatly eliminate the
> assignment to res and vma in the if (prev) block and ensure that both res
> and vma are both explicitly assigned, by just setting both to prev.
> 
> In addition we add an explanation as to under what circumstances both might
> change, and since we absolutely do rely on addr == curr->vm_start should
> curr exist, assert that this is the case.

Hm replied to v2 of this, sorry, so let me repeat that here:

> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit suggestion below.


> ---
>  mm/mmap.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dbdbb92493b2..2a4f63716231 100644
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
> @@ -939,14 +939,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	else
>  		next = NULL;		/* case 5 */
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
> @@ -957,6 +961,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_prev(vmi);
>  		}
>  	}
> +
>  	/* Can we merge the successor? */
>  	if (next && mpol_equal(policy, vma_policy(next)) &&
>  	    can_vma_merge_before(next, vm_flags,
> @@ -997,6 +1002,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
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

