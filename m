Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2DA60684E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJTSkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTSj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000BC402CD;
        Thu, 20 Oct 2022 11:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2AC261CE8;
        Thu, 20 Oct 2022 18:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F428C433C1;
        Thu, 20 Oct 2022 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666291193;
        bh=FDv2Svu9pqn2gMWl0C7lBVdMvYtGOHeCs2L3R1GVwQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQpjqGDIDhV/mzDVim1AVFxDID8K+I2faufh6WUlNs2QIA62oYBKtrIe38CAMQXJs
         CmNhV/YBbbWxrFNTZYVARAQ4teaZbEOKiUQ1RGiVnX+7/vJ+AzafRyS/aMxwzdmtXz
         X/UOk71HPCkMICnDSraFVYYO/JYFotfQcHUgDaTT6ZE66fa2EW0yuYSVwlWouEtGuu
         /6l1hw2PykoBB4ZhzPrFOVcLpKGC6o3I0y0w4e/eJp3shn1/wIJEoPzJJR6LY3z/u8
         bLG/cs3R9SeRSYSU5VTRwSBUdcipD7qM1/26b5HDkOv8YYguTGSDtFG3UYjxkaq1QM
         Lx10G8meS3mCg==
Date:   Thu, 20 Oct 2022 11:39:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@dhl.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Terrell <terrelln@fb.com>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] Makefile.debug: support for -gz=zstd
Message-ID: <Y1GV9sHyODVmBbFW@dev-arch.thelio-3990X>
References: <20221020175655.1660864-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020175655.1660864-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:56:49AM -0700, Nick Desaulniers wrote:
> Make DEBUG_INFO_COMPRESSED a choice; DEBUG_INFO_UNCOMPRESSED is the
> default, DEBUG_INFO_COMPRESSED uses zlib, DEBUG_INFO_COMPRESSED_ZSTD
> uses zstd.
> 
> Some quick N=1 measurements with du, /usr/bin/time -v, and bloaty:
> 
> clang-16, x86_64 defconfig plus
> CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_UNCOMPRESSED=y:
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:55.43
> 488M vmlinux
> 27.6%   136Mi   0.0%       0    .debug_info
>  6.1%  30.2Mi   0.0%       0    .debug_str_offsets
>  3.5%  17.2Mi   0.0%       0    .debug_line
>  3.3%  16.3Mi   0.0%       0    .debug_loclists
>  0.9%  4.62Mi   0.0%       0    .debug_str
> 
> clang-16, x86_64 defconfig plus
> CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED=y (zlib):
> Elapsed (wall clock) time (h:mm:ss or m:ss): 1:00.35
> 385M vmlinux
> 21.8%  85.4Mi   0.0%       0    .debug_info
>  2.1%  8.26Mi   0.0%       0    .debug_str_offsets
>  2.1%  8.24Mi   0.0%       0    .debug_loclists
>  1.9%  7.48Mi   0.0%       0    .debug_line
>  0.5%  1.94Mi   0.0%       0    .debug_str
> 
> clang-16, x86_64 defconfig plus
> CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_ZSTD=y (zstd):
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:59.69
> 373M vmlinux
> 21.4%  81.4Mi   0.0%       0    .debug_info
>  2.3%  8.85Mi   0.0%       0    .debug_loclists
>  1.5%  5.71Mi   0.0%       0    .debug_line
>  0.5%  1.95Mi   0.0%       0    .debug_str_offsets
>  0.4%  1.62Mi   0.0%       0    .debug_str
> 
> That's only a 3.11% overall binary size savings over zlib, but at no
> performance regression.
> 
> Link: https://maskray.me/blog/2022-09-09-zstd-compressed-debug-sections
> Link: https://maskray.me/blog/2022-01-23-compressed-debug-sections
> Suggested-by: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One small comment below.

> ---
>  lib/Kconfig.debug      | 26 +++++++++++++++++++++++++-
>  scripts/Makefile.debug |  4 ++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3fc7abffc7aa..4085ac77dc12 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -312,8 +312,22 @@ config DEBUG_INFO_REDUCED
>  	  DEBUG_INFO build and compile times are reduced too.
>  	  Only works with newer gcc versions.
>  
> +choice
> +	prompt "Compressed Debug information"
> +	depends on DEBUG_KERNEL

I think you can drop this depends. The entire block is in an
'if DEBUG_INFO', which can only be true if CONFIG_DEBUG_KERNEL is set
because of the dependencies of the "Debug information" prompt above this
file, which is how CONFIG_DEBUG_INFO is selected.

> +	help
> +	  Compress the resulting debug info. Results in smaller debug info sections,
> +	  but requires that consumers are able to decompress the results.
> +
> +	  If unsure, choose DEBUG_INFO_UNCOMPRESSED.
> +
> +config DEBUG_INFO_UNCOMPRESSED
> +	bool "Don't compress debug information"
> +	help
> +	  Don't compress debug info sections.
> +
>  config DEBUG_INFO_COMPRESSED
> -	bool "Compressed debugging information"
> +	bool "Compress debugging information with zlib"
>  	depends on $(cc-option,-gz=zlib)
>  	depends on $(ld-option,--compress-debug-sections=zlib)
>  	help
> @@ -327,6 +341,16 @@ config DEBUG_INFO_COMPRESSED
>  	  preferable to setting $KDEB_COMPRESS to "none" which would be even
>  	  larger.
>  
> +config DEBUG_INFO_COMPRESSED_ZSTD
> +	bool "Compress debugging information with zstd"
> +	depends on $(cc-option,-gz=zstd)
> +	depends on $(ld-option,--compress-debug-sections=zstd)
> +	help
> +	  Compress the debug information using zstd.  Requires GCC 13.0+ or Clang
> +	  16.0+, binutils 2.40+, and zstd.
> +
> +endchoice # "Compressed Debug information"
> +
>  config DEBUG_INFO_SPLIT
>  	bool "Produce split debuginfo in .dwo files"
>  	depends on $(cc-option,-gsplit-dwarf)
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 332c486f705f..8ac3379d2255 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -31,6 +31,10 @@ ifdef CONFIG_DEBUG_INFO_COMPRESSED
>  DEBUG_CFLAGS	+= -gz=zlib
>  KBUILD_AFLAGS	+= -gz=zlib
>  KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
> +else ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZSTD
> +DEBUG_CFLAGS	+= -gz=zstd
> +KBUILD_AFLAGS	+= -gz=zstd
> +KBUILD_LDFLAGS	+= --compress-debug-sections=zstd
>  endif
>  
>  KBUILD_CFLAGS	+= $(DEBUG_CFLAGS)
> -- 
> 2.38.0.135.g90850a2211-goog
> 
