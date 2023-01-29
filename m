Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE7680230
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjA2WPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjA2WPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97B1CAF4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675030471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQ2EG58lEBfBcoyGXMvMMXH2dCLi5wC9HNZTuXZVe0I=;
        b=MLkmp4rUPZS5+UAt3pv7OBGIH/+gQ7eUT2qawYHDVnGzT9YMHXGGr6rY9EtfPbk3LJjvV3
        1C4oYAGvEY8pDYHSo4/aTm0Sr43B/FQ8xmIdk4P/alxE/BF1BnSsC0Oj2OLggV4ZHwoMo+
        fO5C3OAyOZnDofVWly0tqtaEdtT4hXQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-M7N1nViIMheAgwD-zRWXew-1; Sun, 29 Jan 2023 17:14:30 -0500
X-MC-Unique: M7N1nViIMheAgwD-zRWXew-1
Received: by mail-qt1-f200.google.com with SMTP id c16-20020ac85190000000b003b841d1118aso1260246qtn.17
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ2EG58lEBfBcoyGXMvMMXH2dCLi5wC9HNZTuXZVe0I=;
        b=0XOjv/CrGgyT+g3CiEcJ52jL73E//ABhVKU7zvbYV0QShrsBD6TqpbwNX1KiXhx48O
         CvsP4t4Vs7NWjjx0B+PCSSsvq4GTk+NeIv1D+DwKitfjje13HOZ5367ulZvFrGZ4xI23
         BadM7aPSp/bm8BXN1A96+m0O0QO6K8xCIvKzv/ZpT/Cy4QEh9YNsTmcA8AOGUlaCSZVN
         yKL7fWkZbOXD+2R0MoLzFGuhXaI6+Juo5vqzNyZciCF3G5cVexxDnzv7g3V/gRpHChFS
         GBSVzOgYApMWVzLMjapZbCr7CVlQxgZn5OM9EHdgW5kS0u0KUAk8GJC4xQmOg8ZC9bGT
         8Byw==
X-Gm-Message-State: AO0yUKXR6AKr5+2+CzypSOoFA4Kt30Y6l0qDJUrXLmDZrKT91LedzlBI
        +HJ+PJOM0M+CUZ2YmgLyptGkZV9uSZgTNGjaF310aW+VNql6no1KelyioqBdm7MQPmbixCGPn9s
        Gk/3b6HeKGseAT8uqPA+vXFYg
X-Received: by 2002:a05:622a:1d3:b0:3b6:2cc8:e120 with SMTP id t19-20020a05622a01d300b003b62cc8e120mr11266306qtw.39.1675030469743;
        Sun, 29 Jan 2023 14:14:29 -0800 (PST)
X-Google-Smtp-Source: AK7set/c8nGKoE4Pi+rMw4N7aF4GlFF+SuNMvKDIkWAl5IXNZZcNu/VR2VsrTBbWYqFYWWq3QARq4A==
X-Received: by 2002:a05:622a:1d3:b0:3b6:2cc8:e120 with SMTP id t19-20020a05622a01d300b003b62cc8e120mr11266279qtw.39.1675030469392;
        Sun, 29 Jan 2023 14:14:29 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id z18-20020ac83e12000000b003b8332f49e0sm3864086qtf.1.2023.01.29.14.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 14:14:28 -0800 (PST)
Date:   Sun, 29 Jan 2023 17:14:27 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1
 (regression)
Message-ID: <Y9bvwz4FIOQ+D8c4@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 09:17:31PM -0500, Nick Bowler wrote:
> Hi,

Hi, Nick,

