Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A044F6A22A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBXT7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBXT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:59:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9974231F4;
        Fri, 24 Feb 2023 11:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Yz6Cnikfbag3U4katUAdKyQvzzXHB/McbEaDU0MXMQ=; b=PQCst6uXd1ZyWdZ/o4hnPdgbkz
        SBe5DQBHfcSyutB2kJLQL6Z4L08f0WOLCFgkl6Kg72I0TJoyQTfbniQ7eSPYadJqR6+jRJ/FRfPam
        DbWHrx5mOGc7I9jak9my+ODizCM4r4jsB5aUcSAIbgxMQiPTazj3NGx4mkZsrbBKyf9SgRTQl/e+J
        EJpCjQqMDbyw9v/bZK640N2P+OrtOfAKQa4nPzMoZAYywRtEHA4zaeH/fV4mz72dvqkpR8KVz+KSp
        /NQnPCgrXFhIyI/02oVScnppS+0/nSocIXYJOY1k1DodrUWFNijkGGr4mlNqx32BF1WGTuYzMqcvb
        PF/RjIxQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVeDm-003jZF-2p; Fri, 24 Feb 2023 19:59:10 +0000
Date:   Fri, 24 Feb 2023 11:59:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 09/27] irqchip: remove MODULE_LICENSE in non-modules
Message-ID: <Y/kXDqW+7d71C4wz@bombadil.infradead.org>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-10-nick.alcock@oracle.com>
 <86y1onw02k.wl-maz@kernel.org>
 <Y/jyJFXqlj9DlX9z@bombadil.infradead.org>
 <86wn47vue1.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wn47vue1.wl-maz@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 05:35:34PM +0000, Marc Zyngier wrote:
> On Fri, 24 Feb 2023 17:21:40 +0000,
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> > 
> > On Fri, Feb 24, 2023 at 03:32:51PM +0000, Marc Zyngier wrote:
> > > On Fri, 24 Feb 2023 15:07:53 +0000,
> > > Nick Alcock <nick.alcock@oracle.com> wrote:
> > > > 
> > > > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > > > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > > > are used to identify modules. As a consequence, uses of the macro
> > > > in non-modules will cause modprobe to misidentify their containing
> > > > object file as a module when it is not (false positives), and modprobe
> > > > might succeed rather than failing with a suitable error message.
> > > > 
> > > > So remove it in the files in this commit, none of which can be built as
> > > > modules.
> > > > 
> > > > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > > > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > Cc: linux-modules@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > > ---
> > > >  drivers/irqchip/irq-renesas-rzg2l.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > index 25fd8ee66565..4bbfa2b0a4df 100644
> > > > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > @@ -390,4 +390,3 @@ IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
> > > >  IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
> > > >  MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
> > > >  MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
> > > > -MODULE_LICENSE("GPL");
> > > 
> > > I'm probably missing some context here, but I find it odd to drop
> > > something that is a important piece of information because of what
> > > looks like a tooling regression.
> > > 
> > > It also means that once a random driver gets enabled as a module, it
> > > won't load because it is now missing a MODULE_LICENSE() annotation.
> > > 
> > > It feels like MODULE_LICENSE should instead degrade to an empty
> > > statement when MODULE isn't defined. Why isn't this approach the
> > > correct one?
> > > 
> > > I expect the cover letter would have some pretty good information on
> > > this, but lore.kernel.org doesn't seem to have it at the time I write
> > > this ("Message-ID <20230224150811.80316-1-nick.alcock@oracle.com> not
> > > found").
> > 
> > The right thing is to not even have this and have the module license
> > inferred from the SPDX tag. But for now we want to remove the tag from
> > things we know for sure are not modules.
> 
> I understand that you want to remove it. I don't get why this is the
> right solution. Can you please assume that, in this particular
> instance, I am a complete idiot and spell it out for me?
> 
> Why isn't that a problem for modules that are compiled-in?

Modules that are compiled in should succeed with a modprobe call as its
already loaded. The construct we're looking for is a way to detect
things which are built-in but *could* be modules. The annotation today
is done at build time for something built-in using a file path using
modinfo.

All of the module macros which peg .modinfo section information for
built-in code can be extracted from vmlinux using objcopy -j .modinfo, and
that's exactly how modules.builtin.modinfo is built:

objcopy -j .modinfo -O binary vmlinux.o modules.builtin.modinfo

From this we grep out the "file:" and sed it with a ^kernel prefix.
You can look at the commit 8b41fc4454e ("kbuild: create modules.builtin
without Makefile.modbuiltin or tristate.conf") which did that.

If a module is built-in then MODULE_FILE() is used we and we add a
MODULE_INFO(file, KBUILD_MODFILE), and so the modinfo exists for the
"file:" tag for it. At build time we sed for all those with a kernel prefix
to build the modules.builtin file. That file is used by modprobe to tell
us "yes your module is loaded as its built-in".

So the thing we wish to not have present is when built-in code is being
compiled but *cannot possibly* be module, and we have no way to verify that.

So one way to go about this is to simply *not* use the MODULE_LICENSE()
which cannot possibly be modules so to simplfy the build process. I
think the alternative would be to have a kconfig tristate add a new define for
the case where the tristate was y.

So something like this:

diff --git a/Makefile b/Makefile
index 197dcb83b2e1..f825d0546a7f 100644
--- a/Makefile
+++ b/Makefile
@@ -574,6 +574,7 @@ KBUILD_CFLAGS_KERNEL :=
 KBUILD_RUSTFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
+KBUILD_CFLAGS_MODULE_POSSIBLE  := -DMODULE_POSSIBLE
 KBUILD_RUSTFLAGS_MODULE := --cfg MODULE
 KBUILD_LDFLAGS_MODULE :=
 KBUILD_LDFLAGS :=
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 100a386fcd71..13f31766eee3 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -211,12 +211,15 @@ endif
 endif
 
 part-of-module = $(if $(filter $(basename $@).o, $(real-obj-m)),y)
+could-be-module = $(if $(filter $(basename $@).o, $(possible-obj-m)),y)
 quiet_modtag = $(if $(part-of-module),[M],   )
 
 modkern_cflags =                                          \
 	$(if $(part-of-module),                           \
 		$(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE), \
-		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL) $(modfile_flags))
+		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL) $(modfile_flags)) \
+	$(if $(could-be-module),, \
+		$(KBUILD_CFLAGS_MODULE_POSSIBLE)
 
 modkern_rustflags =                                              \
 	$(if $(part-of-module),                                   \

The difficulty would be the possible-obj-m, to do it without incurring
a huge slow down on the build process.

  Luis
