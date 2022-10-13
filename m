Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114405FD474
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJMGFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJMGFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:05:01 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E931E73E;
        Wed, 12 Oct 2022 23:04:56 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oirKl-00EDIl-KZ; Thu, 13 Oct 2022 17:04:44 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 13 Oct 2022 14:04:43 +0800
Date:   Thu, 13 Oct 2022 14:04:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Robert Elliott <elliott@hpe.com>, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Message-ID: <Y0eqe5lbazXzpM/K@gondor.apana.org.au>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-5-elliott@hpe.com>
 <Y0eosAIgkvMzYJz8@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0eosAIgkvMzYJz8@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:57:04PM -0700, Eric Biggers wrote:
>
> 'len' can't be 0 at the beginning of this loop, so the 'if (chunk)' check isn't
> needed.  And it wouldn't make sense even if 'len' could be 0, since a while loop
> could just be used in that case.

I don't see anything preventing len from being zero if this gets
called directly by a user of the Crypto API through crypto_shash_update.
But yes a while loop would be a lot cleaner.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
