Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF12638743
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiKYKUY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Nov 2022 05:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKYKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:20:22 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184A22B0D;
        Fri, 25 Nov 2022 02:20:18 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oyVoT-0002Rt-7A; Fri, 25 Nov 2022 11:20:05 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
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
Date:   Fri, 25 Nov 2022 11:20:04 +0100
Message-ID: <3217756.bB369e8A3T@diego>
In-Reply-To: <CA+V-a8sT8VxpeM=eBgmDeojOka-LDmvP4JkhVfEDKi3D3VOsmw@mail.gmail.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <4801607.MHq7AAxBmi@diego> <CA+V-a8sT8VxpeM=eBgmDeojOka-LDmvP4JkhVfEDKi3D3VOsmw@mail.gmail.com>
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

Am Freitag, 25. November 2022, 11:02:21 CET schrieb Lad, Prabhakar:
> Hi Heiko,
> 
> On Thu, Nov 24, 2022 at 7:58 PM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Am Donnerstag, 24. November 2022, 20:52:33 CET schrieb Conor Dooley:
> > > On Thu, Nov 24, 2022 at 05:22:01PM +0000, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Introduce ALTERNATIVE_3() macro.
> > >
> > > Bit perfunctory I think! There's a lovely comment down below that would
> > > make for a better commit message if you were to yoink it.
> > > Content looks about what I'd expect to see though.
> >
> > Also both the comment on the original ALTERNATIVE_2 and the new ALTERNATIVE_3
> > should probably be merged into a single comment explaining this once for all
> > ALTERNATIVE_x variants.
> >
> > Especially with the dma stuff, I'm pretty sure we'll get at least an ALTERNATIVE_4
> > if not even more ;-) . So we defnitly don't want to repeat this multiple times.
> >
> Do agree. How about the below?
> 
> /*
>  * Similar to what ALTERNATIVE_2() macro does but with an additional
>  * vendor content.
>  */
> 
> So the other ALTERNATIVE_2+() macros will keep on building on it.

My idea was more like having _one_ comment block of something like

-----
/*
 * ALTERNATIVE_x macros allow providing multiple replacement options
 * for an ALTERNATIVE code section. This is helpful if multiple
 * implementation variants for the same functionality exist for
 * different cpu cores.
 *
 * Usage:
 *   ALTERNATIVE_x(old_content,
 *	new_content1, vendor_id1, errata_id1, CONFIG_k1,
 *	new_content2, vendor_id2, errata_id2, CONFIG_k2,
 *	...
 *	new_contentx, vendor_idx, errata_idx, CONFIG_kx)
 */

#define ALTERNATIVE_2(...)
#define ALTERNATIVE_3(...)
etc
-----

So this would include dropping the old comment over ALTERNATIVE2


Heiko


