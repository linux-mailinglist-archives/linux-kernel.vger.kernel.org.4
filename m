Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196CE63DA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiK3QYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiK3QYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE221AE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669825422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o2Al/9kqwid6v5pluscQbgDnOPDZ2kG1eBnUqFvKT+A=;
        b=HyQ+IipCiBmmpScV1fIFlafaJgQtbReW0pswyCFx5mW6HME5NB196Kjqd5f7IrYd2zIh3I
        hKeDoWkqm/ENoISiJTaprrYXujyV+oplwYzoMrm6fgjdq0eaj7HVNAOAEuxJb3dPn+4COq
        VLcVN44qSVmsmvFxGv1lg19hoEfjvEo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-ZeMDBDbJNxKe13hZkoE6Ag-1; Wed, 30 Nov 2022 11:23:41 -0500
X-MC-Unique: ZeMDBDbJNxKe13hZkoE6Ag-1
Received: by mail-qt1-f197.google.com with SMTP id ew11-20020a05622a514b00b003a524196d31so28968248qtb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2Al/9kqwid6v5pluscQbgDnOPDZ2kG1eBnUqFvKT+A=;
        b=4FepmmHII98A5gy+KznODnUVQ6Kk8epwROhzmINRUadnyJaCrIQb8mVYAdHKoYv+ft
         IE7P2WLBDwfNFOWwMT3k9Y0XO7PwlRJS4o7Y0zu5yqPCd63XRh2onJAHO7CBB00DuNCP
         n9o2Y1XJBbCYPhC5afS5xFstjh8lMxonBD8Wn7BC1rwJ1cbhLPqaZlMVJgbvFRW39XHk
         RMLUkSiDxngTC/TIMFLsIzs43qsdHBGbuuIURtHNGFLty+Ns4WSez/Ig5na3tliShOXU
         LVdZRcc7twyjdx5FiwwNIVB4fXxTpAcMiXueS4RUCcLE/8mweojCR5wDdnS6hqXszKWS
         IUPA==
X-Gm-Message-State: ANoB5pl4SYZxjOvxsionvEYG0Q+VzR23Wyr8aT8bRGz9XnFpcIezCDUc
        HFxop0GXr+yUVMOibz0kqVQqCItdJTHE5fO8eG7kfBcIQF1XPQ8LPKovuxZV8wYw+/KDXyY8VVg
        r8VMIOC/1iJfzNNcQQrIMbH44
X-Received: by 2002:a05:622a:4184:b0:3a5:931a:8280 with SMTP id cd4-20020a05622a418400b003a5931a8280mr43139177qtb.31.1669825420762;
        Wed, 30 Nov 2022 08:23:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf72rYOP8wiMoqHFGZfl96zZ6te1Cv7mBNQlvjzRx3UydJMhSRTCiSxFdfCFB4SOGBifAY029Q==
X-Received: by 2002:a05:622a:4184:b0:3a5:931a:8280 with SMTP id cd4-20020a05622a418400b003a5931a8280mr43139146qtb.31.1669825420495;
        Wed, 30 Nov 2022 08:23:40 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bn12-20020a05622a1dcc00b003a527d29a41sm1050053qtb.75.2022.11.30.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:23:40 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:23:39 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe for
 pmd unshare
Message-ID: <Y4eDixDUnreiyIXq@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <1eff312b-1aca-6afb-3587-f65e698b3f8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1eff312b-1aca-6afb-3587-f65e698b3f8c@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:46:24AM +0100, David Hildenbrand wrote:
> > huge_pte_offset() is always called with mmap lock held with either read or
> > write.  It was assumed to be safe but it's actually not.  One race
> > condition can easily trigger by: (1) firstly trigger pmd share on a memory
> > range, (2) do huge_pte_offset() on the range, then at the meantime, (3)
> > another thread unshare the pmd range, and the pgtable page is prone to lost
> > if the other shared process wants to free it completely (by either munmap
> > or exit mm).
> 
> So just that I understand correctly:
> 
> Two processes, #A and #B, share a page table. Process #A runs two threads,
> #A1 and #A2.
> 
> #A1 walks that shared page table (using huge_pte_offset()), for example, to
> resolve a page fault. Concurrently, #A2 triggers unsharing of that page
> table (replacing it by a private page table),

Not yet replacing it, just unsharing.

If the replacement happened we shouldn't trigger a bug either because
huge_pte_offset() will return the private pgtable page instead.

> for example, using munmap().

munmap() may not work because it needs mmap lock, so it'll wait until #A1
completes huge_pte_offset() walks and release mmap lock read.

Many of other things can trigger unshare, though.  In the reproducer I used
MADV_DONTNEED.

> 
> So #A1 will eventually read/write the shared page table while we're placing
> a private page table. Which would be fine (assuming no unsharing would be
> required by #A1), however, if #B also concurrently drops the reference to
> the shared page table (), the shared page table could essentially get freed
> while #A1 is still walking it.
> 
> I suspect, looking at the reproducer, that the page table deconstructor was
> called. Will the page table also actually get freed already? IOW, could #A1
> be reading/writing a freed page?

If with the existing code base, I think it could.

If with RCU lock, it couldn't, but still since the pgtable lock is freed
even if the page is not, we'll still hit weird issues when accessing the
lock.

And with vma lock it should be all safe.

-- 
Peter Xu

