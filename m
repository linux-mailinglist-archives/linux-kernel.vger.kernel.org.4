Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC8D6CF237
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC2ShZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC2ShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:37:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63E2D55;
        Wed, 29 Mar 2023 11:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE84CB823FB;
        Wed, 29 Mar 2023 18:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71085C433D2;
        Wed, 29 Mar 2023 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680115037;
        bh=gtCGbqJ0FbcE4MHF5hlo02AxFG+1NLUpi8vGAbO82nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K99OoVJjrepIqcQhSEEt1tV5dFvZ2XNQq76XJFHC7YANN6yWN6UQshxWm2LTUtSWl
         zrpPHxayptuZoplFym7EsCqJygCDMfst7ShEKZub4Tg/ordCEzTvRAEJn5QU0qtIG3
         FUoOVfA+vETzZqrYartLnUycD+9P5AEaGWn2w9s98Bgjv3mxJ0BdgEiIIoqRBvnrdU
         cf1gwWOhCoP4bC8sK00Z1T8Y4gSGK50rmIws15Xb6kRz+yzgPT/R8Y5AsTEXJPX5uE
         cc8zTFjfglgqxsc947xTzgNJMSIvBRxPTX0RYCKF+J6sax9eH+PHH9CQTvx2k5WE9Q
         8p6RPuPtCO6uw==
Date:   Wed, 29 Mar 2023 18:37:16 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 4/4] RISC-V: crypto: add accelerated GCM GHASH
 implementation
Message-ID: <ZCSFXIAnl6LTVLJL@gmail.com>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
 <20230329140642.2186644-5-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329140642.2186644-5-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, Mar 29, 2023 at 04:06:42PM +0200, Heiko Stuebner wrote:
> diff --git a/arch/riscv/crypto/ghash-riscv64-zbc.pl b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> new file mode 100644
> index 000000000000..691231ffa11c
> --- /dev/null
> +++ b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> @@ -0,0 +1,400 @@
> +#! /usr/bin/env perl
> +# Copyright 2022 The OpenSSL Project Authors. All Rights Reserved.
> +#
> +# Licensed under the Apache License 2.0 (the "License").  You may not use
> +# this file except in compliance with the License.  You can obtain a copy
> +# in the file LICENSE in the source distribution or at
> +# https://www.openssl.org/source/license.html

My understanding is that code that is licensed under (only) the Apache License
2.0 cannot be included in GPLv2 programs such as the Linux kernel.

Is this code written by Andy Polyakov?  What's been done in the past for his
code is that he re-releases it in CRYPTOGAMS at
https://github.com/dot-asm/cryptogams with a Linux kernel compatible license.
The Linux kernel then takes the code from there instead of from OpenSSL.

- Eric
