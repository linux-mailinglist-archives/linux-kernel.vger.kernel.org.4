Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632AA66B62C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjAPDds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjAPDdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:33:46 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568803C34;
        Sun, 15 Jan 2023 19:33:45 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pHGF9-000Mjk-F4; Mon, 16 Jan 2023 11:33:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 16 Jan 2023 11:33:07 +0800
Date:   Mon, 16 Jan 2023 11:33:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "peter@n8pjl.ca" <peter@n8pjl.ca>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/13] crypto: x86/sha - yield FPU context during long
 loops
Message-ID: <Y8TFc84dm3hSVHv5@gondor.apana.org.au>
References: <20221219220223.3982176-1-elliott@hpe.com>
 <20221219220223.3982176-4-elliott@hpe.com>
 <Y7+/Yy7+mLEyqeiK@gondor.apana.org.au>
 <Y8BVkjwPc6DLm7HT@sol.localdomain>
 <Y8DDmBg6J31pS0KW@gondor.apana.org.au>
 <Y8DD8s9nakxW5zzE@gondor.apana.org.au>
 <MW5PR84MB1842C7F8190348625158DE9CABC29@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB1842C7F8190348625158DE9CABC29@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 07:35:07PM +0000, Elliott, Robert (Servers) wrote:
>
> pkcs_digest() uses shash like this:
>         /* Allocate the hashing algorithm we're going to need and find out how
>          * big the hash operational data will be.
>          */
>         tfm = crypto_alloc_shash(sinfo->sig->hash_algo, 0, 0);
>         if (IS_ERR(tfm))
>                 return (PTR_ERR(tfm) == -ENOENT) ? -ENOPKG : PTR_ERR(tfm);
> 
>         desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
>         sig->digest_size = crypto_shash_digestsize(tfm);
> 
>         ret = -ENOMEM;
>         sig->digest = kmalloc(sig->digest_size, GFP_KERNEL);
>         if (!sig->digest)
>                 goto error_no_desc;
> 
>         desc = kzalloc(desc_size, GFP_KERNEL);
>         if (!desc)
>                 goto error_no_desc;
> 
>         desc->tfm   = tfm;
> 
>         /* Digest the message [RFC2315 9.3] */
>         ret = crypto_shash_digest(desc, pkcs7->data, pkcs7->data_len,
>                                   sig->digest);
>         if (ret < 0)
>                 goto error;
>         pr_devel("MsgDigest = [%*ph]\n", 8, sig->digest);

As this path is sleepable, the conversion should be fairly trivial
with crypto_wait_req.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
