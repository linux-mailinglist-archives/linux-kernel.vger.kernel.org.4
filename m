Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899F5666C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbjALIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbjALIHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:07:12 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCBDFCFC;
        Thu, 12 Jan 2023 00:06:34 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pFsax-00GhtF-Vu; Thu, 12 Jan 2023 16:05:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Jan 2023 16:05:55 +0800
Date:   Thu, 12 Jan 2023 16:05:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, Jason@zx2c4.com, ardb@kernel.org,
        ap420073@gmail.com, David.Laight@aculab.com, ebiggers@kernel.org,
        tim.c.chen@linux.intel.com, peter@n8pjl.ca, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] crypto: x86/sha - yield FPU context during long
 loops
Message-ID: <Y7+/Yy7+mLEyqeiK@gondor.apana.org.au>
References: <20221219220223.3982176-1-elliott@hpe.com>
 <20221219220223.3982176-4-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219220223.3982176-4-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:02:13PM -0600, Robert Elliott wrote:
>
> @@ -41,9 +41,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,

I just realised a show-stopper with this patch-set.  We don't
have a desc->flags field that tells us whether we can sleep or
not.

I'm currently doing a patch-set for per-request keys and I will
add a flags field to shash_desc so we could use that for your
patch-set too.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
