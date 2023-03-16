Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05F06BCD44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCPKvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCPKv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:51:28 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C423C30
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dKQSMmO1/9WgFYdBrQ+Eoie6qDQfbpn+EnDdMXEPoVo=;
  b=CDbWxOtHWs1Z0pmqLE60JKKB8/d++gdRsHsE6SAz6h/R1jDcaxB38k3E
   aWElT2GM0IhpbUUCcdNLjRr10M0UiQVJVMZ58rIxrdxUVkAUQATrGlPIw
   mllg9kkvO9OLWK3XknMVws06edPCyF4QBZ633t8ZHYem6Kr9Upoh19tbv
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="97537696"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 11:51:23 +0100
Date:   Thu, 16 Mar 2023 11:51:23 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
cc:     Alison Schofield <alison.schofield@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
In-Reply-To: <ZBLxHyiFnOwEdPYf@khadija-virtual-machine>
Message-ID: <d4e16b4-c296-8130-eddd-4de05e426e2@inria.fr>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine> <ZBEJ+8DbhADSBTLr@aschofie-mobl2> <ZBG699SriXWy1I2K@khadija-virtual-machine> <16148020.1MiD057Pog@suse> <ZBHUr7bANuhnOnIV@khadija-virtual-machine> <ZBHtrGjgKOiVwjSF@aschofie-mobl2>
 <ZBLxHyiFnOwEdPYf@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Mar 2023, Khadija Kamran wrote:

> On Wed, Mar 15, 2023 at 09:09:16AM -0700, Alison Schofield wrote:
> > On Wed, Mar 15, 2023 at 07:22:39PM +0500, Khadija Kamran wrote:
> > > On Wed, Mar 15, 2023 at 02:34:31PM +0100, Fabio M. De Francesco wrote:
> > > > Aside from what I said and asked for with the other message of this same
> > > > thread, please take note that you can build a specific module if you prefer
> > > > not to re-build the whole kernel and other modules at the same time.
> > > >
> > > > I'm pretty sure that the instructions to do so are in the OutreachyFirstPatch
> > > > tutorial.
> > > >
> > > > If they are not there, please let us know.
> > > >
> > > > Fabio
> > >
> > > Hey Fabio!
> > >
> > > In the Outreachy FirstPatchTutorial under the 'Compiling only part of
> > > the kernel' section there are ways to compile only some part of the
> > > kernel.
> > >
> > > I have tried using "make W=1 drivers/staging/axis-fifo/" and it says
> > > 'nothing to be done for'.
> > >
> > > Should I start with the steps to reproduce? :'(
> >
> > Khadija,
> >
> > I've applied your patch and it fails to compile with the warnings
> > that LKP reports.
> >
> > If you are doing: $ make drivers/staging/axis-fifo/
> >
> > and it is saying 'nothing to be done...'
> >
> > You either have not changed anything since the last compile, or you
> > do not have the module configured.
> >
>
> Hey Alison!
> I might've written the statement wrong. Actually, here is the output of
> make drivers/staging/axis-fifo
>
> YACC    scripts/genksyms/parse.tab.[ch]
>   HOSTCC  scripts/genksyms/parse.tab.o
>   HOSTCC  scripts/genksyms/lex.lex.o
>   HOSTLD  scripts/genksyms/genksyms
>   CC      scripts/mod/empty.o
>   MKELF   scripts/mod/elfconfig.h
>   HOSTCC  scripts/mod/modpost.o
>   CC      scripts/mod/devicetable-offsets.s
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/sumversion.o
>   HOSTLD  scripts/mod/modpost
>   CC      kernel/bounds.s
>   CC      arch/x86/kernel/asm-offsets.s
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   DESCEND bpf/resolve_btfids
>   INSTALL libsubcmd_headers
> make[3]: Nothing to be done for 'drivers/staging/axis-fifo/'.

Did you try make allyesconfig and make drivers/staging/axis-fifo/axis-fifo.o

I get no warnings with W=1, but I do get a .o file.  I also tried

make drivers/staging/axis-fifo/axis-fifo.i

which just expands macros and simplifies ifdefs, and I see the various
code from the file.  So I don't have the impression that it is getting
ifdef'd away in some obscure way.  Perhaps I am missing something.  Or
perhaps the warning in question only comres from LLVM?

julia

>
>
> > I suspect it has never compiled for you and you need to look at
> > the direction in the tutorial for 'Recompiling the driver' section
> > and learn how to use make menuconfig.
> >
> > This driver has a couple of dependencies described in the Kconfig
> > file. You will not even see the 'XIL_AXIS_FIFO' option until you
> > turn on 'OF' and HAS_'IOMEM'.
> >
> > See the drivers/staging/axis-fifo/Kconfig
> >
> > Please confirm that you have compiled the driver before chasing
> > after the build env that lkp reports.
> >
> > Thanks,
> > Alison
>
> Sorry, I made a mistake here.
>
> I did not change the driver 'Xilinx AXI-Stream FIFO IP core driver' to
> being compiled as a module by typing 'm'.
> Is that the problem here?
>
> Also, now when I try to change it by pressing 'm', it is not working.
> And I have tried many times but I cannot change the driver from '*' to
> 'm'.
>
> Kindly help me with this.
>
> Regards,
> Khadija
>
>
>
>
