Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8E62BC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiKPLqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKPLpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:45:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3A4FAEF;
        Wed, 16 Nov 2022 03:30:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4529761D14;
        Wed, 16 Nov 2022 11:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818CEC433C1;
        Wed, 16 Nov 2022 11:30:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nWynAbr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668598231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+N8BinC/cbIaGX7IiW1cNUIndGYyLx/TYTP2DmKXkPU=;
        b=nWynAbr5b8NnurOjaYS4AqaMT9HpZs5KPbVP1otLyQKD5w+qj3fu85gcbCyyklja/7jx5Y
        Q1KXnLnFSfwPrtN0FetsAbLz9QbeRrYzoPmgOcozgwutVkFrhTFBCc1F6xDsxU1Dm235ri
        CgC1XOAHjQUbLbRg95zXRCY6WXgIO/0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id aebcd94f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 11:30:31 +0000 (UTC)
Date:   Wed, 16 Nov 2022 12:30:29 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 20/24] crypto: x86/ciphers - load based on CPU features
Message-ID: <Y3TJ1e3FzsO5Cae8@zx2c4.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-21-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221116041342.3841-21-elliott@hpe.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:13:38PM -0600, Robert Elliott wrote:
> diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
> index d55fa9e9b9e6..ae7536b17bf9 100644
> --- a/arch/x86/crypto/curve25519-x86_64.c
> +++ b/arch/x86/crypto/curve25519-x86_64.c
> @@ -12,7 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/scatterlist.h>
> -
> +#include <asm/cpu_device_id.h>
>  #include <asm/cpufeature.h>
>  #include <asm/processor.h>
>  
> @@ -1697,13 +1697,22 @@ static struct kpp_alg curve25519_alg = {
>  	.max_size		= curve25519_max_size,
>  };
>  
> +static const struct x86_cpu_id module_cpu_ids[] = {
> +	X86_MATCH_FEATURE(X86_FEATURE_ADX, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
>  
>  static int __init curve25519_mod_init(void)
>  {
> -	if (boot_cpu_has(X86_FEATURE_BMI2) && boot_cpu_has(X86_FEATURE_ADX))
> -		static_branch_enable(&curve25519_use_bmi2_adx);
> -	else
> -		return 0;
> +	if (!x86_match_cpu(module_cpu_ids))
> +		return -ENODEV;
> +
> +	if (!boot_cpu_has(X86_FEATURE_BMI2))
> +		return -ENODEV;
> +
> +	static_branch_enable(&curve25519_use_bmi2_adx);

Can the user still insmod this? If so, you can't remove the ADX check.
Ditto for rest of patch.
