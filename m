Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788EA6362F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiKWPKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbiKWPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8211FCD6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669216150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LUXSxenq26bBGuzE/dcXl0dHV33hoNn/Op7Tm1BCH/E=;
        b=JhCS8laLJ2kUp3l705vEmmKHou5oWZmDimVUDvxjMt6jMLOhT+fJy7YfNRoKbwv4pWmM6G
        iCRN4r2PRchtjoLdnLW7+88V+zy6315K7E9oQ9cMDmSOxeYi1/gxX+c9t/t/5AfN5a/p9X
        VODzOkvnV/jkYc3bsnCWYlWcgzFovK4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-544-MxSQhGdFOGm3vl3Hqsf6rw-1; Wed, 23 Nov 2022 10:09:08 -0500
X-MC-Unique: MxSQhGdFOGm3vl3Hqsf6rw-1
Received: by mail-qv1-f72.google.com with SMTP id u18-20020a0cec92000000b004c6912ea1baso14703396qvo.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUXSxenq26bBGuzE/dcXl0dHV33hoNn/Op7Tm1BCH/E=;
        b=YZcwMvdQJ11hziWzc/mQey375NEhGBXCAasN330+wsx8MgGogZtCy9NSFuds8kDRpH
         12EUO/MgHObrDN8kwh4TkS1ZUIE/NmkFSDDtouMHFXD1sq7RD1Fy0ld+iKunXfwHLr68
         yj1upBEJR1ef/VT1+arIgpgNuK00qo7kcxflkV/nZiL+/cxMAWq1IUb/FVrPknXcvy3+
         yr+hb2sO3QCki2XDH6thxebTWEQdbdqNlLamGqR+e05evwAGDup4IokRLmjMpes+YG2s
         ovlxm7aKnKh3YHVTZjsO0MBswBbRF/mVe4/0XsuaaJSErHy/vUnTO/wEpe+yGDAq2f7y
         /X8Q==
X-Gm-Message-State: ANoB5plEfym9Q9qtl0brCNvKWYxwdnlGC/zWv7kLeFOgRdm3f2CP/THL
        NsP7V4B4pFO8pH9qax1ROa2KL3bBedmhtk7Evo1b2WzIPpwjKctUxjxbxe+CUQRNZ/yyRWTaLxD
        Nh1Z4brSIn1VGb5xhxyfdoScu
X-Received: by 2002:ad4:5424:0:b0:4c5:dca7:2d39 with SMTP id g4-20020ad45424000000b004c5dca72d39mr10399588qvt.55.1669216146320;
        Wed, 23 Nov 2022 07:09:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5CohcbBY0eOU1/N68Fhy3lmFIv6oxB05yh9z9WZXiFHTysiuQwS2eWb95bfscqjOIynKmWXA==
X-Received: by 2002:ad4:5424:0:b0:4c5:dca7:2d39 with SMTP id g4-20020ad45424000000b004c5dca72d39mr10399560qvt.55.1669216145988;
        Wed, 23 Nov 2022 07:09:05 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006b929a56a2bsm12275011qkb.3.2022.11.23.07.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:09:05 -0800 (PST)
Date:   Wed, 23 Nov 2022 10:09:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC v2 00/12] mm/hugetlb: Make huge_pte_offset()
 thread-safe for pmd unshare
Message-ID: <Y343kIQ9l2d8wViz@x1n>
References: <20221118011025.2178986-1-peterx@redhat.com>
 <70376d57-7924-8ac9-9e93-1831248115a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70376d57-7924-8ac9-9e93-1831248115a0@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David,

Thanks for taking a look.

