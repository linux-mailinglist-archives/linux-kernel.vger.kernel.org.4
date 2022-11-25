Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7DA63855A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiKYIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKYIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:41:11 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F1F23E88;
        Fri, 25 Nov 2022 00:41:10 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyUGQ-000gkp-AU; Fri, 25 Nov 2022 16:40:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 16:40:50 +0800
Date:   Fri, 25 Nov 2022 16:40:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Robert Elliott <elliott@hpe.com>, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        David.Laight@aculab.com, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Message-ID: <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com>
 <Y3TF7/+DejcnN0eV@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3TF7/+DejcnN0eV@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:13:51PM +0100, Jason A. Donenfeld wrote:
> On Tue, Nov 15, 2022 at 10:13:28PM -0600, Robert Elliott wrote:
> > +/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
> > +static const unsigned int bytes_per_fpu = 337 * 1024;
> > +
> 
> Use an enum for constants like this:
> 
>     enum { BYTES_PER_FPU = ... };
> 
> You can even make it function-local, so it's near the code that uses it,
> which will better justify its existence.
> 
> Also, where did you get this number? Seems kind of weird.

These numbers are highly dependent on hardware and I think having
them hard-coded is wrong.

Perhaps we should try a different approach.  How about just limiting
the size to 4K, and then depending on need_resched we break out of
the loop? Something like:

	if (!len)
		return 0;

	kernel_fpu_begin();
	for (;;) {
		unsigned int chunk = min(len, 4096);

		sha1_base_do_update(desc, data, chunk, sha1_xform);

		len -= chunk;
		data += chunk;

		if (!len)
			break;

		if (need_resched()) {
			kernel_fpu_end();
			cond_resched();
			kernel_fpu_begin();
		}
	}
	kernel_fpu_end();

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
