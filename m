Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF6773405E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjFQKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:47:23 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD81E5D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 03:47:22 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-570808d8ddeso11500297b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686998842; x=1689590842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+r2JfUv+ZO+RszpI5dllFAqEGRPOcKiZhlZFdKx9JKs=;
        b=fnbIkgvH67XT9/L1sjb9LyxAsiBuHyLM7LsvhIqDUzPsJhPkcFLykPHLlGUDjBLQbi
         CzlLKaIpPzcTGslpjepmV/2RsVJwF1FxB6hpjIAWKUiySTTfWVkcO2OA0/wNsJPD3p5K
         7vGI/yQ5IuViqzdPu+lbxaKGfOIRFrttF7hkied38UAw4QgSiNm7Zep/02x2mvw29Ick
         385LoY8Z3glwiA8kYeJPYXpyJv0ez1HAF5NefP3SSowPRmGYY3lnBCNM85vl+nsKmV+s
         hi8/n+1gSFipMIaqwK5X1tZo4Qq9E7UWhMGs7FE/P1pNDJW2oMGTezb3Ggkf/USuP+gN
         SfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686998842; x=1689590842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+r2JfUv+ZO+RszpI5dllFAqEGRPOcKiZhlZFdKx9JKs=;
        b=jGAFWjJA83VMlFO+a/6jkOJoc0jpmoc7LrDXQB91lo8vBLipgSrLDFYdI3hRd+fDBa
         AWPFZwiJJlfuO9OQlJAiZGJo8IxzzB8Ibcn46J+94b2Oe3w/+Z+OFhzB/iw6AsgYuJjO
         gXa4VBpTNKfDRmjwU+VByG0G1HgTKzYi26oEzHa1RnQyU5J7bX3EUd0xWdUUFDwcbvsS
         Yg2/34Ybm4aiJ/UIlrYN2ydQ9P7nXUrVGwVD9iK8yAYrGDxIyLlA03a9AgBMKq/ijQW/
         H+mWxBj6eUVO1aui/FrWci+PYjiXm80CyrtrxNv+Sy4vHnYfrOy/tkmO8SxQPa3WAN6B
         /l6g==
X-Gm-Message-State: AC+VfDwxJbFyI6LQQJ1fNAjmew4U8xxv7COYufHI2ewTXPTaLv2c0PKK
        za8DkGCOLqmi1W75fUaLBSWIgiZUpTKE76Tiw6tiO4KTQm4wug==
X-Google-Smtp-Source: ACHHUZ5O7s7g8wgj2ugKf8ZyQ/eXclIexDlO/3h9hidaw/UelmVEUU17WcKreRpwZEznYsRhwdYon5s/qTYYGrbGOFM=
X-Received: by 2002:a81:bf52:0:b0:570:17e5:e536 with SMTP id
 s18-20020a81bf52000000b0057017e5e536mr5047541ywk.36.1686998842094; Sat, 17
 Jun 2023 03:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230615142016.419570-1-zhiguangni01@gmail.com> <20230615170011.GK52412@kernel.org>
In-Reply-To: <20230615170011.GK52412@kernel.org>
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Sat, 17 Jun 2023 18:47:11 +0800
Message-ID: <CACZJ9cVxqeDooeAMi8HBFmeo_85E+NuMYbW9PCvp7Rm-wunOGg@mail.gmail.com>
Subject: Re: [PATCH] x86,NUMA:Get the number of ram pages directly in numa_meminfo_cover_memory()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 16 Jun 2023 at 01:00, Mike Rapoport <rppt@kernel.org> wrote:
>
> Hi,
>
> On Fri, Jun 16, 2023 at 12:20:16AM +1000, Liam Ni wrote:
> > In a previous implementation,The ram page is calculated
> > by counting the number of holes,
> > however,the number of ram pages is calculated during hole calculation.
> > Therefore,we can directly calculate the amount of ram pages.
> >
> > Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> > ---
> >  arch/x86/mm/numa.c |  4 ++--
> >  include/linux/mm.h |  4 ++++
> >  mm/mm_init.c       | 33 +++++++++++++++++++++++++++++++++
> >  3 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 2aadb2019b4f..8ea0e956e3d7 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -461,12 +461,12 @@ static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> >               u64 s = mi->blk[i].start >> PAGE_SHIFT;
> >               u64 e = mi->blk[i].end >> PAGE_SHIFT;
> >               numaram += e - s;
> > -             numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> > +             numaram += __available_pages_in_range(mi->blk[i].nid, s, e);
>
> This is wrong. You add number of pages in range core MM sees to the number
> of pages covered by the numa_meminfo.
>
> More generally, rather than traverse all the numa_meminfo's and for each of
> them traverse all the regions in memblock.memory it's enough to count
> memory in memblock that doesn't have the node assigned and compare it to
> memblock_phys_mem_size().

Logic like below?
static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
{
   u64 error_value;
   error_value = pages_without_nid_in_range(0,max_pfn);
    if ((error_value ) >= (1 << (20 - PAGE_SHIFT))) {
        //print error information
        return false;
     }
     return true;
}

I can't figure out why compare it with memblock_phys_mem_size().
The number of pages in memblock that doesn't have the node
assigned,which also means that these pages are not in numa_info.
So these pages can represent the number of lose pages.

Thanks
Liam Ni
