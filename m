Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F53067E2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjA0LH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjA0LHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:07:25 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD774F37E;
        Fri, 27 Jan 2023 03:07:24 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pLMZh-004hQP-Rm; Fri, 27 Jan 2023 19:07:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Jan 2023 19:07:17 +0800
Date:   Fri, 27 Jan 2023 19:07:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Stephan Mueller <smueller@chronox.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - disallow certain DRBG hash functions
 in FIPS mode
Message-ID: <Y9OwZUbZpHQ3gMl4@gondor.apana.org.au>
References: <20230117172006.8912-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117172006.8912-1-vdronov@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:20:06PM +0100, Vladis Dronov wrote:
> According to FIPS 140-3 IG, section D.R "Hash Functions Acceptable for
> Use in the SP 800-90A DRBGs", modules certified after May 16th, 2023
> must not support the use of: SHA-224, SHA-384, SHA512-224, SHA512-256,
> SHA3-224, SHA3-384. Disallow HMAC and HASH DRBGs using SHA-384 in FIPS
> mode.
> 
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
> Some details:
> 
> The following DRBG algos are defined in testmgr.c as of now:
> 
> drbg_{no,}pr_ctr_aes128
> drbg_{no,}pr_ctr_aes192
> drbg_{no,}pr_ctr_aes256
> 
> drbg_{no,}pr_hmac_sha1
> drbg_{no,}pr_hmac_sha256
> drbg_{no,}pr_hmac_sha384 (disallow)
> drbg_{no,}pr_hmac_sha512
> 
> drbg_{no,}pr_sha1
> drbg_{no,}pr_sha256
> drbg_{no,}pr_sha384 (disallow)
> drbg_{no,}pr_sha512
> 
> Marked DRBGs should be disallowed in FIPS mode according to
> the requirements above.
> ---
>  crypto/testmgr.c | 4 ----
>  1 file changed, 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
