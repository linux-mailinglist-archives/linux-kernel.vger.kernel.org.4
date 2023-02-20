Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E9269C7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjBTJvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBTJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:51:05 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C3217162
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:51:01 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id z20so2417966vsp.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ubrSGGpo/lB1Nbx8tNcTbrObPXZHojbGZX+fWT2u70=;
        b=AlIFBSPCK/k3ooNjwrY3lEN2lm36QZxhwfzlGT3bvzW8aQz4IqFW7iJ3DySrB1UU3R
         hGKjfUpWjD4Mq1shhoT4OyOZrRIJAcqgzCJUrkRPx3ViLm6dzXSyIrSTtTyVY12ig6an
         DFu0ryJzx7wuiFcWiKQ+OcdPJIYmLnH7VNHAY0aJHF+cDgE7Jlj1JDHQ5sQ+IRVz7+CX
         5EwaYEnsOkHn4ipR/mVJCwcrf+hwMcfzu7BVYnOzNelFy/Zyz0CfOH0TSQk4FqlddsOP
         +fvjdjTLHl3LhxMm7zQkcNhsNmcASPhgg4eU8dDSxP9aUrFk7UedzqupicNRIZJ8AaIe
         MBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ubrSGGpo/lB1Nbx8tNcTbrObPXZHojbGZX+fWT2u70=;
        b=a9lJQ5ow36jTCg+JDskXX2uppbBVYzrUle5kCwdPmraqWaTmQ6GDngm51a0h8zFi1K
         Tzm/bj8Gd83jCTfEjiopQce4a/15+xDOFI+r/Z5KZBa1RsPMmru+3mkk7v70fERqLGg7
         Q458K4/93BaeiYX+kPdULCItqMN6k3mSFzfI+HSVaJvt1i8awCr4jeeX/agascitp3XV
         jpJ9E+R8QYssbLEHQUuHZ+jwnIHRuRzAnqBJYY4UI/MDUPCroi7zSnI4+GyNvy08zau3
         gLxfrxVMrXYyuoXn2RYdbKtP/Nm0ZdDA2xuKJ49KeaK/3wysAMiJ+vNwZ0nYju7R7gmb
         Tm4g==
X-Gm-Message-State: AO0yUKUwGFe3VF7k/QV4U/X9HgdKGXFYhnfZ5pfx/psyiPssoAd7h0l0
        JgZzVpU5Ml65iZxkTy/1NCLxREVeObeu+Q1QbhQDRq0oPWzYsQ==
X-Google-Smtp-Source: AK7set8Fjc384404hhcu1ncWe0+xFejdg760zKN5yMZ6v+4ljTHJn2PYDr/3cyvciFET+aE/LrM8fImcsdeLrAWw1kM=
X-Received: by 2002:a05:6102:a05:b0:412:1c0a:1cbe with SMTP id
 t5-20020a0561020a0500b004121c0a1cbemr476510vsa.58.1676886660624; Mon, 20 Feb
 2023 01:51:00 -0800 (PST)
MIME-Version: 1.0
References: <mhng-a886c4b4-d748-420f-889b-76ada4f9a432@palmer-ri-x1c9> <0a0d1a182cef674a8e70347b2ed6f67b@kernel.org>
In-Reply-To: <0a0d1a182cef674a8e70347b2ed6f67b@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 20 Feb 2023 15:20:47 +0530
Message-ID: <CAK9=C2UkeTRipSjhU6dNWjSOmpZu4S9QFpTE_ycpdZDy0EfJEQ@mail.gmail.com>
Subject: Re: [PATCH v16 0/9] RISC-V IPI Improvements
To:     Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        daniel.lezcano@linaro.org, marcan@marcan.st, sven@svenpeter.dev,
        alyssa@rosenzweig.io, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 2:05 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2023-02-15 03:17, Palmer Dabbelt wrote:
> > On Sun, 05 Feb 2023 03:04:14 PST (-0800), Marc Zyngier wrote:
> >> On Tue, 03 Jan 2023 14:12:12 +0000,
> >> Anup Patel <apatel@ventanamicro.com> wrote:
> >>>
> >>> This series aims to improve IPI support in Linux RISC-V in following
> >>> ways:
> >>>  1) Treat IPIs as normal per-CPU interrupts instead of having custom
> >>> RISC-V
> >>>     specific hooks. This also makes Linux RISC-V IPI support aligned
> >>> with
> >>>     other architectures.
> >>>  2) Remote TLB flushes and icache flushes should prefer local IPIs
> >>> instead
> >>>     of SBI calls whenever we have specialized hardware (such as
> >>> RISC-V AIA
> >>>     IMSIC and RISC-V SWI) which allows S-mode software to directly
> >>> inject
> >>>     IPIs without any assistance from M-mode runtime firmware.
> >>
> >> [...]
> >>
> >> I'm queuing patches 3 and 9 via the irqchip tree as they are
> >> standalone.
> >>
> >> For the rest, I need an Ack from the riscv maintainers as they change
> >> a large amount of arch-specific code, and the couple of irqchip
> >> patches depend on these changes.
> >>
> >> Palmer, Paul?
> >
> > I haven't gotten time to give this a proper review, but I think we've
> > got enough of a mess with our interrupt handling that it doesn't
> > really matter so
> >
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > if you want to take it for this cycle that's fine with me, but I'm
> > also fine holding off so it can have a while to bake in linux-next --
> > there's no real rush for any of this, as there's no hardware yet.
>
> Letting this sort of things simmering in -next is the way.
>
> Now that the basic dependencies are on their way, I'd expect this to be
> rebased on 6.3-rc1, and we can then put the whole thing in -next.

Okay, I will rebase on 6.3-rc1 whenever it is available.

Thanks,
Anup

>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
