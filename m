Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2872EB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjFMTBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjFMTBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8060BA7;
        Tue, 13 Jun 2023 12:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 185346395C;
        Tue, 13 Jun 2023 19:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D73EC433D9;
        Tue, 13 Jun 2023 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686682902;
        bh=/JuClQfiInF4E+biL4mmyBg4GdWaji39UK48z39WAK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkxj4anxa9SwIR1rVD3AliSkIE6TiUP+JPyhWPaTAMASCYImM6Cj69VqV/Mtcji38
         PGGhjmgEOlhC598j3OTvAFk5BngXgPFozP4Q4rjUmM3OG+aIHzEvXXg8SimdzXAUQ5
         2EcR1OLu9zIhtTwQPeKzlbcreooITMgSpR9vNE4TWLXXoR2Kzs8jL93mnkK+mWOUDi
         4gHH94BmCUyqc83ZesZQPPROYwhrLM1wzbiz9gKngJGqnsSlCrAGZjsMGSoO7POMOK
         7zMiVl0AM3IdDCm2wTfIHvHN9BGYuT1cD4elm9WPPCRXgB+FiOkefM+Q0iRZlrbo7A
         3QHifX5W7No4g==
Date:   Tue, 13 Jun 2023 12:01:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH v5 4/4] RISC-V: crypto: add accelerated GCM GHASH
 implementation
Message-ID: <20230613190140.GD1139@sol.localdomain>
References: <20230612210442.1805962-1-heiko.stuebner@vrull.eu>
 <20230612210442.1805962-5-heiko.stuebner@vrull.eu>
 <20230613031006.GD883@sol.localdomain>
 <2236193.NgBsaNRSFp@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2236193.NgBsaNRSFp@diego>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:00:44AM +0200, Heiko Stübner wrote:
> Am Dienstag, 13. Juni 2023, 05:10:06 CEST schrieb Eric Biggers:
> > Hi Heiko,
> > 
> > On Mon, Jun 12, 2023 at 11:04:42PM +0200, Heiko Stuebner wrote:
> > > diff --git a/arch/riscv/crypto/ghash-riscv64-zbc.pl b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> > > new file mode 100644
> > > index 000000000000..677c438a44bf
> > > --- /dev/null
> > > +++ b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> > > @@ -0,0 +1,427 @@
> > > +#! /usr/bin/env perl
> > > +# Copyright 2022 The OpenSSL Project Authors. All Rights Reserved.
> > > +#
> > > +# Licensed under the Apache License 2.0 (the "License").  You may not use
> > > +# this file except in compliance with the License.  You can obtain a copy
> > > +# in the file LICENSE in the source distribution or at
> > > +# https://www.openssl.org/source/license.html
> > > +
> > > +# This file is dual-licensed and is also available under the following
> > > +# terms:
> > > +#
> > > +# Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
> > > +# All rights reserved.
> > > +#
> > > +# Redistribution and use in source and binary forms, with or without
> > > +# modification, are permitted provided that the following conditions
> > > +# are met:
> > > +# 1. Redistributions of source code must retain the above copyright
> > > +#    notice, this list of conditions and the following disclaimer.
> > > +# 2. Redistributions in binary form must reproduce the above copyright
> > > +#    notice, this list of conditions and the following disclaimer in the
> > > +#    documentation and/or other materials provided with the distribution.
> > 
> > Is this worded properly for a dual license?  The paragraph about the Apache
> > License makes it sound like the Apache License must always be complied with:
> > "You may not use this file except in compliance with the License."
> > 
> > So I worry that this could be interpreted as:
> > 
> >     Apache-2.0 AND BSD-2-Clause
> > 
> > instead of
> > 
> >     Apache-2.0 OR BSD-2-Clause
> > 
> > It needs to be the latter.
> > 
> > So I think the file header needs to be clarified w.r.t. the dual license.
> 
> Hmm, I think the 
> 	"This file is dual-licensed and is also available under the following terms"
> should be pretty clear?

As I said, IMO the problem is that it contradicts the Apache license blurb just
above it, specifically the part "You may not use this file except in compliance
with the License".  So it's not clear what is meant.  That sentence does not
appear in other common license blurbs; it seems to be unique to Apache's.

I know that people often treat these blurbs as magic incantations, but I'm just
looking at the plain English meaning here.

To fix this ambiguity I think either that sentence should be removed, or the
intent to dual license should be clearly described in the *first paragraph*
before listing the two licenses.  (Or do both of those.)

- Eric
