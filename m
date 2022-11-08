Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E05620862
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiKHEng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiKHEnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:43:32 -0500
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C42E2EB;
        Mon,  7 Nov 2022 20:43:22 -0800 (PST)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue,  8 Nov 2022 05:43:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1667882599; bh=f98Ft+mUpEotOSqRVEFhe1RWvSPSfa7SKKHkZsjFsfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kv8LgZ5F6sNlKfbW6DiaegLg4NlBrNQbFXSq115C3UktcU7xwTN9uch6q/bMWtXrC
         Fu09Z4696U4wKUidHFNQEhsq3YBW4uVIZ8iCGAHjVIOXhGSZtnxpJ7mc0zveuthB6a
         ZecfdwnbvxJFtarH8i2BDyho7/JMVozVm/GZaPI4=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 1D5BA806B9;
        Tue,  8 Nov 2022 05:43:19 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 0D7E01814CA; Tue,  8 Nov 2022 05:43:19 +0100 (CET)
Date:   Tue, 8 Nov 2022 05:43:19 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@dhl.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Terrell <terrelln@fb.com>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] Makefile.debug: support for -gz=zstd
Message-ID: <Y2neZ1cfTIaECgcd@buildd.core.avm.de>
References: <CAK7LNATrBDSLqBZFmWr5RA542pUVR=mieUSNVYXy8thkHS6w_A@mail.gmail.com>
 <20221107180137.3634978-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107180137.3634978-1-ndesaulniers@google.com>
X-purgate-ID: 149429::1667882599-8E411378-77C3A1E1/0/0
X-purgate-type: clean
X-purgate-size: 5164
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 10:01:33AM -0800, Nick Desaulniers wrote:
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
> This renames the existing KConfig options:
> * DEBUG_INFO_UNCOMPRESSED -> DEBUG_INFO_COMPRESSED_NONE
> * DEBUG_INFO_COMPRESSED -> DEBUG_INFO_COMPRESSED_ZLIB

Might you want to update the DEBUG_INFO_(UN|)COMPRESSED above to the new
names?

Kind regards,
Nicolas


> So users upgrading may need to reset the new Kconfigs.
> 
> Link: https://maskray.me/blog/2022-09-09-zstd-compressed-debug-sections
> Link: https://maskray.me/blog/2022-01-23-compressed-debug-sections
> Suggested-by: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v1 -> v2:
> * Remove `depends on DEBUG_KERNEL` as per Nathan.
> * Rename Kconfigs as per Sedat and Masahiro.
> * Add note about renamed Kconfigs to commit message.
> * Add more help text to DEBUG_INFO_COMPRESSED_ZSTD.
> 
>  lib/Kconfig.debug      | 29 +++++++++++++++++++++++++++--
>  scripts/Makefile.debug |  4 ++++
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 29280072dc0e..7c28a8fba02e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -312,8 +312,21 @@ config DEBUG_INFO_REDUCED
>  	  DEBUG_INFO build and compile times are reduced too.
>  	  Only works with newer gcc versions.
>  
> -config DEBUG_INFO_COMPRESSED
> -	bool "Compressed debugging information"
> +choice
> +	prompt "Compressed Debug information"
> +	help
> +	  Compress the resulting debug info. Results in smaller debug info sections,
> +	  but requires that consumers are able to decompress the results.
> +
> +	  If unsure, choose DEBUG_INFO_COMPRESSED_NONE.
> +
> +config DEBUG_INFO_COMPRESSED_NONE
> +	bool "Don't compress debug information"
> +	help
> +	  Don't compress debug info sections.
> +
> +config DEBUG_INFO_COMPRESSED_ZLIB
> +	bool "Compress debugging information with zlib"
>  	depends on $(cc-option,-gz=zlib)
>  	depends on $(ld-option,--compress-debug-sections=zlib)
>  	help
> @@ -327,6 +340,18 @@ config DEBUG_INFO_COMPRESSED
>  	  preferable to setting $KDEB_COMPRESS to "none" which would be even
>  	  larger.
>  
> +config DEBUG_INFO_COMPRESSED_ZSTD
> +	bool "Compress debugging information with zstd"
> +	depends on $(cc-option,-gz=zstd)
> +	depends on $(ld-option,--compress-debug-sections=zstd)
> +	help
> +	  Compress the debug information using zstd.  This may provide better
> +	  compression than zlib, for about the same time costs, but requires newer
> +	  toolchain support.  Requires GCC 13.0+ or Clang 16.0+, binutils 2.40+, and
> +	  zstd.
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
> 
> base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
