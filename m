Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8C6046FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiJSNZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiJSNZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C1152035
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F1860B88
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E03C433D6;
        Wed, 19 Oct 2022 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666185070;
        bh=wY1M4RkPxwgRgjYuzUK2ZTBXoD9/bIiPor4ikkDS9K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cc2gVFT+bbsm/hjhbo63RI4Q97w5HISjEMDg1F1wGD0JqNeKSpajr0PR2+d6sqOlB
         InKbG5krytIlt98zeDYQCEMrOx1MbEG1heA3WiaiTRdSnKpkU5f0nPIYNuDUZk5M+r
         uGDekJCYfnGda1Z9yq+5qLOvGbVFec8Bn+6nXljE2gmpsT2spwJo3vgECfjRxkERFS
         Um63BWHI3XZm+xp+0de5g2HgUYbFktmPFCcdWRlKpiwyIfTq0AztzyF+t7jDoeUIat
         zvAP+6Jle1C1OHIg6GR+4NtI3l0IrMBzaIW5a33hFFCOkYhHpShcUA1LkZJ0LMNYXV
         BTjVThuiLYziQ==
Date:   Wed, 19 Oct 2022 21:01:32 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 4/4] riscv: entry: consolidate general regs saving
 into save_gp
Message-ID: <Y0/1LD7pqeKeCfeR@xhacker>
References: <20220928162007.3791-1-jszhang@kernel.org>
 <20220928162007.3791-5-jszhang@kernel.org>
 <CAJF2gTTADq-JpUtitSr0nw1aDPZrsB6f1jA-04WmOVcrxYeakw@mail.gmail.com>
 <YzXBZnGXQdEGR1LW@xhacker>
 <CAJF2gTTonVbTAJGw3qHdfK5vKkHRX64hJB757zsiNgWq4y0Xmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTTonVbTAJGw3qHdfK5vKkHRX64hJB757zsiNgWq4y0Xmw@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:55:09AM +0800, Guo Ren wrote:
> On Fri, Sep 30, 2022 at 12:11 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Thu, Sep 29, 2022 at 11:59:00AM +0800, Guo Ren wrote:
> > > On Thu, Sep 29, 2022 at 12:29 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > >
> > > > Consolidate the saving/restoring GPs(except ra, sp and tp) into
> > > > save_gp/restore_gp macro.
> > > >
> > > > No functional change intended.
> > > >
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >  arch/riscv/include/asm/asm.h   | 65 +++++++++++++++++++++++++
> > > >  arch/riscv/kernel/entry.S      | 87 ++--------------------------------
> > > >  arch/riscv/kernel/mcount-dyn.S | 58 +----------------------
> > > >  3 files changed, 70 insertions(+), 140 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> > > > index 1b471ff73178..2f3b49536e9d 100644
> > > > --- a/arch/riscv/include/asm/asm.h
> > > > +++ b/arch/riscv/include/asm/asm.h
> > > > @@ -68,6 +68,7 @@
> > > >  #endif
> > > >
> > > >  #ifdef __ASSEMBLY__
> > > > +#include <asm/asm-offsets.h>
> > > >
> > > >  /* Common assembly source macros */
> > > >
> > > > @@ -80,6 +81,70 @@
> > > >         .endr
> > > >  .endm
> > > >
> > > > +       /* save all GPs except ra, sp and tp */
> > > > +       .macro save_gp
> > > How about leave x3(gp) out of the macro, and define:
> > > .marco save_from_x5_to_x31
> > > .marco restore_from_x5_to_x31
> >
> > Good idea, will do in next version.
> 
> Where is the next version?
> 
> I want to involve the patch in my generic entry series, it would help
> in the coding convention of the entry code.

Hi,

Here is the v3:
https://lore.kernel.org/linux-riscv/20221003102921.3973-1-jszhang@kernel.org/T/#t

thanks very much
