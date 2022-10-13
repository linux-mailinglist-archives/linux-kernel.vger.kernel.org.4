Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42645FD45E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJMF5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJMF5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92662127BFC;
        Wed, 12 Oct 2022 22:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E4A616FF;
        Thu, 13 Oct 2022 05:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3278EC433C1;
        Thu, 13 Oct 2022 05:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665640626;
        bh=I/882b5jXItKMfRHTuet95Qg1YMdUHzLfSQFTAbLnZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrmEQeGMLGZxFzxAoV3/b27ViZsZ8sPvyFH/rb2Q+/aYAfc/s0zTvJrBv+xrQQRV4
         0qG69iZJMsEcMZnpgsrJaoKT9z+O2t/01SsBIniei54pZSa25FiTifJWxvrb9JjoNp
         L2sQCKRWpyRXOClD7dkdHCgDqIYJhYMsLYvgMBOfzTn/iQ/pL2sOVhSMBdVMl38uqC
         6XF3lV82UZWkDg/sA/t8RD0EVIMho9D3k/cWZYSdBLdZlQZEibhhr7LmOu09r6rEAK
         QzbV6SVHHq4ZM+fRhCMeuGpnJIRaZYihVMDqRycfku3X2UiWqOPldMP0bCbKaudRoB
         bVtOecleheOag==
Date:   Wed, 12 Oct 2022 22:57:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Message-ID: <Y0eosAIgkvMzYJz8@sol.localdomain>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-5-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012215931.3896-5-elliott@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 04:59:16PM -0500, Robert Elliott wrote:
> diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
> index 44340a1139e0..a9f5779b41ca 100644
> --- a/arch/x86/crypto/sha1_ssse3_glue.c
> +++ b/arch/x86/crypto/sha1_ssse3_glue.c
> @@ -26,6 +26,8 @@
>  #include <crypto/sha1_base.h>
>  #include <asm/simd.h>
>  
> +#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
> +
>  static int sha1_update(struct shash_desc *desc, const u8 *data,
>  			     unsigned int len, sha1_block_fn *sha1_xform)
>  {
> @@ -41,9 +43,18 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
>  	 */
>  	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
>  
> -	kernel_fpu_begin();
> -	sha1_base_do_update(desc, data, len, sha1_xform);
> -	kernel_fpu_end();
> +	do {
> +		unsigned int chunk = min(len, FPU_BYTES);
> +
> +		if (chunk) {
> +			kernel_fpu_begin();
> +			sha1_base_do_update(desc, data, chunk, sha1_xform);
> +			kernel_fpu_end();
> +		}
> +
> +		len -= chunk;
> +		data += chunk;
> +	} while (len);

'len' can't be 0 at the beginning of this loop, so the 'if (chunk)' check isn't
needed.  And it wouldn't make sense even if 'len' could be 0, since a while loop
could just be used in that case.

- Eric
