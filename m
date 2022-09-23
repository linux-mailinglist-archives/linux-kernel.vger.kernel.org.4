Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B90B5E7AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiIWM27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiIWM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:28:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7419513C84D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:24:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56DEA1042;
        Fri, 23 Sep 2022 05:24:31 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.80.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B5E63F73D;
        Fri, 23 Sep 2022 05:24:23 -0700 (PDT)
Date:   Fri, 23 Sep 2022 13:24:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        "Mohan Rao .vanimina" <mailtoc.mohanrao@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] vmlinux.lds.h: CFI: Reduce alignment of jump-table to
 function alignment
Message-ID: <Yy2ldICeQQUgOBdb@FVFF77S0Q05N>
References: <20220922215715.13345-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922215715.13345-1-will@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:57:15PM +0100, Will Deacon wrote:
> Due to undocumented, hysterical raisins on x86, the CFI jump-table
> sections in .text are needlessly aligned to PMD_SIZE in the vmlinux
> linker script. When compiling a CFI-enabled arm64 kernel with a 64KiB
> page-size, a PMD maps 512MiB of virtual memory and so the .text section
> increases to a whopping 940MiB and blows the final Image up to 960MiB.
> Others report a link failure.
> 
> Since the CFI jump-table requires only instruction alignment, reduce the
> alignment directives to function alignment for parity with other parts
> of the .text section. This reduces the size of the .text section for the
> aforementioned 64KiB page size arm64 kernel to 19MiB for a much more
> reasonable total Image size of 39MiB.
> 
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Mohan Rao .vanimina" <mailtoc.mohanrao@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/all/CAL_GTzigiNOMYkOPX1KDnagPhJtFNqSK=1USNbS0wUL4PW6-Uw@mail.gmail.com/
> Fixes: cf68fffb66d60 ("add support for Clang CFI")
> Signed-off-by: Will Deacon <will@kernel.org>

Thanks for this!

I gave this a spin atop v6.-rc3 defconfig with:

* CONFIG_ARM64_64K_PAGES=y
* CONFIG_LTO_CLANG_THIN=y
* CONFIG_CFI_CLANG=y

The sizes clearly speak for themselves:

| % ls -al *-v6.0-rc3-64K-CFI*
| -rwxr-xr-x 1 mark mark  959693312 Sep 23 13:13 Image-v6.0-rc3-64K-CFI
| -rwxr-xr-x 1 mark mark   38781440 Sep 23 13:19 Image-v6.0-rc3-64K-CFI-patched
| -rwxr-xr-x 1 mark mark 1378631080 Sep 23 13:13 vmlinux-v6.0-rc3-64K-CFI
| -rwxr-xr-x 1 mark mark  453015376 Sep 23 13:19 vmlinux-v6.0-rc3-64K-CFI-patched

... and before and after applying the patch, the kernel booted fine under QEMU
(in TCG mode, as Cortex-A53).

I see that in scripts/module.lds.S we place the CFI bits into the .text
section, and that's only aligned to PAGE_SIZE, so we don't have a similar issue
for modules.

FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/asm-generic/vmlinux.lds.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 7515a465ec03..7c90b1ab3e00 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -543,10 +543,9 @@
>   */
>  #ifdef CONFIG_CFI_CLANG
>  #define TEXT_CFI_JT							\
> -		. = ALIGN(PMD_SIZE);					\
> +		ALIGN_FUNCTION();					\
>  		__cfi_jt_start = .;					\
>  		*(.text..L.cfi.jumptable .text..L.cfi.jumptable.*)	\
> -		. = ALIGN(PMD_SIZE);					\
>  		__cfi_jt_end = .;
>  #else
>  #define TEXT_CFI_JT
> -- 
> 2.37.3.998.g577e59143f-goog
> 
