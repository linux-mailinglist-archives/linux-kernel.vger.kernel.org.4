Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1145E5F3459
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJCRU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJCRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FD1AF0E;
        Mon,  3 Oct 2022 10:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BECE60FA8;
        Mon,  3 Oct 2022 17:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3B3C433C1;
        Mon,  3 Oct 2022 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664817616;
        bh=CqZMJfdEljuMYZz99/OJQk9Jg5oI7uCfP2nJ0LqL300=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxyTqpSuDAjJWIWx3yTPuqp6qOrbj68hHEhCY2v8aTDqq3dYF/WZqXMw2famWQTU1
         lUIC3U+A6hRBcl0xs7DconznDcWdxELy7cqIlDQtl2eflxu2dLNpf71JiHaiTEeM28
         8qYhkWbMsJdyfd8UoCtGKgmL1iLpjoC4EdnZj0Dy8t9+5nNK6meCmpyXINBSuBx+Ej
         4KC45Z1hxCvksbqTrghEqs4dhhlZYpknby2VEZmnsy/6RuaGRQtmXoJUN3RhPhkDyr
         BLpGoLRyQ7DVrTx6geWoRLjMFPLJMi0HLnsoDuClJWNeYjuwfdkEcSbBx6W+Wg1xRK
         EXjQT8bXk6vtg==
Date:   Mon, 3 Oct 2022 10:20:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 3/3] Kconfig.debug: split debug-level and DWARF-version
 into separate choices
Message-ID: <YzsZzjjJFcPILOji@dev-arch.thelio-3990X>
References: <20221002181107.51286-1-masahiroy@kernel.org>
 <20221002181107.51286-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221002181107.51286-4-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 03:11:07AM +0900, Masahiro Yamada wrote:
> Commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from
> a choice") added CONFIG_DEBUG_INFO_NONE into the DWARF version choice,
> but it should rather belong to the debug level choice.
> 
> This commit consolidates CONFIG options into two choices:
> 
>  - Debug info level (NONE / REDUCED / DEFAULT)
> 
>  - DWARF format (DWARF_TOOLCHAIN_DEFAULT / DWARF4 / DWARF5)
> 
> This is more consistent with compilers' policy because the -g0 compiler
> flag means "no debug info".
> 
>   GCC manual:
> 
>     -g<level>
> 
>       Request debugging information and also use level to specify how
>       much information. The default level is 2.
> 
>       Level 0 produces no debug information at all. Thus, -g0 negates -g.
> 
>       Level 1 produces minimal information, enough for making backtraces
>       in parts of the program that you don’t plan to debug. This includes
>       descriptions of functions and external variables, and line number
>       tables, but no information about local variables.
> 
>       Level 3 includes extra information, such as all the macro
>       definitions present in the program. Some debuggers support macro
>       expansion when you use -g3.
> 
>   Rustc Codegen manual:
> 
>     debuginfo
> 
>       This flag controls the generation of debug information. It takes
>       one of the following values:
> 
>       0: no debug info at all (the default).
>       1: line tables only.
>       2: full debug info.
> 
> I moved CONFIG_DEBUG_INFO_REDUCED into the debug level choice.
> 
> This change will make it easier to add another debug info level if
> necessary.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

As far as I can tell, this will require updating defconfigs again to
include an explicit 'CONFIG_DEBUG_INFO_DEFAULT=y', right? It might be
nice to do that as part of this change to keep everything working, as
there was some fallout from the last time:

92f89ec1b534 ("powerpc: Restore CONFIG_DEBUG_INFO in defconfigs")
ddd366bf01de ("ARM: defconfig: address renamed CONFIG_DEBUG_INFO=y")

Regardless, I think this is a good change.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  lib/Kconfig.debug | 59 +++++++++++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index cc90414d492e..ce1faae1a979 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -234,15 +234,10 @@ config DEBUG_INFO
>  choice
>  	prompt "Debug information"
>  	depends on DEBUG_KERNEL
> +	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
>  	help
>  	  Selecting something other than "None" results in a kernel image
>  	  that will include debugging info resulting in a larger kernel image.
> -	  This adds debug symbols to the kernel and modules (gcc -g), and
> -	  is needed if you intend to use kernel crashdump or binary object
> -	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
> -
> -	  Choose which version of DWARF debug info to emit. If unsure,
> -	  select "Toolchain default".
>  
>  config DEBUG_INFO_NONE
>  	bool "Disable debug information"
> @@ -250,10 +245,40 @@ config DEBUG_INFO_NONE
>  	  Do not build the kernel with debugging information, which will
>  	  result in a faster and smaller build.
>  
> +config DEBUG_INFO_REDUCED
> +	bool "Reduced debugging information"
> +	select DEBUG_INFO
> +	help
> +	  If you say Y here compiler is instructed to generate less debugging
> +	  information for structure types. This means that tools that
> +	  need full debugging information (like kgdb or systemtap) won't
> +	  be happy. But if you merely need debugging information to
> +	  resolve line numbers there is no loss. Advantage is that
> +	  build directory object sizes shrink dramatically over a full
> +	  DEBUG_INFO build and compile times are reduced too.
> +	  Only works with newer gcc versions.
> +
> +config DEBUG_INFO_DEFAULT
> +	bool "Default-level debugging information"
> +	select DEBUG_INFO
> +	help
> +	  If you say Y here compiler is instructed to generate the default
> +	  level of debugging information.
> +
> +	  This adds debug symbols to the kernel and modules (gcc -g), and
> +	  is needed if you intend to use kernel crashdump or binary object
> +	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
> +
> +endchoice # "Debug information"
> +
> +choice
> +	prompt "DWARF version"
> +	depends on DEBUG_INFO
> +	help
> +	  Which version of DWARF debug info to emit.
> +
>  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  	bool "Rely on the toolchain's implicit default DWARF version"
> -	select DEBUG_INFO
> -	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
>  	help
>  	  The implicit default version of DWARF debug info produced by a
>  	  toolchain changes over time.
> @@ -262,9 +287,10 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  	  support newer revisions, and prevent testing newer versions, but
>  	  those should be less common scenarios.
>  
> +	  If unsure, say Y.
> +
>  config DEBUG_INFO_DWARF4
>  	bool "Generate DWARF Version 4 debuginfo"
> -	select DEBUG_INFO
>  	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
>  	help
>  	  Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
> @@ -276,7 +302,6 @@ config DEBUG_INFO_DWARF4
>  
>  config DEBUG_INFO_DWARF5
>  	bool "Generate DWARF Version 5 debuginfo"
> -	select DEBUG_INFO
>  	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
>  	help
>  	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> @@ -291,22 +316,10 @@ config DEBUG_INFO_DWARF5
>  	  config if they rely on tooling that has not yet been updated to
>  	  support DWARF Version 5.
>  
> -endchoice # "Debug information"
> +endchoice # "DWARF version"
>  
>  if DEBUG_INFO
>  
> -config DEBUG_INFO_REDUCED
> -	bool "Reduce debugging information"
> -	help
> -	  If you say Y here gcc is instructed to generate less debugging
> -	  information for structure types. This means that tools that
> -	  need full debugging information (like kgdb or systemtap) won't
> -	  be happy. But if you merely need debugging information to
> -	  resolve line numbers there is no loss. Advantage is that
> -	  build directory object sizes shrink dramatically over a full
> -	  DEBUG_INFO build and compile times are reduced too.
> -	  Only works with newer gcc versions.
> -
>  config DEBUG_INFO_COMPRESSED
>  	bool "Compressed debugging information"
>  	depends on $(cc-option,-gz=zlib)
> -- 
> 2.34.1
> 
