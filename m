Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC0A6EFDF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbjDZXVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjDZXVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:21:19 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8EA3A9F;
        Wed, 26 Apr 2023 16:21:08 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1proR6-0000Cq-Lc; Thu, 27 Apr 2023 01:20:32 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH v4 0/4] Implement GCM ghash using Zbc and Zbkb extensions
Date:   Thu, 27 Apr 2023 01:20:31 +0200
Message-ID: <7664296.GXAFRqVoOG@diego>
In-Reply-To: <20230426225550.GA65659@sol.localdomain>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
 <20230426225550.GA65659@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Am Donnerstag, 27. April 2023, 00:55:50 CEST schrieb Eric Biggers:
> On Wed, Mar 29, 2023 at 04:06:38PM +0200, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > 
> > This was originally part of my vector crypto series, but was part
> > of a separate openssl merge request implementing GCM ghash as using
> > non-vector extensions.
> > 
> > As that pull-request
> >     https://github.com/openssl/openssl/pull/20078
> > got merged recently into openssl, we could also check if this could
> > go into the kernel as well and provide a base for further accelerated
> > cryptographic support.
> 
> One more question.  It seems that this patchset uses the RISC-V scalar crypto
> extensions.  I've been hearing rumors that the RISC-V scalar crypto extensions
> have been superseded by the vector crypto extensions.  Is that accurate?  I
> wonder if it's worth putting effort into implementations that use the scalar
> crypto extensions when they might already be obsolete.

Yes there are the vector crypto extensions - still deep in the
ratification process.

And of course the RISC-V speciality, all extensions are separate
entities that core manufacturers can select at will.

And I guess the whole vector extension + vector-crypto extensions
might require more investment for manufacturers, where the variants
introduced here also "just" work with bitmanip instructions (Zbb + Zbc
extensions).


But for me, this small bit of scalar crypto is also sort of a stepping
stone :-). Previous versions [0] already included patches using the
vector crypto extensions too, I just split that into a separate thing,
as _this_ series actually uses ratified extensions :-)


Heiko



[0] https://lore.kernel.org/lkml/20230313191302.580787-12-heiko.stuebner@vrull.eu/T/