> 
> Starting with Linux 6.1.y, my sparc64 (Sun Ultra 60) system is very
> unstable, with userspace processes randomly crashing with all kinds of
> different weird errors.  The same problem occurs on 6.2-rc5.  Linux
> 6.0.y is OK.
> 
> Usually, it manifests with ssh connections just suddenly dropping out
> like this:
> 
>   malloc(): unaligned tcache chunk detected
>   Connection to alectrona closed.
> 
> but other kinds of failures (random segfaults, bus errors, etc.) are
> seen too.
> 
> I have not ever seen the kernel itself oops or anything like that, there
> are no abnormal kernel log messages of any kind; except for the normal
> ones that get printed when processes segfault, like this one:
> 
>   [  563.085851] zsh[2073]: segfault at 10 ip 00000000f7a7c09c (rpc
> 00000000f7a7c0a0) sp 00000000ff8f5e08 error 1 in
> libc.so.6[f7960000+1b2000]
> 
> I was able to reproduce this fairly reliably by using GNU ddrescue to
> dump a disk from the dvd drive -- things usually go awry after a minute
> or two.  So I was able to bisect to this commit:
> 
>   2e3468778dbe3ec389a10c21a703bb8e5be5cfbc is the first bad commit
>   commit 2e3468778dbe3ec389a10c21a703bb8e5be5cfbc
>   Author: Peter Xu <peterx@redhat.com>
>   Date:   Thu Aug 11 12:13:29 2022 -0400
> 
>       mm: remember young/dirty bit for page migrations
> 
> This does not revert cleanly on master, but I ran my test on the
> immediately preceding commit (0ccf7f168e17: "mm/thp: carry over dirty
> bit when thp splits on pmd") extra times and I am unable to get this
> one to crash, so reasonably confident in this bisection result...

There's a similar report previously but interestingly it was exactly
reported against commit 0ccf7f168e17, which was the one you reported all
good:

https://lore.kernel.org/all/20221021160603.GA23307@u164.east.ru/

It's probably because for some reason the thp split didn't really happen in
your system (maybe thp disabled?) or it should break too. It also means
624a2c94f5b7a didn't really fix all the issues.  So I assumed that's the
only issue we had after verified with 624a2c94f5b7a on two existing
reproducers and we assumed all issues fixed.

However then with this report I looked into the whole set and I did notice
the page migration code actually has similar problem.  Sorry I should have
noticed this even earlier.  So very likely the previous two reports came
from environment where page migration is either rare or not enabled.  And
now I suspect your system has page migration enabled.

Could you try below patch to see whether it fixes your problem?  It should
cover the last piece of possible issue with dirty bit on sparc after that
patchset.  It's based on latest master branch (commit ab072681eabe1ce0).

---8<---
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index abe6cfd92ffa..f15ea5b389f6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3272,15 +3272,17 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
        pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
        if (pmd_swp_soft_dirty(*pvmw->pmd))
                pmde = pmd_mksoft_dirty(pmde);
-       if (is_writable_migration_entry(entry))
-               pmde = maybe_pmd_mkwrite(pmde, vma);
        if (pmd_swp_uffd_wp(*pvmw->pmd))
-               pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
+               pmde = pmd_mkuffd_wp(pmde);
        if (!is_migration_entry_young(entry))
                pmde = pmd_mkold(pmde);
        /* NOTE: this may contain setting soft-dirty on some archs */
        if (PageDirty(new) && is_migration_entry_dirty(entry))
                pmde = pmd_mkdirty(pmde);
+       if (is_writable_migration_entry(entry))
+               pmde = maybe_pmd_mkwrite(pmde, vma);
+       else
+               pmde = pmd_wrprotect(pmde);
 
        if (PageAnon(new)) {
                rmap_t rmap_flags = RMAP_COMPOUND;
diff --git a/mm/migrate.c b/mm/migrate.c
index a4d3fc65085f..cc5455614e01 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -224,6 +224,8 @@ static bool remove_migration_pte(struct folio *folio,
                        pte = maybe_mkwrite(pte, vma);
                else if (pte_swp_uffd_wp(*pvmw.pte))
                        pte = pte_mkuffd_wp(pte);
+               else
+                       pte = pte_wrprotect(pte);
 
                if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
                        rmap_flags |= RMAP_EXCLUSIVE;
---8<---

Thanks,

-- 
Peter Xu

