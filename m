Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1DA63DA19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiK3P7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK3P71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D72D76C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669823910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gumPfomwfQgnMEmlAyv6hxZfw1R4BzWPjEo9qytgwX0=;
        b=emu18ouOknB31YZ+XCw9Os5RWsB8kAygwH/kWmpk87pufkAUhJIcBZgNw3JU8FLNKkjXjC
        nbETsQrr7SJsAecbD+j2p1HP6niM+ZAoe065cmPeBcxYtLUErQ4C24wlgjBi22s8iZWy2+
        vFjGMfeUxxLYoirTC2ByLBtvZRqbj6M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-425-3N1IhMqoNMWVaaTzDEz3Ng-1; Wed, 30 Nov 2022 10:58:29 -0500
X-MC-Unique: 3N1IhMqoNMWVaaTzDEz3Ng-1
Received: by mail-qt1-f198.google.com with SMTP id ff5-20020a05622a4d8500b003a526107477so28751240qtb.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gumPfomwfQgnMEmlAyv6hxZfw1R4BzWPjEo9qytgwX0=;
        b=ulNp2aMjMMFHNjA6ybmLVIvaZ78QjfvZPfPf9KmganA59bx1oGHQ32ieYJstPgsh30
         Kif/CU6ARfrFPnFUrYwOrtuCc7llmXuO/M8d56kGrll7X2zBjp5hgNgI9uyv9JB6N5Bz
         h1HIayY5OJ9Vo8qpeaa+ncATWAzgTkNsdMa5JiL8DRbdZZ48hs9WzGLhiN8JRkzzcrL4
         sjr6Fki0W2ZvbfeKqcXekSjLsxuQoOJX7aqF50li7eDAfZBN9L0hN9m+DWd3CAcgTduv
         kkXztTJ6oF+f0yet8gBUbSy5dJ5H09BmQFV/dKQYnRTApULdDvYVvK7EzvEH+I4nQ0xk
         gAcg==
X-Gm-Message-State: ANoB5pmayhHF3gSKTkXlBGSVIqLlppbvh+6J0UMQifCNsSvQDjWSXyhQ
        DuEP/PO+Ata/CByoGLQnhvro+gYqBRv6MOMl6T+TZXXNrRWatu0i4fVn9Q7yqJ3bwGHw4xafQc6
        1dPlcrhmqI/5ME6V2ncCxwMYo
X-Received: by 2002:ac8:44b9:0:b0:3a5:81ec:c4bf with SMTP id a25-20020ac844b9000000b003a581ecc4bfmr46559860qto.180.1669823908556;
        Wed, 30 Nov 2022 07:58:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6pBOYhiiE2CqRWsX8IsY49phZViulM6NbKkVUdLVuq8qQQboKpqdAL6d3q9aaQVWSWvod8Qg==
X-Received: by 2002:ac8:44b9:0:b0:3a5:81ec:c4bf with SMTP id a25-20020ac844b9000000b003a581ecc4bfmr46559836qto.180.1669823908297;
        Wed, 30 Nov 2022 07:58:28 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id y6-20020a05620a25c600b006b9c9b7db8bsm1462092qko.82.2022.11.30.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:58:27 -0800 (PST)
Date:   Wed, 30 Nov 2022 10:58:26 -0500
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
Subject: Re: [PATCH 03/10] mm/hugetlb: Document huge_pte_offset usage
Message-ID: <Y4d9opX7wok4GCdb@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-4-peterx@redhat.com>
 <Y4biOcQzE0yJ82aE@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4biOcQzE0yJ82aE@monkey>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On Tue, Nov 29, 2022 at 08:55:21PM -0800, Mike Kravetz wrote:
> > + *  (2) For shared mappings: pmd unsharing is possible (so the PUD-ranged
> > + *      pgtable page can go away from under us!  It can be done by a pmd
> > + *      unshare with a follow up munmap() on the other process), then we
> > + *      need either:
> > + *
> > + *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
> > + *           won't happen upon the range (it also makes sure the pte_t we
> > + *           read is the right and stable one), or,
> > + *
> > + *     (2.2) hugetlb mapping i_mmap_rwsem lock held read or write, to make
> > + *           sure even if unshare happened the racy unmap() will wait until
> > + *           i_mmap_rwsem is released.
> 
> Is that 100% correct?  IIUC, the page tables will be released via the
> call to tlb_finish_mmu().  In most cases, the tlb_finish_mmu() call is
> performed when holding i_mmap_rwsem.  However, in the final teardown of
> a hugetlb vma via __unmap_hugepage_range_final, the tlb_finish_mmu call
> is done outside the i_mmap_rwsem lock.  In this case, I think we are
> still safe because nobody else should be walking the page table.
> 
> I really like the documentation.  However, if i_mmap_rwsem is not 100%
> safe I would prefer not to document it here.  I don't think anyone
> relies on this do they?

I think i_mmap_rwsem is 100% safe.

It's not in tlb_finish_mmu(), but when freeing the pgtables we need to
unlink current vma from the vma list first:

	free_pgtables
            unlink_file_vma
                i_mmap_lock_write
	tlb_finish_mmu

So it's not the same logic as how the RCU lock worked, but it's actually
better (even though with higher overhead) because vma unlink happens before
free_pgd_range(), so the pgtable locks are not freed yet (unlike RCU).

Thanks,

-- 
Peter Xu

