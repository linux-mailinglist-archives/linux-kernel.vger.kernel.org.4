Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E75FD1DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 02:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJMAyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 20:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiJMAxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ADCC2C;
        Wed, 12 Oct 2022 17:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0941561683;
        Thu, 13 Oct 2022 00:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3ECC433B5;
        Thu, 13 Oct 2022 00:41:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FdSpELwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665621710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eIMFDNL+viH5FIzK+nsQrnAh9WLYRI0X8JYxLiw0yq0=;
        b=FdSpELwhbtxRZzMMEttT2tsKFkp0aOTKml20lplHcGuvRyJq36k0t09zbsYKNjsdgiQ64i
        QqaZAt5x75h2yc/8d2EVhjvinuiMdb1gY+4/gBhzgglZ0+WW/d2yjuSYzI6LaA9JT5TQ6E
        pl1/Vu1A7ibUh5E7i9IsUoG/+WZFeE0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ca53f257 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Oct 2022 00:41:50 +0000 (UTC)
Date:   Wed, 12 Oct 2022 18:41:45 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Message-ID: <Y0deya7WnwS0HMwl@zx2c4.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-5-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012215931.3896-5-elliott@hpe.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 04:59:16PM -0500, Robert Elliott wrote:
> As done by the ECB and CBC helpers in arch/x86/crypt/ecb_cbc_helpers.h,
> limit the number of bytes processed between kernel_fpu_begin() and
> kernel_fpu_end() calls.
> 
> Those functions call preempt_disable() and preempt_enable(), so
> the CPU core is unavailable for scheduling while running.
> 
> This leads to "rcu_preempt detected expedited stalls" with stack dumps
> pointing to the optimized hash function if the module is loaded and
> used a lot:
>     rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: ...
> 
> For example, that can occur during boot with the stack track pointing
> to the sha512-x86 function if the system set to use SHA-512 for
> module signing. The call trace includes:
>     module_sig_check
>     mod_verify_sig
>     pkcs7_verify
>     pkcs7_digest
>     sha512_finup
>     sha512_base_do_update
> 
> Fixes: 66be89515888 ("crypto: sha1 - SSSE3 based SHA1 implementation for x86-64")
> Fixes: 8275d1aa6422 ("crypto: sha256 - Create module providing optimized SHA256 routines using SSSE3, AVX or AVX2 instructions.")
> Fixes: 87de4579f92d ("crypto: sha512 - Create module providing optimized SHA512 routines using SSSE3, AVX or AVX2 instructions.")
> Fixes: aa031b8f702e ("crypto: x86/sha512 - load based on CPU features")
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  arch/x86/crypto/sha1_ssse3_glue.c   | 32 ++++++++++++++++++++++++-----
>  arch/x86/crypto/sha256_ssse3_glue.c | 32 ++++++++++++++++++++++++-----
>  arch/x86/crypto/sha512_ssse3_glue.c | 32 ++++++++++++++++++++++++-----
>  3 files changed, 81 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
> index 44340a1139e0..a9f5779b41ca 100644
> --- a/arch/x86/crypto/sha1_ssse3_glue.c
> +++ b/arch/x86/crypto/sha1_ssse3_glue.c
> @@ -26,6 +26,8 @@
>  #include <crypto/sha1_base.h>
>  #include <asm/simd.h>
>  
> +#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */

Declare this inside the function it's used as an untyped enum, and give
it a better name, like BYTES_PER_FPU.
