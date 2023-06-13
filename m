Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC32472DBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbjFMICh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Jun 2023 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbjFMIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:01:49 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF6B2974;
        Tue, 13 Jun 2023 01:01:02 -0700 (PDT)
Received: from i53875b22.versanet.de ([83.135.91.34] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q8yxK-0000QG-0v; Tue, 13 Jun 2023 10:00:46 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH v5 4/4] RISC-V: crypto: add accelerated GCM GHASH implementation
Date:   Tue, 13 Jun 2023 10:00:44 +0200
Message-ID: <2236193.NgBsaNRSFp@diego>
In-Reply-To: <20230613031006.GD883@sol.localdomain>
References: <20230612210442.1805962-1-heiko.stuebner@vrull.eu>
 <20230612210442.1805962-5-heiko.stuebner@vrull.eu>
 <20230613031006.GD883@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 13. Juni 2023, 05:10:06 CEST schrieb Eric Biggers:
> Hi Heiko,
> 
> On Mon, Jun 12, 2023 at 11:04:42PM +0200, Heiko Stuebner wrote:
> > diff --git a/arch/riscv/crypto/ghash-riscv64-zbc.pl b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> > new file mode 100644
> > index 000000000000..677c438a44bf
> > --- /dev/null
> > +++ b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> > @@ -0,0 +1,427 @@
> > +#! /usr/bin/env perl
> > +# Copyright 2022 The OpenSSL Project Authors. All Rights Reserved.
> > +#
> > +# Licensed under the Apache License 2.0 (the "License").  You may not use
> > +# this file except in compliance with the License.  You can obtain a copy
> > +# in the file LICENSE in the source distribution or at
> > +# https://www.openssl.org/source/license.html
> > +
> > +# This file is dual-licensed and is also available under the following
> > +# terms:
> > +#
> > +# Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
> > +# All rights reserved.
> > +#
> > +# Redistribution and use in source and binary forms, with or without
> > +# modification, are permitted provided that the following conditions
> > +# are met:
> > +# 1. Redistributions of source code must retain the above copyright
> > +#    notice, this list of conditions and the following disclaimer.
> > +# 2. Redistributions in binary form must reproduce the above copyright
> > +#    notice, this list of conditions and the following disclaimer in the
> > +#    documentation and/or other materials provided with the distribution.
> 
> Is this worded properly for a dual license?  The paragraph about the Apache
> License makes it sound like the Apache License must always be complied with:
> "You may not use this file except in compliance with the License."
> 
> So I worry that this could be interpreted as:
> 
>     Apache-2.0 AND BSD-2-Clause
> 
> instead of
> 
>     Apache-2.0 OR BSD-2-Clause
> 
> It needs to be the latter.
> 
> So I think the file header needs to be clarified w.r.t. the dual license.

Hmm, I think the 
	"This file is dual-licensed and is also available under the following terms"
should be pretty clear?

Also this is wording openSSL uses since 2004 in other parts like
crypto/LPdir_*.c . So I'd guess any "issue" should've come up already
in all these years?


> Side note: can you please also include a SPDX-License-Identifier?

ok, will add them


Heiko


