Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7AB724B29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbjFFSWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbjFFSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:22:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA00F170A;
        Tue,  6 Jun 2023 11:22:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4586963696;
        Tue,  6 Jun 2023 18:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A236EC433A8;
        Tue,  6 Jun 2023 18:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686075733;
        bh=08bgDTu6K2r14VqmkEIMfCPJQ/ZZrnAx7Zh60inB9tQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PvVbLJcYr9sEPc4KvXnz7da5hnzjz64447Y1vyViBiCb+fl59qj0pvbLDlkg7Wuob
         rzrnBjSOFtiQecuq+LZ/SRRxmzgXLdbIbqyyYrcYGhY29RsiV56QlreCUSnVm+stVt
         UoVEGKhBSdT54YRh1gXdKSmvd62cZB1711kSzDIW8D76YUK3gBLlfz43UtqujOAa4M
         WNIOBkfcw2WKv0IUzEzdSsuoiqNT0iAk+aytnzF0p5Ex5Qs+2o2gd4vHHiQKTwquZM
         rFReB/rrpz7owlp/MdxR2Mp3uAIDm8MwdFNdtC8Gq4wlspi7VJYfgsGIf9GhxSZs3/
         0v9cbIwE3cmiA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so75710911fa.3;
        Tue, 06 Jun 2023 11:22:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDzCXm5+70Ovpz7W746cGaUigh8vo5Bs482Vva0c0k6BOaC8cWYw
        xXE/STitpg+B5AXPalqdCtTYAhMWQ+XDi+gPtfw=
X-Google-Smtp-Source: ACHHUZ5bLSr3tA3IB8xCjeC0rEYdnEDeq7vmc1y/QuS5oHjyhnnuqZDpSw2PwmODz4CMTnRxT8zG59Qp1zLSa+hdG70=
X-Received: by 2002:a2e:82d0:0:b0:2b0:297c:cbdf with SMTP id
 n16-20020a2e82d0000000b002b0297ccbdfmr1546782ljh.1.1686075731505; Tue, 06 Jun
 2023 11:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230601101257.530867-1-rppt@kernel.org> <ZHjDU/mxE+cugpLj@FVFF77S0Q05N.cambridge.arm.com>
 <ZHjgIH3aX9dCvVZc@moria.home.lan> <ZHm3zUUbwqlsZBBF@FVFF77S0Q05N>
 <20230605092040.GB3460@kernel.org> <ZH20XkD74prrdN4u@FVFF77S0Q05N>
In-Reply-To: <ZH20XkD74prrdN4u@FVFF77S0Q05N>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Jun 2023 11:21:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7ntn_HpVWdGK_hYVd3zsPEFToBNfmtt0m6K8SwfxJ66Q@mail.gmail.com>
Message-ID: <CAPhsuW7ntn_HpVWdGK_hYVd3zsPEFToBNfmtt0m6K8SwfxJ66Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] mm: jit/text allocator
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 3:09=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:

[...]

> > > > Can you give more detail on what parameters you need? If the only e=
xtra
> > > > parameter is just "does this allocation need to live close to kerne=
l
> > > > text", that's not that big of a deal.
> > >
> > > My thinking was that we at least need the start + end for each caller=
. That
> > > might be it, tbh.
> >
> > Do you mean that modules will have something like
> >
> >       jit_text_alloc(size, MODULES_START, MODULES_END);
> >
> > and kprobes will have
> >
> >       jit_text_alloc(size, KPROBES_START, KPROBES_END);
> > ?
>
> Yes.

How about we start with two APIs:
     jit_text_alloc(size);
     jit_text_alloc_range(size, start, end);

AFAICT, arm64 is the only arch that requires the latter API. And TBH, I am
not quite convinced it is needed.

>
> > It sill can be achieved with a single jit_alloc_arch_params(), just by
> > adding enum jit_type parameter to jit_text_alloc().
>
> That feels backwards to me; it centralizes a bunch of information about
> distinct users to be able to shove that into a static array, when the cal=
lsites
> can pass that information.

I think we only two type of users: module and everything else (ftrace, kpro=
be,
bpf stuff). The key differences are:

  1. module uses text and data; while everything else only uses text.
  2. module code is generated by the compiler, and thus has stronger
  requirements in address ranges; everything else are generated via some
  JIT or manual written assembly, so they are more flexible with address
  ranges (in JIT, we can avoid using instructions that requires a specific
  address range).

The next question is, can we have the two types of users share the same
address ranges? If not, we can reserve the preferred range for modules,
and let everything else use the other range. I don't see reasons to further
separate users in the "everything else" group.

>
> What's *actually* common after separating out the ranges? Is it just the
> permissions?

I believe permission is the key, as we need the hardware to enforce
permission.

>
> If we want this to be able to share allocations and so on, why can't we d=
o this
> like a kmem_cache, and have the callsite pass a pointer to the allocator =
data?
> That would make it easy for callsites to share an allocator or use a dist=
inct
> one.

Sharing among different call sites will give us more benefit (in TLB
misses rate,
etc.). For example, a 2MB page may host text of two kernel modules, 4 kprob=
es,
6 ftrace trampolines, and 10 BPF programs. All of these only require one en=
try
in the iTLB.

Thanks,
Song
