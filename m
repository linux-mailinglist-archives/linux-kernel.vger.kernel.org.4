Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE31638049
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKXUon convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Nov 2022 15:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:44:41 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1990281F9A;
        Thu, 24 Nov 2022 12:44:39 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oyJ59-0007px-11; Thu, 24 Nov 2022 21:44:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Conor Dooley <conor@kernel.org>, Conor Dooley <conor@kernel.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 1/7] riscv: asm: alternative-macros: Introduce ALTERNATIVE_3() macro
Date:   Thu, 24 Nov 2022 21:44:25 +0100
Message-ID: <3307993.NgBsaNRSFp@diego>
In-Reply-To: <59aea5e5-25f1-de8c-9982-5db226f8bda5@kernel.org>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y3/OlKI1jyi0eoCJ@spud> <59aea5e5-25f1-de8c-9982-5db226f8bda5@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. November 2022, 21:08:17 CET schrieb Conor Dooley:
> On 24/11/2022 20:05, Conor Dooley wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Nov 24, 2022 at 08:58:41PM +0100, Heiko Stübner wrote:
> >> Am Donnerstag, 24. November 2022, 20:52:33 CET schrieb Conor Dooley:
> >>> On Thu, Nov 24, 2022 at 05:22:01PM +0000, Prabhakar wrote:
> >>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>>
> >>>> Introduce ALTERNATIVE_3() macro.
> >>>
> >>> Bit perfunctory I think! There's a lovely comment down below that would
> >>> make for a better commit message if you were to yoink it.
> >>> Content looks about what I'd expect to see though.
> >>
> >> Also both the comment on the original ALTERNATIVE_2 and the new ALTERNATIVE_3
> >> should probably be merged into a single comment explaining this once for all
> >> ALTERNATIVE_x variants.
> >>
> >> Especially with the dma stuff, I'm pretty sure we'll get at least an ALTERNATIVE_4
> >> if not even more ;-) . So we defnitly don't want to repeat this multiple times.
> > 
> > Oh I can promise you that there'll be a #4 ;) I do find the comment's
> > wording to be quite odd though..
> > 
> >> + * A vendor wants to replace an old_content, but another vendor has used
> >> + * ALTERNATIVE_2() to patch its customized content at the same location. In
> > 
> > In particular this bit about "at the same location" does not make all
> > that much sense. What "at the same location" means in this context
> > should be expanded on imo. Effectively it boils down to someone else is
> > already replacing the same things you want to replace - it's just the
> > word "location" that might make sense if you're an old hand but not
> > otherwise?
> 
> Or maybe I am just biased because I tried to explain this to someone
> recently and the language in the comments didn't make sense to them,
> and anyone meddling with this code should be able to understand it?

When I first looked at the whole alternatives / patching thing, the whole thing
looked like dark magic to me ;-) .

But yeah, the comment here, but also the original one above ALTERNATIVE_2
could use improvements to explain better what it tries to do.


> >> + * this case, this vendor can create a new macro ALTERNATIVE_3() based
> > 
> > Also, using the word "can". Is it not a "must" rather than a "can",
> > since this stuff needs to be multiplatform?
> > 
> >> + * on the following sample code and then replace ALTERNATIVE_2() with
> >> + * ALTERNATIVE_3() to append its customized content.
> > 
> > 
> 
> 




