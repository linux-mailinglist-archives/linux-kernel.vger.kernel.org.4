Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B767C7DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjAZJ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAZJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:59:15 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B641E5E3;
        Thu, 26 Jan 2023 01:59:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2blG3YNkz4xyF;
        Thu, 26 Jan 2023 20:59:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1674727148;
        bh=5hmT+pUqAPEqD7swMk5Fu2h+tSg6SpqGmlcnSglNmzo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ckTJ2dwo54F+GOKoH7L3XD0wHuMyujSAvyTfKxflfZ0bBfLN9sES4voDIIWq2i7D+
         ZZTQAj4IsSE7l21Iyr8XlAgPPDdZMuZ/W/T1hrjGR+s8PxsfkJvoIDwatFnpTWxOTl
         1MMDjLOGYwHxjc7SSiFbdVUlLIM6TfTcX9uoyLfsPlHD4zoHoICpmoQkotvADZWRvO
         mv+36cit9j285RNnxVXQQZMWThAJJgtFoXLOYaZEBKFCEQW7Nuj2XVmj+ol3uHxfK8
         L3nTin5TCiArcnMAtBG9ylOCP4TjzJe0iggJIpTlKIP/8PafajDAtPiP+NQsYmHfGg
         dKtHzPoOWFWzQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Herve Codina <herve.codina@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 04/10] powerpc/8xx: Use a larger CPM1 command check mask
In-Reply-To: <20230126083222.374243-5-herve.codina@bootlin.com>
References: <20230126083222.374243-1-herve.codina@bootlin.com>
 <20230126083222.374243-5-herve.codina@bootlin.com>
Date:   Thu, 26 Jan 2023 20:59:03 +1100
Message-ID: <87mt65pqfs.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herve Codina <herve.codina@bootlin.com> writes:
> The CPM1 command mask is defined for use with the standard
> CPM1 command register as described in the user's manual:
>   0  |1        3|4    7|8   11|12      14| 15|
>   RST|    -     |OPCODE|CH_NUM|     -    |FLG|
>
> In the QMC extension the CPM1 command register is redefined
> (QMC supplement user's manuel) with the following mapping:
>   0  |1        3|4    7|8           13|14| 15|
>   RST|QMC OPCODE|  1110|CHANNEL_NUMBER| -|FLG|
>
> Extend the check command mask in order to support both the
> standard CH_NUM field and the QMC extension CHANNEL_NUMBER
> field.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/platforms/8xx/cpm1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
> index 8ef1f4392086..6b828b9f90d9 100644
> --- a/arch/powerpc/platforms/8xx/cpm1.c
> +++ b/arch/powerpc/platforms/8xx/cpm1.c
> @@ -100,7 +100,7 @@ int cpm_command(u32 command, u8 opcode)
>  	int i, ret;
>  	unsigned long flags;
>  
> -	if (command & 0xffffff0f)
> +	if (command & 0xffffff03)
>  		return -EINVAL;
>  
>  	spin_lock_irqsave(&cmd_lock, flags);
> -- 
> 2.39.0
