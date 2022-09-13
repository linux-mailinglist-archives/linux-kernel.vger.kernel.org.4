Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C083F5B7D98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIMXkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIMXki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:40:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C7B3ECE0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6576BB81186
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FD7C433D6;
        Tue, 13 Sep 2022 23:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663112434;
        bh=Jdmd7znayNN5ij2TbRAHpfdH8FfkBL1rJwJ+C+Q1JFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOIWqLVAkpNltdPo1D0nipKkW8wEPZxOzTDqizXk7gGH0fgKvrMA8ww5+U/zWbwtd
         4hTjG9jxHFFbUnjPm7IDmkpVMgPbEPQ3IMMIhXHauOAcoFdr146tidVXCCh7xdL7I3
         X0gWk2FrmFxIjaBTr3vihwcWCJvzfa5CAfRs/JkfJ9uwWHopbi+9bArmNytI9bAELA
         zDsFusEeNRnUg+RuybsUSOs2tA2AhQbkdAYwCHcN90gVDb8u9tMpd1RCaOj0cJOJXm
         6MG3O/cDSK6U3khyLRh2SQHyWAqjlwE1zEG76sTCSjcWcILVqiFyOQGd2rhsz5dIwp
         V/cGMeado2nbA==
Date:   Tue, 13 Sep 2022 16:40:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        nicolas@fjasle.eu, masahiroy@kernel.org,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        michael.roth@amd.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Avoid relocation information in final vmlinux
Message-ID: <YyEU70K1aY8b/EXZ@dev-arch.thelio-3990X>
References: <20220913132911.6850-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913132911.6850-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Tue, Sep 13, 2022 at 03:29:11PM +0200, Petr Pavlu wrote:
> The Linux build process on x86 roughly consists of compiling all input
> files, statically linking them into a vmlinux ELF file, and then taking
> and turning this file into an actual bzImage bootable file.
> 
> vmlinux has in this process two main purposes:
> 1) It is an intermediate build target on the way to produce the final
>    bootable image.
> 2) It is a file that is expected to be used by debuggers and standard
>    ELF tooling to work with the built kernel.
> 
> For the second purpose, a vmlinux file is typically collected by various
> package build recipes, such as distribution spec files, including the
> kernel's own binrpm-pkg target.
> 
> When building a kernel supporting KASLR with CONFIG_X86_NEED_RELOCS,
> vmlinux contains also relocation information produced by using the
> --emit-relocs linker option. This is utilized by subsequent build steps
> to create vmlinux.relocs and produce a relocatable image. However, the
> information is not needed by debuggers and other standard ELF tooling.
> 
> The issue is then that the collected vmlinux file and hence distribution
> packages end up unnecessarily large because of this extra data. The
> following is a size comparison of vmlinux v6.0-rc5 with and without the
> relocation information:
> | Configuration      | With relocs | Stripped relocs |
> | x86_64_defconfig   |       70 MB |           43 MB |
> | +CONFIG_DEBUG_INFO |      818 MB |          367 MB |
> 
> The patch optimizes a resulting vmlinux by adding a postlink step that
> splits the relocation information into vmlinux.relocs and then strips it
> from the vmlinux binary.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> 
> Notes:
>     The implemented approach has two shortcomings which is worth mentioning:
>     * The vmlinux file is rewritten in place. This creates a problem if the
>       build is interrupted when ld produced vmlinux but before the postlink
>       is started. A subsequent restart of the build would use the
>       incompletely processed vmlinux.
>     
>       The current build logic already appears to have this problem as
>       scripts/link-vmlinux.sh rewrites vmlinux in place, for example, when
>       handling CONFIG_BUILDTIME_TABLE_SORT. It could be solved by using an
>       intermediate target and renaming it to vmlinux only once the file is
>       final.
>     
>     * vmlinux.relocs is hidden from the Makefile workflow and Make is
>       additionally told about the file in arch/x86/boot/compressed/Makefile.
> 
>  .gitignore                        |  1 +
>  arch/x86/Makefile.postlink        | 41 +++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/Makefile | 10 +++-----
>  3 files changed, 46 insertions(+), 6 deletions(-)
>  create mode 100644 arch/x86/Makefile.postlink
> 
> diff --git a/.gitignore b/.gitignore
> index 265959544978..cd4ef88584ea 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -37,6 +37,7 @@
>  *.o
>  *.o.*
>  *.patch
> +*.relocs
>  *.s
>  *.so
>  *.so.dbg
> diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
> new file mode 100644
> index 000000000000..4650aaf6d8b3
> --- /dev/null
> +++ b/arch/x86/Makefile.postlink
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# ===========================================================================
> +# Post-link x86 pass
> +# ===========================================================================
> +#
> +# 1. Separate relocations from vmlinux into vmlinux.relocs.
> +# 2. Strip relocations from vmlinux.
> +
> +PHONY := __archpost
> +__archpost:
> +
> +-include include/config/auto.conf
> +include scripts/Kbuild.include
> +
> +CMD_RELOCS = arch/x86/tools/relocs
> +quiet_cmd_relocs = RELOCS  $@.relocs
> +      cmd_relocs = $(CMD_RELOCS) $@ > $@.relocs;$(CMD_RELOCS) --abs-relocs $@
> +
> +quiet_cmd_strip_relocs = RSTRIP  $@
> +      cmd_strip_relocs = objcopy --remove-relocations='*' $@

Just a small drive by comment, prefer $(OBJCOPY) over objcopy so that
the user's choice of objcopy is respected (such as llvm-objcopy).
Unfortunately, llvm-objcopy does not appear to support
'--remove-relocations'. We can certainly file a feature request for this
upstream but is there a way to accomplish this in a different way? Or
perhaps this could be something that is controlled via Kconfig so it
is only selectable with GNU objcopy??

Cheers,
Nathan

> +
> +# `@true` prevents complaint when there is nothing to be done
> +
> +vmlinux: FORCE
> +	@true
> +ifeq ($(CONFIG_X86_NEED_RELOCS),y)
> +	$(call cmd,relocs)
> +	$(call cmd,strip_relocs)
> +endif
> +
> +%.ko: FORCE
> +	@true
> +
> +clean:
> +	@rm -f vmlinux.relocs
> +
> +PHONY += FORCE clean
> +
> +FORCE:
> +
> +.PHONY: $(PHONY)
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 35ce1a64068b..eba7709d75ae 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -120,14 +120,12 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>  
>  targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
>  
> -CMD_RELOCS = arch/x86/tools/relocs
> -quiet_cmd_relocs = RELOCS  $@
> -      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
> -$(obj)/vmlinux.relocs: vmlinux FORCE
> -	$(call if_changed,relocs)
> +# vmlinux.relocs is created by the vmlinux postlink step.
> +vmlinux.relocs: vmlinux
> +	@true
>  
>  vmlinux.bin.all-y := $(obj)/vmlinux.bin
> -vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
> +vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += vmlinux.relocs
>  
>  $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
>  	$(call if_changed,gzip)
> -- 
> 2.35.3
> 
