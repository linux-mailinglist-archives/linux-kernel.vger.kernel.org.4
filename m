Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B351667D3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjAZSJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjAZSJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:09:12 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 735371DBA7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:09:11 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 30QI5rrM030369;
        Thu, 26 Jan 2023 12:05:53 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 30QI5qYL030368;
        Thu, 26 Jan 2023 12:05:52 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 26 Jan 2023 12:05:52 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     kernel test robot <lkp@intel.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Subject: Re: arch/powerpc/kernel/head_85xx.o: warning: objtool: .head.text+0x1a6c: unannotated intra-function call
Message-ID: <20230126180552.GO25951@gate.crashing.org>
References: <202301161955.38kK6ksW-lkp@intel.com> <b2273730-f885-7658-7ec4-12fb5bfc515b@linux.ibm.com> <1674631223.9e09lbzzb6.naveen@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1674631223.9e09lbzzb6.naveen@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Jan 25, 2023 at 12:57:35PM +0530, Naveen N. Rao wrote:
> Sathvika Vasireddy wrote:
> >--- a/arch/powerpc/kvm/booke.c
> >+++ b/arch/powerpc/kvm/booke.c
> >@@ -917,7 +917,9 @@ static void kvmppc_fill_pt_regs(struct pt_regs *regs)
> >         asm("mr %0, 1" : "=r"(r1));
> >         asm("mflr %0" : "=r"(lr));
> >         asm("mfmsr %0" : "=r"(msr));
> >+       asm(".pushsection .discard.intra_function_calls; .long 999f; 
> >.popsection; 999:");
> >         asm("bl 1f; 1: mflr %0" : "=r"(ip));
> 
> I don't think you can assume that there won't be anything in between two 
> asm statements.

It would be a false assumption.  There is nothing that stops the
compiler from moving, duplicating, or even removing these statements
(removing only if no outputs from the asm are required of course).

> Does it work if you combine both the above asm 
> statements into a single one?
> 
> Even if that works, I don't think it is good to expand the macro here.  
> That asm statement looks to be trying to grab the current nip. I don't 
> know enough about that code, and someone who knows more about KVM may be 
> able to help, but it looks like we should be able to simply set 'ip' to 
> the address of kvmppc_fill_pt_regs()?

Such things are much better as actual assembler code (like, a .s file).
You have to be certain the compiler doesn't transform this in unexpected
ways, like, copy and move it to all callers for example.  You need the
mfmsr to remain somewhat in place for example.

A big reason to not want inline asm for things like this is you need so
very many operands in a single asm that way; it becomes very hard to
write, esp. if you want it to be correct code as well.  That is a good
hint there are better way to do this ;-)


Segher
