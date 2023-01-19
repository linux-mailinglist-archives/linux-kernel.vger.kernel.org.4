Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8C2674B18
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjATEoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjATEnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:43:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5115C4585
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:39:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0809B826F4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 18:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D091EC433EF;
        Thu, 19 Jan 2023 18:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674153884;
        bh=faXqnVFxCaTO+HtK1xtCzq7sAIRKpPiqBX5y1aM7img=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVvIxldflGICga3EBD5uaWrtAUhoh/WyERGIzSbbuIGRrw6/PseX4Tx1/TlDHTBVj
         VngIeotz5JNDs5M+U8Q+XSuJF/fGsAUaou+vEHp9wQuqfSnQ8xyP9TPAfYNmjxYO+d
         6EeGzkl+0fc6OC9Wl5QWvJY8taGwaWkdM07++BbHxAml957M6Rfsvh+6PRKL7I7dP7
         7tPbGwvVMsV2wQ8alBZDhED5dNbA6g1prHu/pvgSt5E9DQ9zhOk+wcuyfTuKfQlwDA
         5EhCex68o/NXykbN1N/2xWxoUkkWoa+gdhvgqwO0VJ2gTCu6auDaZkXSH3T3Ghkv45
         16el007k447Dw==
Date:   Thu, 19 Jan 2023 11:44:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
Message-ID: <Y8mPmqDWiRJNdXs/@thelio-3990X>
References: <20230119082447.152020-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119082447.152020-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 05:24:47PM +0900, Masahiro Yamada wrote:
> crtsavres.o is linked to modules, but as commit d0e628cd817f ("kbuild:
> doc: clarify the difference between extra-y and always-y") explained,
> 'make modules' does not build extra-y.
> 
> The following command fails:
> 
>   $ make ARCH=powerpc LLVM=1 mrproper ps3_defconfig modules
>     [snip]
>     LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
>   ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such file or directory
>   make[1]: *** [scripts/Makefile.modfinal:61: arch/powerpc/platforms/cell/spufs/spufs.ko] Error 1
>   make: *** [Makefile:1924: modules] Error 2
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  arch/powerpc/lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index c53618c34b70..aa34854bc9f5 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -43,7 +43,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
>  # so it is only needed for modules, and only for older linkers which
>  # do not support --save-restore-funcs
>  ifndef CONFIG_LD_IS_BFD
> -extra-$(CONFIG_PPC64)	+= crtsavres.o
> +always-$(CONFIG_PPC64)	+= crtsavres.o
>  endif
>  
>  obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
> -- 
> 2.34.1
> 
