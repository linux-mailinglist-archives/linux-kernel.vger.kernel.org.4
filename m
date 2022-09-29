Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3729C5EFCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiI2SSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiI2SSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:18:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3894A1F7B2D;
        Thu, 29 Sep 2022 11:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9B88B8257B;
        Thu, 29 Sep 2022 18:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D8EC433D6;
        Thu, 29 Sep 2022 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664475479;
        bh=nDnHLzf58bxqnErR+eXLb4bIm338J8AUuIB1gu/k4CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGuq76aYxzPqms4X0Ukp+5q0L03XuDDezfS1SEF7JWCWjm8dxWNfnV5SZyUfSDDvZ
         PWuh2dZQfLK5fRKYkxm5CwhFbxNt5BFPWoR2JVwuFECX3Yn6V0iAQfL5RMZNesIxlN
         64wKlKn4JOBC22HKLToKjDCN7Z1HTJUM90hbvP8wg+xS+3ymD1Cxl5L2RWfgorNDU6
         Sq2r09C/xl3lDiBfEUP57QivbAewPkpoAncNpqR+t6G4bfWkKEX6KVLZlsM0jc2pwT
         fofSAxtEsmXCXnsG7IiB1JGLtUvyULedxDRkor814YApaTPciHS0BgHGSWiopImHL5
         Ib/auPNvSVkig==
Date:   Thu, 29 Sep 2022 11:17:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] Revert "kbuild: Check if linker supports the -X option"
Message-ID: <YzXhVSkCVKZzpf9H@dev-arch.thelio-3990X>
References: <20220929181223.2502994-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929181223.2502994-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:12:23AM +0900, Masahiro Yamada wrote:
> This reverts commit d79a27195a33f4b5e591de5536799ad874ea6cf5.
> 
> According to the commit description, this ld-option test was added for
> the gold linker at that time.
> 
> Commit 75959d44f9dc ("kbuild: Fail if gold linker is detected") gave
> up the gold linker support after all.
> 
> I tested the BFD linker from binutils 2.23 and LLD from LLVM 11.0.0.
> Both of them support the -X option.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 49dcae886c48..d7c85ec79000 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1037,7 +1037,7 @@ KBUILD_LDFLAGS	+= $(call ld-option,--no-warn-rwx-segments)
>  endif
>  
>  ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
> -LDFLAGS_vmlinux	+= $(call ld-option, -X,)
> +LDFLAGS_vmlinux	+= -X
>  endif
>  
>  ifeq ($(CONFIG_RELR),y)
> -- 
> 2.34.1
> 
