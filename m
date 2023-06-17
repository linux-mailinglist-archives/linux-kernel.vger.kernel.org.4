Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ED2733EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjFQG6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFQG6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82871FD3;
        Fri, 16 Jun 2023 23:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3686A60B29;
        Sat, 17 Jun 2023 06:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9588BC433C0;
        Sat, 17 Jun 2023 06:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686985126;
        bh=9S4P8JW7Aw6+2ZoVDniU5EdIBLc9OdiTvqw3YA9ECf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHkTyW+hctadrgmIg2I6LaptKR6YKkmtmdcOS/HSni9feQ5p1DZtCSX6Dnam1slU3
         FLDQnf/OEx1d4jSPxMmAwLEhSg3dDkigyXgxGzkX1VJc1UJnkk6n01fCEZ0qwx4ELP
         r6wbjQNoXnPg5HveUgv1zS7owOZuF5kej34YgRIGZdC2tH3sGX0H+MpQa784HSW6mk
         qjN9Au7ZhvMEPLupJ+gAv5/GudEwZVVlLyNGJFO9CDGv8qdQ0I+Zmw8CDlXcjxb8w/
         RZuOMQ5h8Q4Z/8VeTux+zm8PEK9dnLGg98fBUnC+4CbpTq0gKeC8d5BMUXJufl+4IU
         tPAEuFrGSOYnA==
Date:   Sat, 17 Jun 2023 09:57:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
Subject: Re: [PATCH v2 07/12] arm64, execmem: extend execmem_params for
 generated code definitions
Message-ID: <20230617065759.GT52412@kernel.org>
References: <20230616085038.4121892-1-rppt@kernel.org>
 <20230616085038.4121892-8-rppt@kernel.org>
 <CAPhsuW6BG2oVrGDOpCKyOEvU9fBOboYYhducv96KUBe276Mvng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6BG2oVrGDOpCKyOEvU9fBOboYYhducv96KUBe276Mvng@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:05:29PM -0700, Song Liu wrote:
> On Fri, Jun 16, 2023 at 1:52 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > The memory allocations for kprobes on arm64 can be placed anywhere in
> > vmalloc address space and currently this is implemented with an override
> > of alloc_insn_page() in arm64.
> >
> > Extend execmem_params with a range for generated code allocations and
> > make kprobes on arm64 use this extension rather than override
> > alloc_insn_page().
> >
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >  arch/arm64/kernel/module.c         |  9 +++++++++
> >  arch/arm64/kernel/probes/kprobes.c |  7 -------
> >  include/linux/execmem.h            | 11 +++++++++++
> >  mm/execmem.c                       | 14 +++++++++++++-
> >  4 files changed, 33 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> > index c3d999f3a3dd..52b09626bc0f 100644
> > --- a/arch/arm64/kernel/module.c
> > +++ b/arch/arm64/kernel/module.c
> > @@ -30,6 +30,13 @@ static struct execmem_params execmem_params = {
> >                         .alignment = MODULE_ALIGN,
> >                 },
> >         },
> > +       .jit = {
> > +               .text = {
> > +                       .start = VMALLOC_START,
> > +                       .end = VMALLOC_END,
> > +                       .alignment = 1,
> > +               },
> > +       },
> >  };
> 
> This is growing fast. :) We have 3 now: text, data, jit. And it will be
> 5 when we split data into rw data, ro data, ro after init data. I wonder
> whether we should still do some type enum here. But we can revisit
> this topic later.

I don't think we'd need 5. Four at most :)

I don't know yet what would be the best way to differentiate RW and RO
data, but ro_after_init surely won't need a new type. It either will be
allocated as RW and then the caller will have to set it RO after
initialization is done, or it will be allocated as RO and the caller will
have to do something like text_poke to update it.
 
> Other than that
> 
> Acked-by: Song Liu <song@kernel.org>

-- 
Sincerely yours,
Mike.
