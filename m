Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92D76C7C29
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCXKEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCXKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:04:21 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70B1A49F;
        Fri, 24 Mar 2023 03:04:20 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pfeH8-008FBY-Ov; Fri, 24 Mar 2023 18:03:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Mar 2023 18:03:58 +0800
Date:   Fri, 24 Mar 2023 18:03:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto - img-hash: Drop of_match_ptr for ID table
Message-ID: <ZB11jq3qnZUpmMrm@gondor.apana.org.au>
References: <20230310223027.315954-1-krzysztof.kozlowski@linaro.org>
 <20230310223027.315954-2-krzysztof.kozlowski@linaro.org>
 <ZBPYpYfd29YwN1Dy@gondor.apana.org.au>
 <b8cd828b-edc5-6748-bf97-af0fc85e14a4@linaro.org>
 <ZBQlKMTcTm1yjete@gondor.apana.org.au>
 <e7cd7252-9cc6-0970-b0e2-35fccde45e86@linaro.org>
 <ZBQvx0PDQJ4qpnNO@gondor.apana.org.au>
 <CAMj1kXH3oZhO=dMBmLzNO_nScJBjcjwUqy2sZbCJwmMS1XtLKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH3oZhO=dMBmLzNO_nScJBjcjwUqy2sZbCJwmMS1XtLKg@mail.gmail.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:43:58AM +0100, Ard Biesheuvel wrote:
>
> No. PRP0001 support in ACPI does not depend on OF, so drivers that may
> be bound to such devices should not either.
> 
> If you are concerned about the memory used by such tables, you can
> always propose making PRP0001 support configurable in the ACPI core,
> but making individual devices depend on OF for PRP0001 matching seems
> wrong to me.

What I am against is removing of_match_ptr by doing a million
tiny patches.  Either we should keep it, in which case the
of_match_table field should be made conditional on OF or perhaps
a new Kconfig option if there is no way to reconcile this with
ACPI, or we decide to get rid of it and you should do one giant
patch to remove of_match_ptr across the kernel tree.

We should not be doing a patch for every single driver that has
of_match_table based on whether it can or cannot be used through
ACPI.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
