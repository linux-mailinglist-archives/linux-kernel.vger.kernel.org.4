Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6272C8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbjFLOqU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjFLOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:46:19 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F193;
        Mon, 12 Jun 2023 07:46:14 -0700 (PDT)
Received: from i53875b22.versanet.de ([83.135.91.34] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q8inu-0003G3-9v; Mon, 12 Jun 2023 16:45:58 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Eric Biggers <ebiggers@kernel.org>, christoph.muellner@vrull.eu
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 4/4] RISC-V: crypto: add accelerated GCM GHASH implementation
Date:   Mon, 12 Jun 2023 16:45:57 +0200
Message-ID: <3745175.MHq7AAxBmi@diego>
In-Reply-To: <45936818.fMDQidcC6G@diego>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu> <2102949.OBFZWjSADL@diego>
 <45936818.fMDQidcC6G@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. April 2023, 17:04:57 CEST schrieb Heiko Stübner:
> Hi again,
> 
> Am Mittwoch, 29. März 2023, 21:20:21 CEST schrieb Heiko Stübner:
> > Am Mittwoch, 29. März 2023, 20:37:16 CEST schrieb Eric Biggers:
> > > On Wed, Mar 29, 2023 at 04:06:42PM +0200, Heiko Stuebner wrote:
> > > > diff --git a/arch/riscv/crypto/ghash-riscv64-zbc.pl b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> > > > new file mode 100644
> > > > index 000000000000..691231ffa11c
> > > > --- /dev/null
> > > > +++ b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> > > > @@ -0,0 +1,400 @@
> > > > +#! /usr/bin/env perl
> > > > +# Copyright 2022 The OpenSSL Project Authors. All Rights Reserved.
> > > > +#
> > > > +# Licensed under the Apache License 2.0 (the "License").  You may not use
> > > > +# this file except in compliance with the License.  You can obtain a copy
> > > > +# in the file LICENSE in the source distribution or at
> > > > +# https://www.openssl.org/source/license.html
> > > 
> > > My understanding is that code that is licensed under (only) the Apache License
> > > 2.0 cannot be included in GPLv2 programs such as the Linux kernel.
> > 
> > Thanks a lot for pointing out that possible licensing issue.
> > It seems I'm not touching enough non-GPL code most days to keep that
> > in the front of my mind :-) .
> > 
> > 
> > > Is this code written by Andy Polyakov?  What's been done in the past for his
> > > code is that he re-releases it in CRYPTOGAMS at
> > > https://github.com/dot-asm/cryptogams with a Linux kernel compatible license.
> > > The Linux kernel then takes the code from there instead of from OpenSSL.
> > 
> > The git log for the original openssl ".pl" thankfully only contains
> > @vrull.eu addresses, so getting this in a compatible license shouldn't be
> > overly hard - I hope.
> 
> just to follow up with the current state.
> 
> We're currently trying to see if openSSL allows us to dual-license the
> files inside openssl itself [0]. It looks a bit like we're the first to
> try something like this, so the decision gets to be made by the OMC.

Openssl merged the dual-licensing approach.
So we get Apache + BSD licensed code which should be ok to simply merge
over without needing additional repositories and also allows to import
future improvements on the openssl side.


> [0] https://github.com/openssl/openssl/pull/20649





