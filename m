Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4B45EABDF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiIZQBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiIZQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:00:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09210D114
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:49:05 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e74d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e74d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 423C91EC0380;
        Mon, 26 Sep 2022 16:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664203740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gh0gCJBkqhG9sXIL7zX8waUm9202zXr2/aFd1UurmKI=;
        b=bUqRvkq3uoLW5Q283DSAUm9sOkZjpKtCWPxujg/EIVAGf0xAURMsoxzviAxa5Zz0uNKPYh
        65U5WbLF8gbOXbC2PqNBTx54nAGrOyQ3PcyrkvrzJCf1Mc0uuKbhSyIlqy2B2KUEzhomos
        yFe4vYaQNpKQepf1SLCl8sdHfartZ24=
Date:   Mon, 26 Sep 2022 16:48:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, brijesh.singh@amd.com,
        michael.roth@amd.com, venu.busireddy@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/sev: Remove unused variable "err" in
 enforce_vmpl0()
Message-ID: <YzG72ynMieCUaHVM@zn.tnic>
References: <20220923113209.3046960-1-lizetao1@huawei.com>
 <Yy2kU7lZuArVMC5p@zn.tnic>
 <b02f72c5-636d-2d4f-98d7-bf3741e38e5d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b02f72c5-636d-2d4f-98d7-bf3741e38e5d@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 06:18:19PM +0800, Li Zetao wrote:
> My Compiler version is 11.2.0. I used the default .config and compiled with
> flags "-Wall -Werror", just as follows:
> 
>     make allmodconfig
> 
>     make EXTRA_CFLAGS="-Wall -Werror"

Ah, compressed/Makefile doesn't have -Wall. That's the old problem of
x86 not sharing makefiles. I need to dust off my patches which do that.

Now, if you do:

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 35ce1a64068b..10abb7c45d04 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -34,7 +34,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 # be valid.
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
-KBUILD_CFLAGS += -Wundef
+KBUILD_CFLAGS += -Wundef -Wall
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone

then allmodconfig triggers a bunch:

arch/x86/boot/compressed/efi.c: In function ‘efi_get_system_table’:
arch/x86/boot/compressed/efi.c:62:23: warning: unused variable ‘et’ [-Wunused-variable]
   62 |         enum efi_type et;
      |                       ^~
arch/x86/boot/compressed/efi.c: In function ‘efi_get_conf_table’:
arch/x86/boot/compressed/efi.c:134:13: warning: unused variable ‘ret’ [-Wunused-variable]
  134 |         int ret;
      |             ^~~
arch/x86/boot/compressed/acpi.c: In function ‘__efi_get_rsdp_addr’:
arch/x86/boot/compressed/acpi.c:27:13: warning: unused variable ‘ret’ [-Wunused-variable]
   27 |         int ret;
      |             ^~~
arch/x86/boot/compressed/acpi.c: In function ‘efi_get_rsdp_addr’:
arch/x86/boot/compressed/acpi.c:55:22: warning: unused variable ‘nr_tables’ [-Wunused-variable]
   55 |         unsigned int nr_tables;
      |                      ^~~~~~~~~
arch/x86/boot/compressed/sev.c: In function ‘enforce_vmpl0’:
arch/x86/boot/compressed/sev.c:256:13: warning: unused variable ‘err’ [-Wunused-variable]
  256 |         int err;
      |             ^~~


Would you like to do the above instead and fix them all in one go?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
