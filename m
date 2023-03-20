Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88756C14A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjCTOZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCTOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:25:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAA92279A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:25:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso13574924pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679322340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nN7DipLP7dLBOA+57oyzIvizGh3o895mcXNvmekLypo=;
        b=Dz4uiikJLAYxR5ZfL/tzcJAqZb2ADS8OIafcjM5R73WJkTJeoxQ15/7PVhAiktUaGs
         CDjmLXDmyvUwTiUsuzg2hwnjd7oIIhLNaTea+/U+5nPCr/LQ0Tjfkw9D8U89Dz4BvtvP
         X7X7dA4nwKNn56NXQCrbkubV4mPdIevLxBK5D/oLDEFAYxOtX/EZKZVWwa74OhcRbhE4
         Q9etSn+ABv3pNG2l/wfto7AzAAaP2J0nNzOcYux2vyE06d7MGVmfl16I7srFzXD1Fsdf
         kud2cy2QnxVbxz2bSGWr+fdS77Ol1syQ+SD1KrX9vhkDKJuWI8P78nRYRwU7rg7eFtTi
         /7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679322340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN7DipLP7dLBOA+57oyzIvizGh3o895mcXNvmekLypo=;
        b=dgqKzD/UBvxJtlZ9rl55u1fqnlZ8sdufScQ/H/Id4jf5ZkW8PZrrYhBSRcTRyUuynT
         Jnl7sjdLFfwzP+Tk7B8SNx4D+rEWMgpdcdx0MdD0Jxkq7o50mMHjQXurMHzSuTOw+P8D
         MxbMMfLOP4jcIG1nUTHZC7q1e522SVqagpy4SUn941NPhTf0hBnaYGeKuIfyiuUfBjS9
         UM/lioLXoV5iOYOEbjKWiQPAfiorj0XPAhwikvkc5igBK0hba3gnApoMt5yjwNQa5gln
         M9FbbonCoxrqbrO11/CgztmD9Ctv/TOkTtUIA6KakKtgRb/+Bvy4W0MZveYEfqPnERDY
         xeaQ==
X-Gm-Message-State: AO0yUKWnha3B7iZ6NHvY1j9G63K6xG3xqt4BL4c08lnl/t2PIbC4PmEk
        6rCiPjMvzA3pSd5qzQ281v0=
X-Google-Smtp-Source: AK7set9vLCuUzsZ19dKcM2/O/nFf7dCt/B48YaQfoLaCnboxQvKvVHSvh9y7HQmL9mKQQXwo9x6YgA==
X-Received: by 2002:a05:6a20:8b8a:b0:d8:e8aa:f323 with SMTP id m10-20020a056a208b8a00b000d8e8aaf323mr7498064pzh.44.1679322339802;
        Mon, 20 Mar 2023 07:25:39 -0700 (PDT)
Received: from vernon-pc ([114.231.52.220])
        by smtp.gmail.com with ESMTPSA id w129-20020a636287000000b00476d1385265sm6348683pgb.25.2023.03.20.07.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:25:39 -0700 (PDT)
Date:   Mon, 20 Mar 2023 22:25:11 +0800
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/4] mm/mmap/vma_merge: set next to NULL if not applicable
Message-ID: <ZBhpPFmAOKyohN0M@vernon-pc>
References: <cover.1679137163.git.lstoakes@gmail.com>
 <4d717269303d8a6fe1d837968c252eeb6ff1d7e5.1679137163.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d717269303d8a6fe1d837968c252eeb6ff1d7e5.1679137163.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 11:13:19AM +0000, Lorenzo Stoakes wrote:
> We are only interested in next if end == next->vm_start (in which case we
> check to see if we can set merge_next), so perform this check alongside
> checking whether curr should be set.
>
> This groups all of the simple range checks together and establishes the
> invariant that, if prev, curr or next are non-NULL then their positions are
> as expected.
>
> Additionally, use the abstract 'vma' object to look up the possible curr or
> next VMA in order to avoid any confusion as to what these variables
> represent - now curr and next are assigned once and only once.

Hi Lorenzo,

Due to the "vma" variable is used as an intermediate member, I feels a bit
confusing, so cleanup this patch as below.

If this cleanup patch is issue, please let me know, and then ignore it
directly, thanks.

----
From 7dac3ed8c1b747c2edf2a6c867c4e6342c7447c3 Mon Sep 17 00:00:00 2001
From: Vernon Yang <vernon2gm@gmail.com>
Date: Mon, 20 Mar 2023 21:38:09 +0800
Subject: [PATCH] mm/mmap/vma_merge: set next to NULL if not applicable-cleanup

