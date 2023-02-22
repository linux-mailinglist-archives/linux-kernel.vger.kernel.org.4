Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5353069F8DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjBVQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjBVQRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:17:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663483D922
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:17:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 06C4020629;
        Wed, 22 Feb 2023 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677082631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNoRjmK/6b6p+tMaBE1nK/wJKeAnzp3Jf3E5BDeYjR0=;
        b=TJkYfK3HGKG1PaVmDv9Dl8Gx8yLzkmmJso6UV0YNWL6PY399duoo7Nr0usB5VvHFSReAvM
        vNTEONwGJIwZLxyNsNCsWM1pXDbbSUS12laisZUSS6YoVdAHEw2fpJZJkpt2nna/rKaFy7
        V9snqZmM6+qPatUgSuW33pWSk4QLF7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677082631;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNoRjmK/6b6p+tMaBE1nK/wJKeAnzp3Jf3E5BDeYjR0=;
        b=+m6EftINa9XM7V5R3DlkBN22y0JpzeeG/SHC8wdFJp09j5mtoLmKHwX+z2XhxZzlUdK/ti
        9GBIPJ+xwLccS6Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E38AA133E0;
        Wed, 22 Feb 2023 16:17:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f87+NgZA9mP/SAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Feb 2023 16:17:10 +0000
Message-ID: <ad91d62b-37eb-4b73-707a-3c45c9e16256@suse.cz>
Date:   Wed, 22 Feb 2023 17:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 48/49] mm/mmap: Remove __vma_adjust()
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
 <20230120162650.984577-49-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230120162650.984577-49-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 17:26, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Inline the work of __vma_adjust() into vma_merge().  This reduces code
> size and has the added benefits of the comments for the cases being
> located with the code.
> 
> Change the comments referencing vma_adjust() accordingly.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

...

> @@ -1054,32 +945,85 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  					     vm_userfaultfd_ctx, anon_name)) {
>  		merge_next = true;
>  	}
> +
> +	remove = remove2 = adjust = NULL;
>  	/* Can we merge both the predecessor and the successor? */
>  	if (merge_prev && merge_next &&
> -			is_mergeable_anon_vma(prev->anon_vma,
> -				next->anon_vma, NULL)) {	 /* cases 1, 6 */
> -		err = __vma_adjust(vmi, prev, prev->vm_start,
> -					next->vm_end, prev->vm_pgoff, prev);
> -		res = prev;
> -	} else if (merge_prev) {			/* cases 2, 5, 7 */
> -		err = __vma_adjust(vmi, prev, prev->vm_start,
> -					end, prev->vm_pgoff, prev);
> -		res = prev;
> +	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
> +		remove = mid;				/* case 1 */
> +		vma_end = next->vm_end;
> +		err = dup_anon_vma(res, remove);
> +		if (mid != next) {			/* case 6 */
> +			remove2 = next;
> +			if (!remove->anon_vma)
> +				err = dup_anon_vma(res, remove2);
> +		}
> +	} else if (merge_prev) {
> +		err = 0;				/* case 2 */
> +		if (mid && end > mid->vm_start) {
> +			err = dup_anon_vma(res, mid);
> +			if (end == mid->vm_end) {	/* case 7 */
> +				remove = mid;
> +			} else {			/* case 5 */
> +				adjust = mid;
> +				adj_next = (end - mid->vm_start);
> +			}
> +		}
>  	} else if (merge_next) {
> -		if (prev && addr < prev->vm_end)	/* case 4 */
> -			err = __vma_adjust(vmi, prev, prev->vm_start,
> -					addr, prev->vm_pgoff, next);
> -		else					/* cases 3, 8 */
> -			err = __vma_adjust(vmi, mid, addr, next->vm_end,
> -					next->vm_pgoff - pglen, next);
>  		res = next;
> +		if (prev && addr < prev->vm_end) {	/* case 4 */
> +			vma_end = addr;
> +			adjust = mid;
> +			adj_next = -(vma->vm_end - addr);
> +			err = dup_anon_vma(res, adjust);

I think this one is wrong, and should be fixed as below. I'm not
exactly sure about user visible effects, but shouldn't matter if
we fix before rc1? I guess what can happen is we end up with pages
becoming part of 'prev' that have anon_vma originally from 'mid'
which is not connected to 'prev', so eventually some rmap operation
will fail to do the right thing etc. Or 'mid' is unmapped, its
anon_vma freed and we have a use-after free. Probably rare to happen,
but nasty enough.

----8<----
From 854f4cef0fecde9a0a89ff1a5beb0a1e2115363f Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 22 Feb 2023 16:51:46 +0100
Subject: [PATCH urgent for 6.3-rc1] mm/mremap: fix dup_anon_vma() in vma_merge() case 4

In case 4, we are shrinking 'prev' (PPPP in the comment) and expanding
'mid' (NNNN). So we need to make sure 'mid' clones the anon_vma from
'prev', if it doesn't have any. After commit 0503ea8f5ba7 ("mm/mmap:
remove __vma_adjust()") we can fail to do that due to wrong parameters
for dup_anon_vma(). The call is a no-op because res == next, adjust ==
mid and mid == next. Fix it.

Fixes: 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 20f21f0949dd..740b54be3ed4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -973,7 +973,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = addr;
 			adjust = mid;
 			adj_next = -(vma->vm_end - addr);
-			err = dup_anon_vma(res, adjust);
+			err = dup_anon_vma(adjust, prev);
 		} else {
 			vma = next;			/* case 3 */
 			vma_start = addr;
-- 
2.39.2



