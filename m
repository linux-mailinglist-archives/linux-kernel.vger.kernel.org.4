Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F365ECFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiI0V6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiI0V6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:58:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7811D605
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8E91B81D90
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 21:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7857C433D6;
        Tue, 27 Sep 2022 21:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664315907;
        bh=mgzpt4Y0780eW4XJ95mo4/v3lWIzVBI4eQS8tis1nfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtjD8bDwXAwv3Xaws/Kdfi3FYd5z1BJ+U+5qN5RYStixcBJdp7qRHafwrLDxol3y6
         SKQyqkCO2A/QcYJQ4D6Lgf4fsYM+cOHYFN6iJXy/uOu6USrzPAitlRsHl0tbFUbPAx
         CtuWtu4MDjjPJ5mNyQlaDMN09Bj+TOdaholjFK6/i6PbMnl9HRv/FmB5z/jAlDK07l
         u0GY12/qigyYtBeowIDoaRz/oY2OuDTxQ/Q3hCfV1iONahmedSr3RSFAGfC9ALGcJh
         1lkhJLcy73DutXSiB/46qX5HzcR2howWX07DtfHW1RMMbuqicwkLkDYrtV9AwHf+2O
         /t5fFJIiCKF1A==
Date:   Tue, 27 Sep 2022 14:58:25 -0700
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
Message-ID: <YzNyAVmsUMdZl5OA@dev-arch.thelio-3990X>
References: <20220927081512.2456624-1-lizetao1@huawei.com>
 <YzNwG3iWz+qfNCC9@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzNwG3iWz+qfNCC9@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:50:19PM -0700, Nathan Chancellor wrote:
> Hi Li,
> 
> On Tue, Sep 27, 2022 at 08:15:10AM +0000, Li Zetao wrote:
> > This patch set removes some unused variables in x86/boot, and add the
> > "-Wall" flag to Makefile, which is the old problem of x86 not sharing
> > makefiles.
> > 
> > Changes since v1:
> > - Add "-Wall" flag to x86/boot/compressed/Makefile
> > - Remove unused variables "et" in efi_get_system_table() and "ret" in
> >   efi_get_conf_table()
> > - Remove unused variables "ret" in __efi_get_rsdp_addr() and 
> >   "nr_tables" in efi_get_rsdp_addr()
> > 
> > v1 at:
> > https://lore.kernel.org/all/20220923113209.3046960-1-lizetao1@huawei.com/
> > 
> > Li Zetao (2):
> >   x86/boot/compressed: Add "-Wall" flag to Makefile
> >   x86/boot: Remove unused variables
> > 
> >  arch/x86/boot/compressed/Makefile | 2 +-
> >  arch/x86/boot/compressed/acpi.c   | 2 --
> >  arch/x86/boot/compressed/efi.c    | 2 --
> >  arch/x86/boot/compressed/sev.c    | 1 -
> >  4 files changed, 1 insertion(+), 6 deletions(-)
> 
> I took this series for a spin with clang and found a few extra warnings.
> 
> 1.
> 
>   In file included from arch/x86/boot/compressed/misc.c:15:
>   In file included from arch/x86/boot/compressed/misc.h:24:
>   In file included from ./include/linux/elf.h:6:
>   In file included from ./arch/x86/include/asm/elf.h:8:
>   In file included from ./include/linux/thread_info.h:60:
>   ./arch/x86/include/asm/thread_info.h:175:13: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
>           oldframe = __builtin_frame_address(1);
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./arch/x86/include/asm/thread_info.h:177:11: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
>                   frame = __builtin_frame_address(2);
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This warning is disabled in the main Makefile for this reason so we
> should just be able to disable it:
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 10abb7c45d04..3f004567f3d5 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -43,6 +43,7 @@ KBUILD_CFLAGS += -mno-mmx -mno-sse
>  KBUILD_CFLAGS += -ffreestanding -fshort-wchar
>  KBUILD_CFLAGS += -fno-stack-protector
>  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> +KBUILD_CFLAGS += $(call cc-disable-warning, frame-address)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> 
> 2.
> 
>   arch/x86/boot/compressed/kaslr.c:627:6: warning: unused variable 'i' [-Wunused-variable]
>           int i;
>               ^
> 
> This happens when CONFIG_MEMORY_HOTREMOVE or CONFIG_ACPI are 'n'. I
> think it can just be fixed by aligning arch/x86/boot/compressed with the
> rest of the kernel and explicitly compiling with '-std=gnu11', which
> will allow us to declare the variable within the for loop, like so.
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 3f004567f3d5..6c7e366a437b 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -34,7 +34,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>  # be valid.
>  KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
>  KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
> -KBUILD_CFLAGS += -Wundef -Wall
> +KBUILD_CFLAGS += -Wundef -Wall -std=gnu11
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  cflags-$(CONFIG_X86_32) := -march=i386
>  cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 4a3f223973f4..be859c7e7f6b 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -624,7 +624,6 @@ static bool process_mem_region(struct mem_vector *region,
>  			       unsigned long minimum,
>  			       unsigned long image_size)
>  {
> -	int i;
>  	/*
>  	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
>  	 * use @region directly.
> @@ -644,7 +643,7 @@ static bool process_mem_region(struct mem_vector *region,
>  	 * If immovable memory found, filter the intersection between
>  	 * immovable memory and @region.
>  	 */
> -	for (i = 0; i < num_immovable_mem; i++) {
> +	for (int i = 0; i < num_immovable_mem; i++) {
>  		u64 start, end, entry_end, region_end;
>  		struct mem_vector entry;
>  
> 
> Additionally, I think these two patches should be reordered so that the
> warnings are fixed before they are enabled.
> 
> With those comments addressed, consider the series:
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Oops, missed another one on second glance of my build logs:

3.

  arch/x86/boot/compressed/acpi.c:23:1: warning: unused function '__efi_get_rsdp_addr' [-Wunused-function]
  __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
  ^
  1 warning generated.

This happens when CONFIG_EFI is disabled. This will resolve it:

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 21febd9f21ab..5f2b8966e723 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -19,10 +19,10 @@
  */
 struct mem_vector immovable_mem[MAX_NUMNODES*2];
 
+#ifdef CONFIG_EFI
 static acpi_physical_address
 __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 {
-#ifdef CONFIG_EFI
 	unsigned long rsdp_addr;
 
 	/*
@@ -41,9 +41,9 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 		return (acpi_physical_address)rsdp_addr;
 
 	debug_putstr("Error getting RSDP address.\n");
-#endif
 	return 0;
 }
+#endif
 
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
