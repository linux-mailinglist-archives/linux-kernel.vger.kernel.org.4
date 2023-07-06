Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02E74A589
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGFVJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGFVJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:09:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A16819A7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:09:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1791474e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688677758; x=1691269758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exHyMG/2/1kKC28Ybg6ScTLzo0giggAORojrlxybewA=;
        b=kF5Y63MhmJB8mZlZ/HqjRfBnqgfCMscqtLojzJmHuuOf8gzukAij0qpog+kOgu+QJA
         lHxzm50w2ETmE3Lm46H4qT2fd4lCxfJD0+4UVumzI2eM1E7hbnnics2tgvT+POevYODJ
         yVb4XiIsHfd3gRzQWnVL3Tg23LmFl9c1i32Y1mrM6Qo93rK7Zm/b8+bt2463pBCTyQU5
         AkWUGb2dG5rX0gJfZ4QhrzFJSRWFepBHBdheVGjn6Ty6FO+brd2gVVvD4M3WqS+LEoZ+
         V9Md47ULyKa6AkCwW08Dv9+5fShysec7Vmb4Ffh1Z440jN8WDM9TN3lmYr2OYyXrpLGH
         jLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688677758; x=1691269758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exHyMG/2/1kKC28Ybg6ScTLzo0giggAORojrlxybewA=;
        b=Ox3ph4N0BNkZ89XD8wphi0bphdXMSd76X+KpfQeGkX5DmZyzVIMUgc+4qUwwfkZ21h
         SsjT5LowuxzSaeoTqCrrvoH+ZNLyXqGZC0xrjihqGUzfGLcbM+C8cm5Aj+regDUTD9pB
         a+roXY7ve34BWaXo7iUjBfGhP92enzS+KAgqCCpEmZcxAL9yeVvt6f65aBIouHq/9/q4
         FwmOT7/XtEYaodtNLTa2aMQ0o/GBvm1h2mtHKKJCotOOTdQwxTGe4/XNNpHGu2EFnQA+
         lvEofcLZCHuBd8GZZ6epwEOoX1do5Igdfx6dBYmkZfOjTFeNuGkH+lVUSJhpGYRV7yGZ
         Lg1g==
X-Gm-Message-State: ABy/qLYwXtQLDGfAev08sZoUcbBZn/8EbV4EazGc0341kSe7mpC4GGyT
        0taK/M5IW4IaKGNieb8RIzWnBh/i+GCpt19DWoHGcA==
X-Google-Smtp-Source: APBJJlHN6ED9syl3kYb4BjqhjlPPjJ9Q/LFb+RIhZbT9cv4aGzNlq2nrtlMLrUdHOVizjADFCJf6RD8XGrGC6qRdc+I=
X-Received: by 2002:a19:790f:0:b0:4f9:b31b:db6 with SMTP id
 u15-20020a19790f000000b004f9b31b0db6mr2099061lfc.9.1688677758243; Thu, 06 Jul
 2023 14:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <CALs-Hssc6Uxf-6FKbye2n-CD0FWWE4xDmUWvN1NoKNFpn88SKg@mail.gmail.com>
 <mhng-ebe222a1-57eb-41cf-a541-38b4b5595ac0@palmer-ri-x1c9a>
In-Reply-To: <mhng-ebe222a1-57eb-41cf-a541-38b4b5595ac0@palmer-ri-x1c9a>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 6 Jul 2023 14:08:42 -0700
Message-ID: <CALs-HstZRd1KMBkrn5D6jRs2CsaXXhk-OON=z-2YgnY8Ny60XA@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        heiko.stuebner@vrull.eu, Paul Walmsley <paul.walmsley@sifive.com>,
        sunilvl@ventanamicro.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 12:45=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Thu, 06 Jul 2023 12:34:30 PDT (-0700), Evan Green wrote:
> > On Thu, Jul 6, 2023 at 3:53=E2=80=AFAM Conor Dooley <conor.dooley@micro=
chip.com> wrote:
> >>
> >> On Thu, Jul 06, 2023 at 10:01:31AM +0200, Andrew Jones wrote:
> >> > On Wed, Jul 05, 2023 at 10:29:31AM -0700, Evan Green wrote:
> >> > > In /proc/cpuinfo, most of the information we show for each process=
or is
> >> > > specific to that hart: marchid, mvendorid, mimpid, processor, hart=
,
> >> > > compatible, and the mmu size. But the ISA string gets filtered thr=
ough a
> >> > > lowest common denominator mask, so that if one CPU is missing an I=
SA
> >> > > extension, no CPUs will show it.
> >> > >
> >> > > Now that we track the ISA extensions for each hart, let's report I=
SA
> >> > > extension info accurately per-hart in /proc/cpuinfo. We cannot cha=
nge
> >> > > the "isa:" line, as usermode may be relying on that line to show o=
nly
> >> > > the common set of extensions supported across all harts. Add a new=
 "hart
> >> > > isa" line instead, which reports the true set of extensions for th=
at
> >> > > hart. This matches what is returned in riscv_hwprobe() when queryi=
ng a
> >> > > given hart.
> >> > >
> >> > > Signed-off-by: Evan Green <evan@rivosinc.com>
> >> > >
> >> > > ---
> >> > >
> >> > > Changes in v2:
> >> > >  - Added new "hart isa" line rather than altering behavior of exis=
ting
> >> > >    "isa" line (Conor, Palmer)
> >> > >
> >> > >
> >> > > I based this series on top of Conor's riscv-extensions-strings bra=
nch
> >> > > from July 3rd, since otherwise this change gets hopelessly entangl=
ed
> >> > > with that series.
> >> > >
> >> > > I was unsure if I could snuggle the new "hart isa" line in just be=
low
> >> > > "isa". Aesthetically it would be quite pleasing, but it runs the r=
isk of
> >> > > breaking brittle usermode parsers that are assuming a specific lin=
e
> >> > > order. So I put it at the end.
> >> >
> >> > Actually, they're probably only aesthetically pleasing when they mat=
ch. If
> >> > there are differences, then I'd guess having them side by side, almo=
st the
> >> > same, but different, would make them even harder to look at then the=
y
> >> > already are. So I think I'll be happier with them separated by a few=
 lines
> >> > anyway.
> >>
> >> This list is eventually going to be so big that I don't think doing
> >> by-eye anything is going to be useful, so aesthetics be damned.
> >> That said, a parser that relies on the order of individual lines like
> >> that might deserve to be broken ;)
> >>
> >> Anyway, change looks good to me:
> >> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> I was thinking the uabi doc might need an update - should we add to it
> >> that "isa" means the common set & "hart isa"?
> >
> > I did do a little search for documentation to update, but failed to
> > come up with any. Which doc are you thinking of?
>
> Should be somewhere like Documentation/arch/riscv/uabi.rst

Thanks, I'll spin this patch and add something here.
-Evan
