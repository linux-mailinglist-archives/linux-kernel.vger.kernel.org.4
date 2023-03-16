Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49F06BCC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCPKLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCPKLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:11:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71DBB79C6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:11:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62FEA21A1E;
        Thu, 16 Mar 2023 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678961496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uwpdt+RBDrsH6AdtxhdDgkHRjthkhHrodD6FLeXyAOU=;
        b=meBMcCfw5uBJsQUXOXIp/wi/kESa6DyCLt/DMsVm+xRtb/oxMx4AIu5SpVBLZ9kQK15g8h
        cgXLC7KSvSmXgMwftEBhwWp44TYdQSz8vivJMrVHzLgy97VvVkqDA+sGC8pkPqjveQrxL9
        SR84d9pj+9BdISo+3t7nSpT3w2QT5UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678961496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uwpdt+RBDrsH6AdtxhdDgkHRjthkhHrodD6FLeXyAOU=;
        b=hrvtXqylWlxZ4NhjASW0N2lN1yac97MpkZ7px/G1/vm1gAqeyeF+/QdqJz+q7Mby7+NN3D
        SuGXldCiqYYlXRDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F870133E0;
        Thu, 16 Mar 2023 10:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OQTADljrEmTwWQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Mar 2023 10:11:36 +0000
Message-ID: <def43190-53f7-a607-d1b0-b657565f4288@suse.cz>
Date:   Thu, 16 Mar 2023 11:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/10] mm/mmap/vma_merge: set mid to NULL if not
 applicable
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
References: <20230309111258.24079-1-vbabka@suse.cz>
 <20230309111258.24079-7-vbabka@suse.cz>
 <388605ee-261d-4aa9-8d75-4afbee87adbc@lucifer.local>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <388605ee-261d-4aa9-8d75-4afbee87adbc@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/15/23 22:34, Lorenzo Stoakes wrote:
> On Thu, Mar 09, 2023 at 12:12:54PM +0100, Vlastimil Babka wrote:
>> There are several places where we test if 'mid' is really the area NNNN
>> in the diagram and the tests have two variants and are non-obvious to
>> follow.  Instead, set 'mid' to NULL up-front if it's not the NNNN area,
>> and simplify the tests.
>>
>> Also update the description in comment accordingly.
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/mmap.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index be60b344e4b1..3396c9b13f1c 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -848,10 +848,11 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>>   *
>>   * The following mprotect cases have to be considered, where AAAA is
>>   * the area passed down from mprotect_fixup, never extending beyond one
>> - * vma, PPPPPP is the prev vma specified, and NNNNNN the next vma after:
>> + * vma, PPPPPP is the prev vma specified, NNNN is a vma that overlaps
>> + * the area AAAA and XXXXXX the next vma after AAAA:
> 
> I think this is worded in a bit of a confusing way + can be read as 'NNNN is a
> vma that overlaps the area AAAA and XXXXXX' whereas you mean to say 'NNNN is a
> VMA that overlaps the area AAAA, and XXXXXX is the next vma after AAAA'.
> 
> This therefore might be better worded as:-
> 
> 'PPPP is the previous VMA, NNNN is a VMA which overlaps AAAA and XXXX is the
> next VMA after AAAA.'
> 
> Also - nit, but there's also inconsistency here between the number of letters in
> each block, e.g. 6 P's 4 N's 4 A's and 6 X's.

OK, I fixed that up (-fix patch below), thanks. Note that it's not just
"overlaps" for NNNN, it also has to align at the start of AAAA, so I made
that explicit in the comment. It also means PPPP no longer "overlaps" by
this definition in case 4.

> 'N' and 'X' are starting to be horrifically misleading here imo, I feel as if
> 'N' moving to 'O' (for overlapping) and 'X' to 'N' would make a big difference
> here.
 
I'll leave that possibility for a future patch as that's easier to done at
once after all those incremental changes here. But again note how
"overlapping" is not completely accurate word due to the start alignemnt.

>>   *
>>   *     AAAA             AAAA                   AAAA
>> - *    PPPPPPNNNNNN    PPPPPPXXXXXX       PPPPPPNNNNNN
>> + *    PPPPPPXXXXXX    PPPPPPXXXXXX       PPPPPPNNNNNN
>>   *    cannot merge    might become       might become
>>   *                    PPXXXXXXXXXX       PPPPPPPPPPNN
>>   *    mmap, brk or    case 4 below       case 5 below
>> @@ -879,9 +880,10 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>>   *
>>   * In the code below:
>>   * PPPP is represented by *prev
>> - * NNNN is represented by *mid (and possibly equal to *next)
>> - * XXXX is represented by *next or not represented at all.
>> - * AAAA is not represented - it will be merged or the function will return NULL
>> + * NNNN is represented by *mid or not represented at all (NULL)
>> + * XXXX is represented by *next or not represented at all (NULL)
>> + * AAAA is not represented - it will be merged and the vma containing the
>> + *      area is returned, or the function will return NULL
>>   */
>>  struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>>  			struct vm_area_struct *prev, unsigned long addr,
>> @@ -918,6 +920,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>>  	else
>>  		next = mid;
>>
>> +	if (mid && end <= mid->vm_start)
>> +		mid = NULL;
>> +
> 
> Might be worth putting a comment with the cases where this will happen, 1 - 4
> right? And also something like 'does AAAA overlap with mid?'

