Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C957400F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjF0QZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjF0QZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:25:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09BA1FF0;
        Tue, 27 Jun 2023 09:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D483611DA;
        Tue, 27 Jun 2023 16:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B60C43140;
        Tue, 27 Jun 2023 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687883098;
        bh=jKKR5PNgNFP6ECOtEfBH8lo88UqUsORih3jRd4zDBJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9kPtfDaBiPNpJt60dsV6FEJ6AgzbVdJu0iSwrn80kuJ5InxY+tmGHKW3rKygy31e
         xiujV6hNF6E0QiI/hFmYt2yFaSn9r0CPPnsENrAQSpx38nArP7op3eTt5r8jwB8Alk
         DiNI+oRC89EiNmLKtdvaDTu2kg5NyLZmPLRCpgsTtEYF3v22LSh9QMrSdnoYrH6GVD
         /MNSMO1aHPsoT+0VORqDjhx7z76MLtB5D27heMHxe9/1N4HP/s4glVKjACnMpCTq2n
         g76Ufh9EEI16rqX4X9fYm2j+o+hnqKgWL5+wGhKYoRgoBQPqT8F237jVvED56YlQMX
         WNyyN+lmdBwQQ==
Date:   Tue, 27 Jun 2023 09:24:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: Re: [PATCH 1/2] LoongArch: vDSO: Use CLANG_FLAGS instead of
 filtering out '--target='
Message-ID: <20230627162456.GA223742@dev-arch.thelio-3990X>
References: <20230627130122.1491765-1-kernel@xen0n.name>
 <20230627130122.1491765-2-kernel@xen0n.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627130122.1491765-2-kernel@xen0n.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 09:01:21PM +0800, WANG Xuerui wrote:
> From: WANG Xuerui <git@xen0n.name>
> 
> This is a port of commit 76d7fff22be3e ("MIPS: VDSO: Use CLANG_FLAGS
> instead of filtering out '--target='") to arch/loongarch, for fixing
> cross-compilation with Clang.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1787#issuecomment-1608306002
> Signed-off-by: WANG Xuerui <git@xen0n.name>

Thanks for the patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/loongarch/vdso/Makefile | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index 3f9df4d9930f..a50308b6fc25 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -12,12 +12,9 @@ ccflags-vdso := \
>  	$(filter -E%,$(KBUILD_CFLAGS)) \
>  	$(filter -march=%,$(KBUILD_CFLAGS)) \
>  	$(filter -m%-float,$(KBUILD_CFLAGS)) \
> +	$(CLANG_FLAGS) \
>  	-D__VDSO__
>  
> -ifeq ($(cc-name),clang)
> -ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
> -endif
> -
>  cflags-vdso := $(ccflags-vdso) \
>  	-isystem $(shell $(CC) -print-file-name=include) \
>  	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
> -- 
> 2.40.0
> 
