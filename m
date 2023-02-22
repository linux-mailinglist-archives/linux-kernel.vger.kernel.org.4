Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC53C69FE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjBVWJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:09:08 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E724497
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:09:06 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id o6so12004902vsq.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677103746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WciCA1CMzlFfl1f6xky7Jmeg52uHIibqpo9Byc9TkK8=;
        b=nHyJXMwNnmLIUbOuzaLEHwnKt6f83hoeDRc7ZSd/aDXVPU/gwtHrecaGBheAp8zhfs
         +NeItiyj616QfyNwuy9mAdkNs5GwwAzOzKoKuwd7KCPCkbtX9NPTiN5VLtYVHuLXs0w+
         1HMg1flCpGkPw4znLTOJllXoiqF66JvnLpjv4UX8SlW6nF33Lc+IHkadD4buuZeiYtmY
         Dvs00JvRsbwTKJIiImEs29b/eQs1TVR/vPmVKqPBdk1w4TGlYgBXQH39FpxUn15vI/i0
         8ybfc0oXk/Fo3YVvc27nehjdpdAvE5mOPTOyzY9iNNzMulK+TKN6J+TOJn5RAzBHMrqw
         w3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677103746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WciCA1CMzlFfl1f6xky7Jmeg52uHIibqpo9Byc9TkK8=;
        b=rkykPMPr67gw6ZLGdEEtv9KNLRKMkpBShS4ugLIAEDCSFLDV+5Nr4YyOTB0V/mpP8n
         /uNvH6Y1M3z/miq+I8sohMaKqLKI4I3R2TJGypUgsEeebudHuVzKrsy6UEDNj4UUruXi
         AghgbvKBQjdXpwgTpqczuNDF8VuLmRwRWa57exXb3TS8zNJlW1NU6ONRFQ/Q7vo2u5gH
         H1+W9/KlzRRG4iMA/yBz62kh8q+GXx6IWZsH9b2nl1WbOHqow1YFyf0wK0A8WbiuHOw5
         a6JNrMcNi2WOBBIWuHpEAqxar4+JwCeCNmoS0N71OZsz8KqVXIbAOH1MSOPEmT5yhsLn
         cGTg==
X-Gm-Message-State: AO0yUKWi1sYDrOlyl//42vFrFrmxI5+X0eB8BvPpA3AuzZVSrdwy3GZj
        i6jeNTBy9G7B1ilbH8EAcMumcZD7NlSMvIScZXU7PH7ZnK8CrbabmCc=
X-Google-Smtp-Source: AK7set//57QKVDR+2KQUp0fEEP3uwX7jwbgfPN3iBMELqlKF9+5hHrQixB7WG/+CXZMq4ejmyay89ntSdRaLyBYSxlI=
X-Received: by 2002:a05:6102:23f6:b0:3c8:6949:ea4c with SMTP id
 p22-20020a05610223f600b003c86949ea4cmr2259757vsc.76.1677103745760; Wed, 22
 Feb 2023 14:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20221208053649.540891-1-almasrymina@google.com> <20230124120913.GA26449@willie-the-truck>
In-Reply-To: <20230124120913.GA26449@willie-the-truck>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 22 Feb 2023 14:08:54 -0800
Message-ID: <CAHS8izNQjBcyV3RLY2uyiK5d8hZ=QbmGK_5iokiVwfGoiE-47Q@mail.gmail.com>
Subject: Re: [PATCH v1] arch: Enable function alignment for arm64
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Jan 24, 2023 at 4:09 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Dec 07, 2022 at 09:36:48PM -0800, Mina Almasry wrote:
> > We recently ran into a double-digit percentage hackbench regression
> > when backporting commit 12df140f0bdf ("mm,hugetlb: take hugetlb_lock
> > before decrementing h->resv_huge_pages") to an older kernel. This was
> > surprising since hackbench does use hugetlb pages at all and the
> > modified code is not invoked. After some debugging we found that the
> > regression can be fixed by back-porting commit d49a0626216b ("arch:
> > Introduce CONFIG_FUNCTION_ALIGNMENT") and enabling function alignment
> > for arm64. I suggest enabling it by default for arm64 if possible.
> >
> > Tested by examing function alignment on a compiled object file
> > before/after:
> >
> > After this patch:
> >
> > $ ~/is-aligned.sh mm/hugetlb.o 16
> > file=mm/hugetlb.o, alignment=16
> > total number of functions: 146
> > total number of unaligned: 0
> >
> > Before this patch:
> >
> > $ ~/is-aligned.sh mm/hugetlb.o 16
> > file=mm/hugetlb.o, alignment=16
> > total number of functions: 146
> > total number of unaligned: 94
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  arch/arm64/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index cf6d1cd8b6dc..bcc9e1578937 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -235,6 +235,7 @@ config ARM64
> >       select TRACE_IRQFLAGS_SUPPORT
> >       select TRACE_IRQFLAGS_NMI_SUPPORT
> >       select HAVE_SOFTIRQ_ON_OWN_STACK
> > +     select FUNCTION_ALIGNMENT_16B
> >       help
> >         ARM 64-bit (AArch64) Linux support.
>
> This increases the size of .text for a defconfig build by ~2%, so I think it
> would be nice to have some real numbers for the performance uplift. Are you
> able to elaborate beyond "double-digit percentage hackbench regression"?
>

(Sorry for the late reply)

The full story is already in the commit message. The only details I
omitted are the exact regression numbers we saw:

-16% on hackbench_process_pipes_234 (which should be `hackbench -pipe
234 process 1000`)
-23% on hackbench_process_sockets_234 (which should be `hackbnech 234
process 1000`)

Like the commit message says it doesn't make much sense that
cherry-picking 12df140f0bdf ("mm,hugetlb: take hugetlb_lock before
decrementing h->resv_huge_pages") to our kernel causes such a huge
regression, because hackbench doesn't use hugetlb at all.

> In general, however, I'm supportive of the patch (and it seems that x86
> does the same thing) so:
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Will
