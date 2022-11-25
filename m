Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC51638497
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKYHls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKYHlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:41:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0A02790B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669362042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=omzOAQuOPD821XyVl59RQ4e2xtcxIZdVZNTB92ld58s=;
        b=ZWx/5TWiiTcm/ATuA++zs50PphdeywxcWxzRXF2Jh7W0wt3m7HE+ldnmZLPpTdvrGB+Pw5
        NmXcCQYz9F2PdmvRwihmeVsxzScRkfnQ5RBv3NalzQuythQgbca12Z28qpZP+0rQZx/I4U
        OW5HTOzMM7mKuJ0IHBeNxt0dJSvlfaU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-pi9AoZOlOYeVHQvBQ1AYaw-1; Fri, 25 Nov 2022 02:40:41 -0500
X-MC-Unique: pi9AoZOlOYeVHQvBQ1AYaw-1
Received: by mail-ej1-f69.google.com with SMTP id hp16-20020a1709073e1000b007adf5a83df7so1881628ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omzOAQuOPD821XyVl59RQ4e2xtcxIZdVZNTB92ld58s=;
        b=ht4jpjqwbxyaSLgkrfcA657lDakCNbgJGjZzkq6lYr+AVVHKWQ5kzhhGExcsWQYag1
         eKhUAOWSmDfj5oaPjHiovvzGlaoE0yALybSxJ05RHzcZ2uKQFMdFLZAmFFsIbm3wCbcN
         NC2/GYnevf7XHLutfyS1sDubOfin/iH7PiHvpB8gKdueR7A6ErKCuVE1VvQOfOxOleJA
         y+c5sOQGkX6clrhs+0rCCLiomjPP/9CHOrE/URWgdVrf2tc6fC+1WfPPz/uIiJQpXBr4
         9TGwJx1n1b3wm8UJyGMfunCmAB+EdzLJt2RuM71bwUNM7P5/ftSBBeyhohddmnptkNls
         DF9w==
X-Gm-Message-State: ANoB5pniY79Gds7425goocwt16fmXJZjwsrnNwHgigyC2JpzxSWQ0OJF
        evOZ9jJY60nlK3nifj/xFlHVeS6wIUX/Ask6v7f78GXRN4dp1RprelTnv3WEkW4KX1yCE8Qp7vd
        3zfG1asQwxT2ehYoyxwr2WafxJFRPP5W/kDenguOl
X-Received: by 2002:a17:906:684a:b0:7bc:73e6:b2c3 with SMTP id a10-20020a170906684a00b007bc73e6b2c3mr1534470ejs.451.1669362040511;
        Thu, 24 Nov 2022 23:40:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4p+DPVWOPmqc6ICeZN0JH2//EVrObfeM7Ie7k/w1ZHJstjzMHFQRDba/oYFFIvOrSRLaf33MvfHD5tkmM8wVc=
X-Received: by 2002:a17:906:684a:b0:7bc:73e6:b2c3 with SMTP id
 a10-20020a170906684a00b007bc73e6b2c3mr1534452ejs.451.1669362040223; Thu, 24
 Nov 2022 23:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20221124095523.31061-1-gshan@redhat.com> <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
 <22407f18-0406-6ede-ef1e-592f03d3699e@redhat.com> <31bda0ab-a185-340d-b96b-b1cfed7c3910@redhat.com>
 <da854e1c-c876-b2f3-a2cb-56664da541bf@redhat.com> <759a17cf-e234-2601-bf42-7a40a4d89466@redhat.com>
 <31947f33-cd9e-adbb-2dcc-106a464438df@redhat.com>
In-Reply-To: <31947f33-cd9e-adbb-2dcc-106a464438df@redhat.com>
From:   Zhenyu Zhang <zhenyzha@redhat.com>
Date:   Fri, 25 Nov 2022 15:40:03 +0800
Message-ID: <CAJFLiBJQBaXkdr+siDhQVRTze88SSfb-nSp_+5cBXAtqjKzdqQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: migrate: Fix THP's mapcount on isolation
To:     Guowen Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, ziy@nvidia.com,
        kirill.shutemov@linux.intel.com, apopple@nvidia.com,
        hughd@google.com, willy@infradead.org, shan.gavin@gmail.com,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the patch applied, I'm unable to hit memory hot-remove failure in
