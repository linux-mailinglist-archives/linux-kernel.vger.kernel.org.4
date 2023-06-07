Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16488726AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjFGUTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFGUSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:18:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4451FC8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:18:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so844747f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686169070; x=1688761070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjIpS+9DDWPdZUeti9i32IuBAuaa2dTEgXNkRKMTJXY=;
        b=hy+CFSjePMFciT4vJLq23m5nIHJJ/eUUVPO20yUoLr8nkwMcAoHEQ1ico1MAJaUgg0
         GFdNWcDjcl10c5PXa9nsRxw1bqld3fbHodE0V1IvHrmVjrqsXD7SRYJ5kEMduYk/XJLZ
         BaoSgyxwrq22pqNwTWNTS9NwrvCsCfLs7N8DEki/6UV0KA2ER3uEomqprqWMai3MleoW
         rB1rdw6lY7icvCO/LvKtMySE6zGvqrt4XioZ8e6PhYMJP9PpebmJCZcwKSvXZyGtGpoV
         8qCBC4Bs1pA+cfOs140wl4v9vSRtnF7rEOk6XphVKvtNWw6ljh/WxyJKxeXMpikjJuYm
         8ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686169070; x=1688761070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjIpS+9DDWPdZUeti9i32IuBAuaa2dTEgXNkRKMTJXY=;
        b=WfjY12mtQ21p/PtUQAAQK3jKoxHoU/6BtS0FVMDemWU29ady9d2/RqLxMCn95hfI/N
         GVzoWziGNMWMjEqEwZI1r/LyZapUYTdXFvSCdzLWMivQcKRujspB5pwfplV9owHU+pnP
         /yMf/lysZ6C3iU/z1Ei1BxL6qt4J1z/KhA/Z1ssmqHOYEm80EnBFGhuBU4iCZMS6VtvQ
         BLtJYBANKiQBfRxkYc71hI1fZhuUaTVGJ1w1Xdjli+5mx1zvEyTilChh3IrifUdEBlLq
         XxFLlKErNodY0tYbAJXpTXf7J8kEE5QgZiRYPp4H3vZXNToHKxbzOp+b2D+S6R5cyS62
         eH7g==
X-Gm-Message-State: AC+VfDyYj/lmPDoS5RWfcO4+t4ykpJ3Yy19t0SnlxyiC9VdIL0hE7yG8
        Fx3g/mv2TBORiiFMvEDN6+M=
X-Google-Smtp-Source: ACHHUZ5uMSzIHR+faL+dCqJzuHGY6d25HQf27aMv77FsC5gjzGXNnO07p8uGNwJC/Or4lHmqK7+IRA==
X-Received: by 2002:adf:fa03:0:b0:307:869c:99ce with SMTP id m3-20020adffa03000000b00307869c99cemr78990wrr.21.1686169069641;
        Wed, 07 Jun 2023 13:17:49 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4d09000000b0030e5c8d55f2sm2192386wrt.6.2023.06.07.13.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:17:48 -0700 (PDT)
Date:   Wed, 7 Jun 2023 21:17:47 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: RFC for new feature to move pages from one vma to another
 without split
Message-ID: <67045cc5-b35b-4274-b22e-21b3920e33e1@lucifer.local>
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n>
 <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
 <ZDbVMk0trT5UaqaA@x1n>
 <3059388f-1604-c326-c66f-c2e0f9bb6cbf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3059388f-1604-c326-c66f-c2e0f9bb6cbf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:10:44AM +0200, David Hildenbrand wrote:
> For RMAP and friends (relying on linear_page_index), folio->index has to
> match the index within the VMA. If would set pgoff to something else, we'd
> have less VMA merging opportunities. So your system might work, but you'd
> end up with many anon VMAs.

I thik the reverse situation, i.e. splitting the VMA, is the more serious
one, and without a correct index would simply break rmap.

Consider:-

     [ VMA ]
        ^
        |
     [ avc ]
        ^
        |
   [ anon_vma ]
    ^    ^    ^
   /     |     \
page 1 page 2 page 3

If we unmap page 2, we cannot (or would rather not) update page 1 and page
3 to point to a new anon_vma and instead end up with:-

 [ VMA 1 ]  [ VMA 3 ]
     ^          ^
     |          |
  [ avc ]    [ avc ]
     ^          ^
      \        /
     [ anon_vma ]
      ^         ^
     /           \
  page 1        page 3

Now you need some means of knowing which VMA each belongs to - we have to
use the folio->index to look up which anon_vma_chain (avc) in the
anon_vma's interval tree (which is keyed on folio->index) contains its VMA
(actually this could be multiple VMAs due to forking).

mremap() seems to me to be a lot of the reason we don't just put
vma->vm_start >> PAGE_SHIFT in folio->index the fly, as when a block of
memory is moved, we don't want to have to go and update all of the
underlying pages, so we just keep the vm_pgoff the same as the old position
even after it's moved. We keep this in vm_pgoff so we know what pgoff's to
give to new pages to put in their index fields.

As a result, we obviously wouldn't want to merge an mremap'd VMA with that
special handling with one that didn't have it to avoid the pages not being
able to be rmap'd back to the correct VMAs, so requiring vm_pgoff to be
linearly monotonically increasing across the merged range achieves this.

Doing it this way keeps the code for the VMA manipulation logic the same
for file-backed and anon mappings so is (kind of) neat in that respect.

Oh as a point of interest there is _yet another_ thing that can go in
vm_pgoff, which is remapped kernel mappings via remap_pfn_range_notrack()
which puts PFN in there :))

(as you can imagine I've torn out my rapidly diminishing hair writing about
this stuff in the book)

>
>
> Imagine the following:
>
> [ anon0 ][  fd   ][ anon1 ]
>
> Unmap the fd:
>
> [ anon0 ][ hole  ][ anon1 ]
>
> Mmap anon:
>
> [ anon0 ][ anon2 ][ anon1 ]
>
>
> We can now merge all 3 VMAs into one, even if the first and latter already
> map pages.
>
>
> A simpler and more common example is probably:
>
> [ anon0 ]
>
> Mmmap anon1 before the existing one
>
> [ anon1 ][ anon0 ]
>
> Which we can merge into a single one.
>
>
>
> Mapping after an existing one could work, but one would have to carefully
> set pgoff based on the size of the previous anon VMA ... which is more
> complicated
>
> So instead, we consider the whole address space as a virtual, anon file,
> starting at offset 0. The pgoff of a VMA is then simply the offset in that
> virtual file (easily computed from the start of the VMA), and VMA merging is
> just the same as for an ordinary file.

This is a very good way of explaining it (though mremap complicates things
somewhat).

>
> --
> Thanks,
>
> David / dhildenb
>
