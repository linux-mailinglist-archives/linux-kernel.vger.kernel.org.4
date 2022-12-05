Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9064399F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiLEXhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiLEXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212F201B5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670283395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnO7sa7gSzPB4vbpmgmHXbkc9bOWdh6rM7DpO68yVMw=;
        b=HdtR8fA7VlUQQX2YVI2sn0lx2ovmcifY9bngAzQCEYM6v5RDMj/bc2jeZzFXn/0m9S1cWB
        x842IqcKJc0NVB4cVPwUXckOjLLLg6UYrsy61WCpp4ZJtrITxICBJI0zs2Soi8v0t5txVq
        eQL1NFv9ifgvmV4t9e/7e2F2S+5+Ads=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-357-5aTqJlXZNYu4UGR9gOyNQw-1; Mon, 05 Dec 2022 18:36:33 -0500
X-MC-Unique: 5aTqJlXZNYu4UGR9gOyNQw-1
Received: by mail-qv1-f70.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso31398408qvr.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnO7sa7gSzPB4vbpmgmHXbkc9bOWdh6rM7DpO68yVMw=;
        b=GaIUanV3g16LqcKCQ3wC4rmWXss6PhsnfrSsbv+CEoJ2NDHJ8yNl+/mSIcRobFvCXI
         xOtmTYzGQCiWQPcCMas3fyond+Udt4bpZ2pry0VfnrSrXTABdXYe3zdDeFbKppvMjPCe
         9bfgJTuzlrtlqPkVL9NJr0dOFuyzm+3Uho4Pqsu0pGu2cdhGgPUehyxvRc0Gaqtm4Dq3
         ka7AHzmy6M/87oyuaSsqihZC/ISbqXijocCPTzMIHF0stXGiwwRorynmDNOCUv7Auh4U
         K456KVw+oh58jnoGemZCrPGKdEcN4xMQ2DNPvRqJ5MgUMni1wd194DJabga1cd59xpDq
         yVJg==
X-Gm-Message-State: ANoB5pm2/ZXXgWZUENfoTwHv3lW9d18m9knipiT41D26TlUYiBEOxTYA
        OkdRBhXc0j1qxC7p9SFNR3UUUMImlvF2b3nAEqjj6V6VaA2XR5h1owgSb/DtWNHSWtbIZstq2g5
        FqzMSyfGzQW84nihOAKcv9KvI
X-Received: by 2002:ad4:5849:0:b0:4c7:933:144c with SMTP id de9-20020ad45849000000b004c70933144cmr30574158qvb.80.1670283393225;
        Mon, 05 Dec 2022 15:36:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4lr+1n1Z+ukiqEUTq0BmC2P5iDPk1qbzmNGUgtKxSx5t+iR8zsMGwkhO4+Jhs1P04Va1COBg==
X-Received: by 2002:ad4:5849:0:b0:4c7:933:144c with SMTP id de9-20020ad45849000000b004c70933144cmr30574141qvb.80.1670283392964;
        Mon, 05 Dec 2022 15:36:32 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id g13-20020a05620a40cd00b006fc7c5d456asm10575370qko.136.2022.12.05.15.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:36:32 -0800 (PST)
Date:   Mon, 5 Dec 2022 18:36:31 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 04/10] mm/hugetlb: Move swap entry handling into vma lock
 when faulted
Message-ID: <Y46Af21YstNXfvW6@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-5-peterx@redhat.com>
 <Y45tTl3tleVP8fA6@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y45tTl3tleVP8fA6@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:14:38PM -0800, Mike Kravetz wrote:
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index dfe677fadaf8..776e34ccf029 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5826,22 +5826,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >  	int need_wait_lock = 0;
> >  	unsigned long haddr = address & huge_page_mask(h);
> >  
> > -	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> > -	if (ptep) {
> > -		/*
> > -		 * Since we hold no locks, ptep could be stale.  That is
> > -		 * OK as we are only making decisions based on content and
> > -		 * not actually modifying content here.
> > -		 */
> > -		entry = huge_ptep_get(ptep);
> > -		if (unlikely(is_hugetlb_entry_migration(entry))) {
> > -			migration_entry_wait_huge(vma, ptep);
> > -			return 0;
> > -		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
> > -			return VM_FAULT_HWPOISON_LARGE |
> > -				VM_FAULT_SET_HINDEX(hstate_index(h));
> > -	}
> > -
> 
> Before acquiring the vma_lock, there is this comment:
> 
> 	/*
> 	 * Acquire vma lock before calling huge_pte_alloc and hold
> 	 * until finished with ptep.  This prevents huge_pmd_unshare from
> 	 * being called elsewhere and making the ptep no longer valid.
> 	 *
> 	 * ptep could have already be assigned via hugetlb_walk().  That
> 	 * is OK, as huge_pte_alloc will return the same value unless
> 	 * something has changed.
> 	 */
> 
> The second sentence in that comment about ptep being already assigned no
> longer applies and can be deleted.

Correct, this can be removed.

One thing to mention is there's an inline touch-up above in the last patch
of the series when introducing hugetlb_walk() to s/pte_offset/walk/, but I
saw that Andrew has already done the right thing on the fixup one in his
local tree, so I think we're all good.

Thanks!

-- 
Peter Xu

