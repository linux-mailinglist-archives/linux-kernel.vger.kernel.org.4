Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A70874BBE9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjGHFH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHFHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:07:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94176DB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:07:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-401f4408955so66591cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 22:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688792843; x=1691384843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJPlH2A20BSoetFXC9PO9H4/tK1DlbPvOLWrqMRgi10=;
        b=xgX7VPL6E3X1MrP5BwiYRc9lpmL8tLlTzes/fYEWclTcsY1pgzJO5ErzBo1/WMKzRu
         RQiZFINtT2y/mv7frd+20w+iO/3vz4zTITGSmSEgo4R9rMQncv3IEpAkRM7mAP1M46C3
         Yo1tTd/k7StBRguVqKHX8ZAkGF0cN+RpIRLEQO9TvFSzFExB29uS6XgQ73qCdft1l4M1
         Z0gYiZvTx5xWUuYlS906wAwVkIV3qj7imKcVa4w3Zzm4hoGeMgNzQgmmu0Y5nPateb0M
         aQEMVQVmbugeK2UyCUgtw57yY7/BDB9NudMSiFAPXoRW4G8RM2ncrrQPycbMP8b8qjof
         MTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688792843; x=1691384843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJPlH2A20BSoetFXC9PO9H4/tK1DlbPvOLWrqMRgi10=;
        b=I7KKpAmSiSj5w2cSP0Lu/qp1x3l3Sgp3G/qMQCP0f/j55E/Powumpbsr0uMrrVv0Z6
         szC2TMvRm0FfLRSErBhyoW5i6MfJOPMmy/++Sw3O6y5OT/+42J1TrIFvSb+E1+C5YrvH
         gJITssGr1R/z9PYHUDKC2Ec0M6j3C1XDY+hCrZr9LW5W9nVR4hNoskr+EV3cfYwCAbK+
         cSEDhbBurueWT8+PqJ8FAuLPwDYrXu2nSwVD3O6HYaAzHVQDaLvQPcWrKzRgteVgOZXl
         4XJ6ZDILNp9OPyKobEemPmjK+ToM6bbO52Ts8j4X5PZ2ZWvHRwUAUO5rqzitc7Qdabt7
         jxQg==
X-Gm-Message-State: ABy/qLZgXxT18ahvj7kjU9hcpF2u//iVqL4mZ94tWJSIM9XWA8n+Te4G
        8R7Clpt4HzskVt0PqI7BEBOz0t4Cy0QZVoe7wmX48Q==
X-Google-Smtp-Source: APBJJlF8nf3SbjZ1hMkNn21f0qlCb7shAuz8Pg3pN8HPmp7wDbYvhDFc1THp/0lGYG0+tRor5LDzYQUbn4R/8GqapFM=
X-Received: by 2002:a05:622a:104b:b0:3f8:e0a:3e66 with SMTP id
 f11-20020a05622a104b00b003f80e0a3e66mr60103qte.3.1688792843627; Fri, 07 Jul
 2023 22:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <CAOUHufY++PUYp3qcmX2rK5AQrgu9rPT3tYOpj=44BX4K67Znrw@mail.gmail.com> <ca1df2b0-3a36-2762-f20e-b4a235087c9d@intel.com>
In-Reply-To: <ca1df2b0-3a36-2762-f20e-b4a235087c9d@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 7 Jul 2023 23:06:47 -0600
Message-ID: <CAOUHufY0=EW65tD01mm6ha75XWjcc43aGVuSJ8AfPc+dDLH6ZA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 11:01=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 7/8/2023 12:45 PM, Yu Zhao wrote:
> > On Fri, Jul 7, 2023 at 10:52=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >> Yu mentioned at [1] about the mlock() can't be applied to large folio.
> >>
> >> I leant the related code and here is my understanding:
> >> - For RLIMIT_MEMLOCK related, there is no problem. Becuase the
> >>   RLIMIT_MEMLOCK statistics is not related underneath page. That means
> >>   underneath page mlock or munlock doesn't impact the RLIMIT_MEMLOCK
> >>   statistics collection which is always correct.
> >>
> >> - For keeping the page in RAM, there is no problem either. At least,
> >>   during try_to_unmap_one(), once detect the VMA has VM_LOCKED bit
> >>   set in vm_flags, the folio will be kept whatever the folio is
> >>   mlocked or not.
> >>
> >> So the function of mlock for large folio works. But it's not optimized
> >> because the page reclaim needs scan these large folio and may split
> >> them.
> >>
> >> This series identified the large folio for mlock to two types:
> >>   - The large folio is in VM_LOCKED VMA range
> >>   - The large folio cross VM_LOCKED VMA boundary
> >>
> >> For the first type, we mlock large folio so page relcaim will skip it.
> >> For the second type, we don't mlock large folio. It's allowed to be
> >> picked by page reclaim and be split. So the pages not in VM_LOCKED VMA
> >> range are allowed to be reclaimed/released.
> >
> > This is a sound design, which is also what I have in mind. I see the
> > rationales are being spelled out in this thread, and hopefully
> > everyone can be convinced.
> >
> >> patch1 introduce API to check whether large folio is in VMA range.
> >> patch2 make page reclaim/mlock_vma_folio/munlock_vma_folio support
> >> large folio mlock/munlock.
> >> patch3 make mlock/munlock syscall support large folio.
> >
> > Could you tidy up the last patch a little bit? E.g., Saying "mlock the
> > 4K folio" is obviously not the best idea.
> >
> > And if it's possible, make the loop just look like before, i.e.,
> >
> >   if (!can_mlock_entire_folio())
> >     continue;
> >   if (vma->vm_flags & VM_LOCKED)
> >     mlock_folio_range();
> >   else
> >     munlock_folio_range();
> This can make large folio mlocked() even user space call munlock()
> to the range. Considering following case:
>   1. mlock() 64K range and underneath 64K large folio is mlocked().
>   2. mprotect the first 32K range to different prot and triggers
>      VMA split.
>   3. munlock() 64K range. As 64K large folio doesn't in these two
>      new VMAs range, it will not be munlocked() and only can be
>      reclaimed after it's unmapped from two VMAs instead of after
>      the range is munlocked().

I understand. I'm asking to factor the code, not to change the logic.
