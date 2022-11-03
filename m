Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50754618303
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKCPkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiKCPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC2DF4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667489948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCO0eVFO3uvEok1cguH8xZ0emQ98va1B5hUX7PNPCwA=;
        b=TdukN2kV6i2qTTnT2WFd2cVs5IhgxNnIiP9qbsgOyzGZbuU5U6ZI9u9L5Y8Z+xxYg8BEZK
        7uBzr8fLETW1EwZ90jEdfsqAXK83vFir3gQVO+moWfAbVW89hiheoyTxPI3zPxgUx/JzPJ
        4o78kHfZrpv1bXvWeHpd7w6VusFF+1E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-396-OKEIMvUZMNqKATXH1I6Wig-1; Thu, 03 Nov 2022 11:39:07 -0400
X-MC-Unique: OKEIMvUZMNqKATXH1I6Wig-1
Received: by mail-qt1-f198.google.com with SMTP id b20-20020ac844d4000000b003a542f9de3dso2059097qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCO0eVFO3uvEok1cguH8xZ0emQ98va1B5hUX7PNPCwA=;
        b=ttEEYpvO2sEVt5s8UId5I23sb2dlo86zcZngEUErUPsCDelRCHgqL7m0tCggjZwtLG
         1al5RSHOKDJCX4MqWXPw7iAHEh/qypMFw+yi+c+/psBZuFNkoCEGr1qL6rMO4SUvcoqo
         v0QhfwCXhwUgjqe1QOtIT1D0JQmcnFcff0BY45PzvPKIVozwJqFWTRbNsdaq0ZseBwDU
         s4CCKY3mjDnCRhoLgLrbJTmo43dj9lzGM2Di89iTmc1FKmwyWbuOwsFGTdQDs7Gcw0aB
         SRHkuk9BQe5LHakkNdMot58RqjHsYTRCdVIUye5fnlzkhjGaYhdtxoTHyuzypdO0dnbw
         qsow==
X-Gm-Message-State: ACrzQf2VydHA6LB01+Jt3oN8+KVE3SmDRbvN2o+wPAG1rhLoWKh0Am+A
        ruNmK4O8vb9EbFX2qQy9BjMsGFUjvOY1UGAIxtpmYj5LEFHejMEkYG5Q7Lra8wa1WCtGZB7COI+
        Any6R7Go1BDMnfaYEytRSw+SF
X-Received: by 2002:a05:620a:1a14:b0:6ce:a65b:8e6 with SMTP id bk20-20020a05620a1a1400b006cea65b08e6mr22646411qkb.145.1667489946737;
        Thu, 03 Nov 2022 08:39:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Bes9+1WNllEELeLCD5AFB3zKvZwG1Ig3CdThVFvTsMP3GaaDsEqnyg3zz0l+66R5s+diOoA==
X-Received: by 2002:a05:620a:1a14:b0:6ce:a65b:8e6 with SMTP id bk20-20020a05620a1a1400b006cea65b08e6mr22646383qkb.145.1667489946469;
        Thu, 03 Nov 2022 08:39:06 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a431600b006cdd0939ffbsm936018qko.86.2022.11.03.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:39:05 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:39:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC 09/10] mm/hugetlb: Make hugetlb_fault() RCU-safe
Message-ID: <Y2PgmMs5q5jOEN0K@x1n>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030213043.335669-1-peterx@redhat.com>
 <CADrL8HUrCkjnBuD7=NJZ5gOBYWBbu=pa0sKp4FMnDH7OhtKvSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUrCkjnBuD7=NJZ5gOBYWBbu=pa0sKp4FMnDH7OhtKvSA@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:04:01AM -0700, James Houghton wrote:
> On Sun, Oct 30, 2022 at 2:30 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > RCU makes sure the pte_t* won't go away from under us.  Please refer to the
> > comment above huge_pte_offset() for more information.
> 
> Thanks for this series, Peter! :)

Thanks for reviewing, James!

> 
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hugetlb.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 5dc87e4e6780..6d336d286394 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5822,6 +5822,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >         int need_wait_lock = 0;
> >         unsigned long haddr = address & huge_page_mask(h);
> >
> > +       /* For huge_pte_offset() */
> > +       rcu_read_lock();
> >         ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> >         if (ptep) {
> >                 /*
> > @@ -5830,13 +5832,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >                  * not actually modifying content here.
> >                  */
> >                 entry = huge_ptep_get(ptep);
> > +               rcu_read_unlock();
> >                 if (unlikely(is_hugetlb_entry_migration(entry))) {
> >                         migration_entry_wait_huge(vma, ptep);
> 
> ptep is used here (and we dereference it in
> `__migration_entry_wait_huge`), so this looks unsafe to me. A simple
> way to fix this would be to move the migration entry check after the
> huge_pte_alloc call.

Right, I definitely overlooked the migration entries in both patches
(including the previous one that you commented), thanks for pointing that
out.

Though moving that after huge_pte_alloc() may have similar problem, iiuc.
The thing is we need either the vma lock or rcu to protect accessing the
pte*, while the pte* page and its pgtable lock can be accessed very deep
into the migration core (e.g., migration_entry_wait_on_locked()) as the
lock cannot be released before the thread queues itself into the waitqueue.

So far I don't see a good way to achieve this but add a hook to
migration_entry_wait_on_locked() so that any lock held for huge migrations
can be properly released after the pgtable lock released but before the
thread yields itself.

-- 
Peter Xu

