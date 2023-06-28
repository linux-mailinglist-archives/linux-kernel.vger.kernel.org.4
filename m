Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A63741719
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjF1RTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjF1RTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:19:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F26A198D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:19:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so627541fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687972750; x=1690564750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUxTuJ7SYMUJNED8HWvX+wC3nrWl1+CukmahGo2CNkE=;
        b=NTyTiinJA2JKXdptZuPF/uLO4E+gZLBMMsd44vKuq86yYbtMbahA1MMTIWOpwsRbOI
         t8vGVXIyi5WzGL0VlUGi7XpjFpTI7vwdMZc25MPp3y0LkTQvJ8PbE5lUhW3nzyFRHupZ
         Q+eLxPjtcptKDUpwggzWKUMr9W4QyLkhwpWMif20T6tie8MNuAS3+0N7nMAWWuLA4+vX
         5v6gEO8tGEUEzX2dh+pA/S60cR5j0MnDV8gm+l2+YcaAPydTzpQSQVQbQiHkQd1CG1+f
         j3ZMk41dj1anGiS4dl0yFhjp3XgceAhqPVddocGN7GfTl3Fr4duPYbcj0vaBezNWJwhT
         WPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972750; x=1690564750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUxTuJ7SYMUJNED8HWvX+wC3nrWl1+CukmahGo2CNkE=;
        b=k6+D1Q1hDkD0iNBJov3A9ZtI4MWsLt8/LNv84GEHbRxCxahrYyITk6RmBkQfJK8DeN
         OkenDkcTgGnYe6MkY+nBdKClQSTVjL6fco8d8N2tYoBWjvTAZapiEwBWzPm1/YmIP0YW
         bys875+C+5G++/NSl+BFlIxh2hjCWh9ayDW1pL+18o1NlMM8kwEHud4FZhEfHf3XXRRG
         fcFCLN1w/Wx+5sR3ZcjV6/t3bVm5bu5wQz+R1DmWSWABPbuHDTjmR37muFatvgvfBTlS
         nJtoqBme8EUdkBbEO4Z2PEEjJ8+BG/584LPcEuZapyz+SvWrNpN/02Xb5R3CJ5XN71HD
         +ICw==
X-Gm-Message-State: AC+VfDy/bHvCI8TIo220/zh50rYezO98V58IVCY7QIkPZkR9I588bZ5w
        8rDzvFGAGK/52MqFj7y0eSfoEKHN2xR4gCTqPhSysQ==
X-Google-Smtp-Source: ACHHUZ7iCGsA8a9YWEulaTcajXBjFoUhV2YqawFJYt9M7glCW5ic8AdFXSkpCVRPm5fMQrnvMkLoQrk/6Vs4qTFn1hc=
X-Received: by 2002:a19:e046:0:b0:4f9:24b6:6695 with SMTP id
 g6-20020a19e046000000b004f924b66695mr14518746lfj.29.1687972750417; Wed, 28
 Jun 2023 10:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230627143747.1599218-1-sameo@rivosinc.com> <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
 <20230627-debating-twelve-da2c1ed60948@spud> <ZJwE5wRVkoND3Z6P@vermeer> <20230628-unfeeling-tavern-edd4f58396fa@wendy>
In-Reply-To: <20230628-unfeeling-tavern-edd4f58396fa@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 28 Jun 2023 10:18:34 -0700
Message-ID: <CALs-HstZe+bw_fY--4FQXfFoA67tvMSaEjKhZ2pRstNT07xBxA@mail.gmail.com>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Samuel Ortiz <sameo@rivosinc.com>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
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

On Wed, Jun 28, 2023 at 4:10=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Wed, Jun 28, 2023 at 12:01:11PM +0200, Samuel Ortiz wrote:
> > On Tue, Jun 27, 2023 at 07:48:15PM +0100, Conor Dooley wrote:
> > > On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> > > > On Tue, Jun 27, 2023 at 7:38=E2=80=AFAM Samuel Ortiz <sameo@rivosin=
c.com> wrote:
>
> > > > It would be nice to consolidate the ones together that search for a
> > > > single string and set multiple bits, though I don't have any super
> > > > elegant ideas for how off the top of my head.
> > >
> > > I've got a refactor of this code in progress, dropping all of these
> > > copy-paste in place of a loop. It certainly looks more elegant than
> > > this, but it will fall over a bit for these "one string matches many
> > > extensions" cases. See here:
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20230626-thiev=
ing-jockstrap-d35d20b535c5@wendy/
> > > My immediate thought is to add another element to riscv_isa_ext_data,
> > > that contains "parent" extensions to check for. Should be fairly doab=
le,
> > > I'll whip something up on top of that...
> >
> > Nice, and thanks for the review.
>
> > Should I wait for your refactor to be merged before pushing this one?
>
> I don't know. I think that you should continue on with your series here,
> and whichever goes in second gets rebased on top of the other.
> I don't think it makes material difference to review of this patchset as
> to whether you rebase on top of what I'm working on, so I wouldn't
> bother until it gets merged.
>
> Rather hacky, had less time than expected this morning:
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Driscv-extensions-strings-supersets
> Clearly there's issues with looping to RISCV_ISA_MAX_SUPERSETS & I just
> repurposed Zicsr for the sake of testing something in the time I had.
>
> Evan, at a high level, does that look more elegant to you, or have I made
> things worse?
>

I see what you're going for at least. It's unfortunate that when
someone bumps up RISCV_ISA_MAX_SUPERSETS it squares the whole array.
Another way to go might be to define the elements in a separate array,
like:

unsigned int riscv_zks_exts[] =3D {
       RISCV_ISA_EXT_ZBKB,
       RISCV_ISA_EXT_ZBKC,
       ....
};

then the macro entry looks like:

SET_ISA_EXT_MAP_MULTI("zks", riscv_zks_exts),

where the SET_ISA_EXT_MAP_MULTI() could use ARRAY_SIZE() to stash both
the pointer to the array and the number of elements.

-Evan