the environment where the issue was initially found.

Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>

On Thu, Nov 24, 2022 at 10:09 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 24.11.22 14:22, David Hildenbrand wrote:
> > On 24.11.22 13:55, Gavin Shan wrote:
> >> On 11/24/22 6:43 PM, David Hildenbrand wrote:
> >>> On 24.11.22 11:21, Gavin Shan wrote:
> >>>> On 11/24/22 6:09 PM, David Hildenbrand wrote:
> >>>>> On 24.11.22 10:55, Gavin Shan wrote:
> >>>>>> The issue is reported when removing memory through virtio_mem device.
> >>>>>> The transparent huge page, experienced copy-on-write fault, is wrongly
> >>>>>> regarded as pinned. The transparent huge page is escaped from being
> >>>>>> isolated in isolate_migratepages_block(). The transparent huge page
> >>>>>> can't be migrated and the corresponding memory block can't be put
> >>>>>> into offline state.
> >>>>>>
> >>>>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
> >>>>>> the transparent huge page can be isolated and migrated, and the memory
> >>>>>> block can be put into offline state. Besides, The page's refcount is
> >>>>>> increased a bit earlier to avoid the page is released when the check
> >>>>>> is executed.
> >>>>>
> >>>>> Did you look into handling pages that are in the swapcache case as well?
> >>>>>
> >>>>> See is_refcount_suitable() in mm/khugepaged.c.
> >>>>>
> >>>>> Should be easy to reproduce, let me know if you need inspiration.
> >>>>>
> >>>>
> >>>> Nope, I didn't look into the case. Please elaborate the details so that
> >>>> I can reproduce it firstly.
> >>>
> >>>
> >>> A simple reproducer would be (on a system with ordinary swap (not zram))
> >>>
> >>> 1) mmap a region (MAP_ANON|MAP_PRIVATE) that can hold a THP
> >>>
> >>> 2) Enable THP for that region (MADV_HUGEPAGE)
> >>>
> >>> 3) Populate a THP (e.g., write access)
> >>>
> >>> 4) PTE-map the THP, for example, using MADV_FREE on the last subpage
> >>>
> >>> 5) Trigger swapout of the THP, for example, using MADV_PAGEOUT
> >>>
> >>> 6) Read-access to some subpages to fault them in from the swapcache
> >>>
> >>>
> >>> Now you'd have a THP, which
> >>>
> >>> 1) Is partially PTE-mapped into the page table
> >>> 2) Is in the swapcache (each subpage should have one reference from the swapache)
> >>>
> >>>
> >>> Now we could test, if alloc_contig_range() will still succeed (e.g., using virtio-mem).
> >>>
> >>
> >> Thanks for the details. Step (4) and (5) can be actually combined. To swap part of
> >> the THP (e.g. one sub-page) will force the THP to be split.
> >>
> >> I followed your steps in the attached program, there is no issue to do memory hot-remove
> >> through virtio-mem with or without this patch.
> >
> > Interesting. But I don't really see how we could pass this check with a
> > page that's in the swapcache, maybe I'm missing something else.
> >
> > I'll try to see if I can reproduce it.
> >
>
> After some unsuccessful attempts and many head-scratches, I realized
> that it's quite simple why we don't have to worry about swapcache pages
> here:
>
> page_mapping() is != NULL for pages in the swapcache: folio_mapping()
> makes this rather obvious:
>
> if (unlikely(folio_test_swapcache(folio))
>         return swap_address_space(folio_swap_entry(folio));
>
>
> I think the get_page_unless_zero() might also be a fix for the
> page_mapping() call, smells like something could blow up on concurrent
> page freeing. (what about concurrent removal from the swapcache? nobody
> knows :) )
>
>
> Thanks Gavin!
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
>
> --
> Thanks,
>
> David / dhildenb
>