On Wed, Nov 23, 2022 at 10:40:40AM +0100, David Hildenbrand wrote:
> On 18.11.22 02:10, Peter Xu wrote:
> > Based on latest mm-unstable (96aa38b69507).
> > 
> > This can be seen as a follow-up series to Mike's recent hugetlb vma lock
> > series for pmd unsharing, so this series also depends on that one.
> > Hopefully this series can make it a more complete resolution for pmd
> > unsharing.
> > 
> > PS: so far no one strongly ACKed this, let me keep the RFC tag.  But I
> > think I'm already more confident than many of the RFCs I posted.
> > 
> > PS2: there're a lot of changes comparing to rfcv1, so I'm just not adding
> > the changelog.  The whole idea is still the same, though.
> > 
> > Problem
> > =======
> > 
> > huge_pte_offset() is a major helper used by hugetlb code paths to walk a
> > hugetlb pgtable.  It's used mostly everywhere since that's needed even
> > before taking the pgtable lock.
> > 
> > huge_pte_offset() is always called with mmap lock held with either read or
> > write.
> > 
> > For normal memory types that's far enough, since any pgtable removal
> > requires mmap write lock (e.g. munmap or mm destructions).  However hugetlb
> > has the pmd unshare feature, it means not only the pgtable page can be gone
> > from under us when we're doing a walking, but also the pgtable page we're
> > walking (even after unshared, in this case it can only be the huge PUD page
> > which contains 512 huge pmd entries, with the vma VM_SHARED mapped).  It's
> > possible because even though freeing the pgtable page requires mmap write
> > lock, it doesn't help us when we're walking on another mm's pgtable, so
> > it's still on risk even if we're with the current->mm's mmap lock.
> > 
> > The recent work from Mike on vma lock can resolve most of this already.
> > It's achieved by forbidden pmd unsharing during the lock being taken, so no
> > further risk of the pgtable page being freed.  It means if we can take the
> > vma lock around all huge_pte_offset() callers it'll be safe.

[1]

> > 
> > There're already a bunch of them that we did as per the latest mm-unstable,
> > but also quite a few others that we didn't for various reasons.  E.g. it
> > may not be applicable for not-allow-to-sleep contexts like FOLL_NOWAIT.
> > Or, huge_pmd_share() is actually a tricky user of huge_pte_offset(),

[2]

> > because even if we took the vma lock, we're walking on another mm's vma!
> > Taking vma lock for all the vmas are probably not gonna work.
> > 
> > I have totally no report showing that I can trigger such a race, but from
> > code wise I never see anything that stops the race from happening.  This
> > series is trying to resolve that problem.
> 
> Let me try understand the basic problem first:
> 
> hugetlb walks page tables semi-lockless: while we hold the mmap lock, we
> don't grab the page table locks. That's very hugetlb specific handling and I
> assume hugetlb uses different mechanisms to sync against MADV_DONTNEED,
> concurrent page fault s... but that's no news. hugetlb is weird in many ways
> :)
> 
> So, IIUC, you want a mechanism to synchronize against PMD unsharing. Can't
> we use some very basic locking for that?

Yes we can in most cases.  Please refer to above paragraph [1] where I
referred Mike's recent work on vma lock.  That's the basic locking we need
so far to protect pmd unsharing.  I'll attach the link too in the next
post, which is here:

https://lore.kernel.org/r/20220914221810.95771-1-mike.kravetz@oracle.com

> 
> Using RCU / disabling local irqs seems a bit excessive because we *are*
> holding the mmap lock and only care about concurrent unsharing

The series wanted to address where the vma lock is not easy to take.  It
originates from when I was reading Mike's other patch, I forgot why I did
that but I just noticed there's some code path that we may not want to take
a sleepable lock, e.g. in follow page code.

The other one is huge_pmd_share() where we may have the mmap lock for
current mm but we're fundamentally walking another mm.  It'll be tricky to
take a sleepable lock in such condition too.

I mentioned these cases in the other paragraph above [2].  Let me try to
expand that in my next post too.

It's debatable whether all the rest places can only work with either RCU or
irq disabled, but the idea is at least it should speed up those paths when
we still can.  Here, irqoff might be a bit heavy, but RCU lock should be
always superior to vma lock when possible, the payoff is we may still see
stale pgtable data (since unsharing can still happen in parallel), while
that can be completely avoided when we take the vma lock.

Thanks,

-- 
Peter Xu