Added to the -fix patch below, with slightly different comment.

> And I really think renaming this to 'overlapping' or 'overlaps' or similar would
> make a big readability difference.

Yeah but it's quite long word and again not completely self explanatory.

> However we do have the thorny issue of case 4 where A overlaps P... But probably
> the fact that we treat this as a separate VMA from prev is enough to make it
> clear it being called 'overlaps' means 'separate from prev, also overlaps' so I
> think that's fine.
> 
> Adding this actually makes me think twice about the previous 'natural order'
> patch, because the intuition which that promotes is:-
> 
> mid = VMA after prev
> next = VMA after mid
> 
> [ prev ] [ mid ] [ next ]
> 
> But in reality that else branch means that next could be be equal to mid and
> now if there isn't overlap we rename mid to next effectively, e.g.:-
> 
> mid = VMA after prev
> next = mid
> delete mid
> 
> Which feels like the 'natural' intuition is suddenly broken. Maybe this needs
> reworking to be super explicit about this? Such as:-
> 
> struct vm_area_struct tmp;
> 
> ...
> 
> /* If there is a previous VMA, find the next, otherwise find the first. */
> tmp = find_vma(mm, prev ? prev->vm_end : 0);
> 
> /*
>  * If the address range overlaps with the input range (which can cover only a
>  * single VMA at most), then we are only interested in next if we span right up
>  * to its end.
>  *
>  * Otherwise we are simply left with prev and next.
>  */
> overlaps = tmp && end > tmp->vm_start ? tmp : NULL;
> if (overlaps)
> 	next = overlaps->vm_end == end ? overlaps->vm_next : NULL;
> else
> 	next = tmp;
> 
> Of course I haven't read the rest of the patches in this series so you may
> address aspects of this already :)

So as said above feel free to propose further followup in that direction.
You're right that in case 5 we should end up with next == NULL, in order to
be completely accurate. If we made sure next is only non-NULL if "end ==
next->vm_start" upfront, we could leave out that test later in "/* Can we
merge the successor? */".

>>  	/* verify some invariant that must be enforced by the caller */
>>  	VM_WARN_ON(prev && addr <= prev->vm_start);
>>  	VM_WARN_ON(mid && end > mid->vm_end);
>> @@ -952,7 +957,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>>  		remove = next;				/* case 1 */
>>  		vma_end = next->vm_end;
>>  		err = dup_anon_vma(prev, next);
>> -		if (mid != next) {			/* case 6 */
>> +		if (mid) {				/* case 6 */
>>  			remove = mid;
>>  			remove2 = next;
>>  			if (!next->anon_vma)
>> @@ -960,7 +965,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>>  		}
>>  	} else if (merge_prev) {
>>  		err = 0;				/* case 2 */
>> -		if (mid && end > mid->vm_start) {
>> +		if (mid) {
>>  			err = dup_anon_vma(prev, mid);
>>  			if (end == mid->vm_end) {	/* case 7 */
>>  				remove = mid;
>> @@ -982,7 +987,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>>  			vma_end = next->vm_end;
>>  			vma_pgoff = next->vm_pgoff;
>>  			err = 0;
>> -			if (mid != next) {		/* case 8 */
>> +			if (mid) {			/* case 8 */
>>  				vma_pgoff = mid->vm_pgoff;
>>  				remove = mid;
>>  				err = dup_anon_vma(next, mid);
>> --
>> 2.39.2
>>
> 
> Other than the nitty comment notes and the conceptual discussion, this LGTM so:-
> 
> Reviewed-By: Lorenzo Stoakes <lstoakes@gmail.com>

Thanks! Here's the -fix patch:

----8<----
From 1016590e31f0173070daffd905c3396607a68b4b Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 16 Mar 2023 10:56:04 +0100
Subject: [PATCH] mm/mmap/vma_merge: set mid to NULL if not applicable-fix

Adjust/add comments as suggested by Lorenzo.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3396c9b13f1c..cd0b0d1f4aeb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -848,8 +848,9 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  *
  * The following mprotect cases have to be considered, where AAAA is
  * the area passed down from mprotect_fixup, never extending beyond one
- * vma, PPPPPP is the prev vma specified, NNNN is a vma that overlaps
- * the area AAAA and XXXXXX the next vma after AAAA:
+ * vma, PPPP is the previous vma, NNNN is a vma that starts at the same
+ * address as AAAA and is of the same or larger span, and XXXX the next
+ * vma after AAAA:
  *
  *     AAAA             AAAA                   AAAA
  *    PPPPPPXXXXXX    PPPPPPXXXXXX       PPPPPPNNNNNN
@@ -920,6 +921,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	else
 		next = mid;
 
+	/* In cases 1 - 4 there's no NNNN vma */
 	if (mid && end <= mid->vm_start)
 		mid = NULL;
 
-- 
2.39.2


