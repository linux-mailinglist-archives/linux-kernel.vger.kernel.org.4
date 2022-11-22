Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B35C634178
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiKVQ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiKVQ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:27:52 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C14A26D1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:27:50 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p1-20020a17090a2c4100b00212733d7aaaso7820119pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PDPHpg3FoSEfatXEdymj1J6bzmmuafnhuxNaKgp3vY=;
        b=VMOr0enba7bo5QpD9v2s1jCYse9HichRnVIZL9vq8t91LyPi5jzYYCzu0vRmmpXFhP
         mVWH49GSnRF8Ptu1PT2SxT0AI/gDz4VEkyN57D70TI4dQ9lmmfkDSiUVlGBB7/9Q1IdE
         5A6bcubRqRqLZ9cMiUBw9UwmRwoxMIAJ89Ye45p7rmDQeLAtrZUaTuGRhebLZw4WVV7J
         oA1WHHSn5BKWoj9IiGxJUrvRXaX8TcfpFI5YIdJ0d882ACc4ztGqyPTecVtYWp5fEawd
         mv+BsqJ4auMv9ZXz023CHvmV4NvmHsJn0jskYIHpZ3YniBHX2+Ve49CjhFe/NwPW8yk5
         pIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8PDPHpg3FoSEfatXEdymj1J6bzmmuafnhuxNaKgp3vY=;
        b=qMJuZaotIQ3WODCTo1dop3qKEl94hhKnC/7MM/tNHeR+BzUUvO1C/S9iWiavDYQ+S8
         DV/Csd9QO7HEwzMO1n5oiWrLo3Zhek+S126iQ+QmkTciTZU3dKJSV5PziSkXhJVK6WBP
         NSpVgUNIcumElRWQwLIKheBqHG16Jwvcw5DFbxvyhyR9EWqEqEVlwuSiJ+1IsP/xZ2y1
         sXVY333YWlJDk2sFOzajaW+1QV0kriDNr8kag0F35dkEJsYYxA2A/tddvkfiQrrHfZbG
         +InIWAreGJRqLoHY2IcMjbmXFlq16AS8Bc34Uqyk6ViWpI7w4xZ1FyBbuFWJB0zhI8DM
         +vXw==
X-Gm-Message-State: ANoB5pnjtdRRUQDCKnHMzYlk+D07UpmnZb/4QLHNzFolnnhz2/gFKA+o
        Xdh/wRdNoYJch/oxZqSaANsM+G3ntw7GyQ==
X-Google-Smtp-Source: AA0mqf5RNc74C8zoBBjjWCIqYQecB9p2pLvXj69GJPKNSS3Soq6P4eXgBypP82aZlW1QnJdjVq0+pnjMCpsrRQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:d106:b0:213:1944:dde2 with SMTP
 id l6-20020a17090ad10600b002131944dde2mr26049964pju.193.1669134470008; Tue,
 22 Nov 2022 08:27:50 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:27:47 +0000
In-Reply-To: <CAHk-=wgR=vJnkkUS=x26=meF=i0x_9q9ytSd+DZGaFP8uoGJsg@mail.gmail.com>
Mime-Version: 1.0
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <20221121165938.oid3pemsfkaeq3ws@google.com>
 <CAHk-=wgR=vJnkkUS=x26=meF=i0x_9q9ytSd+DZGaFP8uoGJsg@mail.gmail.com>
Message-ID: <20221122162747.opnte2csfr5hors2@google.com>
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
From:   Shakeel Butt <shakeelb@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:16:58AM -0800, Linus Torvalds wrote:
> On Mon, Nov 21, 2022 at 8:59 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > Is there a plan to remove lock_page_memcg() altogether which I missed? =
I
> > am planning to make lock_page_memcg() a nop for cgroup-v2 (as it shows
> > up in the perf profile on exit path)
>=20
> Yay. It seems I'm not the only one hating it.
>=20
> > but if we are removing it then I should just wait.
>=20
> Well, I think Johannes was saying that at least the case I disliked
> (the rmap removal from the page table tear-down - I strongly suspect
> it's the one you're seeing on your perf profile too)

Yes indeed that is the one.

-   99.89%     0.00%  fork-large-mmap  [kernel.kallsyms]  [k] entry_SYSCALL=
_64_after_hw=E2=97=86
     entry_SYSCALL_64_after_hwframe                              =20
   - do_syscall_64                                               =20
      - 48.94% __x64_sys_exit_group                              =20
           do_group_exit                                         =20
         - do_exit                                               =20
            - 48.94% exit_mm                                     =20
                 mmput                                           =20
               - __mmput                                         =20
                  - exit_mmap                                    =20
                     - 48.61% unmap_vmas                         =20
                        - 48.61% unmap_single_vma                =20
                           - unmap_page_range                    =20
                              - 48.60% zap_p4d_range             =20
                                 - 44.66% zap_pte_range          =20
                                    + 12.61% tlb_flush_mmu       =20
                                    - 9.38% page_remove_rmap     =20
                                         2.50% lock_page_memcg   =20
                                         2.37% unlock_page_memcg =20
                                         0.61% PageHuge          =20
                                      4.80% vm_normal_page       =20
                                      2.56% __tlb_remove_page_size
                                      0.85% lock_page_memcg      =20
                                      0.53% PageHuge             =20
                                   2.22% __tlb_remove_page_size  =20
                                   0.93% vm_normal_page          =20
                                   0.72% page_remove_rmap

> can be removed
> entirely as long as it's done under the page table lock (which my
> final version of the rmap delaying still was).
>=20
> See
>=20
>     https://lore.kernel.org/all/Y2llcRiDLHc2kg%2FN@cmpxchg.org/
>=20
> for his preliminary patch.
>=20
> That said, if you have some patch to make it a no-op for _other_
> reasons, and could be done away with _entirely_ (not just for rmap),
> then that would be even better.

I am actually looking at deprecating the whole "move charge"
funcitonality of cgroup-v1 i.e. the underlying reason lock_page_memcg
exists. That already does not work for couple of cases like partially
mapped THP and madv_free'd pages. Though that deprecation process would
take some time. In the meantime I was looking at if we can make these
functions nop for cgroup-v2.

thanks,
Shakeel
