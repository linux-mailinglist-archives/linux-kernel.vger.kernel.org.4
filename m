Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B1574BBD6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 06:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGHEqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHEqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:46:31 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE511FEA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:46:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4036bd4fff1so70841cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 21:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688791589; x=1691383589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyAMdvJktjgVZgqIlZO7YuMmEhUFKN2Y2cqBBOKqGiU=;
        b=N00yb2y9yM9yMJ/lJ+MIeALEu4ief3j70Iy2wzbccmSEshsLeJFXNGscVhBc1wqufP
         285RIu0byqu0sHgr1Dj/U0pcr5vyLipTY9pYyFzP4qWl/8eFLDqkKcRHLUeWepi1m9aJ
         8/a5kA8EXvpXzu5COj4KCTv86ShSD2w4641Yil5uKyqanCGg5mIZhSG3dycSp941GKZw
         kGncppV1z/kqlaJcwPctOCzfRsNWsMHeOFDiUMK2y4A7Odmx0xtvIz8DucxA0rWto9O7
         bwRRjM5D+Ki+uANjMJN0tjhZleM8IDjkYofxaPlfbkKJgxmaXW88yf2ZsSMyRmwcV2iC
         IXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688791589; x=1691383589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyAMdvJktjgVZgqIlZO7YuMmEhUFKN2Y2cqBBOKqGiU=;
        b=RrVsoPtwk+lbrvHVuyHaFmnlW2tI7VXamvwJrW/+FRR4moAylAvYyjtk4TfXr+JxQ7
         GqCQ6vv3VuyMtzeQF90rQ6/5IQPgAyFlI9w/SAJ7jsgLIp7nYhCvT/djV/+bAkCexQKl
         KOoTHZIXoe9KcaEeo4zJeUs0lVX+N/DYjUPuy/rCUNO2j+ZQYGmZwFXKISy88u5DM9Ty
         gTjussH3MFK92W0xvVbyShuKay51Mm93Oltsp2SWX28If6MZ38O9acyW2JNTEVkxhlQY
         hCvwYZtgzs7/BQZmKtOzJMd/bNX5UGjcWHWSPz+lzIIaCBhJU+6Iy0ybSC+ZsG6Gdflc
         FXGw==
X-Gm-Message-State: ABy/qLahF+POyY1Ls5QaQ3qnIA7xFkaX23pbPnfSlQoehe7k52tL3GYZ
        dcOlwkASSnu/tMdBYwlkzlpH3G4gR4qX3rEDaLbdUikwTVK22bUVcSGSUE0E
X-Google-Smtp-Source: APBJJlFoC6KdctcB2dk1Nls7g98ZI12r8YIz0zdzjvddb7lswh7FUNnBgCmR0ecN/b30tq+Wsmu+35xn0ifk+G/VzcA=
X-Received: by 2002:a05:622a:104b:b0:3f8:e0a:3e66 with SMTP id
 f11-20020a05622a104b00b003f80e0a3e66mr59202qte.3.1688791589388; Fri, 07 Jul
 2023 21:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
In-Reply-To: <20230707165221.4076590-1-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 7 Jul 2023 22:45:53 -0600
Message-ID: <CAOUHufY++PUYp3qcmX2rK5AQrgu9rPT3tYOpj=44BX4K67Znrw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
To:     Yin Fengwei <fengwei.yin@intel.com>
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

On Fri, Jul 7, 2023 at 10:52=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> Yu mentioned at [1] about the mlock() can't be applied to large folio.
>
> I leant the related code and here is my understanding:
> - For RLIMIT_MEMLOCK related, there is no problem. Becuase the
>   RLIMIT_MEMLOCK statistics is not related underneath page. That means
>   underneath page mlock or munlock doesn't impact the RLIMIT_MEMLOCK
>   statistics collection which is always correct.
>
> - For keeping the page in RAM, there is no problem either. At least,
>   during try_to_unmap_one(), once detect the VMA has VM_LOCKED bit
>   set in vm_flags, the folio will be kept whatever the folio is
>   mlocked or not.
>
> So the function of mlock for large folio works. But it's not optimized
> because the page reclaim needs scan these large folio and may split
> them.
>
> This series identified the large folio for mlock to two types:
>   - The large folio is in VM_LOCKED VMA range
>   - The large folio cross VM_LOCKED VMA boundary
>
> For the first type, we mlock large folio so page relcaim will skip it.
> For the second type, we don't mlock large folio. It's allowed to be
> picked by page reclaim and be split. So the pages not in VM_LOCKED VMA
> range are allowed to be reclaimed/released.

This is a sound design, which is also what I have in mind. I see the
rationales are being spelled out in this thread, and hopefully
everyone can be convinced.

> patch1 introduce API to check whether large folio is in VMA range.
> patch2 make page reclaim/mlock_vma_folio/munlock_vma_folio support
> large folio mlock/munlock.
> patch3 make mlock/munlock syscall support large folio.

Could you tidy up the last patch a little bit? E.g., Saying "mlock the
4K folio" is obviously not the best idea.

And if it's possible, make the loop just look like before, i.e.,

  if (!can_mlock_entire_folio())
    continue;
  if (vma->vm_flags & VM_LOCKED)
    mlock_folio_range();
  else
    munlock_folio_range();

Thanks.
