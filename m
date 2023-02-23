Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CCC6A0F87
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjBWSeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBWSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B88F28234
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677177201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1KAswVqKkyuNKqIt1Ix9JYojFZp/MLILNHy2iRtWpg0=;
        b=MXkp7Z7U4ZkhEHb896ABVoCjmAQV2UMcs8Jm56uc8+bxC5Or0gIUyqB4+hcGTuUqBsVVTR
        6nSYgRYqGxttc4MSUOa9m7lpJYtadKnSJ8ur5aJkZEdHPtjzWq68skg3BDV1gu5cKTi3B4
        7Gsycr4yo8t/XG4K/RMf/nTq6xtgq5Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-GnN87mhkPlyckh4ocvdCow-1; Thu, 23 Feb 2023 13:33:19 -0500
X-MC-Unique: GnN87mhkPlyckh4ocvdCow-1
Received: by mail-wm1-f69.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so1931384wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KAswVqKkyuNKqIt1Ix9JYojFZp/MLILNHy2iRtWpg0=;
        b=HbzvMwXsvpa78GH9zISsbT8B14GJL+bfijdckoX0PvxlIzUqXkLn9nPMpHjbrnepf3
         DwkqQeWWZtcW0Z0qVs5uSiUKfjPIoE52TXZUqhlXC8EaF+EYo2qhjsjSNtX59oIqXa13
         bY/CaynPjufEFqite9E0SPewqh3xW7oYGzFiUqgghXccFHX02ZRDIawo6pCrOb7L7ru8
         V89R0DiTQDDTeT2K4EDHVJkaYfdF1k4hKyQ9pcXkkhJpKxWEoyctAU38IWVhr0m4X6mY
         a2k/SBMNPhZsCvtvAnTGtzpDcaWyLV30HdQOUQzJW5WT2lQy7WGG0/usYOOBOq3xeo7o
         LQyg==
X-Gm-Message-State: AO0yUKXpL6dX2ZpkH8Ut9GLiaeQ6eM9M+/WZXzQcopdHRZ+yxojFIdNM
        R5NQRSQfHfsU8GCy9DcpGGfcXUSAoo1HlhnhBv3jM8JFcZBmvDCM0+s4pc8wnOJS3HH365VzHSq
        Qik2/hc+YxdIt1GiWM2scxRls
X-Received: by 2002:a05:600c:3087:b0:3df:ed95:d757 with SMTP id g7-20020a05600c308700b003dfed95d757mr3630700wmn.34.1677177198808;
        Thu, 23 Feb 2023 10:33:18 -0800 (PST)
X-Google-Smtp-Source: AK7set8ejRjRgHsjmuw9FlhJJ7ByKe/I22ckwwECJpD2qxuSviTHWx1ibGuDvL+3sB1SlImSkM8HOQ==
X-Received: by 2002:a05:600c:3087:b0:3df:ed95:d757 with SMTP id g7-20020a05600c308700b003dfed95d757mr3630681wmn.34.1677177198490;
        Thu, 23 Feb 2023 10:33:18 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c359400b003daf7721bb3sm148177wmq.12.2023.02.23.10.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 10:33:17 -0800 (PST)
Date:   Thu, 23 Feb 2023 18:33:15 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/46] hugetlb: introduce HugeTLB high-granularity
 mapping
Message-ID: <Y/exa3cQSwGhw262@work-vm>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <Y/U7ngTyPlg2XCRj@monkey>
 <28a7208c-939c-19ea-1cf0-298444dffe85@redhat.com>
 <CAHS8izNPr+TfxLL_dBitKAgd11rPhjHx+10Nn96TD3HXzUSevQ@mail.gmail.com>
 <94a10407-ebcb-7090-ef92-2bbc9416d6fa@redhat.com>
 <CADrL8HVYBEJrn2BnXEzenTxmxgqCwg5EM+ow509TBCPQrDxsNQ@mail.gmail.com>
 <0a0b3032-a275-ddc9-697b-a8bc2344d3bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0b3032-a275-ddc9-697b-a8bc2344d3bc@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand (david@redhat.com) wrote:
> On 23.02.23 16:53, James Houghton wrote:
> > On Thu, Feb 23, 2023 at 1:07 AM David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > On 22.02.23 21:57, Mina Almasry wrote:
> > > > On Wed, Feb 22, 2023 at 7:49 AM David Hildenbrand <david@redhat.com> wrote:
> > > > > 
> > > > > On 21.02.23 22:46, Mike Kravetz wrote:
> > > > > > On 02/18/23 00:27, James Houghton wrote:
> > > > > > > This series introduces the concept of HugeTLB high-granularity mapping
> > > > > > > (HGM). This series teaches HugeTLB how to map HugeTLB pages at
> > > > > > > high-granularity, similar to how THPs can be PTE-mapped.
> > > > > > > 
> > > > > > > Support for HGM in this series is for MAP_SHARED VMAs on x86_64 only. Other
> > > > > > > architectures and (some) support for MAP_PRIVATE will come later.
> > > > > > > 
> > > > > > > This series is based on latest mm-unstable (ccd6a73daba9).
> > > > > > > 
> > > > > > > Notable changes with this series
> > > > > > > ================================
> > > > > > > 
> > > > > > >     - hugetlb_add_file_rmap / hugetlb_remove_rmap are added to handle
> > > > > > >       mapcounting for non-anon hugetlb.
> > > > > > >     - The mapcounting scheme uses subpages' mapcounts for high-granularity
> > > > > > >       mappings, but it does not use subpages_mapcount(). This scheme
> > > > > > >       prevents the HugeTLB VMEMMAP optimization from being used, so it
> > > > > > >       will be improved in a later series.
> > > > > > >     - page_add_file_rmap and page_remove_rmap are updated so they can be
> > > > > > >       used by hugetlb_add_file_rmap / hugetlb_remove_rmap.
> > > > > > >     - MADV_SPLIT has been added to enable the userspace API changes that
> > > > > > >       HGM allows for: high-granularity UFFDIO_CONTINUE (and maybe other
> > > > > > >       changes in the future). MADV_SPLIT does NOT force all the mappings to
> > > > > > >       be PAGE_SIZE.
> > > > > > >     - MADV_COLLAPSE is expanded to include HugeTLB mappings.
> > > > > > > 
> > > > > > > Old versions:
> > > > > > > v1: https://lore.kernel.org/linux-mm/20230105101844.1893104-1-jthoughton@google.com/
> > > > > > > RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
> > > > > > > RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
> > > > > > > 
> > > > > > > Changelog:
> > > > > > > v1 -> v2 (thanks Peter for all your suggestions!):
> > > > > > > - Changed mapcount to be more THP-like, and make HGM incompatible with
> > > > > > >      HVO.
> > > > > > > - HGM is now disabled by default to leave HVO enabled by default.
> > > > > > 
> > > > > > I understand the reasoning behind the move to THP-like mapcounting, and the
> > > > > > incompatibility with HVO.  However, I just got to patch 5 and realized either
> > > > > > HGM or HVO will need to be chosen at kernel build time.  That may not be an
> > > > > > issue for cloud providers or others building their own kernels for internal
> > > > > > use.  However, distro kernels will need to pick one option or the other.
> > > > > > Right now, my Fedora desktop has HVO enabled so it would likely not have
> > > > > > HGM enabled.  That is not a big deal for a desktop.
> > > > > > 
> > > > > > Just curious, do we have distro kernel users that want to use HGM?
> > > > > 
> > > > > Most certainly I would say :)
> > 
> > I'm not sure. Maybe distros want the hwpoison benefits HGM provides?
> > But that's not implemented in this series.
> 
> From what I can tell, HGM helps to improve live migration of VMs with
> gigantic pages. That sounds like a good reason why distros (that support
> virtualization) might want it independent of hwpoison changes.

Yes, in particular for postcopy migration of those VMs, where we can't
afford the latency of waiting for the entire gigantic page to bubble
along the network.

Dave

> -- 
> Thanks,
> 
> David / dhildenb
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

