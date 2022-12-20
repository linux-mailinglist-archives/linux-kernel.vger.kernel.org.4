Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38B26527B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLTUQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiLTUP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:15:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6711EAF5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:15:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ECB1B818AD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3F9C433EF;
        Tue, 20 Dec 2022 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671567352;
        bh=Ysbhxfb4+GSt8g7B+0msZxC7XX+fKQNQougHwdZVmyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sn6Oh5cYMfEPaNmNUsOnY6L7sLghzqaf92oeLFwxc4sUmT+Ku4UEMJl/QMossxE7k
         fkWLOdLaE64rx8tXdUhvi3+902orunRfP7G4ahtigr3Ab0O5GA93jF8ELkPVT0i6+Y
         Pxx1l1hyrcHua1ceEIDp+vCOp4wMxOekOaVaXVA9NBEdB/TX9zEW1DhH37Idk9ObK0
         Ph7Wib9FEtR8/LMy4E0JjUDAPuGvutlR+5oNSEk2g4jh/T+x5jkwnqmau63fyOYB11
         4pqqNHkYOiD6q19fKDaKf2QO8UFxJPbbJCZi1Vj599TiAqz/mD7VmfDNBdE7eh5h1u
         T3Nyt28m84plQ==
Received: by pali.im (Postfix)
        id ABF36963; Tue, 20 Dec 2022 21:15:49 +0100 (CET)
Date:   Tue, 20 Dec 2022 21:15:49 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] powerpc: Remove cpu-as-y completely
Message-ID: <20221220201549.fpnopv6h4y5mpabj@pali>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
 <9e43ad8b173c2fdb540e2555a8ba3e375419f3cf.1671475543.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e43ad8b173c2fdb540e2555a8ba3e375419f3cf.1671475543.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 December 2022 19:45:59 Christophe Leroy wrote:
> cpu-as-y is there to force assembler building options.
> But there is no need for that. Gcc is passed the necessary
> options and it automatically pass the appropriate option to
> GAS.
> 
> GCC is given -maltivec when relevant, so no need
> for -Wa,-maltivec in addition
> 
> And -Wa,-many is wrong as it will hide innapropriate
> instructions. Better to detect them and handle them on a
> case by case basis.
> -Wa,-many was added by commit 960e30029863 ("powerpc/Makefile:
> Fix PPC_BOOK3S_64 ASFLAGS") in order to fix an issue with
> clang and the passed -Wa,-mpower4 option. But we have now
> removed it expecting the compiler to automatically pass the
> proper options and instructions based on -mcpu=power4
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  arch/powerpc/Makefile | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 0f9f291895cb..7e67f939a243 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -201,18 +201,6 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  # often slow when they are implemented at all
>  KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
>  
> -cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
> -
> -# When using '-many -mpower4' gas will first try and find a matching power4
> -# mnemonic and failing that it will allow any valid mnemonic that GAS knows
> -# about. GCC will pass -many to GAS when assembling, clang does not.
> -# LLVM IAS doesn't understand either flag: https://github.com/ClangBuiltLinux/linux/issues/675
> -# but LLVM IAS only supports ISA >= 2.06 for Book3S 64 anyway...
> -cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-many)
> -
> -KBUILD_AFLAGS += $(cpu-as-y)
> -KBUILD_CFLAGS += $(cpu-as-y)
> -
>  KBUILD_AFLAGS += $(aflags-y)
>  KBUILD_CFLAGS += $(cflags-y)
>  
> -- 
> 2.38.1
> 
