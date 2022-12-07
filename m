Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B47D645D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiLGPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLGPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:01:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762E360359
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670425120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/M7RKADQKDoU7dhao5dBCCFwY6Zh8brnj1gC/LTmYIY=;
        b=XOItYhsaya9S7Knl04HQxYJlDKY9Z8m3f6iV6/LQY+qDXkIX6HaIBlhoOXAUuPs9zly2Re
        LWTb0t9/bdoA+tV4+0RwTrPzt61AgIWKXh+0zgGTFQpkTMfCySDUWsRJekAP9JOUR9NkQ/
        MmehPw6SZeMADV/vzjgMATKZtxW1bYw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-252--F0NGCcAOnSyza6Vvknr7Q-1; Wed, 07 Dec 2022 09:58:39 -0500
X-MC-Unique: -F0NGCcAOnSyza6Vvknr7Q-1
Received: by mail-qk1-f198.google.com with SMTP id m3-20020a05620a24c300b006fee2294e97so3644345qkn.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 06:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M7RKADQKDoU7dhao5dBCCFwY6Zh8brnj1gC/LTmYIY=;
        b=4NMUNkHx/slDVZc1uXXiIJhfkDM6rFffsAk1drsntsQAaaiJVmyxshKZnQS+YfOOs1
         kqlSsXbJKrgVds2Ly8PLiuGErycuwJD8JC4H6Wjg5CRh6/JlfguoRoxrRlONh8V3J+7F
         EU6//pk5ym+FSZmsyeWpKzXSpJ47xfehclx8QvX/HWBvp6RGnUJ9IRFU664Fm8Ig43pa
         32yPIDwvXiO4I5bULTYNYMqaDD71pU1rCLnk65CH5RWxSQTbhAKNJ0Vd+SFos4HlF8Or
         V7vjKXkwMq1yfqzIIP4Mcp64ciKxP9o9veeM7sDN5xxWDqUivTmvganxGaBuJ49iJEwV
         W36g==
X-Gm-Message-State: ANoB5plMDPstTP0m6y72wgyHt4MpJT2/8o1woWdUt6uL8AiOsn2fCxfK
        ZHb3nLuhfH+wysntoBBsuQt2nR/pYP97TjoJdyARAt3K6sKWjprh8fVk2Q1oILfNquYeqmQVBVs
        /1Qely4oGW+PTvf84pmOT64wT
X-Received: by 2002:ac8:7305:0:b0:3a6:9cca:67e4 with SMTP id x5-20020ac87305000000b003a69cca67e4mr982589qto.60.1670425118920;
        Wed, 07 Dec 2022 06:58:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4HZKnZ6yNOukOueF+OPGuEXOR0k70Isv3SlCGQ6xBviYaMfoghlhhnWDiVMK31xVr4ORxoMQ==
X-Received: by 2002:ac8:7305:0:b0:3a6:9cca:67e4 with SMTP id x5-20020ac87305000000b003a69cca67e4mr982580qto.60.1670425118624;
        Wed, 07 Dec 2022 06:58:38 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id o1-20020ac841c1000000b0039cc82a319asm13393764qtm.76.2022.12.07.06.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:58:38 -0800 (PST)
Date:   Wed, 7 Dec 2022 09:58:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Message-ID: <Y5CqHIp3nsJfnwAm@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com>
 <Y45/5ezH6uwn7Cfy@monkey>
 <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com>
 <Y49xlV8I2/92Flha@x1n>
 <97e3a8f2-df75-306e-2edf-85976c168955@nvidia.com>
 <Y4+5R+nh0W0RUX9R@x1n>
 <c5d839da-cb7e-e887-11a6-30ccd1c3c845@nvidia.com>
 <Y4/ZT3ab9TL1j5TL@x1n>
 <3f032921-c373-e942-a857-4328d7993ef0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f032921-c373-e942-a857-4328d7993ef0@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 06:38:54PM -0800, John Hubbard wrote:
> On 12/6/22 16:07, Peter Xu wrote:
> > I thought I answered this one at [1] above.  If not, I can extend the
> > answer.
> 
> [1] explains it, but it doesn't mention why it's safe to drop and reacquire.
> 
> ...
> > 
> > If we touch it, it's a potential bug as you mentioned.  But we didn't.
> > 
> > Hope it explains.
> 
> I think it's OK after all, because hmm_vma_fault() does revalidate after
> it takes the vma lock, so that closes the loop that I was fretting over.
> 
> I was just also worried that I'd missed some other place, but it looks
> like that's not the case.
> 
> So, good.
> 
> How about this incremental diff on top, as an attempt to clarify what's
> going on? Or is this too much wordage? Sometimes I write too many words:

Nop, that all looks good, thanks.  I'll apply them in my new post.

> 
> 
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 1f7c2011f6cb..27a6df448ee5 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -21,13 +21,16 @@ struct mm_walk;
>   *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
>   *			Any folded depths (where PTRS_PER_P?D is equal to 1)
>   *			are skipped.
> - * @hugetlb_entry:	if set, called for each hugetlb entry.	Note that
> - *			currently the hook function is protected by hugetlb
> - *			vma lock to make sure pte_t* and the spinlock is valid
> - *			to access.  If the hook function needs to yield the
> - *			thread or retake the vma lock for some reason, it
> - *			needs to properly release the vma lock manually,
> - *			and retake it before the function returns.
> + * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
> + *			function is called with the vma lock held, in order to
> + *			protect against a concurrent freeing of the pte_t* or
> + *			the ptl. In some cases, the hook function needs to drop
> + *			and retake the vma lock in order to avoid deadlocks
> + *			while calling other functions. In such cases the hook
> + *			function must either refrain from accessing the pte or
> + *			ptl after dropping the vma lock, or else revalidate
> + *			those items after re-acquiring the vma lock and before
> + *			accessing them.
>   * @test_walk:		caller specific callback function to determine whether
>   *			we walk over the current vma or not. Returning 0 means
>   *			"do page table walk over the current vma", returning
> diff --git a/mm/hmm.c b/mm/hmm.c
> index dcd624f28bcf..b428f2011cfd 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -497,7 +497,13 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  		spin_unlock(ptl);
>  		hugetlb_vma_unlock_read(vma);
> -		/* hmm_vma_fault() can retake the vma lock */
> +		/*
> +		 * Avoid deadlock: drop the vma lock before calling
> +		 * hmm_vma_fault(), which will itself potentially take and drop
> +		 * the vma lock. This is also correct from a protection point of
> +		 * view, because there is no further use here of either pte or
> +		 * ptl after dropping the vma lock.
> +		 */
>  		ret = hmm_vma_fault(addr, end, required_fault, walk);
>  		hugetlb_vma_lock_read(vma);
>  		return ret;
> 
> > > I guess it's on me to think of something cleaner, so if I do I'll pipe
> > > up. :)
> > 
> > That'll be very much appricated.
> > 
> > It's really that I don't know how to make this better, or I can rework the
> > series as long as it hasn't land upstream.
> > 
> 
> It's always 10x easier to notice an imperfection, than it is to improve on
> it. :)

-- 
Peter Xu

