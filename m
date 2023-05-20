Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCBC70AAF3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjETUcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETUcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 16:32:31 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52039FA;
        Sat, 20 May 2023 13:32:30 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0A53A92009D; Sat, 20 May 2023 22:32:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 036F392009B;
        Sat, 20 May 2023 21:32:28 +0100 (BST)
Date:   Sat, 20 May 2023 21:32:28 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] MIPS: Fix MIPS_O32_FP64_SUPPORT for 64bit CPUs before
 R2
In-Reply-To: <C1676532-0051-43D7-82D8-1E5697407C70@flygoat.com>
Message-ID: <alpine.DEB.2.21.2305192352100.27887@angie.orcam.me.uk>
References: <20230519163023.70542-1-jiaxun.yang@flygoat.com> <alpine.DEB.2.21.2305192033550.50034@angie.orcam.me.uk> <C1676532-0051-43D7-82D8-1E5697407C70@flygoat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023, Jiaxun Yang wrote:

> > I guess one can do it and still run FPXX software, but I fail to see what 
> > gain it provides.  For FP32 it breaks things as accesses to odd-numbered 
> > FPRs will no longer get at the high part of a double value and for FP64 
> > there are no MTHC1/MFHC1 instructions required to access the high part.
> 
> Actually software may access the high part by SDC1/LDC1.

 I'm aware of that, but you'd need a new psABI variation really to handle 
such an arrangement.  None of the existing FP32, FP64, FPXX handles it.

> > What problem are you trying to solve?  And how did you verify this patch?
> 
> Was trying to deal a proprietary JIT software who want to enable FR1 via prctl
> on Loongson-2F with 32 bit kernel.

 There may be a better way: rather than avoiding MTHC1/MFHC1, handle them 
in the FPU emulator where unavailable in FR=1 mode while leaving the rest 
to hardware.  That would make regular FR64 software work.

 I'd expect such a JIT to have other issues with pre-R2 hardware though, 
with missing machine instructions.  I had a similar situation a few years 
ago with FireFox's JIT making assumptions above the MIPS ISA level the 
piece of software was itself compiled for and opted for just disabling the 
JIT, as fixing FireFox and rebuilding it would be more effort than it was 
worth in my view.

 This might be the best way for you to move forward too, and I'm all but 
enthusiastic about adding a workaround in the kernel for a broken piece of 
proprietary user software.  Sorry.

 Also I seem to remember there was a pitfall with running 32-bit software 
on pre-R2 hardware in the FR=1 mode, but maybe I'm making up things here.  
It's been so long since I last looked into this.

 In any case you do need to verify this somehow, like by running the math 
part of the glibc testsuite with o32 in the FR=1 mode on pre-R2 hardware.  
Running the GDB test suite to make sure ptrace(2) works fine with the new 
FPU configuration would make sense too.

> > Currently all FPUs we support implement double and we require that, so no 
> > need to make this piece conditional (I would use IS_ENABLED otherwise, so 
> > as not to clutter the source with #ifdef), but `c->fpu_id' is also exposed 
> > to the user via ptrace(2), so this has to reflect hardware and not give a 
> > synthesized value.
> 
> Alas, I thought R2030 class FPU does not have double? Since MIPS-IV spec
> says SDC1 is introduced in MIPS II.

 There's no SDC1/LDC1, but the usual MIPS I FP machine instructions (of 
which there are fewer than in MIPS II, e.g. there's no SQRT.fmt or direct 
conversions) do support the double format/encoding.  It's just that double 
FP data has to be transferred piecemeal; other supported operations will 
execute just fine.  Otherwise the existence of the odd-numbered FPRs would 
make no sense in the first place.

 Plain single floating-point units are extremely rare, e.g. the R4650 has 
one (it does support CP0.Status.FR though, for 32 singles), and we do not 
support them (e.g. the R4650 has a simple base-bounds MMU only, no TLB).  
Another one is the R5900, but its FPU is not an IEEE 754 device even.

  Maciej
