Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8201D6F406C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjEBJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjEBJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:51:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2234C29
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:51:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 853AC21EA6;
        Tue,  2 May 2023 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683021099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMpJRWn62oZaFRK4wu8v5XGvOR+iZZILi1niAhJCyhE=;
        b=VVk8iwx1fx2Et8PSvuO0o+7eSXGpIT5M4LIZ/Z+jaKpXRePWdc4Xn3ZZU+lO2ALu+58Boq
        q7489gCVJVMcRClFser3zX+pPj2t9mOPEcopfaBXI1NFxsHFfKaU0o0sVPDK/ZMLDUkvMM
        Sw/nsBhrDi5n9b9eJLfQKhoJJQmdsxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683021099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMpJRWn62oZaFRK4wu8v5XGvOR+iZZILi1niAhJCyhE=;
        b=TyIW8e4sZ7OgLPQDZQ6XCjXnBMUSbnlwvwUCo77JPUAJJwOQxpAYuqQN9WASUKmbFDQFF3
        BpOzsHmtDnWkVfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 705D7139C3;
        Tue,  2 May 2023 09:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qtjeGivdUGRtYgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 02 May 2023 09:51:39 +0000
Message-ID: <0947aa26-46b8-1cd6-935d-5767c951436b@suse.cz>
Date:   Tue, 2 May 2023 11:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/23 22:19, Lorenzo Stoakes wrote:
> We may still have inconsistent input parameters even if we choose not to
> merge and the vma_merge() invariant checks are useful for checking this
> with no production runtime cost (these are only relevant when
> CONFIG_DEBUG_VM is specified).
> 
> Therefore, perform these checks regardless of whether we merge.
> 
> This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
> Correctly update prev when policy is equal on mbind") in the mbind logic
> was only picked up in the 6.2.y stable branch where these assertions are
> performed prior to determining mergeability.
> 
> Had this remained the same in mainline this issue may have been picked up
> faster, so moving forward let's always check them.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5522130ae606..13678edaa22c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		merge_next = true;
>  	}
>  
> +	/* Verify some invariant that must be enforced by the caller. */
> +	VM_WARN_ON(prev && addr <= prev->vm_start);
> +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> +	VM_WARN_ON(addr >= end);
> +
>  	if (!merge_prev && !merge_next)
>  		return NULL; /* Not mergeable. */
>  
>  	res = vma = prev;
>  	remove = remove2 = adjust = NULL;
>  
> -	/* Verify some invariant that must be enforced by the caller. */
> -	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> -	VM_WARN_ON(addr >= end);
> -
>  	/* Can we merge both the predecessor and the successor? */
>  	if (merge_prev && merge_next &&
>  	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {

