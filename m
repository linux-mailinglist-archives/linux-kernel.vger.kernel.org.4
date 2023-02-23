Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E106A0D59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjBWPxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjBWPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:53:47 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA314981
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:53:45 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id f13so12068517vsg.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677167624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WR8J1yySR+0/+fVoLBVx+Pz8ZWOGTNl9xmEJughuYe8=;
        b=dC6fr4Mw/64An6SCj+zn/qIrUjwH5oYk5qaDdAJG/T7Jow4YcLQDEeapjbpFCACl0e
         puZeK9AzaUlAXnaAIPdDV+0I+CtjntdFnCLs9dN8fd6qfPpk4QdZXuLZW+/eo0esuImn
         DIDidVbU7iM5mAj4k/EwfVDwlbwkDZrGenlu2/jwZ4sQho8VTdwlPfscTqWcDteHWaAd
         C3cUrKJ7D8wDegVAsmwKjjxaroN4Df7Ue9akgeoVsVMj42fXIf9VkSuNOveUFX0B3tNB
         jq/BGO8j/2+9YvXqo5zhz991NhUfzd3O1K+y1BWfTmAgbM1awu4mVfoAkop2u9GVnmZU
         do9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677167624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WR8J1yySR+0/+fVoLBVx+Pz8ZWOGTNl9xmEJughuYe8=;
        b=Za2eKpawkOmapHWmdSj+9dNsYl1juKB8fOqh2vAwF0O5nrMCJqPIgcFNGlq9G0sFcY
         QNIiTpn3CAsTe3lSnXCQ7XAjTX7M+VkUhahefAnxaOcNoJp7ZLhuFgtEbmaskC/CJgA0
         s9MgDAeUaSxsJpS2cY4VxS/j8amXSCfaM5xJYJrj/0nEoN6USA4ZefHaUETY3BaCqbkO
         T2vOKM2QJ5rRgUw0LQPvzi06YIX7w4xpC0rfiu5Rr/bTvEf9EoOHhvW9UOTpCECIIYNE
         NnrPUu6dEpmuU2eCCrAMa6Hgaav8vAWYWDCcjV/vML5etxv/D3nCJK+kxbAxZoaTajnL
         4uJA==
X-Gm-Message-State: AO0yUKVjLhwEd51fLbos/HGD2oNU8QkjhxTyb6ra+utE4WtXgDDtmx/4
        acWdvd6lTjTPxRptwHBGrXCyXDxiJB0Ly0tq2Kayyg==
X-Google-Smtp-Source: AK7set+K0XkCUQOwXH6d6Qv7aslzK+oG8h9kFQjkmG1qI/R3yLYB1jl3yirsNm3D+qm8ytEpPDj21tj/WoGoRs0Lc8o=
X-Received: by 2002:a67:e081:0:b0:41e:910f:10ed with SMTP id
 f1-20020a67e081000000b0041e910f10edmr2338883vsl.11.1677167624313; Thu, 23 Feb
 2023 07:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <Y/U7ngTyPlg2XCRj@monkey> <28a7208c-939c-19ea-1cf0-298444dffe85@redhat.com>
 <CAHS8izNPr+TfxLL_dBitKAgd11rPhjHx+10Nn96TD3HXzUSevQ@mail.gmail.com> <94a10407-ebcb-7090-ef92-2bbc9416d6fa@redhat.com>
In-Reply-To: <94a10407-ebcb-7090-ef92-2bbc9416d6fa@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 23 Feb 2023 07:53:08 -0800
Message-ID: <CADrL8HVYBEJrn2BnXEzenTxmxgqCwg5EM+ow509TBCPQrDxsNQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/46] hugetlb: introduce HugeTLB high-granularity mapping
To:     David Hildenbrand <david@redhat.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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

On Thu, Feb 23, 2023 at 1:07 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.02.23 21:57, Mina Almasry wrote:
> > On Wed, Feb 22, 2023 at 7:49 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 21.02.23 22:46, Mike Kravetz wrote:
> >>> On 02/18/23 00:27, James Houghton wrote:
> >>>> This series introduces the concept of HugeTLB high-granularity mapping
> >>>> (HGM). This series teaches HugeTLB how to map HugeTLB pages at
> >>>> high-granularity, similar to how THPs can be PTE-mapped.
> >>>>
> >>>> Support for HGM in this series is for MAP_SHARED VMAs on x86_64 only. Other
> >>>> architectures and (some) support for MAP_PRIVATE will come later.
> >>>>
> >>>> This series is based on latest mm-unstable (ccd6a73daba9).
> >>>>
> >>>> Notable changes with this series
> >>>> ================================
> >>>>
> >>>>    - hugetlb_add_file_rmap / hugetlb_remove_rmap are added to handle
> >>>>      mapcounting for non-anon hugetlb.
> >>>>    - The mapcounting scheme uses subpages' mapcounts for high-granularity
> >>>>      mappings, but it does not use subpages_mapcount(). This scheme
> >>>>      prevents the HugeTLB VMEMMAP optimization from being used, so it
> >>>>      will be improved in a later series.
> >>>>    - page_add_file_rmap and page_remove_rmap are updated so they can be
> >>>>      used by hugetlb_add_file_rmap / hugetlb_remove_rmap.
> >>>>    - MADV_SPLIT has been added to enable the userspace API changes that
> >>>>      HGM allows for: high-granularity UFFDIO_CONTINUE (and maybe other
> >>>>      changes in the future). MADV_SPLIT does NOT force all the mappings to
> >>>>      be PAGE_SIZE.
> >>>>    - MADV_COLLAPSE is expanded to include HugeTLB mappings.
> >>>>
> >>>> Old versions:
> >>>> v1: https://lore.kernel.org/linux-mm/20230105101844.1893104-1-jthoughton@google.com/
> >>>> RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
> >>>> RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
> >>>>
> >>>> Changelog:
> >>>> v1 -> v2 (thanks Peter for all your suggestions!):
> >>>> - Changed mapcount to be more THP-like, and make HGM incompatible with
> >>>>     HVO.
> >>>> - HGM is now disabled by default to leave HVO enabled by default.
> >>>
> >>> I understand the reasoning behind the move to THP-like mapcounting, and the
> >>> incompatibility with HVO.  However, I just got to patch 5 and realized either
> >>> HGM or HVO will need to be chosen at kernel build time.  That may not be an
> >>> issue for cloud providers or others building their own kernels for internal
> >>> use.  However, distro kernels will need to pick one option or the other.
> >>> Right now, my Fedora desktop has HVO enabled so it would likely not have
> >>> HGM enabled.  That is not a big deal for a desktop.
> >>>
> >>> Just curious, do we have distro kernel users that want to use HGM?
> >>
> >> Most certainly I would say :)

I'm not sure. Maybe distros want the hwpoison benefits HGM provides?
But that's not implemented in this series.

> >>
> >
> > Is it a blocker to merge in an initial implementation though? Do
> > distro kernel users have a pressing need for HVO + HGM used in tandem?

+1. I don't see why this should be a blocker.

>
> At least RHEL9 seems to include HVO. It's not enabled as default
> (CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON not set), but compiled
> in so it can be runtime-enabled. Disabling HVO is not an option IMHO.

I agree!

CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y is still the default here; I
made sure not to change that. :)

>
> Maybe, one could make both features compile-time compatible but
> runtime-mutually exclusive. Or work on a way to make them fully
> compatible right from the start.

For the sake of simplifying this series as much as possible, going
with the THP-like mapcount scheme that we know works properly seems
like the right decision to me, even though it is incompatible with
HVO.

Making HGM and HVO play nice at runtime is a little bit complicated,
and it becomes worthless as soon as we optimize the mapcount strategy.
So let's just optimize the mapcount strategy, but in a later series.

As soon as this series has been fully reviewed, patches will be sent up to:
1. Change the mapcount scheme to make HGM and HVO compatible again
(and make MADV_COLLAPSE faster)
2. Add arm64 support
3. Add hwpoison support

If we try to integrate #1 with this series now, I fear that that will
just slow things down more than if #1 is sent up by itself later.

(FWIW, #2 is basically fully implemented and #3 is basically done for
MAP_SHARED. Each of these series are MUCH smaller than this main one.)

- James
