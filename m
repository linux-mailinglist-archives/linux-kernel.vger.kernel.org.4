Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9816A5FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjB1Tnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjB1Tnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:43:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E519B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677613370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PdsM/iL56+yhqvj5vNisyU3+lVwEZ4AAgNHpSpMNXI=;
        b=hna14TeRkM0nvQfm/3s4tc9kj26W+COeeXfF6CXOiGoAy2/Ybn/dZBhfckDi3EyIKM16/f
        eOa7sUv8duvcUo6SEGTKER4uprI0MhEFAcjqT5h05xRvLW4u0EHIYu0vsnO5WgjHAzFKlR
        0d4JyW/4RRiSb4pfPk+hopV3LkYJ5JI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-494-Ud-tIN19OX60X5bpGswrgA-1; Tue, 28 Feb 2023 14:42:49 -0500
X-MC-Unique: Ud-tIN19OX60X5bpGswrgA-1
Received: by mail-qt1-f197.google.com with SMTP id b7-20020ac85407000000b003bfb9cff263so5168056qtq.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677613368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PdsM/iL56+yhqvj5vNisyU3+lVwEZ4AAgNHpSpMNXI=;
        b=4zw1W9aXC57GLpbbQOzR81WVYbSwuWquLXCAyVslAZydL1uTRSISEuw9b+FjTBorf1
         YQEzBrFNWKJ74OtdTRc5/V43vlP5irbFUsdTpK8MUiauE/oSCskOWO6Jc69HW41nM+RA
         cI3YEKJQl64+Sm273YjA/ZZSiCuI551p/J/WuArjmqqHCPeLq+aL3R0OpOXoRg1Tkh7M
         QBzig5yWaR63/xuJtmEdZ5aJb87JVF+0MnzrJb2H4xEvgErp92dfRIM4gGepZmlDXfeb
         tsPwGhiGzYYYljVoPhyS3fmmaJ+OvxEGrOMZ92Fr9dFSPFlyXw7ftE7B7nM71qc4yxzt
         /SWA==
X-Gm-Message-State: AO0yUKVXdDHR/c0dsfYNwMmaqEXH+1X3YyhpzoemAoN16imWQKQD8nll
        Pt8u4GRhDHVGeGvA52j52dwAC5m1b0fpkB7LsqjoCA0PKNLQvpv6XNZzzuXWqDJPK8/94yi8sqe
        74yc8TQ0VFR9mRO46p1Bgvyl2EGiU6Q==
X-Received: by 2002:a05:622a:306:b0:3b9:fc92:a6 with SMTP id q6-20020a05622a030600b003b9fc9200a6mr8263346qtw.6.1677613367778;
        Tue, 28 Feb 2023 11:42:47 -0800 (PST)
X-Google-Smtp-Source: AK7set+J/kJ+JwXDuFlF2fZVP0JuHo1NNbT5QNuUO6XGXHiZyL5u8JtWFUD7rdaXpjhYR2VZpthXGA==
X-Received: by 2002:a05:622a:306:b0:3b9:fc92:a6 with SMTP id q6-20020a05622a030600b003b9fc9200a6mr8263304qtw.6.1677613367374;
        Tue, 28 Feb 2023 11:42:47 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 20-20020a370a14000000b0072396cb73cdsm7399499qkk.13.2023.02.28.11.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 11:42:46 -0800 (PST)
Date:   Tue, 28 Feb 2023 14:42:45 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
Message-ID: <Y/5ZNTESKfntBSF3@x1n>
References: <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com>
 <Y+6NKPuty9V3nycI@x1n>
 <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com>
 <Y/AIEvHJoMUnh4b6@x1n>
 <c463c421-2f33-9ae3-7d41-b394d1737d42@redhat.com>
 <Y/VQMyssclyIGa5i@x1n>
 <91d7c512-ee57-7d71-34b7-90e45f5c109b@redhat.com>
 <Y/Z9ACW8l2E3kOVk@x1n>
 <4b3c2f37-3b84-3147-7513-4293e5408fdd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b3c2f37-3b84-3147-7513-4293e5408fdd@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 03:35:13PM +0100, David Hildenbrand wrote:
> I had some idea of using two markers: PTE_UFFD_WP and PT_UFFD_NO_WP, and
> being pte_none() being something fuzzy in between that the application knows
> how to deal with ("not touched since we registered uffd-wp").
> 
> The goal would be to not populate page tables just to insert PTE
> markers/zeropages, but to only special case on the "there is a page table
> with a present PTE and we're unmapping something with uffd-wp set or uffd-wp
> not set". Because when we're unmapping we already have a page table entry we
> can just set instead of allocating a page table.
> 
> Sorry for throwing semi-finished ideas at you, but the basic idea would be
> to only special case when we're unmapping something: there, we already do
> have a page mapped and can remember uffd-wp-set (clean) vs. !uffd-wp-set
> (dirty).
> 
> 
> uffd-wp protecting a range:
> * !pte_none() -> set uffd-wp bit and wrprotect
> * pte_none() -> nothing to do
> * PTE_UFFD_WP -> nothing to do
> * PTE_UFFD_NO_WP -> set PTE_UFFD_WP
> 
> unmapping a page (old way: !pte_none() -> pte_none()):
> * uffd-wp bit set: set PTE_UFFD_WP
> * uffd-wp bit not set: set PTE_UFFD_NO_WP
> 
> (re)mapping a page (old: pte_none() -> !pte_none()):
> * PTE_UFFD_WP -> set pte bit for new PTE
> * PTE_UFFD_NO_WP -> don't set pte bit for new PTE
> * pte_none() -> set pte bit for new PTE
> 
> Zapping an anon page using MADV_DONTNEED is a bit confusing. It's actually
> similar to a memory write (-> write zeroes), but we don't notify uffd-wp for
> that (I think that's something you comment on below). Theoretically, we'd
> want to set PTE_UFFD_NO_WP ("dirty") in the async mode. But that might need
> more thought of what the expected semantics actually are.
> 
> When we walk over the page tables we would get the following information
> after protecting the range:
> 
> * PTE_UFFD_WP -> clean, not modified since last protection round
> * PTE_UFFD_NO_WP -> dirty, modified since last protection round
> * pte_none() -> not mapped and therefore not modified since beginning of
>                 protection.
> * !pte_none() -> uffd-wp bit decides

I can't say I thought a lot but I feel like it may work. I'd probably avoid
calling it PTE_UFFD_NO_WP or it'll be confusing.. maybe WP_WRITTEN or
WP_RESOLVED instead.

But that interface looks weird in that the protection happens right after
VM_UFFD_WP applied to VMA and that keeps true until unregister.  One needs
to reprotect using ioctl(UFFDIO_WRITEPROTECT) OTOH after the 1st round of
tracking.  It just looks a little bit over-complicated, not to mention we
will need two markers only for userfault-wp.  I had a feeling this
complexity can cause us some trouble elsewhere.

IIUC this can be something done on top even if it'll work (I think the
userspace API doesn't need to change at all), so I'd suggest giving it some
more thoughts and we start with simple and working.

In general, I'll be happy with anything simpler if Muhammad is happy with
its current performance..  For myself, WP_UNPOPULATED is definitely much
better than the old workaround in QEMU live snapshots, so I never worry that.

> Yes, I focused on anon. Let's see if any of the above I said makes sense. :)
> 
> Anyhow, what we're discussing here is yet another uffd-wp addition, if ever,
> so don't feel blocked by my comments.

Thanks.  I've just posted a new version.

-- 
Peter Xu

