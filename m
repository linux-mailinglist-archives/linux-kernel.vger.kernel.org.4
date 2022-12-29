Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27CB658879
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiL2Bsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiL2Bsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:48:51 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5666E12604;
        Wed, 28 Dec 2022 17:48:48 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pAi28-00BrPk-4O; Thu, 29 Dec 2022 09:48:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 Dec 2022 09:48:36 +0800
Date:   Thu, 29 Dec 2022 09:48:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        "David S. Miller" <davem@davemloft.net>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] crypto: caam - Avoid GCC memset bug warning
Message-ID: <Y6zx9H7pZZ6VTzUd@gondor.apana.org.au>
References: <20221222162513.4021928-1-u.kleine-koenig@pengutronix.de>
 <Y6VK4IJkHiawAbJz@gondor.apana.org.au>
 <20221223174719.4n6pmwio4zycj2qm@pengutronix.de>
 <Y6wCbyttJ+WVzmZX@gondor.apana.org.au>
 <20221228113035.ups6echnsmo4flnz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228113035.ups6echnsmo4flnz@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 12:30:35PM +0100, Uwe Kleine-König wrote:
>
> > -	if (len) /* avoid sparse warning: memcpy with byte count of 0 */
> > +	/* Avoid gcc warning: memcpy with data == NULL */
> > +	if (!IS_ENABLED(CONFIG_CRYPTO_DEV_FSL_CAAM_DEBUG) || data)
> 
> I just tried: For me a plain
> 
> 	if (data)
> 
> is also enough to make both gcc and sparse happy.

Of course it is.  The point of the extra condition is to remove
the unnecessary check on data unless we are in debugging mode
(as it is only needed in debugging mode to work around the buggy
compiler).

> (On a related note, sparse reports:
> 
>   CHECK   drivers/crypto/caam/jr.c
> drivers/crypto/caam/jr.c: note: in included file (through arch/arm64/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
> include/asm-generic/io.h:290:22: warning: incorrect type in argument 1 (different base types)
> include/asm-generic/io.h:290:22:    expected unsigned long long [usertype] val
> include/asm-generic/io.h:290:22:    got restricted __le64 [usertype]
> include/asm-generic/io.h:290:22: warning: incorrect type in argument 1 (different base types)
> include/asm-generic/io.h:290:22:    expected unsigned long long [usertype] val
> include/asm-generic/io.h:290:22:    got restricted __le64 [usertype]

That's a bug in include/asm-generic/io.h.  It feeds an __le64 to
__raw_writeq which wants a u64.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
