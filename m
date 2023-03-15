Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCDF6BBF38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjCOVir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjCOVin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:38:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495E35241
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:38:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i9so9559508wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678916320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXOeJTwK4KmrIlxPr5Klq/AQ/BW356EV8A+6kgkSRD0=;
        b=a7dd7ol8g0McRzHN9i+DikaHfAmyHidSQuumacuyPuGkR7b5c7Pex1Zwe5vsDridmY
         ZqXUXQ9S0+QpVKTXvFelyu4lbJIt+Mb5v8Ouf9kU2R3ci02M4bIny2Q4I6TeRgHTcyMA
         +OHeuYvKI8Nsxq4bqNg9XH5rtK9h7E+gcFM+pfGpUB/dBpABMfP2MshZMQhlMq9L24eq
         Jjao0w/tVY1gkq2AMxJbtoK7DeojIHkccR8x8+MhJO5nsu5mrsu0CPNrSkpAtqZkdQ+v
         qsLr37rO5o1yS8QCCSADy/bDKJr8mSeCHxlqmbbnnG5D2H3EgOnmFcb/aUp8rflLLt8n
         Nanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXOeJTwK4KmrIlxPr5Klq/AQ/BW356EV8A+6kgkSRD0=;
        b=TWBP96jxC0D4hP1bNIH/nk72INWkspEppjL68Rf6Xt6DKfPlvSTEQjc2fyyDXCrQxr
         GD2VuZj7dqmrtHFxZyHLIbqQU9uc7s7vX97wO2ZbZ9AzeYqxew7ZZzdw3/gxnwdUzxMg
         0M5eKn3YrLPOLOe9ma8085fe6yhPEh7elIkFvsWTG4k3Spir8S/fRCsvIM2l1QTwRZAv
         zUH0LVdKM4fTYI26yU/WLghU4PHN8sWXT4zHQUjzFcd51DscRt/9Jglyb719Pq4WTNSr
         xuUxLOR6J2/GMcwxYCRUpTtCKAp+vJhbB26lFOm9gVJ57+yx1ZlbW8vmrLdQdhyYTD8E
         CGoA==
X-Gm-Message-State: AO0yUKVa2a+daXftBHn8Eoh1s3A+ww2jAJhIVast8OgxdHVOMM8lYFus
        /nCXfYmOsLAoeqr89wwKXBY=
X-Google-Smtp-Source: AK7set81j8IB4FbIu43mVKYxxp6kE0h/UZ6TURg26EiYc4FNvjDKvEMTAT/LfN1Vsqopn93EObZbow==
X-Received: by 2002:adf:dcc2:0:b0:2ce:aa2d:c625 with SMTP id x2-20020adfdcc2000000b002ceaa2dc625mr3116855wrm.22.1678916319688;
        Wed, 15 Mar 2023 14:38:39 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b002be5bdbe40csm5584754wry.27.2023.03.15.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:38:38 -0700 (PDT)
Date:   Wed, 15 Mar 2023 21:38:37 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 07/10] mm/mmap/vma_merge: rename adj_next to adj_start
Message-ID: <f6a24126-99b8-4b6b-a456-bd6633ec491b@lucifer.local>
References: <20230309111258.24079-1-vbabka@suse.cz>
 <20230309111258.24079-8-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309111258.24079-8-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:12:55PM +0100, Vlastimil Babka wrote:
> The variable 'adj_next' holds the value by which we adjust vm_start of a
> vma in variable 'adjust', that's either 'next' or 'mid', so the current
> name is inaccurate. Rename it to 'adj_start'.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3396c9b13f1c..c51d69592e4e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -903,7 +903,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	bool vma_expanded = false;
>  	struct vma_prepare vp;
>  	unsigned long vma_end = end;
> -	long adj_next = 0;
> +	long adj_start = 0;
>  	unsigned long vma_start = addr;
>
>  	validate_mm(mm);
> @@ -971,7 +971,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  				remove = mid;
>  			} else {			/* case 5 */
>  				adjust = mid;
> -				adj_next = (end - mid->vm_start);
> +				adj_start = (end - mid->vm_start);
>  			}
>  		}
>  	} else if (merge_next) {
> @@ -979,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		if (prev && addr < prev->vm_end) {	/* case 4 */
>  			vma_end = addr;
>  			adjust = next;
> -			adj_next = -(prev->vm_end - addr);
> +			adj_start = -(prev->vm_end - addr);
>  			err = dup_anon_vma(next, prev);
>  		} else {
>  			vma = next;			/* case 3 */
> @@ -1002,7 +1002,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vma_iter_prealloc(vmi))
>  		return NULL;
>
> -	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_next);
> +	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
>  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
>  	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
>  		   vp.anon_vma != adjust->anon_vma);
> @@ -1018,10 +1018,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vma_expanded)
>  		vma_iter_store(vmi, vma);
>
> -	if (adj_next) {
> -		adjust->vm_start += adj_next;
> -		adjust->vm_pgoff += adj_next >> PAGE_SHIFT;
> -		if (adj_next < 0) {
> +	if (adj_start) {
> +		adjust->vm_start += adj_start;
> +		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
> +		if (adj_start < 0) {
>  			WARN_ON(vma_expanded);
>  			vma_iter_store(vmi, next);
>  		}
> --
> 2.39.2
>

This feels like a very silly oversight in the first instance but I imagine one
that is a result of 'code evolution' :) excellent improvement in clarity, so:-

Reviewed-By: Lorenzo Stoakes <lstoakes@gmail.com>
