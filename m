Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5496689AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjAMCiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjAMCiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:38:01 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8BCFE7;
        Thu, 12 Jan 2023 18:38:01 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pG9wo-00H4Bl-SR; Fri, 13 Jan 2023 10:37:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Jan 2023 10:37:38 +0800
Date:   Fri, 13 Jan 2023 10:37:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Robert Elliott <elliott@hpe.com>, davem@davemloft.net,
        Jason@zx2c4.com, ardb@kernel.org, ap420073@gmail.com,
        David.Laight@aculab.com, tim.c.chen@linux.intel.com,
        peter@n8pjl.ca, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] crypto: x86/sha - yield FPU context during long
 loops
Message-ID: <Y8DD8s9nakxW5zzE@gondor.apana.org.au>
References: <20221219220223.3982176-1-elliott@hpe.com>
 <20221219220223.3982176-4-elliott@hpe.com>
 <Y7+/Yy7+mLEyqeiK@gondor.apana.org.au>
 <Y8BVkjwPc6DLm7HT@sol.localdomain>
 <Y8DDmBg6J31pS0KW@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8DDmBg6J31pS0KW@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:36:08AM +0800, Herbert Xu wrote:
>
> Perhaps we should just convert any users that trigger these warnings
> over to ahash? The shash interface was never meant to process large
> amounts of data anyway.

We could even add some length checks in shash to ensure that
all large updates fail with a big bright warning once the existing
users have been converted.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
