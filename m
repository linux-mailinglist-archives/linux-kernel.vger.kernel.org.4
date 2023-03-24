Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2246C7BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCXJux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCXJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:50:44 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC8811654;
        Fri, 24 Mar 2023 02:50:42 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pfe3k-008ExG-92; Fri, 24 Mar 2023 17:50:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Mar 2023 17:50:08 +0800
Date:   Fri, 24 Mar 2023 17:50:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 4/4] crypto: starfive - Add hash and HMAC support
Message-ID: <ZB1yULAh8GUswpHk@gondor.apana.org.au>
References: <20230313135646.2077707-1-jiajie.ho@starfivetech.com>
 <20230313135646.2077707-5-jiajie.ho@starfivetech.com>
 <ZB1x/bUdOSWzim+8@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB1x/bUdOSWzim+8@gondor.apana.org.au>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:48:45PM +0800, Herbert Xu wrote:
>
> Please don't allocate the whole thing because it could be unlimited
> in size (and triggered from user-space by untrusted users too).
> 
> If you have to copy, then just allocate a single page and copy
> that, hash, and then repeat until it's all done.

Nevermind, your hardware doesn't support hashing piece-meal.

So just use the fallback if it's not aligned.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
