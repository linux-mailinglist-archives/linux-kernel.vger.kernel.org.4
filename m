Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F41F643C41
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiLFE10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLFE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:27:22 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897421A3B5;
        Mon,  5 Dec 2022 20:27:19 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2PXr-004LJG-Ep; Tue, 06 Dec 2022 12:27:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Dec 2022 12:27:03 +0800
Date:   Tue, 6 Dec 2022 12:27:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Message-ID: <Y47El6TRitHm7Xz9@gondor.apana.org.au>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com>
 <Y3TF7/+DejcnN0eV@zx2c4.com>
 <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
 <MW5PR84MB1842C2D1EA00D5EF65784E25AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <Y4nEcV4w3eOEFYze@gondor.apana.org.au>
 <MW5PR84MB184215302DC8E824812D6B13AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB184215302DC8E824812D6B13AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:15:23PM +0000, Elliott, Robert (Servers) wrote:
> 
> 
> > -----Original Message-----
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> > Sent: Friday, December 2, 2022 3:25 AM
> > To: Elliott, Robert (Servers) <elliott@hpe.com>
> > Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
> > 
> > On Fri, Dec 02, 2022 at 06:21:02AM +0000, Elliott, Robert (Servers) wrote:
> ...
> > BTW, just a minor nit but you can delete the cond_resched() call
> > because kernel_fpu_end()/preempt_enable() will do it anyway.
> 
> That happens under
> 	CONFIG_PREEMPTION=y
> (from include/Linux/preempt.h and arch/x86/include/asm/preempt.h)
> 
> Is calling cond_resched() still helpful if that is not the configuration?

Perhaps, but then again perhaps if preemption is off, maybe we
shouldn't even bother with the 4K split.  Were the initial
warnings with or without preemption?

Personally I don't really care since I always use preemption.

The PREEMPT Kconfigs do provide a bit of nuance with the split
between PREEMPT_NONE vs. PREEMPT_VOLUNTARY.  But perhaps that is
just overkill for our situation.

I'll leave it to you to decide :)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
