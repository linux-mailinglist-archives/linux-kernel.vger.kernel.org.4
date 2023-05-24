Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EE770F8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjEXOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjEXOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:39:57 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03D12F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:39:55 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba8cf3cb34fso1804140276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684939195; x=1687531195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5wvA3g9Brr3zmUG8t2NDe8/UIsllixPh2+k8+KTHWg=;
        b=GQVCESiLeRIpeEhLwtwghMZm6iN/BjTrPnGpir5QscG4fQ+E+mU5RnuSekUfHJJqFI
         jl/pzbE8rxCkIKRIdPqE/3obpsrNlAE9zBje6sMXK8Jb9WFfonsge6n1FdKOmKaad+Sm
         K9WHh982qh3mY1wsu9B4x+tPIFox9g7jENZV8ZpcOfxPu6SBCih4kY0TjjnO9vl5RBmZ
         wet3gSBz8UqiVm5bZ7ze7w/w/vqWgvtFCq4E0rTNBH/DmUTVBOT4jmEX0o5Taw2vSYf5
         HOey4wCKHPdPr/8jTM8JcEXf+Zepiq/Dp0U0pj2ymegdtkb0Q4iUek0klvHeQnBnXv07
         jq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684939195; x=1687531195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5wvA3g9Brr3zmUG8t2NDe8/UIsllixPh2+k8+KTHWg=;
        b=koGCRkNmIOZqNcWZ1oRK1NQFOixtXiDZCcjGFS9UMB3KrIrnbsKMHOPH1J865Tv5Dw
         FrKVFwMfHsKYzuq3Z3X7CNKyspTB8EhczMeS1TuJ/LtXR/tJ+D4/0dfuw+h6SLrYpPTf
         Dhonb6h9exdnMzaMVqYt7hRbgYqJOv8QL9PHbqtmUMqsifvnKJpJQrXLL0AlmA4FluLn
         oQtuSu5ZLVcxGyObxQWGPq09z+VR/0+uOVZ1/imGiIjLxQStENstnHtPl6/HftBFWUu4
         PLwyFzR1xIyYfYO+Lx8nYJYS3fq+49ZBubRN+s8/OBhXofelXHX0pLBQYhBESOLoOlLK
         FxMQ==
X-Gm-Message-State: AC+VfDwq711YfkhhtoywVckUXw8wXfXrpOJl2No70XfJbhb7tssiZ909
        sZpPGa4MCfSyx0qLHVh6c96fC1bWxONvt01hzVf/h7AQa4LVC4/MyNcv7w==
X-Google-Smtp-Source: ACHHUZ5bmET0UbIr/IbuHGU112rYOFzmEhGZW+1Xmmau/Dmz729pek9Z0NLnMYtvS1Elk8Twg2hATNa9GK9LheEvlyQ=
X-Received: by 2002:a25:a89:0:b0:b9e:64b7:3e75 with SMTP id
 131-20020a250a89000000b00b9e64b73e75mr124338ybk.0.1684939194893; Wed, 24 May
 2023 07:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230524131238.2791-1-jszhang@kernel.org> <ZG4QlvkkaoBlyoFC@xhacker>
In-Reply-To: <ZG4QlvkkaoBlyoFC@xhacker>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 24 May 2023 07:39:43 -0700
Message-ID: <CAJuCfpGuqa_2_7ae9EP9-5Z_C47_W2jR3B25qwbWMO+Tfxxw6A@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: pass original fault address to
 handle_mm_fault() in PER_VMA_LOCK block
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, May 24, 2023 at 6:38=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Wed, May 24, 2023 at 09:12:38PM +0800, Jisheng Zhang wrote:
> > When reading the arm64's PER_VMA_LOCK support code, I found a bit
> > difference between arm64 and other arch when calling handle_mm_fault()
> > during VMA lock-based page fault handling: the fault address is masked
> > before passing to handle_mm_fault(). This is also different from the
> > usage in mmap_lock-based handling. I think we need to pass the
> > original fault address to handle_mm_fault() as we did in
> > commit 84c5e23edecd ("arm64: mm: Pass original fault address to
> > handle_mm_fault()").

Thanks for noticing. I'm not sure why this masking leaked into my
patch. I don't think I wrote it before 84c5e23edecd was merged in June
2021.
Anyway, your assessment looks correct to me.

> >
> > If we go through the code path further, we can find that the "masked"
> > fault address can cause mismatched fault address between perf sw
> > major/minor page fault sw event and perf page fault sw event:
>
> OOPS, sorry please ignore this one. I pressed ctrl-c to interrupt the
> git send-mail, but it's still sent out ;)
>
> Instead, let's focus on
> https://lore.kernel.org/linux-arm-kernel/20230524131305.2808-1-jszhang@ke=
rnel.org/T/#u
>
> The two patches are the same, I just added Suren into CC list.
>
> >
> > do_page_fault
> >   perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, ..., addr)   // orig addr
> >   handle_mm_fault
> >     mm_account_fault
> >       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, ...) // masked addr
> >
> > Fixes: cd7f176aea5f ("arm64/mm: try VMA lock-based page fault handling =
first")
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> > ---
> >  arch/arm64/mm/fault.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index cb21ccd7940d..6045a5117ac1 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -600,8 +600,7 @@ static int __kprobes do_page_fault(unsigned long fa=
r, unsigned long esr,
> >               vma_end_read(vma);
> >               goto lock_mmap;
> >       }
> > -     fault =3D handle_mm_fault(vma, addr & PAGE_MASK,
> > -                             mm_flags | FAULT_FLAG_VMA_LOCK, regs);
> > +     fault =3D handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LO=
CK, regs);
> >       vma_end_read(vma);
> >
> >       if (!(fault & VM_FAULT_RETRY)) {
> > --
> > 2.40.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
