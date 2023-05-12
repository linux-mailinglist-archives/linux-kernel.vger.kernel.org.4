Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CAD700A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbjELOma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjELOm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA11FEB;
        Fri, 12 May 2023 07:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0330C65746;
        Fri, 12 May 2023 14:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A31C433A4;
        Fri, 12 May 2023 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683902545;
        bh=Cq0Kbtx91XM0CWPBj4j6IY7NnGd/kSGer8Mrsg2uWeI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TFARr7Yju0/zYC3P03kjGthGO4LKrUPM6ZV2dy1VAbme1m7iah/Q2v/j+YdArMjC2
         IISKa5rqJe5QHiOpL+b1eQm3mm3PiZ9YkVaDKIDgwcEPNhOk5nodB0VrUQjSGwG44N
         9c1JnpacFGfWPXVIAT5UOsLC42ZCz3IiNgQbk1vtX1cuWb1QnxeWvf6UVCnRY+TQk2
         iX2Uo6MMgxgIUTbD4N1EKorWMs+I89a7xvcMNzbHLDjWqT4ZBw9aIvAM3kTxRvSbcf
         M2ZGMl5kWNNFADPOgaGGQ8v0eFuvVYWfb0ZgnF7esXrQmmMj1/bysLxSRacvaK7oO1
         NKVWaYw1e5ztw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f139de8cefso52620382e87.0;
        Fri, 12 May 2023 07:42:25 -0700 (PDT)
X-Gm-Message-State: AC+VfDxwY8UsslaU9jrWrQzimvkfEA9KdZKbr+T1uXi1lx8OlSoN7OZE
        zh20YKwYlZMhvfCqQqB5pYuNrRJubxdrUShExjY=
X-Google-Smtp-Source: ACHHUZ5EB+DWgV11PDIE1zsI8SLx4pz1jY2iF09/gzRcWg7Lu9DuSS4cTes2wcetJPmkVKvoac2pTbi5cjXcWlbxiso=
X-Received: by 2002:a05:6512:33d4:b0:4f0:3e1:9ada with SMTP id
 d20-20020a05651233d400b004f003e19adamr4151585lfg.31.1683902543268; Fri, 12
 May 2023 07:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230406040515.383238-1-jhubbard@nvidia.com> <CAMj1kXHxyntweiq76CdW=ov2_CkEQUbdPekGNDtFp7rBCJJE2w@mail.gmail.com>
 <a421b96a-ed4b-ae7d-2fe9-ed5f5f8deacf@nvidia.com> <CAMj1kXGtFyugzi9MZW=4_oVTy==eAF6283fwvX9fdZhO98ZA3g@mail.gmail.com>
 <8dd0e252-8d8b-a62d-8836-f9f26bc12bc7@nvidia.com> <90505ef2-9250-d791-e05d-dbcb7672e4c4@nvidia.com>
In-Reply-To: <90505ef2-9250-d791-e05d-dbcb7672e4c4@nvidia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 May 2023 16:42:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFZ=4hLL1w6iCV5O5uVoVLHAJbc0rr40j24ObenAjXe9w@mail.gmail.com>
Message-ID: <CAMj1kXFZ=4hLL1w6iCV5O5uVoVLHAJbc0rr40j24ObenAjXe9w@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: don't WARN when alloc/free-ing device private pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 04:48, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 4/10/23 00:39, John Hubbard wrote:
> >> pfn_to_page(x) for values 0xc00_0000 < x < 0x1000_0000 will produce a
> >> kernel VA that points outside the region set aside for the vmemmap.
> >> This region is currently unused, but that will likely change soon.
> >>
> >
> > I tentatively think I'm in this case right now. Because there is no wrap
> > around happening in my particular config, which is CONFIG_ARM64_VA_BITS
> > == 48, and PAGE_SIZE == 4KB and sizeof(struct page) == 64 (details
> > below).
> >
>
> Correction, actually it *is* wrapping around, and ending up as a bogus
> user space address, as you said it would when being above the range:
>
> page_to_pfn(0xffffffffaee00000):  0x0000000ffec38000
>

Interesting.

>
> > It occurs to me that ZONE_DEVICE and (within that category) device
> > private page support need only support rather large setups. On x86, it
> > requires 64-bit. And on arm64, from what I'm learning after a day or so
> > of looking around and comparing, I think we must require at least 48 bit
> > VA support. Otherwise there's just no room for things.
>
> I'm still not sure of how to make room, but working on it.
>

The assumption that only the linear map needs to be covered by struct
pages is rather fundamental to the arm64 mm code, as far as I am
aware.

Given that these device memory regions have no direct correspondence
with the linear map at all, couldn't we simply vmalloc() a range of
memory for struct pages for such a region and wire that up in the
existing code? That seems far more maintainable to me than
reorganizing the entire kernel VA space, and only for some choices for
the dimensions.
