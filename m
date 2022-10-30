Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B487C612B8E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 17:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ3QNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 12:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3QNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 12:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC6B5FB6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 09:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F33560EE0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 16:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CABC433C1;
        Sun, 30 Oct 2022 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667146387;
        bh=/T3JSPF6RKm+uD0J6i/rJY8j22suaEB2nqLWyc8WVfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obSU/JkGAzLXB2CTMQPpINuXYLeHg6YL1DjxNB2QF7uMKz1r/E7SidAZAcS1fpMpx
         Yw4PyaS2BTlkZXWZh+cZULssGS8MF+Ih3xf1QgmjQm0/fusis7NSu/If3paWkdmn5Z
         Lece3ClpVkyI3+sO6OHjYr7XANVbCpYCaJFtPJNf7ugSIDVX/mzmQnNd0BOqtEG8V+
         RaxjnyR/Q44cJS+D92wTN7fXCb+/KiTnETa3m2SIrALQmnDEqJ3qLY8C7S6sIXeLCN
         mODLW7ndGAZLTJbb6yPA+rJ7V9awtGeVDa3Z7AI7OY2bhSikKU7mfV9WAXwaYYfbVo
         aAMcc9GXrupKQ==
Date:   Mon, 31 Oct 2022 00:03:20 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] riscv: improve boot time isa extensions handling
Message-ID: <Y16gSDwCWmp3vxaw@xhacker>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221029095609.e4ymkbnk2hl3kxzc@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221029095609.e4ymkbnk2hl3kxzc@kamzik>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 11:56:09AM +0200, Andrew Jones wrote:
> On Thu, Oct 06, 2022 at 03:08:10PM +0800, Jisheng Zhang wrote:
> > Generally, riscv ISA extensions are fixed for any specific hardware
> > platform, that's to say, the hart features won't change any more
> > after booting, this chacteristic make it straightforward to use
> > static branch to check one specific ISA extension is supported or not
> > to optimize performance.
> > 
> > However, some ISA extensions such as SVPBMT and ZICBOM are handled
> > via. the alternative sequences.
> > 
> > Basically, for ease of maintenance, we prefer to use static branches
> > in C code, but recently, Samuel found that the static branch usage in
> > cpu_relax() breaks building with CONFIG_CC_OPTIMIZE_FOR_SIZE[1]. As
> > Samuel pointed out, "Having a static branch in cpu_relax() is
> > problematic because that function is widely inlined, including in some
> > quite complex functions like in the VDSO. A quick measurement shows
> > this static branch is responsible by itself for around 40% of the jump
> > table."
> > 
> > Samuel's findings pointed out one of a few downsides of static branches
> > usage in C code to handle ISA extensions detected at boot time:
> > static branch's metadata in the __jump_table section, which is not
> > discarded after ISA extensions are finalized, wastes some space.
> > 
> > I want to try to solve the issue for all possible dynamic handling of
> > ISA extensions at boot time. Inspired by Mark[2], this patch introduces
> > riscv_has_extension_*() helpers, which work like static branches but
> > are patched using alternatives, thus the metadata can be freed after
> > patching.
> > 
> > [1]https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> > [2]https://lore.kernel.org/linux-arm-kernel/20220912162210.3626215-8-mark.rutland@arm.com/
> > 
> > 
> > Jisheng Zhang (8):
> >   riscv: move riscv_noncoherent_supported() out of ZICBOM probe
> >   riscv: cpufeature: detect RISCV_ALTERNATIVES_EARLY_BOOT earlier
> >   riscv: hwcap: make ISA extension ids can be used in asm
> >   riscv: cpufeature: extend riscv_cpufeature_patch_func to all ISA
> >     extensions
> >   riscv: introduce riscv_has_extension_[un]likely()
> >   riscv: fpu: switch has_fpu() to riscv_has_extension_likely()
> >   riscv: cpu_relax: switch to riscv_has_extension_likely()
> >   riscv: remove riscv_isa_ext_keys[] array and related usage
> > 
> >  arch/riscv/include/asm/errata_list.h    |  9 +--
> >  arch/riscv/include/asm/hwcap.h          | 94 ++++++++++++++-----------
> >  arch/riscv/include/asm/switch_to.h      |  3 +-
> >  arch/riscv/include/asm/vdso/processor.h |  2 +-
> >  arch/riscv/kernel/cpufeature.c          | 78 +++-----------------
> >  arch/riscv/kernel/setup.c               |  4 ++
> >  6 files changed, 71 insertions(+), 119 deletions(-)
> > 
> > -- 
> > 2.37.2
> >
> 
> Hi Jisheng,
> 
> I just tried building this with LLVM=1 and fails to compile with messages
> like
> 
>  ld.lld: error: relocation R_RISCV_64 cannot be used against symbol '.Ltmp1'; recompile with -fPIC
>  >>> defined in arch/riscv/kernel/vdso/vgettimeofday.o
>  >>> referenced by vgettimeofday.c
>  >>>               arch/riscv/kernel/vdso/vgettimeofday.o:(.alternative+0x0)
> 
> It does compile and boot with CC=clang and binutils 2.39, where my clang
> version is 14.0.5 (Fedora 14.0.5-1.fc36).

Hi Andrew, 

Below is a quick fix.

PS: I think I need add two or more patches to apply alternatives in the
vDSO. But currently only Zihintpause is affected.

Will send out a new version.

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f2e065671e4d..522b78477bab 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -44,7 +44,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
        $(call if_changed,vdsold)
-LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
+LDFLAGS_vdso.so.dbg = -shared -z notext -S -soname=linux-vdso.so.1 \

> 
> Thanks,
> drew
