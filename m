Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BCC6ADB78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCGKKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCGKKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:10:39 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB8656519;
        Tue,  7 Mar 2023 02:10:36 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pZUGs-001CvQ-4K; Tue, 07 Mar 2023 18:10:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 07 Mar 2023 18:10:14 +0800
Date:   Tue, 7 Mar 2023 18:10:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Subject: Re: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each
 request
Message-ID: <ZAcNhtm/+mik1N2m@gondor.apana.org.au>
References: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au>
 <E1pZ2fs-000e27-4H@formenos.hmeau.com>
 <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 11:08:13AM +0100, Linus Walleij wrote:
>
> This partly works (after my folded in fix in patch 5)!
> 
> Clean SHA1 and SHA256 works flawlessly.
> HMAC still fails, but not until we start testing random vectors:
> 
> [    7.541954] alg: ahash: stm32-hmac-sha256 digest() failed on test
> vector "random: psize=0 ksize=80"; expected_error=0,
> actual_error=-110, cfg="random: may_sleep"
> [    7.567212] alg: self-tests for hmac(sha256) using
> stm32-hmac-sha256 failed (rc=-110)

So it's timing out.  I wonder if the timeout in stm32_hash_wait_busy
is long enough.  Perhaps try adding a zero so that the timeout becomes
100,000us and see if it still breaks?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
