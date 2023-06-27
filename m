Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EDD73F485
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjF0G2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjF0G2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:28:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBBE2117
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:28:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B80F31F8B6;
        Tue, 27 Jun 2023 06:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687847305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6YA6fL2joJ0ClnNKexgdl9gAy80OqHyknDXy5To9p4=;
        b=uGtApQVu0dfKXKjxe0gwObmVprQXHVApCJ4elryKMNlC5ZUHh3Abo1t4vi+56HdQPFagBd
        VrvI3lbXk3n3Dqe380ebtgBlFUYQoXNPP5HStBM2saLhf50XXvTR8Mu4DABfBpOpegqIEu
        KgsE4a7BsgTAqK5VoPN/J57jcHiSrWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687847305;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6YA6fL2joJ0ClnNKexgdl9gAy80OqHyknDXy5To9p4=;
        b=n5E2xF4mbQsbDk4XDfxofqz8E4o1JAU6hpvQ21+R7lFWd5EQtlQ04QXLDEkBeZ9wM8rGxq
        duTNEpqum5uS9RCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A85C13276;
        Tue, 27 Jun 2023 06:28:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LwIQJYmBmmSPfQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 27 Jun 2023 06:28:25 +0000
Message-ID: <074fc253-beb4-f7be-14a1-ee5f4745c15b@suse.cz>
Date:   Tue, 27 Jun 2023 08:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/mprotect: allow unfaulted VMAs to be unaccounted on
 mprotect()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <20230626204612.106165-1-lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230626204612.106165-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 22:46, Lorenzo Stoakes wrote:
> When mprotect() is used to make unwritable VMAs writable, they have the
> VM_ACCOUNT flag applied and memory accounted accordingly.
> 
> If the VMA has had no pages faulted in and is then made unwritable once
> again, it will remain accounted for, despite not being capable of extending
> memory usage.
> 
> Consider:-
> 
> ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
> mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
> mprotect(ptr + page_size, page_size, PROT_READ);

In the original Mike's example there were actual pages populated, in that
case we still won't merge the vma's, right? Guess that can't be helped.

> The first mprotect() splits the range into 3 VMAs and the second fails to
> merge the three as the middle VMA has VM_ACCOUNT set and the others do not,
> rendering them unmergeable.
> 
> This is unnecessary, since no pages have actually been allocated and the
> middle VMA is not capable of utilising more memory, thereby introducing
> unnecessary VMA fragmentation (and accounting for more memory than is
> necessary).
> 
> Since we cannot efficiently determine which pages map to an anonymous VMA,
> we have to be very conservative - determining whether any pages at all have
> been faulted in, by checking whether vma->anon_vma is NULL.
> 
> We can see that the lack of anon_vma implies that no anonymous pages are
> present as evidenced by vma_needs_copy() utilising this on fork to
> determine whether page tables need to be copied.
> 
> The only place where anon_vma is set NULL explicitly is on fork with
> VM_WIPEONFORK set, however since this flag is intended to cause the child
> process to not CoW on a given memory range, it is right to interpret this
> as indicating the VMA has no faulted-in anonymous memory mapped.
> 
> If the VMA was forked without VM_WIPEONFORK set, then anon_vma_fork() will
> have ensured that a new anon_vma is assigned (and correctly related to its
> parent anon_vma) should any pages be CoW-mapped.
> 
> The overall operation is safe against races as we hold a write lock against
> mm->mmap_lock.
> 
> If we could efficiently look up the VMA's faulted-in pages then we would
> unaccount all those pages not yet faulted in. However as the original
> comment alludes this simply isn't currently possible, so we remain
> conservative and account all pages or none at all.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

So in practice programs will likely do the PROT_WRITE in order to actually
populate the area, so this won't trigger as I commented above. But it can
still help in some cases and is cheap to do, so:

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mprotect.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 6f658d483704..9461c936082b 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -607,8 +607,11 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	/*
>  	 * If we make a private mapping writable we increase our commit;
>  	 * but (without finer accounting) cannot reduce our commit if we
> -	 * make it unwritable again. hugetlb mapping were accounted for
> -	 * even if read-only so there is no need to account for them here
> +	 * make it unwritable again except in the anonymous case where no
> +	 * anon_vma has yet been assigned.
> +	 *
> +	 * hugetlb mapping were accounted for even if read-only so there is
> +	 * no need to account for them here.
>  	 */
>  	if (newflags & VM_WRITE) {
>  		/* Check space limits when area turns into data. */
> @@ -622,6 +625,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  				return -ENOMEM;
>  			newflags |= VM_ACCOUNT;
>  		}
> +	} else if ((oldflags & VM_ACCOUNT) && vma_is_anonymous(vma) &&
> +		   !vma->anon_vma) {
> +		newflags &= ~VM_ACCOUNT;
>  	}
>  
>  	/*
> @@ -652,6 +658,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	}
>  
>  success:
> +	if ((oldflags & VM_ACCOUNT) && !(newflags & VM_ACCOUNT))
> +		vm_unacct_memory(nrpages);
> +
>  	/*
>  	 * vm_flags and vm_page_prot are protected by the mmap_lock
>  	 * held in write mode.

