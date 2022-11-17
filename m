Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0D62D1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 04:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiKQD7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 22:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiKQD7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 22:59:06 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635A21403D;
        Wed, 16 Nov 2022 19:59:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ovW30-00F4UP-Dk; Thu, 17 Nov 2022 11:58:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 17 Nov 2022 11:58:42 +0800
Date:   Thu, 17 Nov 2022 11:58:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, tim.c.chen@linux.intel.com,
        ap420073@gmail.com, ardb@kernel.org, Jason@zx2c4.com,
        David.Laight@aculab.com, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/24] crypto: fix RCU stalls
Message-ID: <Y3WxcrjHD4MRWHcS@gondor.apana.org.au>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:13:18PM -0600, Robert Elliott wrote:
> This series fixes the RCU stalls triggered by the x86 crypto
> modules discussed in
> https://lore.kernel.org/all/MW5PR84MB18426EBBA3303770A8BC0BDFAB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM/
> 
> Two root causes were:
> - too much data processed between kernel_fpu_begin and
>   kernel_fpu_end calls (which are heavily used by the x86
>   optimized drivers)
> - tcrypt not calling cond_resched during speed test loops
> 
> These problems have always been lurking, but improving the
> loading of the x86/sha512 module led to it happening a lot
> during boot when using SHA-512 for module signature checking.

Can we split this series up please? The fixes to the stalls should
stand separately from the changes to how modules are loaded.  The
latter is more of an improvement while the former should be applied
ASAP.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
