Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0B5FD471
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJMGDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJMGDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:03:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52AE10566D;
        Wed, 12 Oct 2022 23:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 659F7B81CAA;
        Thu, 13 Oct 2022 06:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD38EC433D6;
        Thu, 13 Oct 2022 06:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665640996;
        bh=F1785BOSplLzR4WTfp2dJKZ1diabrk2YQw2XRMSDRVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJj1gDIPPnPFO9tP5GU0QFleMWK0fJYTSPjnzIDUJ6eSgGCUr1GCqmkFGTObnOgio
         pEt4h6Tdt37JaJWAvJLM2UwuPTnUa5Ef1GrPb4PETBSLyWs7nWzXofhBd6f9kHb1Ne
         w6mip2sJjSaAfoGrgzysgpPS1jWj9ZBW/5fS2psP4UgduSZT2aKyhYSQzmnDcD+0Ls
         V1/CHnTXdlzfDCpslYS7QjsSoHA9x8e2/vWWsbeiosGBhgXLiOJT5KHWwK9YdT0daQ
         uPu194T70QgXrD/oZ8Zv81TEPSMeDbgoCxwU0W0V4+nEa1zc/5CRg+f16DMZdmHFg3
         Ksv8sOMdpav9w==
Date:   Wed, 12 Oct 2022 23:03:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/19] crypto: x86/ghash - limit FPU preemption
Message-ID: <Y0eqIQ9PC3Edd+D/@sol.localdomain>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-9-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012215931.3896-9-elliott@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 04:59:20PM -0500, Robert Elliott wrote:
> -	kernel_fpu_begin();
> -	clmul_ghash_update(dst, src, srclen, &ctx->shash);
> -	kernel_fpu_end();
> +	while (srclen >= GHASH_BLOCK_SIZE) {
> +		unsigned int fpulen = min(srclen, FPU_BYTES);
> +
> +		kernel_fpu_begin();
> +		while (fpulen >= GHASH_BLOCK_SIZE) {
> +			int n = min_t(unsigned int, fpulen, GHASH_BLOCK_SIZE);
> +
> +			clmul_ghash_update(dst, src, n, &ctx->shash);
> +
> +			srclen -= n;
> +			fpulen -= n;
> +			src += n;
> +		}
> +		kernel_fpu_end();
> +	}

Another loop that doesn't make sense.  Why is this only passing 16 bytes at a
time into the assembly code?  There shouldn't be an inner loop here at all.

- Eric
