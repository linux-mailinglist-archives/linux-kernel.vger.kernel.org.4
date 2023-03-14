Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104E46BA2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCNWwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCNWwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:52:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2154FAB4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:52:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so2981459wrh.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678834339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRo6A8udz7vMTU2bOR1zXhbLdqVTQmZ/8R5vMq7kqsA=;
        b=gMnv7YC62gXcz6glohYqgwR5fcc0cr0oK67SD7UYTJ4OcShFey80KOTfIRE7VgWIDt
         JFrTuHV7521bLX8F5WsWT7gdoBNL1XIPL6IYJlq62OnCIU7Xe4Ej89rnyBxIcModa/I0
         RSeqMvImGYbdL7El9dXjzMSR8Ydr53FJ9hZuOWBcrk3DThT7rrV+WIoHF8h6M2E+KI7W
         e6b/xxCJ2u/W3gOutWRSC5kORfU+pJWfNES4N7UZgCsF6/7cF0SDzJ50km0Q0DiIfcHa
         hvGPjxoXBek5R4S6lMtF6NW2DglWdYYA9aWX2z02habT7pauMZ0XgnuniReKcT3nayJ5
         Kpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678834339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRo6A8udz7vMTU2bOR1zXhbLdqVTQmZ/8R5vMq7kqsA=;
        b=63D9KBqo1l/FVMLMDlVYTUJhyFqvLmPh61uQTnkC3ZwQq51rd2ZBsgniJQyKBVxJ+u
         fdNCykH4wZJe6Tj9VfdH9lC38fqXyQqhhu8VczxxkSPfSkIvk8krDbzG38C2lH0wautc
         99wxeIvAcZt3vN35c8ytYOfbh6HGigzqcUOkPTgreTKNL366mwfavPE6Y3pHRBFxJWvG
         iM6WeyYwDCf8bWCUFn74be/PvI3tDjnHY1wlJtklswKAAMZ6mIUMXYZ03MujTSQM8JwD
         0gyUqz5DaSFU32COl/qccovVdtTTJ3vV0tff0NdUmcCWmaA5w8JUwmsjj8ZdokzS8rnT
         5QeQ==
X-Gm-Message-State: AO0yUKWsvR13qtDbtlTtfomJGcy6ss9v1DYe5Gz2In1NcXnSIRFRuWfp
        8zXgczGE60o3NaqetDZju42p2C1NlFQ=
X-Google-Smtp-Source: AK7set/cYhxGfJWpjfFLyQky/1yUlsdvhgUbYSCD6TKzoUKEbeib3e22z9mD5ZXIJp8m8WUSJxjGQg==
X-Received: by 2002:adf:fa09:0:b0:2cf:e58e:2dca with SMTP id m9-20020adffa09000000b002cfe58e2dcamr467660wrr.36.1678834339057;
        Tue, 14 Mar 2023 15:52:19 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d6108000000b002be0b1e556esm3046633wrt.59.2023.03.14.15.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 15:52:18 -0700 (PDT)
Date:   Tue, 14 Mar 2023 22:52:17 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 01/10] mm/mmap/vma_merge: use only primary pointers for
 preparing merge
Message-ID: <4385c202-2281-403e-8d9b-9587e88f9009@lucifer.local>
References: <20230309111258.24079-1-vbabka@suse.cz>
 <20230309111258.24079-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309111258.24079-2-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:12:49PM +0100, Vlastimil Babka wrote:
> In the merging preparation part of vma_merge(), some vma pointer
> variables are assigned for later execution of the merge, but also read
> from in the block itself. The code is easier follow and check against
> the cases diagram in the comment if the code reads only from the
> "primary" vma variables prev, mid, next instead. No functional change.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 740b54be3ed4..0a8b052e3022 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -950,16 +950,16 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
>  		remove = mid;				/* case 1 */
>  		vma_end = next->vm_end;
> -		err = dup_anon_vma(res, remove);
> +		err = dup_anon_vma(prev, mid);
>  		if (mid != next) {			/* case 6 */
>  			remove2 = next;
> -			if (!remove->anon_vma)
> -				err = dup_anon_vma(res, remove2);
> +			if (!mid->anon_vma)
> +				err = dup_anon_vma(prev, next);
>  		}
>  	} else if (merge_prev) {
>  		err = 0;				/* case 2 */
>  		if (mid && end > mid->vm_start) {
> -			err = dup_anon_vma(res, mid);
> +			err = dup_anon_vma(prev, mid);
>  			if (end == mid->vm_end) {	/* case 7 */
>  				remove = mid;
>  			} else {			/* case 5 */
> @@ -972,8 +972,8 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		if (prev && addr < prev->vm_end) {	/* case 4 */
>  			vma_end = addr;
>  			adjust = mid;
> -			adj_next = -(vma->vm_end - addr);
> -			err = dup_anon_vma(adjust, prev);
> +			adj_next = -(prev->vm_end - addr);
> +			err = dup_anon_vma(mid, prev);
>  		} else {
>  			vma = next;			/* case 3 */
>  			vma_start = addr;
> @@ -982,7 +982,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			err = 0;
>  			if (mid != next) {		/* case 8 */
>  				remove = mid;
> -				err = dup_anon_vma(res, remove);
> +				err = dup_anon_vma(next, mid);
>  			}
>  		}
>  	}
> --
> 2.39.2
>

Big improvement in readability already here.

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
