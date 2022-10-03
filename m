Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1ED5F33DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJCQrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJCQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B655A303D4;
        Mon,  3 Oct 2022 09:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5342461170;
        Mon,  3 Oct 2022 16:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77975C433D6;
        Mon,  3 Oct 2022 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664815633;
        bh=w7l59wmIDWNir4WvFHbQdoRtvMv+YFpmws0JL39LjNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2aL11wX6VlhNi38RWpU9TD4hlJaysNYFuonrgQ0kmG6mWRwPOT82lvKO/eHZfvUo
         5dyDS1YMvcMm3ywUvlv6xwLtexGBFjYRebl3KKC7wPxB7oAUGcJZ0dh0by0oKVkBvy
         Bl3Mv6SeNILLwPQdiOmkp5MSULnTKsNgABE66TSsTtxfnDvMmVRDP5LJZqAtPMg1kT
         0d1qF0ZSXD6KbZeZ1CwO6pJS0tQzeG2wLAImcaqfS7ggAB3Y9PTmo7cB3eZ31Un9dW
         Wk7ef8hdmt8pc2RkBXlZS8JR/wqvRHsJRALJbDlxyQVIAimeP+6F2hHr50lXDVYyb9
         Xn1mTcB1PvPew==
Date:   Mon, 3 Oct 2022 09:47:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/3] Kconfig.debug: simplify the dependency of
 DEBUG_INFO_DWARF4/5
Message-ID: <YzsSD2d7YPPW0rz/@dev-arch.thelio-3990X>
References: <20221002181107.51286-1-masahiroy@kernel.org>
 <20221002181107.51286-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002181107.51286-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 03:11:05AM +0900, Masahiro Yamada wrote:
> Commit c0a5c81ca9be ("Kconfig.debug: drop GCC 5+ version check for
> DWARF5") could have cleaned up the code a bit deeper.
> 
> "CC_IS_CLANG &&" is unneeded. No functional change is intended.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Good point!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  lib/Kconfig.debug | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d3e5f36bb01e..f4b2165f24db 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -264,7 +264,7 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  config DEBUG_INFO_DWARF4
>  	bool "Generate DWARF Version 4 debuginfo"
>  	select DEBUG_INFO
> -	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> +	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
>  	help
>  	  Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
>  	  if using clang without clang's integrated assembler, and gdb 7.0+.
> @@ -276,7 +276,7 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_DWARF5
>  	bool "Generate DWARF Version 5 debuginfo"
>  	select DEBUG_INFO
> -	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> +	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
>  	help
>  	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
>  	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> -- 
> 2.34.1
> 
