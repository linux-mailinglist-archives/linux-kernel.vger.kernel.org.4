Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2CA67520E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjATKJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjATKI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:08:59 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9E8B32A;
        Fri, 20 Jan 2023 02:08:57 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pIoKC-002B4r-5s; Fri, 20 Jan 2023 18:08:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Jan 2023 18:08:44 +0800
Date:   Fri, 20 Jan 2023 18:08:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Rix <trix@redhat.com>
Cc:     brijesh.singh@amd.com, thomas.lendacky@amd.com, john.allen@amd.com,
        davem@davemloft.net, nathan@kernel.org, ndesaulniers@google.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v3] crypto: ccp: initialize 'error' variable to zero
Message-ID: <Y8poLLMG8C31f91j@gondor.apana.org.au>
References: <20230110170848.3022682-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110170848.3022682-1-trix@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:08:48PM -0500, Tom Rix wrote:
> Clang static analysis reports this problem
> drivers/crypto/ccp/sev-dev.c:1347:3: warning: 3rd function call
>   argument is an uninitialized value [core.CallAndMessage]
>     dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> __sev_platform_init_locked() can return without setting the
> error parameter, causing the dev_err() to report a garbage
> value.
> 
> Fixes: 200664d5237f ("crypto: ccp: Add Secure Encrypted Virtualization (SEV) command support")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v2 cleanup commit log
> v3 cleanup commit log
> ---
>  drivers/crypto/ccp/sev-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think error should be removed completely on top of

https://patchwork.kernel.org/project/linux-crypto/patch/20230110191201.29666-1-jarkko@profian.com/

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
