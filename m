Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA962BC25
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiKPLhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbiKPLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:36:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B7951C2E;
        Wed, 16 Nov 2022 03:26:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2055361CFF;
        Wed, 16 Nov 2022 11:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53730C433C1;
        Wed, 16 Nov 2022 11:26:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mcP6Fk7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668597963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NHhqvFQ5r0anWMx+9slZK6tVQP3dyCKSR+RxTtYRrmg=;
        b=mcP6Fk7r7H+2tdZmTuha/S5We8nfoRWo6qc7lCiulf31/juAQ86eiiZN3t4ns8nSP+vWbq
        hmM261s8VwnS0ryyccthoS5RS59GGEsTmzisU+Fj8d1qGIzJOITdTNqmBQa1gul3dd/lG1
        XH75Anwak5x40AeeLnJ1lk49p+Lefmk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ccbc54fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 11:26:02 +0000 (UTC)
Date:   Wed, 16 Nov 2022 12:26:00 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 21/24] crypto: x86 - report used CPU features via
 module parameters
Message-ID: <Y3TIyAjV5i02W9z5@zx2c4.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-22-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221116041342.3841-22-elliott@hpe.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:13:39PM -0600, Robert Elliott wrote:
> For modules that have multiple choices, add read-only module parameters
> reporting which CPU features a module is using.
> 
> The parameters show up as follows for modules that modify the behavior
> of their registered drivers or register additional drivers for
> each choice:
>     /sys/module/aesni_intel/parameters/using_x86_avx:1
>     /sys/module/aesni_intel/parameters/using_x86_avx2:1
>     /sys/module/aria_aesni_avx_x86_64/parameters/using_x86_gfni:0
>     /sys/module/chacha_x86_64/parameters/using_x86_avx2:1
>     /sys/module/chacha_x86_64/parameters/using_x86_avx512:1
>     /sys/module/crc32c_intel/parameters/using_x86_pclmulqdq:1
>     /sys/module/curve25519_x86_64/parameters/using_x86_adx:1
>     /sys/module/libblake2s_x86_64/parameters/using_x86_avx512:1
>     /sys/module/libblake2s_x86_64/parameters/using_x86_ssse3:1
>     /sys/module/poly1305_x86_64/parameters/using_x86_avx:1
>     /sys/module/poly1305_x86_64/parameters/using_x86_avx2:1
>     /sys/module/poly1305_x86_64/parameters/using_x86_avx512:0
>     /sys/module/sha1_ssse3/parameters/using_x86_avx:1
>     /sys/module/sha1_ssse3/parameters/using_x86_avx2:1
>     /sys/module/sha1_ssse3/parameters/using_x86_shani:0
>     /sys/module/sha1_ssse3/parameters/using_x86_ssse3:1
>     /sys/module/sha256_ssse3/parameters/using_x86_avx:1
>     /sys/module/sha256_ssse3/parameters/using_x86_avx2:1
>     /sys/module/sha256_ssse3/parameters/using_x86_shani:0
>     /sys/module/sha256_ssse3/parameters/using_x86_ssse3:1
>     /sys/module/sha512_ssse3/parameters/using_x86_avx:1
>     /sys/module/sha512_ssse3/parameters/using_x86_avx2:1
>     /sys/module/sha512_ssse3/parameters/using_x86_ssse3:1

Isn't chacha missing?

However, what's the point of any of this? Who benefits from this info?
If something seems slow, I'll generally look at perf top, which provides
this same thing.

Also, "using" isn't quite correct. Some AVX2 machines will never use any
ssse3 instructions, despite the code being executable.

> 
> Delete the aesni_intel prints reporting those selections:
>     pr_info("AVX2 version of gcm_enc/dec engaged.\n");

This part I like.

> +module_param_named(using_x86_adx, curve25519_use_bmi2_adx.key.enabled.counter, int, 0444);
> +MODULE_PARM_DESC(using_x86_adx, "Using x86 instruction set extensions: ADX");

And BMI2, not just ADX.
