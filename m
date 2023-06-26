Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137B273EF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjFZXUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFZXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:20:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C58FB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:20:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso3510509e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687821635; x=1690413635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsuDpkg4STj8VScLUF1v+q9KU/sRwZdf0lwfYtb4nAU=;
        b=C1YJv7l5E3ROxSNyp2Ma6wOHfw4IZG4XuKs7uygKnjuEeNdgXPdVAbHlgIu26QN7+d
         f/E6Klo+Jt15f+XgaseGnZbh5P4e4AskGzdAJPBVkNsec1Edy2+5r0YfY3FUHNs4I3Fx
         9hUvqUZYv6RZtVMZKo0YOyaUV7s+t5PwywAzl1+gfNqOyX4RVzhzuOExFRdEJyCryp7v
         DqFfxkYgVUzi4GcaPCfvmRH7HeGbxRarFUtHWbhupqIaPypod8XI3JzmwbkrApzMB3TJ
         dePdQY3aEed7GXqATYVhwFYTukwJoUt9sKREaaZr59XUMO0q4hJSRXALp4jE1X8Hbtg/
         1rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687821635; x=1690413635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsuDpkg4STj8VScLUF1v+q9KU/sRwZdf0lwfYtb4nAU=;
        b=CEusmrYnF04q1Hp8rLWu4rU5qSxXnFTwSSepjfGaWv8W6NIi8YN1C9rR8AKaxz7kz9
         ZL/JKUf1JVVmGu4qYoQBDaza/uZ/hW+Cv1CQTdAoB0oCpPdWo63vCNIuJhW3zN6yrb64
         m9w9iMbd2BdJo/u7bNWXyqTnaY52bIyPbpnJ6mAOe0dg5kQ7NNC8Eifeys2TRVhS0u+W
         9cUfDCYm5M7WNMzZ8IfXbqfHqqUV77VAk2pvpY5AwWPNQTAkF32DAJL9uR4OWeRDpd7B
         tWUGZ6f3P9vFmVFwNxLtyR2YuLeQhEbt63Y/VAW3VZwzRbxOPTFp2qwHbHsv+UZYMVLB
         FqBg==
X-Gm-Message-State: AC+VfDwSDgbKWJjtcWrMIGQGFG5WRxoIdA/T79O7D5Dy/3VSDfAiiZBA
        PFRv+bwAanJu4wpjBAAUoAeqWQUfmuy45fuEO+jEzA==
X-Google-Smtp-Source: ACHHUZ7ggykNDv4GNwR59J6Un/xdcCwEfTkyvP6dZPtd3LNrRL+OzpPAQH0aK5EpljAet7sMLGfDHuCLj8AS/0jchBg=
X-Received: by 2002:a05:6512:12c7:b0:4f9:72a5:2b72 with SMTP id
 p7-20020a05651212c700b004f972a52b72mr7112983lfg.22.1687821634913; Mon, 26 Jun
 2023 16:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230626-nature-seventh-6102e17bb4be@spud> <mhng-7656ce4f-bdcb-419c-8a77-18ab7d301cd7@palmer-ri-x1c9>
In-Reply-To: <mhng-7656ce4f-bdcb-419c-8a77-18ab7d301cd7@palmer-ri-x1c9>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 26 Jun 2023 16:19:58 -0700
Message-ID: <CALs-HstCEFJD0xC1Ro8bjTL-bu4ramiXk5LZRr8QNsW1OcUZFA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor@kernel.org>, aou@eecs.berkeley.edu,
        ajones@ventanamicro.com, apatel@ventanamicro.com,
        Conor Dooley <conor.dooley@microchip.com>,
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

On Mon, Jun 26, 2023 at 1:48=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Mon, 26 Jun 2023 13:34:24 PDT (-0700), Conor Dooley wrote:
> > On Mon, Jun 26, 2023 at 12:25:42PM -0700, Evan Green wrote:
> >> On Fri, Jun 23, 2023 at 5:12=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> >> > On Fri, Jun 23, 2023 at 03:23:53PM -0700, Evan Green wrote:
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
> >> > > extension info accurately per-hart in /proc/cpuinfo.
> >> >
> >> > No, you can't do this as it breaks the assumptions of userspace that
> >> > this shows the set supported across all harts.
> >> > Sorry, but NAK.
> >
> >> My hope was that we were still early enough that no production systems
> >> existed (yet) that actually had different ISA extensions in the set we
> >> track, and therefore usermode would have been unable to make those
> >> assumptions at this point. If such a system exists, and I don't know
> >> if it does or not, then I agree it's too late to make a change like
> >> this.
> >
> > You should put this information into your commit messages & not just
> > hope that people understand your intent.

Fair enough.

> > Userspace does actually make these assumptions already, see for example
> > this Google "cpu features" repo:
> > https://github.com/google/cpu_features/tree/main
> > To be quite honest, I really dislike the fragility of what they have
> > implemented - with only one of the reasons being they made the mistake
> > of assuming homogeneity.

> >
> > There's got to be a line somewhere for what constitutes buggy userspace
> > and what's a regression. Up to Palmer I suppose as to what constitutes
> > which.
>
> Maybe let's just add a pretty printed version of the hwprobe info to
> /proc/cpuinfo, and then leave the ISA string alone as a legacy
> interface?

I like it! I'll aim for that for v2. I'll resist the urge to name the
row isa_for_real.

>
> Having something so poorly defined as uABI is a bit embarassing, but
> it's our mistake so we've got to live with it.
>
> >> I thought I'd put this out here and see if someone could point at such
> >> a system; but if not it'd be great to keep /proc/cpuinfo accurate and
> >> consistent with hwprobe (which does return accurate per-hart ISA
> >> extension info).
> >
> > Just another nail in the coffin for a bad interface :)
> > There are apparently some mixed c906 chips that support vector on one
> > core and not the other - although it is thead vector which is not
> > supported upstream yet...
> >
> > Other than that, SiFive stuff technically can be mixed - rv64imac &
> > rv64imafdc on a bunch of the older stuff. I don't think anyone actually
> > runs those sort of configurations on them though.