Make code logic simpler and more readable.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 mm/mmap.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 45bd43225013..78cb96774602 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -921,7 +921,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	 * If there is a previous VMA specified, find the next, otherwise find
 	 * the first.
 	 */
-	vma = find_vma(mm, prev ? prev->vm_end : 0);
+	curr = find_vma(mm, prev ? prev->vm_end : 0);

 	/*
 	 * Does the input range span an existing VMA? If so, we designate this
@@ -929,21 +929,19 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	 *
 	 * Cases 5 - 8.
 	 */
-	if (vma && end > vma->vm_start) {
-		curr = vma;
-
+	if (curr && end > curr->vm_start) {
 		/*
 		 * If the addr - end range spans this VMA entirely, then we
 		 * check to see if another VMA follows it.
 		 *
-		 * If it is _immediately_ adjacent (checked below), then we
+		 * If it is immediately adjacent (checked below), then we
 		 * designate it 'next' (cases 6 - 8).
 		 */
 		if (curr->vm_end == end)
-			vma = find_vma(mm, curr->vm_end);
+			next = find_vma(mm, curr->vm_end);
 		else
 			/* Case 5. */
-			vma = NULL;
+			next = NULL;
 	} else {
 		/*
 		 * The addr - end range either spans the end of prev or spans no
@@ -952,19 +950,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		 *
 		 * Cases 1 - 4.
 		 */
+		next = curr;
 		curr = NULL;
 	}

-	/*
-	 * We only actually examine the next VMA if it is immediately adjacent
-	 * to end which sits either at the end of a hole (cases 1 - 3), PPPP
-	 * (case 4) or CCCC (cases 6 - 8).
-	 */
-	if (vma && end == vma->vm_start)
-		next = vma;
-	else
-		next = NULL;
-
 	/*
 	 * By default, we return prev. Cases 3, 4, 8 will instead return next
 	 * and cases 3, 8 will also update vma to point at next.
--
2.34.1


>
> This has no functional impact.
>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c9834364ac98..66893fc72e03 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -930,15 +930,53 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
>
> -	curr = find_vma(mm, prev ? prev->vm_end : 0);
> -	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
> -		next = find_vma(mm, curr->vm_end);
> -	else
> -		next = curr;
> +	/*
> +	 * If there is a previous VMA specified, find the next, otherwise find
> +	 * the first.
> +	 */
> +	vma = find_vma(mm, prev ? prev->vm_end : 0);
> +
> +	/*
> +	 * Does the input range span an existing VMA? If so, we designate this
> +	 * VMA 'curr'. The caller will have ensured that curr->vm_start == addr.
> +	 *
> +	 * Cases 5 - 8.
> +	 */
> +	if (vma && end > vma->vm_start) {
> +		curr = vma;
>
> -	/* In cases 1 - 4 there's no CCCC vma */
> -	if (curr && end <= curr->vm_start)
> +		/*
> +		 * If the addr - end range spans this VMA entirely, then we
> +		 * check to see if another VMA follows it.
> +		 *
> +		 * If it is _immediately_ adjacent (checked below), then we
> +		 * designate it 'next' (cases 6 - 8).
> +		 */
> +		if (curr->vm_end == end)
> +			vma = find_vma(mm, curr->vm_end);
> +		else
> +			/* Case 5. */
> +			vma = NULL;
> +	} else {
> +		/*
> +		 * The addr - end range either spans the end of prev or spans no
> +		 * VMA at all - in either case we dispense with 'curr' and
> +		 * maintain only 'prev' and (possibly) 'next'.
> +		 *
> +		 * Cases 1 - 4.
> +		 */
>  		curr = NULL;
> +	}
> +
> +	/*
> +	 * We only actually examine the next VMA if it is immediately adjacent
> +	 * to end which sits either at the end of a hole (cases 1 - 3), PPPP
> +	 * (case 4) or CCCC (cases 6 - 8).
> +	 */
> +	if (vma && end == vma->vm_start)
> +		next = vma;
> +	else
> +		next = NULL;
>
>  	/* verify some invariant that must be enforced by the caller */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> @@ -959,11 +997,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		}
>  	}
>  	/* Can we merge the successor? */
> -	if (next && end == next->vm_start &&
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
>
> --
> 2.39.2
>
