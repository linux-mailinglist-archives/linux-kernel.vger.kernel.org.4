Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349E56E0E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDMNMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjDMNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:12:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C00993EA;
        Thu, 13 Apr 2023 06:12:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Py0Nn70dVz4xDh;
        Thu, 13 Apr 2023 23:12:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681391546;
        bh=crgB2H34rkuafhrK1Vi28o4cqKi/40bu1huE2OcOQyU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=n8LWsImf33Tn7eZ8EBYXAVb86z1pOmBoHfcgiK0ed+Sw511ah+l0y+HfAqvOcXYoa
         Hgj8K48VeheAH2eYGFuUQQf4SR7f9aDszEmltFh1co2i0gSQfwlI29CIxgybugv7yZ
         x2hnYp2Cdhju/CldEUiSijKxuzk+HcHl/wvaOHP4OJXtVo52NirX2bd9lgNCXnWsix
         nGxXTcQRHplZt79u8EnK5s+yCqKFmTY+HrKordqt7ofQGvlDWaR4YnLn9zxFw0T/GP
         4VA+DY0Pr1aKK0lEIEGPOde8ar5ow8PoekWPAY1gwchswJ2wHtqqhEKUiNairE01Zs
         SAI6uuWJHk5Pw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: Re: [PATCH] Remove POWER10_CPU dependency and move
 PPC_MODULE_FEATURE_P10.
In-Reply-To: <20230412181232.2051-1-dtsen@linux.ibm.com>
References: <20230412181232.2051-1-dtsen@linux.ibm.com>
Date:   Thu, 13 Apr 2023 23:12:22 +1000
Message-ID: <87wn2g9b9l.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Danny Tsen <dtsen@linux.ibm.com> writes:
> Remove Power10 dependency in Kconfig and detect Power10 feature at runtime.
> Move PPC_MODULE_FEATURE_P10 definition to be in
> arch/powerpc/include/asm/cpufeature.h.

This should be two patches, one for the Kconfig change and one moving
the feature flag.

Also don't you need a cpu feature check in p10_init()? Otherwise the
driver can be loaded on non-P10 CPUs, either by being built-in, or
manually.

cheers

> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
> ---
>  arch/powerpc/crypto/Kconfig            | 2 +-
>  arch/powerpc/crypto/aes-gcm-p10-glue.c | 1 -
>  arch/powerpc/include/asm/cpufeature.h  | 1 +
>  3 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
> index 1f8f02b494e1..7113f9355165 100644
> --- a/arch/powerpc/crypto/Kconfig
> +++ b/arch/powerpc/crypto/Kconfig
> @@ -96,7 +96,7 @@ config CRYPTO_AES_PPC_SPE
>  
>  config CRYPTO_AES_GCM_P10
>  	tristate "Stitched AES/GCM acceleration support on P10 or later CPU (PPC)"
> -	depends on PPC64 && POWER10_CPU && CPU_LITTLE_ENDIAN
> +	depends on PPC64 && CPU_LITTLE_ENDIAN
>  	select CRYPTO_LIB_AES
>  	select CRYPTO_ALGAPI
>  	select CRYPTO_AEAD
> diff --git a/arch/powerpc/crypto/aes-gcm-p10-glue.c b/arch/powerpc/crypto/aes-gcm-p10-glue.c
> index 1533c8cdd26f..bd3475f5348d 100644
> --- a/arch/powerpc/crypto/aes-gcm-p10-glue.c
> +++ b/arch/powerpc/crypto/aes-gcm-p10-glue.c
> @@ -22,7 +22,6 @@
>  #include <linux/module.h>
>  #include <linux/types.h>
>  
> -#define PPC_MODULE_FEATURE_P10	(32 + ilog2(PPC_FEATURE2_ARCH_3_1))
>  #define	PPC_ALIGN		16
>  #define GCM_IV_SIZE		12
>  
> diff --git a/arch/powerpc/include/asm/cpufeature.h b/arch/powerpc/include/asm/cpufeature.h
> index f6f790a90367..2dcc66225e7f 100644
> --- a/arch/powerpc/include/asm/cpufeature.h
> +++ b/arch/powerpc/include/asm/cpufeature.h
> @@ -22,6 +22,7 @@
>   */
>  
>  #define PPC_MODULE_FEATURE_VEC_CRYPTO			(32 + ilog2(PPC_FEATURE2_VEC_CRYPTO))
> +#define PPC_MODULE_FEATURE_P10				(32 + ilog2(PPC_FEATURE2_ARCH_3_1))
>  
>  #define cpu_feature(x)		(x)
>  
> -- 
> 2.31.1
