Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD16C45A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCVJHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCVJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:06:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD35D26A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:06:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AEC7D33917;
        Wed, 22 Mar 2023 09:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679475996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXPZdtC3/8ESKjUegO9xJERlnt3L0CV5dBvqF2U3wmg=;
        b=uNtamlvKe1guwUHrN3+caOkGYONlLCpr9lguDQfbNaYFBVMuFZy6jAjHYmmNVuDyBalqFY
        vdASdRlcMStsyztKl3x+O9NfXu7Gl/ZDUaZWLFFwMgDIdkHC/MggyhakFLm0rUCzBSBFpw
        cYXgCQ38wezCV9l3TsmX2JtcDk+Gnkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679475996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXPZdtC3/8ESKjUegO9xJERlnt3L0CV5dBvqF2U3wmg=;
        b=m4bPifmwYbSV8n7WnjdcXYED+LdISpkgUgZSlAevu79yPMpyxMfOPk2MQuIphb9gGe+4TA
        OfJIChreWUx4wyBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 909AA13AA4;
        Wed, 22 Mar 2023 09:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CizrIRzFGmS1VgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 09:06:36 +0000
Message-ID: <bdbb5362-a4bf-a87c-95e6-e94ab28665bd@suse.cz>
Date:   Wed, 22 Mar 2023 10:06:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/4] mm/mmap/vma_merge: fold curr, next assignment
 logic
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
 <36399b6cdc843eb7fe243488ea9b29464f699170.1679468982.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <36399b6cdc843eb7fe243488ea9b29464f699170.1679468982.git.lstoakes@gmail.com>
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
> Use find_vma_intersection() and vma_lookup() to both simplify the logic and
> to fold the end == next->vm_start condition into one block.
> 
> This groups all of the simple range checks together and establishes the
> invariant that, if prev, curr or next are non-NULL then their positions are
> as expected.
> 
> This has no functional impact.

I'm not so sure...

> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c9834364ac98..dbdbb92493b2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -930,15 +930,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
> 
> -	curr = find_vma(mm, prev ? prev->vm_end : 0);
> -	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
> -		next = find_vma(mm, curr->vm_end);
> -	else
> -		next = curr;
> +	/* Does the input range span an existing VMA? (cases 5 - 8) */
> +	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
> 
> -	/* In cases 1 - 4 there's no CCCC vma */
> -	if (curr && end <= curr->vm_start)
> -		curr = NULL;
> +	if (!curr ||			/* cases 1 - 4 */
> +	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> +		next = vma_lookup(mm, end);

AFAICS if the next vma is not adjacent to CCCC or ****, but there's a gap,
this will still give you a non-NULL result?

> +	else
> +		next = NULL;		/* case 5 */
> 
>  	/* verify some invariant that must be enforced by the caller */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> @@ -959,11 +958,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		}
>  	}
>  	/* Can we merge the successor? */
> -	if (next && end == next->vm_start &&

And then without this end == next->vm_start check, merge will be done
despite the gap.

> -			mpol_equal(policy, vma_policy(next)) &&
> -			can_vma_merge_before(next, vm_flags,
> -					     anon_vma, file, pgoff+pglen,
> -					     vm_userfaultfd_ctx, anon_name)) {
> +	if (next && mpol_equal(policy, vma_policy(next)) &&
> +	    can_vma_merge_before(next, vm_flags,
> +				 anon_vma, file, pgoff+pglen,
> +				 vm_userfaultfd_ctx, anon_name)) {
>  		merge_next = true;
>  	}
> 
> --
> 2.39.2

