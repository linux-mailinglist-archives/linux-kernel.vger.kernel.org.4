Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A9064685D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLHE7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLHE67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:58:59 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483A77DA7C;
        Wed,  7 Dec 2022 20:58:57 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p38zi-005EOm-IS; Thu, 08 Dec 2022 12:58:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Dec 2022 12:58:50 +0800
Date:   Thu, 8 Dec 2022 12:58:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Robert Elliott <elliott@hpe.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: arch/arm/crypto/sha1_glue.c:34:8: warning: cast from 'void
 (*)(u32 *, const unsigned char *, unsigned int)' (aka 'void (*)(unsigned int
 *, const unsigned char *, unsigned int)') to 'sha1_block_fn *' (aka 'void
 (*)(struct sha1_state *, const unsigned char ...
Message-ID: <Y5FvChDBD/+uaFy8@gondor.apana.org.au>
References: <202211041904.f9S5gAGL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211041904.f9S5gAGL-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 07:33:43PM +0800, kernel test robot wrote:
>
> vim +34 arch/arm/crypto/sha1_glue.c
> 
> f0be44f4fb1fae David McCullough 2012-09-07  23  
> 1f8673d31a999e Jussi Kivilinna  2014-07-29  24  asmlinkage void sha1_block_data_order(u32 *digest,
> f0be44f4fb1fae David McCullough 2012-09-07  25  		const unsigned char *data, unsigned int rounds);
> f0be44f4fb1fae David McCullough 2012-09-07  26  
> 604682551aa511 Jussi Kivilinna  2014-07-29  27  int sha1_update_arm(struct shash_desc *desc, const u8 *data,
> f0be44f4fb1fae David McCullough 2012-09-07  28  		    unsigned int len)
> f0be44f4fb1fae David McCullough 2012-09-07  29  {
> 90451d6bdb787e Ard Biesheuvel   2015-04-09  30  	/* make sure casting to sha1_block_fn() is safe */
> 90451d6bdb787e Ard Biesheuvel   2015-04-09  31  	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
> f0be44f4fb1fae David McCullough 2012-09-07  32  
> 90451d6bdb787e Ard Biesheuvel   2015-04-09  33  	return sha1_base_do_update(desc, data, len,
> 90451d6bdb787e Ard Biesheuvel   2015-04-09 @34  				   (sha1_block_fn *)sha1_block_data_order);
> f0be44f4fb1fae David McCullough 2012-09-07  35  }
> 604682551aa511 Jussi Kivilinna  2014-07-29  36  EXPORT_SYMBOL_GPL(sha1_update_arm);
> f0be44f4fb1fae David McCullough 2012-09-07  37  

So clan doesn't like the cast on the assembly function.

Ard, why can't we just change the signature of the assembly
function instead of casting?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
