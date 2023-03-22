Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006E26C5843
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjCVU5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCVU5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:57:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247551D93D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:57:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso24827091pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679518661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SWUgefOoTtNi3gmeeAtf1bvYzy9AkdsHRyOlhL+jM08=;
        b=Yhd1yrx0b4txAe0mKga9eIzMZjv6Ac0IA742m2F2UwJmtSwssQ3wEyuVYlfzIlL6ZB
         DmXCGMM4V9rHlco2Sis4m8J93/i7uzCuvWG2gj41DFWk+46Qs7LX11fjdNptN/KWSAJ8
         SSNX5DpHUMNjAaGRueMHyYPx+yLDMMXxFZCnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679518661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWUgefOoTtNi3gmeeAtf1bvYzy9AkdsHRyOlhL+jM08=;
        b=5Vj+db9jt7pvEt/YbZ0sJ7fUxFkRLTQaW4xmoEzKJq2f1B0RRO6CUBdgiWYrEinaZt
         Mk2v8FN0szUgQyXBFCG4+FJlMyM+fvdGXfG+wRLl3zgwZbk/z0fuBz5hdhhunJJhF5FB
         GJirt9hk6Ny632G5uoD/5Qw9ZF9l/SXNgtiNZI/sTi/ZsC13JTnywZbWMIrvn/lVXvA9
         uBiTwhc3iW5Ra/egrfNSkr0cGBmAD2DRu+5vkM+qRZ4XLyyOy1sUjT9Ssw6Hww5CjkUg
         PUj61QXhyxVWhBDRISkehq8xOGNuu+zQK9XFCSToNZwGRn/cIf0iCLGOciFUPggZBfNR
         VdXg==
X-Gm-Message-State: AO0yUKW/zuVE6qWflSMerrPRkAuDRk/k7Mny74yJ2wI6FPgOrQNoO1Pv
        r54TCo1pD+r/69fUoWJnuvj8FCALb9VY22EdnhLIIQ==
X-Google-Smtp-Source: AK7set/+VV0Eakc8XBoKcP/+l0juMrjnNEidhV0mgYmowFTuv9g0OL1j6Ib79H85UPIs4H/DvuhQig==
X-Received: by 2002:a17:903:1210:b0:19d:1bd6:4b84 with SMTP id l16-20020a170903121000b0019d1bd64b84mr3393265plh.17.1679518661365;
        Wed, 22 Mar 2023 13:57:41 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902b61100b001a1a82fc6d3sm10704906pls.268.2023.03.22.13.57.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 13:57:40 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id ja10so20429686plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:57:40 -0700 (PDT)
X-Received: by 2002:a17:90a:5ac7:b0:23b:3d0b:f162 with SMTP id
 n65-20020a17090a5ac700b0023b3d0bf162mr1549778pji.7.1679518659894; Wed, 22 Mar
 2023 13:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org> <20230322204217.GA3076000@google.com>
In-Reply-To: <20230322204217.GA3076000@google.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Mar 2023 21:57:28 +0100
X-Gmail-Original-Message-ID: <CANiDSCvTMmqGxQSYcs+p7v6y-aoE0HSZLuKkHWQA1O-dpkKxqQ@mail.gmail.com>
Message-ID: <CANiDSCvTMmqGxQSYcs+p7v6y-aoE0HSZLuKkHWQA1O-dpkKxqQ@mail.gmail.com>
Subject: Re: [PATCH v3] kexec: Support purgatories with .text.hot sections
To:     Ross Zwisler <zwisler@google.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Ross

Thanks for your review.

I think we should backport this one, in case people use old kernels
with new compilers.
If there is a v4 i will resend it with your tag and the stable tag.

Thanks!

On Wed, 22 Mar 2023 at 21:42, Ross Zwisler <zwisler@google.com> wrote:
>
> On Wed, Mar 22, 2023 at 08:09:21PM +0100, Ricardo Ribalda wrote:
> > Clang16 links the purgatory text in two sections:
> >
> >   [ 1] .text             PROGBITS         0000000000000000  00000040
> >        00000000000011a1  0000000000000000  AX       0     0     16
> >   [ 2] .rela.text        RELA             0000000000000000  00003498
> >        0000000000000648  0000000000000018   I      24     1     8
> >   ...
> >   [17] .text.hot.        PROGBITS         0000000000000000  00003220
> >        000000000000020b  0000000000000000  AX       0     0     1
> >   [18] .rela.text.hot.   RELA             0000000000000000  00004428
> >        0000000000000078  0000000000000018   I      24    17     8
> >
> > And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> > area pointed by `e_entry`.
> >
> > This causes that image->start is calculated twice, once for .text and
> > another time for .text.hot. The second calculation leaves image->start
> > in a random location.
> >
> > Because of this, the system crashes inmediatly after:
> >
> > kexec_core: Starting new kernel
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Reviewed-by: Ross Zwisler <zwisler@google.com>

Cc: stable@vger.kernel.org
>
> > ---
> > kexec: Fix kexec_file_load for llvm16
> >
> > When upreving llvm I realised that kexec stopped working on my test
> > platform. This patch fixes it.
> >
> > To: Eric Biederman <ebiederm@xmission.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > Cc: kexec@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > Changes in v3:
> > - Fix initial value. Thanks Ross!
> > - Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org
> >
> > Changes in v2:
> > - Fix if condition. Thanks Steven!.
> > - Update Philipp email. Thanks Baoquan.
> > - Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
> > ---
> >  kernel/kexec_file.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f1a0e4e3fb5c..25a37d8f113a 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >               }
> >
> >               offset = ALIGN(offset, align);
> > +
> > +             /*
> > +              * Check if the segment contains the entry point, if so,
> > +              * calculate the value of image->start based on it.
> > +              * If the compiler has produced more than one .text sections
> > +              * (Eg: .text.hot), they are generally after the main .text
> > +              * section, and they shall not be used to calculate
> > +              * image->start. So do not re-calculate image->start if it
> > +              * is not set to the initial value.
> > +              */
> >               if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> >                   pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> >                   pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > -                                      + sechdrs[i].sh_size)) {
> > +                                      + sechdrs[i].sh_size) &&
> > +                 kbuf->image->start == pi->ehdr->e_entry) {
> >                       kbuf->image->start -= sechdrs[i].sh_addr;
> >                       kbuf->image->start += kbuf->mem + offset;
> >               }
> >
> > ---
> > base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> > change-id: 20230321-kexec_clang16-4510c23d129c
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>



-- 
Ricardo Ribalda
