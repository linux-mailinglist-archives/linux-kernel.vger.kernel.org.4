Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091525EFB73
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiI2Q7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiI2Q7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E18E0C0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC30161E66
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699A6C433C1;
        Thu, 29 Sep 2022 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664470777;
        bh=O7vzlE+g6QyEk7TzCDxdtB0ONZNe14oHz1jKlpsdbwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wxf4e96OW6Dkwk0ToQd8ESbumSBRMTO316z9VPFU74MG40VLtlCkEGNxCstPb3OlT
         tO6PmrPpGwtnsUAFR03NfAQ2dSkH1UcOrGSleJ+YbcZhQTvgTuzEOySWwxddpANOXl
         i/U0Iz+weX87MEEKxyltv8Avq9N4KxIEnfMoALh9XTeuOgcvuUi0OS1Ttbhv2SgiM1
         5YDukkUMVFRxAua7j1btsZydH3m4gvoApDha8e5Wvti32q56BUswY3/q6UX7KrinHU
         Eo4jeDmKDP92WH6J2hW92TXwBP2hu6WwY45vhiyommtiNobbdMl7fo/kfrd7vuAYe5
         4SC2l75pzggZQ==
Date:   Thu, 29 Sep 2022 09:59:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        ndesaulniers@google.com, masahiroy@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, michael.roth@amd.com,
        brijesh.singh@amd.com, venu.busireddy@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 0/2] Remove unused variables in x86/boot
Message-ID: <YzXO9mbRaoUFPdKr@dev-arch.thelio-3990X>
References: <20220927081512.2456624-1-lizetao1@huawei.com>
 <YzNwG3iWz+qfNCC9@dev-arch.thelio-3990X>
 <2d57b0a4-e1ad-fbae-8c28-5db2299ea84e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d57b0a4-e1ad-fbae-8c28-5db2299ea84e@huawei.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:16:11AM +0800, Li Zetao wrote:
