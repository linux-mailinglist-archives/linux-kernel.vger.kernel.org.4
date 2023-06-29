Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED347430E4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjF2XKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjF2XKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:10:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC930E6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:10:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso2020290e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688080247; x=1690672247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOurnaMZUdb/k4kFNvbu1tJhgntbSJLOIlDNG1veMtc=;
        b=fRvpjUyIzWosp4wJZ9+CgVdvvl+cSgO0d9f4px0w9swQ5qz9TN5Sp2CHyAOqco6PCi
         0G7/8pE+tDu+++XoUtR7P+tnfsdvo2tXbwpbpSBvCbH8jr8Hm7UG4HF5sWPbuVtNZapv
         XOUZe+6Rlw4RDGKfqaB7crYWWG9AeD8xxdm9MytaL9GB5XYSlwc8PW2h/pAOdQiGKKoH
         eAtdrLW60XDOWld398pHoNySi1Y1uuGOgcs01gF48qlXMNZy61zGiS7Rb5nf6ZzaxzBX
         f6PvRexNJupNK5jRs1nyf8d/DnlGh8HzQB1vTch2WCK7I5Y3rUHUQAU00j1U+rDx1WsY
         UgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688080247; x=1690672247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOurnaMZUdb/k4kFNvbu1tJhgntbSJLOIlDNG1veMtc=;
        b=j/ATDrdAix/WY0xXIV4QSSFf8QwRStP0BZuvLJLRTA5L31j0zKTck+/E/w/TRtj9Yu
         KqMwUg8Ds4N1a5PjuFF8R1AxR9UlSfkpNXn8og6SHqGXH822aMg0GjAHYHZJvRbcoa/E
         UwAmKH5dqIUYpL5RFh+G8tr4VCrt1Wk5jpaeJuvKW5wLFyg+L3TrzbJHsOnYn6iE+YWj
         FAlkocJmVcSoU5BbvPom891kpN6KNX3cOOb3xUKjppzCc8Wd5hfrwcPsTagpGVzWtTfP
         HEdNLLUl7lz4z3441Wde5YIcPkATNOPNB9PLVMHLwGt8vX6wIv+KHcV3f/XD3YdN8sxf
         6NMg==
X-Gm-Message-State: ABy/qLafuDVH94VCvMpPxptHrKP75pVoxctD/qoST1nVXSDeyH2SYcPL
        FCoGIFYjxOgA5L5vp3icVof0ILVYY8U7Hyi71Hzntg==
X-Google-Smtp-Source: APBJJlGjycSr7eiVtsYdR8UO8c7yL6rvjBfztXjuRS86wMWH1lovN1IhFs/b0VgwmKIxlYDpwEDhcHF13Dot6nWJINo=
X-Received: by 2002:a05:6512:348e:b0:4f8:6aa4:17ec with SMTP id
 v14-20020a056512348e00b004f86aa417ecmr771881lfr.43.1688080247044; Thu, 29 Jun
 2023 16:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230623222016.3742145-1-evan@rivosinc.com> <20230623222016.3742145-2-evan@rivosinc.com>
 <20230626-veneering-superglue-751719bd967c@wendy> <CALs-HsskE1-OkZxFzH9bM6bR9NBW5R4mh5AJScVtnvHbv+Pi6A@mail.gmail.com>
 <20230629-untaxed-tripping-6000bc8c1873@wendy>
In-Reply-To: <20230629-untaxed-tripping-6000bc8c1873@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 29 Jun 2023 16:10:11 -0700
Message-ID: <CALs-HstWNYD7HW3kNKjSHF9gd5+DB6ByH-Ay5xboh6dwBxv+-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Probe for unaligned access speed
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Yangyu Chen <cyy@cyyself.name>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 7:03=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Tue, Jun 27, 2023 at 12:11:25PM -0700, Evan Green wrote:
> > On Mon, Jun 26, 2023 at 7:15=E2=80=AFAM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > > > +void check_misaligned_access(int cpu)
> > > > +{
> > > > +     unsigned long j0, j1;
> > > > +     struct page *page;
> > > > +     void *dst;
> > > > +     void *src;
> > > > +     long word_copies =3D 0;
> > > > +     long byte_copies =3D 0;
> > > > +     long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> > >
> > > Is this not a change from current behaviour, that may actually lead t=
o
> > > incorrect reporting. Presently, only T-Head stuff sets a speed, so
> > > hwprobe falls back to UNKNOWN for everything else. With this, we will
> > > get slow set, for anything failing the test.
> > > Slow is defined as "Misaligned accesses are supported in hardware, bu=
t
> > > are slower than the cooresponding aligned accesses sequences (sic)", =
but
> > > you have no way of knowing, based on the test you are performing, whe=
ther
> > > the hardware supports it or if it is emulated by firmware.
> > > Perhaps that is not relevant to userspace, but wanted to know your
> > > thoughts.
> > >
> >
> > Hm, that's true. EMULATED was an easy one when we were planning to get
> > this info from the DT. It also might be an easy one in the future, if
> > we get an SBI call that allows the kernel to take over misaligned trap
> > handling. We'd then be able to do a misaligned access and see if our
> > trap handler got called.
> >
> > One option is to leave the value alone if we fail the FAST test
> > (rather than changing it from UNKNOWN to SLOW). This isn't great
> > though, as it effectively makes UNKNOWN synonymous with SLOW, but in a
> > way where usermode can't tell the difference between "I truly don't
> > know" and "I tried the fast test and it failed".
> >
> > The alternative, as it is now, may mislabel some emulated systems as
> > slow until the new SBI call shows up.
>
> Make that "mislabel some emulated systems forever", existing systems
> don't magically grow support for new extensions unfortunately.

Right.

>
> Realistically though, does it matter to userspace if it is slow because
> the hardware is slow, or if the emulation is slow, since there's not
> really a way for userspace to tell from the syscall by how much it is
> slower.
> It can probably guess that emulation is worse, given how crap the
> speed I see on mpfs is.
>
> I'd rather we did say slow, rather than people start to interpret
> UNKNOWN as slow.

I think I agree.

>
> > I'm not sure how bad this is in
> > practice. We could add a subsequent performance bar below which we
> > guess "emulated".
>
> Nah, I don't really think that that is required.
>
> > This probably matches what usermode will use that
> > value for anyway (a synonym for "very slow"), but it's basically the
> > same problem with reversed polarity (we mislabel some slow systems as
> > emulated). I'm open to suggestions!
>
> I think I just agreed with you, give or take. If it is fast, say fast.
> If it is slow, we say it is slow. If we know it is emulated, then we can
> report it being emulated. Is it too late to remove the "hardware" from
> the syscall documentation, IOW s/supported in hardware/supported/?
>
> Please actually describe the assumptions/subtleties in the commit
> message though, so that the rationale for stuff is in the history :)

Will do. I pondered an alternative of creating a "gray zone" where if
misaligned words and bytes come out close to each other (which I don't
expect them to), we leave the setting of UNKNOWN alone. But I'm not
sure this really solves anything, it just moves the "waffle point"
around, so I couldn't convince myself it was valuable.
-Evan
