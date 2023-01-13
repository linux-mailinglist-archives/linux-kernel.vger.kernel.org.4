Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F96689A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjAMCgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjAMCgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:36:46 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C170FE7;
        Thu, 12 Jan 2023 18:36:42 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pG9vM-00H49q-Ab; Fri, 13 Jan 2023 10:36:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Jan 2023 10:36:08 +0800
Date:   Fri, 13 Jan 2023 10:36:08 +0800
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
Message-ID: <Y8DDmBg6J31pS0KW@gondor.apana.org.au>
References: <20221219220223.3982176-1-elliott@hpe.com>
 <20221219220223.3982176-4-elliott@hpe.com>
 <Y7+/Yy7+mLEyqeiK@gondor.apana.org.au>
 <Y8BVkjwPc6DLm7HT@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8BVkjwPc6DLm7HT@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:46:42AM -0800, Eric Biggers wrote:
>
> Right, this used to exist, but it didn't actually do anything, and it had
> suffered heavily from bitrot.  For example, some callers specified MAY_SLEEP
> when actually they couldn't sleep.  IIRC, some callers also didn't even bother
> initializing the flags, so they were passing uninitialized memory.  So I removed
> it in commit 877b5691f27a ("crypto: shash - remove shash_desc::flags").
> 
> Has there been any consideration of just adding the crypto_shash_update_large()
> helper function that I had mentioned in the commit message of 877b5691f27a?

I had forgotten about this :)

Perhaps we should just convert any users that trigger these warnings
over to ahash? The shash interface was never meant to process large
amounts of data anyway.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
