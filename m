Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E706E2400
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDNNIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNNIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:08:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4E6E77;
        Fri, 14 Apr 2023 06:08:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PycFc55W0z4xDp;
        Fri, 14 Apr 2023 23:08:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681477701;
        bh=oj/wAWvWwblyAy9BivgS9S5w0Qg18/UMB9ocKCFLE8Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AI6TsBJJTv4I2Vv0XN3pvsY3994LZ5BmYemqW7/MsyiHQSzEbkP4SLwc6hEgrLyVq
         5rUJB7vaqMls8qsgrvRV+qmzBf1xOsiYZu3fg4JSrpcQw5CfBJbbeeLwqi46ImlnWu
         i+6ravrfwv1mRDgDxcwojXWeQ4gw/GAw7rYsUQslDrO4M8LFRr6uuNf0xczs8helCM
         YeC+wisOnp9G5rlqdLZD+m7Lr5asYDIst48O9Mzxhw+ic+YEHr/tR5OnGaid2u9OWz
         RXUi5j7bUDEDhaC4VyrHTNicU+uelac+Dormr2/kWG0eIKdh3EhgbSgjo3g9e3csCV
         o/ponLWrNh3IQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] Remove POWER10_CPU dependency.
In-Reply-To: <20230413194625.10631-2-dtsen@linux.ibm.com>
References: <20230413194625.10631-1-dtsen@linux.ibm.com>
 <20230413194625.10631-2-dtsen@linux.ibm.com>
Date:   Fri, 14 Apr 2023 23:08:14 +1000
Message-ID: <87ildya9xd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Danny Tsen <dtsen@linux.ibm.com> writes:
> Remove Power10 dependency in Kconfig and detect Power10 feature at runtime.

... using the existing call to module_cpu_feature_match() :)

> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
> ---
>  arch/powerpc/crypto/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

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
> -- 
> 2.31.1
