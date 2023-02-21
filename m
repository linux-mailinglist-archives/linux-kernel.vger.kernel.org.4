Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768C069EA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBUWwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBUWwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:52:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA97D2ED74;
        Tue, 21 Feb 2023 14:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kcif8EVy9vme1vFm160QThdb15hPzUROyGcA3HYTLWo=; b=nAu56HkJCYaFlIPN5n8HGydt2p
        6gvlNOMIig0bcSB2SDXTy/3pNpgAm/eXSLipFsyG+ABX3nALEMIrOpdCkK12mt6uvCOqMZoSG4lk6
        jwZrH9Adcz9qxm4hyDC3TbK4vsyC8qj6O3K0Yzfp3YA1VVJlOM3AN07KaQQ96/ayUNmHyfb+hemKg
        jUY66LLxCWrLR+su7YiU91FsCmkuU8VIuUQwwRBjAbjMGtxtO5RNKW7Ih/8SYHYTsU1Yj/cbNZj15
        bx1KObUQAB4F1gbkkgv53dFFIKd87NL8IMgWcebMBoE8ZER/5CzD0MeX8NloO8Kkth6njrJ1yl+wI
        2RETYhMA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUbUI-00A36j-FA; Tue, 21 Feb 2023 22:51:54 +0000
Date:   Tue, 21 Feb 2023 14:51:54 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mpdesouza@suse.com, masahiroy@kernel.org,
        christophe.jaillet@wanadoo.fr, rdunlap@infradead.org,
        dan.j.williams@intel.com, nicolas@fjasle.eu,
        nick.alcock@oracle.com, tglx@linutronix.de, peterz@infradead.org,
        linux@weissschuh.net, jiapeng.chong@linux.alibaba.com,
        p.raghav@samsung.com, dave@stgolabs.net, linux@roeck-us.net,
        hch@infradead.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org
Subject: [GIT PULL] modules changes for v6.3-rc1
Message-ID: <Y/VLCgqeWIvzfiAj@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 7c46948a6e9cf47ed03b0d489fde894ad46f1437:

  Merge tag 'fs.fuse.acl.v6.2-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping (2023-01-25 09:15:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.3-rc1

for you to fetch changes up to f412eef03938d3a40d4f6f5a79d0f98ed89b596d:

  Documentation: livepatch: module-elf-format: Remove local klp_modinfo definition (2023-02-06 08:45:55 -0800)

----------------------------------------------------------------
modules-6.3-rc1

Nothing exciting at all for modules for v6.3. The biggest change is
just the change of INSTALL_MOD_DIR from "extra" to "updates" which
I found lingered for ages for no good reason while testing the CXL
mock driver [0]. The CXL mock driver has no kconfig integration and requires
building an external module... and re-building the *rest* of the production
drivers. This mock driver when loaded but not the production ones will
crash. All this crap can obviously be fixed by integrating kconfig
semantics into such test module, however that's not desirable by
the maintainer, and so sensible defaults must be used to ensure a
default "make modules_install" will suffice for most distros which
do not have a file like /etc/depmod.d/dist.conf with something like
`search updates extra built-in`. Since most distros rely on kmod and
since its inception the "updates" directory is always in the search
path it makes more sense to use that than the "extra" which only
*some* RH based systems rely on. All this stuff has been on linux-next
for a while.

For v6.4 I already have queued some initial work by Song Liu which gets
us slowly going to a place where we *may* see a generic allocator for
huge pages for module text to avoid direct map fragmentation *and*
reduce iTLB pressure. That work is in its initial stages, no allocator
work is done yet. This is all just prep work. Fortunately Thomas Gleixner
has helped convince Song that modules *need* to be *requirement* if we
are going to see any special allocator touch x86. So who knows... maybe
around v6.5 we'll start seeing some *real* performance numbers of the
effect of using huge pages for something other than eBPF toys.

For v6.4 also, you may start seeing patches from Nick Alcock on different
trees and modules-next which aims at extending kallsyms *eventually* to provide
clearer address to symbol lookups. The claim is that this is a *great* *feature*
tracing tools are dying to have so they can for instance disambiguate symbols as
coming from modules or from other parts of the kernel. I'm still waiting to see
proper too usage of such stuff, but *how* we lay this out is still being ironed
out. Part of the initial work I've been pushing for is to help upkeep our
modules build optimizations, so being mindful about the work by Masahiro Yamada
on commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf") which helps avoid traversing the build
tree twice. After this commit we now rely on the MODULE_LICENSE() tag to
determine in a *faster* way if something being built could be a module and
we dump this into the modules.builtin so that modprobe can simply succeed
if a module is known to already be built-in. The cleanup work on MODULE_LICENSE()
simply stems to assist false positives from userspace for things as built-in
when they *cannot ever* be modules as we don't even tristate the code as
modular. This work also helps with the SPDX effort as some code is not clearly
identified with a tag. In the *future*, once all *possible* modules are
confirmed to have a respective SPDX tag, we *may* just be able to replace the
MODULE_LICENSE() to instead be generated automatically through inference of
the respective module SPDX tags.

[0] https://lkml.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org

----------------------------------------------------------------
Christophe JAILLET (2):
      kernel/params.c: Use kstrtobool() instead of strtobool()
      module: Use kstrtobool() instead of strtobool()

Luis Chamberlain (1):
      kbuild: Modify default INSTALL_MOD_DIR from extra to updates

Marcos Paulo de Souza (2):
      module.h: Document klp_modinfo struct using kdoc
      Documentation: livepatch: module-elf-format: Remove local klp_modinfo definition

Randy Dunlap (1):
      test_kmod: stop kernel-doc warnings

 Documentation/livepatch/module-elf-format.rst | 11 ++---------
 include/linux/module.h                        |  8 ++++++++
 kernel/module/main.c                          |  3 ++-
 kernel/params.c                               |  3 ++-
 lib/test_kmod.c                               | 11 +++++------
 scripts/Makefile.modinst                      |  2 +-
 6 files changed, 20 insertions(+), 18 deletions(-)
