Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2287F69FD40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBVU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBVU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:57:40 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614613E0B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:57:39 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id m10so9456838vso.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677099458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XO/60+i0K11q3bhzf+PVd34dhBLRH4Ix6IhGCPR4Tec=;
        b=QrN6VLuokAQJAgYd4+9Ank3gXSQtBlR+BGp8tdzFBFHzVmKsqPNfZ9hZUAS6d91d2X
         Ce+X5eX93odULB/j44/FsEcw7uULYFMhGaFUbmNFvOB6ePPUQaHzoY8V6TK/Za085/0l
         8xICacb6e3cBuA/X8iGZsN9862zyk5v0nkAg83hqRkbT6U2Ur3MVcoYz16fSg5p0grsK
         oLRaObuNUn9QILiAWwbn+/ikkDqYzHCgzA6/Cunb1mi8tsk4ksb0pDTLqpNQDaZCrrP8
         Hzl25ucZoHqIvkgTUX28SFOmHFYXo9w3XaA77I7S4ZWT+jUQMpzegwvGcYBpWLvyAuhl
         MTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677099458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO/60+i0K11q3bhzf+PVd34dhBLRH4Ix6IhGCPR4Tec=;
        b=rmu9CftEGNQ9H/1J99QLT7cX95FZyVycRXWNfLJ8CJrcVCjJEVqJETFm6MS/4IVntN
         puX8u1wPv/nk9Yuut6EJP4JdMvdlnoLtHiWwj4nY5F+dv9/rxri2J48BizNJaqlQVJXZ
         qRb0yeMJCf3J5eVNxyAwSD/cNtvGOTLCEgEd299tE9oAnaAel1k9kRJblGYwl4vrPb7U
         C6pHU6FXa+NFD+nZ3Vi1CHOrD365TZL11D+HCMHvEmC8mRD52E6xShE2ZsIYItpNj8JA
         v68yG2d7anHTwu66WFfGW2FucEnZVKADM9MC/z+cDEGOYiAUg31a5Woz1XOgvjh0CraW
         MDag==
X-Gm-Message-State: AO0yUKVylvltDGLOHCP/VDADKbHZuHV2VL+NcHKp/WS91NEVo6taLutO
        yRa8mhvZGm8VjTUXfFOaQ+dXM7I5nm5LbLyP8nXt3A==
X-Google-Smtp-Source: AK7set9+P+EVsDhs4PBijx8RrqiWI/mDw4GXQvb8TvyeO5ATbT4qXZzQsMAnrfq4Eu4pse8Ds+VKoDCFv/m3JBR0zzk=
X-Received: by 2002:a05:6102:23f6:b0:3c8:6949:ea4c with SMTP id
 p22-20020a05610223f600b003c86949ea4cmr2233390vsc.76.1677099458355; Wed, 22
 Feb 2023 12:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <Y/U7ngTyPlg2XCRj@monkey> <28a7208c-939c-19ea-1cf0-298444dffe85@redhat.com>
In-Reply-To: <28a7208c-939c-19ea-1cf0-298444dffe85@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 22 Feb 2023 12:57:27 -0800
Message-ID: <CAHS8izNPr+TfxLL_dBitKAgd11rPhjHx+10Nn96TD3HXzUSevQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/46] hugetlb: introduce HugeTLB high-granularity mapping
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

On Wed, Feb 22, 2023 at 7:49 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 21.02.23 22:46, Mike Kravetz wrote:
> > On 02/18/23 00:27, James Houghton wrote:
> >> This series introduces the concept of HugeTLB high-granularity mapping
> >> (HGM). This series teaches HugeTLB how to map HugeTLB pages at
> >> high-granularity, similar to how THPs can be PTE-mapped.
> >>
> >> Support for HGM in this series is for MAP_SHARED VMAs on x86_64 only. Other
> >> architectures and (some) support for MAP_PRIVATE will come later.
> >>
> >> This series is based on latest mm-unstable (ccd6a73daba9).
> >>
> >> Notable changes with this series
> >> ================================
> >>
> >>   - hugetlb_add_file_rmap / hugetlb_remove_rmap are added to handle
> >>     mapcounting for non-anon hugetlb.
> >>   - The mapcounting scheme uses subpages' mapcounts for high-granularity
> >>     mappings, but it does not use subpages_mapcount(). This scheme
> >>     prevents the HugeTLB VMEMMAP optimization from being used, so it
> >>     will be improved in a later series.
> >>   - page_add_file_rmap and page_remove_rmap are updated so they can be
> >>     used by hugetlb_add_file_rmap / hugetlb_remove_rmap.
> >>   - MADV_SPLIT has been added to enable the userspace API changes that
> >>     HGM allows for: high-granularity UFFDIO_CONTINUE (and maybe other
> >>     changes in the future). MADV_SPLIT does NOT force all the mappings to
> >>     be PAGE_SIZE.
> >>   - MADV_COLLAPSE is expanded to include HugeTLB mappings.
> >>
> >> Old versions:
> >> v1: https://lore.kernel.org/linux-mm/20230105101844.1893104-1-jthoughton@google.com/
> >> RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
> >> RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
> >>
> >> Changelog:
> >> v1 -> v2 (thanks Peter for all your suggestions!):
> >> - Changed mapcount to be more THP-like, and make HGM incompatible with
> >>    HVO.
> >> - HGM is now disabled by default to leave HVO enabled by default.
> >
> > I understand the reasoning behind the move to THP-like mapcounting, and the
> > incompatibility with HVO.  However, I just got to patch 5 and realized either
> > HGM or HVO will need to be chosen at kernel build time.  That may not be an
> > issue for cloud providers or others building their own kernels for internal
> > use.  However, distro kernels will need to pick one option or the other.
> > Right now, my Fedora desktop has HVO enabled so it would likely not have
> > HGM enabled.  That is not a big deal for a desktop.
> >
> > Just curious, do we have distro kernel users that want to use HGM?
>
> Most certainly I would say :)
>

Is it a blocker to merge in an initial implementation though? Do
distro kernel users have a pressing need for HVO + HGM used in tandem?


> --
> Thanks,
>
> David / dhildenb
>
