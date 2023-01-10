Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53EA6635FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjAJABq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbjAJABl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:01:41 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7C13D72
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:01:39 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fc4so24374773ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 16:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C1EfFzfabpcvKD8Z4XD1PnuKj//ORNqUpFVSgTL9doA=;
        b=bljXDsaYUCchWh5iEvR4owIXmDy0emx8cGCi9oxdUsZNMdEtoeJ6jsiPswcGUrpZrV
         5Gr48my7EhtPBF/sO6GMslAki0O7fJsEyP223LJxQ96IrARoHXjvtfdc/QpAXM6cMGCf
         J+XQzModiguk5xVF/JO/u+EIuPdzukJhuHP5y+DVVIbBbr8pJgZScSCzFbYFMwWSYMen
         llJwQF4bK6XLeHGKtBj8g0/D7H54JRK5a5O3qduUSGby05wIC7CfK2ELfC3p7HYOXBiQ
         Lj2VL1As+dZcztekN57UgV6nA0DHu2SCcbw9kn1YfSQtAMQ9e2ASAtpVbyNBZ8WbIivB
         rq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1EfFzfabpcvKD8Z4XD1PnuKj//ORNqUpFVSgTL9doA=;
        b=hqeBwhOnkhc3yCW3PXcGubsPq9SrPB65QnZspbBb+GKSSQEBRbDk0UxK8DSNdveuSl
         cSgBPc3O18lCuhhKCJqGr0koOe2oXEiuUT5Iy3U/odr9Few8pegYZ+MVP92zt9Kb1cNn
         VVzDEvhcEistuVMVeNdA25E6hLmUHhsGVSabeuNE89G/6JQ+X2P673J/K9InTdIjr7a/
         /FnaWMjTy2mjyQa1G1ItYRdGKl6m9spZzNnRdnaIgsHJqMzItkcUqjHQJVR9DLqeFt3D
         GzMikAd7cq35pJVlvskPcDdDzH+xAHzJ1ZTSH4yg7ZdnIowriHjCnMVVA1hBrGMdKnSd
         ON3w==
X-Gm-Message-State: AFqh2kq1qmowcrIoq9o9wJuHE5puCse/yLsFk6PWMmH3/pB6XkDv5E07
        wvXaOsryHgPaeSXYj9m1v85lSfHvODbIM/RccLfxFQ==
X-Google-Smtp-Source: AMrXdXtHRlaLgCreznIXqJJmsCLD7YOsbSH4m+WWHCdSVVPlJSIFj4Gl+qn/LHHUlYVcyHHJBYOtmDqEIn24JTWk4pM=
X-Received: by 2002:a17:906:a2c3:b0:839:74cf:7c4c with SMTP id
 by3-20020a170906a2c300b0083974cf7c4cmr6866686ejb.265.1673308897469; Mon, 09
 Jan 2023 16:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-10-jthoughton@google.com> <797b85c0-ec50-f340-30dd-5a63b51dc45a@redhat.com>
In-Reply-To: <797b85c0-ec50-f340-30dd-5a63b51dc45a@redhat.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 9 Jan 2023 16:01:00 -0800
Message-ID: <CAAa6QmRzg7N74dZyqZoLWspPqbRkOAiJHheW39=QD91XBzbOeg@mail.gmail.com>
Subject: Re: [PATCH 09/46] mm: add MADV_SPLIT to enable HugeTLB HGM
To:     David Hildenbrand <david@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 7:29 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 05.01.23 11:18, James Houghton wrote:
> > Issuing ioctl(MADV_SPLIT) on a HugeTLB address range will enable
> > HugeTLB HGM. MADV_SPLIT was chosen for the name so that this API can be
> > applied to non-HugeTLB memory in the future, if such an application is
> > to arise.
> >
> > MADV_SPLIT provides several API changes for some syscalls on HugeTLB
> > address ranges:
> > 1. UFFDIO_CONTINUE is allowed for MAP_SHARED VMAs at PAGE_SIZE
> >     alignment.
> > 2. read()ing a page fault event from a userfaultfd will yield a
> >     PAGE_SIZE-rounded address, instead of a huge-page-size-rounded
> >     address (unless UFFD_FEATURE_EXACT_ADDRESS is used).
> >
> > There is no way to disable the API changes that come with issuing
> > MADV_SPLIT. MADV_COLLAPSE can be used to collapse high-granularity page
> > table mappings that come from the extended functionality that comes with
> > using MADV_SPLIT.
> >
> > For post-copy live migration, the expected use-case is:
> > 1. mmap(MAP_SHARED, some_fd) primary mapping
> > 2. mmap(MAP_SHARED, some_fd) alias mapping
> > 3. MADV_SPLIT the primary mapping
> > 4. UFFDIO_REGISTER/etc. the primary mapping
> > 5. Copy memory contents into alias mapping and UFFDIO_CONTINUE the
> >     corresponding PAGE_SIZE sections in the primary mapping.
> >
> > More API changes may be added in the future.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >   arch/alpha/include/uapi/asm/mman.h     |  2 ++
> >   arch/mips/include/uapi/asm/mman.h      |  2 ++
> >   arch/parisc/include/uapi/asm/mman.h    |  2 ++
> >   arch/xtensa/include/uapi/asm/mman.h    |  2 ++
> >   include/linux/hugetlb.h                |  2 ++
> >   include/uapi/asm-generic/mman-common.h |  2 ++
> >   mm/hugetlb.c                           |  3 +--
> >   mm/madvise.c                           | 26 ++++++++++++++++++++++++++
> >   8 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> > index 763929e814e9..7a26f3648b90 100644
> > --- a/arch/alpha/include/uapi/asm/mman.h
> > +++ b/arch/alpha/include/uapi/asm/mman.h
> > @@ -78,6 +78,8 @@
> >
> >   #define MADV_COLLAPSE       25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_SPLIT   26              /* Enable hugepage high-granularity APIs */
>
> I think we should make a split more generic, such that it also splits
> (pte-maps) a THP. Has that been discussed?


Thanks James / David.

MADV_SPLIT for THP has come up a few times; firstly, during the
initial RFC about hugepage collapse in process context, as the natural
inverse operation required by a generic userspace-managed hugepage
daemon, the second -- which is more immediately practical -- is to
avoid stranding THPs on the deferred split queue (and thus still
incurring the memcg charge) for too long [1].

However, its exact semantics / API have yet to be discussed / flushed
out (though I'm planning to do exactly this in the near-term).

Just as James has co-opted MADV_COLLAPSE for hugetlb, we can co-opt
MADV_SPLIT for THP, when the time comes -- which I think makes a lot
of sense.

Hopefully I can get my ducks in order to start a discussion about this
eminently.

Best,
Zach

[1] https://lore.kernel.org/linux-mm/YZ9kUD5AG6inbUEg@xz-m1.local/

> --
> Thanks,
>
> David / dhildenb
>
