Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878455FD313
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJMCA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJMCAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:00:20 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D45E37;
        Wed, 12 Oct 2022 19:00:19 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oinW2-00EA1F-DO; Thu, 13 Oct 2022 13:00:07 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 13 Oct 2022 10:00:06 +0800
Date:   Thu, 13 Oct 2022 10:00:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, tim.c.chen@linux.intel.com,
        ap420073@gmail.com, ardb@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/19] crypto: x86/crc - limit FPU preemption
Message-ID: <Y0dxJrRx/Neo4r1Z@gondor.apana.org.au>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-6-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012215931.3896-6-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 04:59:17PM -0500, Robert Elliott wrote:
>
> @@ -170,9 +179,17 @@ static int __crc32c_pcl_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
>  				u8 *out)
>  {
>  	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
> -		kernel_fpu_begin();
> -		*(__le32 *)out = ~cpu_to_le32(crc_pcl(data, len, *crcp));
> -		kernel_fpu_end();
> +		do {
> +			unsigned int chunk = min(len, FPU_BYTES);
> +
> +			kernel_fpu_begin();
> +			*crcp = crc_pcl(data, chunk, *crcp);

How about storing the intermediate result in a local variable
instead of overwriting *crcp?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