> Hi Nathan,
> 
> On 2022/9/28 5:50, Nathan Chancellor wrote:
> > Hi Li,
> > 
> > On Tue, Sep 27, 2022 at 08:15:10AM +0000, Li Zetao wrote:
> > > This patch set removes some unused variables in x86/boot, and add the
> > > "-Wall" flag to Makefile, which is the old problem of x86 not sharing
> > > makefiles.
> > > 
> > > Changes since v1:
> > > - Add "-Wall" flag to x86/boot/compressed/Makefile
> > > - Remove unused variables "et" in efi_get_system_table() and "ret" in
> > >    efi_get_conf_table()
> > > - Remove unused variables "ret" in __efi_get_rsdp_addr() and
> > >    "nr_tables" in efi_get_rsdp_addr()
> > > 
> > > v1 at:
> > > https://lore.kernel.org/all/20220923113209.3046960-1-lizetao1@huawei.com/
> > > 
> > > Li Zetao (2):
> > >    x86/boot/compressed: Add "-Wall" flag to Makefile
> > >    x86/boot: Remove unused variables
> > > 
> > >   arch/x86/boot/compressed/Makefile | 2 +-
> > >   arch/x86/boot/compressed/acpi.c   | 2 --
> > >   arch/x86/boot/compressed/efi.c    | 2 --
> > >   arch/x86/boot/compressed/sev.c    | 1 -
> > >   4 files changed, 1 insertion(+), 6 deletions(-)
> > I took this series for a spin with clang and found a few extra warnings.
> > 
> > 1.
> > 
> >    In file included from arch/x86/boot/compressed/misc.c:15:
> >    In file included from arch/x86/boot/compressed/misc.h:24:
> >    In file included from ./include/linux/elf.h:6:
> >    In file included from ./arch/x86/include/asm/elf.h:8:
> >    In file included from ./include/linux/thread_info.h:60:
> >    ./arch/x86/include/asm/thread_info.h:175:13: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
> >            oldframe = __builtin_frame_address(1);
> >                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >    ./arch/x86/include/asm/thread_info.h:177:11: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
> >                    frame = __builtin_frame_address(2);
> >                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This warning is disabled in the main Makefile for this reason so we
> > should just be able to disable it:
> > 
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 10abb7c45d04..3f004567f3d5 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -43,6 +43,7 @@ KBUILD_CFLAGS += -mno-mmx -mno-sse
> >   KBUILD_CFLAGS += -ffreestanding -fshort-wchar
> >   KBUILD_CFLAGS += -fno-stack-protector
> >   KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> > +KBUILD_CFLAGS += $(call cc-disable-warning, frame-address)
> >   KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> >   KBUILD_CFLAGS += -Wno-pointer-sign
> >   KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> > 
> > 2.
> > 
> >    arch/x86/boot/compressed/kaslr.c:627:6: warning: unused variable 'i' [-Wunused-variable]
> >            int i;
> >                ^
> > 
> > This happens when CONFIG_MEMORY_HOTREMOVE or CONFIG_ACPI are 'n'. I
> > think it can just be fixed by aligning arch/x86/boot/compressed with the
> > rest of the kernel and explicitly compiling with '-std=gnu11', which
> > will allow us to declare the variable within the for loop, like so.
> > 
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 3f004567f3d5..6c7e366a437b 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -34,7 +34,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
> >   # be valid.
> >   KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
> >   KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
> > -KBUILD_CFLAGS += -Wundef -Wall
> > +KBUILD_CFLAGS += -Wundef -Wall -std=gnu11
> >   KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> >   cflags-$(CONFIG_X86_32) := -march=i386
> >   cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 4a3f223973f4..be859c7e7f6b 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -624,7 +624,6 @@ static bool process_mem_region(struct mem_vector *region,
> >   			       unsigned long minimum,
> >   			       unsigned long image_size)
> >   {
> > -	int i;
> >   	/*
> >   	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
> >   	 * use @region directly.
> > @@ -644,7 +643,7 @@ static bool process_mem_region(struct mem_vector *region,
> >   	 * If immovable memory found, filter the intersection between
> >   	 * immovable memory and @region.
> >   	 */
> > -	for (i = 0; i < num_immovable_mem; i++) {
> > +	for (int i = 0; i < num_immovable_mem; i++) {
> >   		u64 start, end, entry_end, region_end;
> >   		struct mem_vector entry;
> > 
> > Additionally, I think these two patches should be reordered so that the
> > warnings are fixed before they are enabled.
> > 
> > With those comments addressed, consider the series:
> > 
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > Cheers,
> > Nathan
> 
> What is your clang compiler version and .config? My clang compiler is
> 14.0.0-1ubuntu1, and I can't reproduce
> 
> problem 1("calling '__builtin_frame_address' with a nonzero argument is
> unsafe"). Can you provide more
> 
> information.

Sure thing! My compiler is tip of tree LLVM, so clang 16.0.0. That
should not matter for this particular issue though. I can reproduce it
with my distribution's clang (14.0.6) with a configuration that has
CONFIG_FRAME_POINTER enabled; allnoconfig works for me here.

  $ clang --version
  clang version 14.0.6
  Target: x86_64-pc-linux-gnu
  Thread model: posix
  InstalledDir: /usr/bin

  $ make -skj"$(nproc)" ARCH=i386 LLVM=1 clean allnoconfig all
  ...
  In file included from arch/x86/boot/compressed/misc.c:15:
  In file included from arch/x86/boot/compressed/misc.h:24:
  In file included from ./include/linux/elf.h:6:
  In file included from ./arch/x86/include/asm/elf.h:8:
  In file included from ./include/linux/thread_info.h:60:
  ./arch/x86/include/asm/thread_info.h:175:13: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
          oldframe = __builtin_frame_address(1);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
  ./arch/x86/include/asm/thread_info.h:177:11: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
                  frame = __builtin_frame_address(2);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
  ...

  $ grep CONFIG_FRAME_POINTER .config
  CONFIG_FRAME_POINTER=y

If there is any other information I can provide, please let me know!

Cheers,
Nathan
