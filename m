Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F275F64172C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLCN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLCN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:58:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C101275D5;
        Sat,  3 Dec 2022 05:58:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4658123A;
        Sat,  3 Dec 2022 05:58:58 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD4A23F73D;
        Sat,  3 Dec 2022 05:58:49 -0800 (PST)
Date:   Sat, 3 Dec 2022 13:57:13 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/5] clk: sunxi-ng: Remove duplicate ARCH_SUNXI
 dependencies
Message-ID: <20221203135713.0591b0b7@slackpad.lan>
In-Reply-To: <b7774c58-ccf8-4204-2e7e-6841fd13002d@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org>
        <20221126191319.6404-2-samuel@sholland.org>
        <20221203001439.64284671@slackpad.lan>
        <b7774c58-ccf8-4204-2e7e-6841fd13002d@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 19:52:41 -0600
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> On 12/2/22 18:14, Andre Przywara wrote:
> > On Sat, 26 Nov 2022 13:13:15 -0600
> > Samuel Holland <samuel@sholland.org> wrote:
> > 
> > Hi,
> > 
> > thanks for addressing this!
> >   
> >> SUNXI_CCU already depends on ARCH_SUNXI, so adding the dependency to
> >> individual SoC drivers is redundant.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>
> >>  drivers/clk/sunxi-ng/Kconfig | 43 ++++++++++++++++++------------------
> >>  1 file changed, 21 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> >> index 461537679c04..64cfa022e320 100644
> >> --- a/drivers/clk/sunxi-ng/Kconfig
> >> +++ b/drivers/clk/sunxi-ng/Kconfig
> >> @@ -14,43 +14,43 @@ config SUNIV_F1C100S_CCU
> >>  
> >>  config SUN20I_D1_CCU
> >>  	tristate "Support for the Allwinner D1 CCU"
> >> -	default RISCV && ARCH_SUNXI
> >> -	depends on (RISCV && ARCH_SUNXI) || COMPILE_TEST
> >> +	default RISCV
> >> +	depends on RISCV || COMPILE_TEST  
> > 
> > I agree on the "depends" part: Indeed the guard symbol already covers
> > that, so it's redundant.
> > However I am not so sure about the "default" part: When ARCH_SUNXI is
> > deselected, but COMPILE_TEST in enabled, we default to every CCU driver
> > being built-in. I am not sure this is the intention, or at least
> > expected when doing compile testing?  
> 
> SUNXI_CCU, which these depend on, is still "default ARCH_SUNXI", so if
> you have ARCH_SUNXI disabled, you only get any drivers if you manually
> enable SUNXI_CCU. I mentioned this in the patch 2 description, but maybe
> I should move that comment here.

Yeah, I read this later on, I guess it's fine then.

> 
> >>  
> >>  config SUN20I_D1_R_CCU
> >>  	tristate "Support for the Allwinner D1 PRCM CCU"
> >> -	default RISCV && ARCH_SUNXI
> >> -	depends on (RISCV && ARCH_SUNXI) || COMPILE_TEST
> >> +	default RISCV
> >> +	depends on RISCV || COMPILE_TEST
> >>  
> >>  config SUN50I_A64_CCU
> >>  	tristate "Support for the Allwinner A64 CCU"
> >> -	default ARM64 && ARCH_SUNXI
> >> -	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> >> +	default ARM64
> >> +	depends on ARM64 || COMPILE_TEST  
> > 
> > I wonder if this "depends" line was always wrong and should be fixed:
> > We can compile a 32-bit ARM kernel and run it on an A64. Granted this
> > requires a special bootloader or a hacked U-Boot (tried that), and
> > reveals some other issues with the decompressor, but technically there
> > is no 64-bit dependency in here.
> > The same goes for all the other ARM64 CCUs: Cortex-A53s can run AArch32
> > in all exception levels.  
> 
> I was trying to simplify things by hiding irrelevant options, and you
> bring up an edge case of an edge case. :) I am okay with relaxing the
> dependency, though I would want to leave them disabled by default for
> 32-bit kernels (excluding them from the change in patch 2).

Yes, definitely, that was the idea.

And sorry for being a nuisance, but I think this "depends on ARCH_SUNXI"
here is and was always misplaced. In contrast to things like "depends
on PCI" or "depends on GPIOLIB", there is no real dependency on
ARCH_SUNXI or even ARM/RISCV here, it's more a "only useful on
ARCH_SUNXI".
And this ARM vs ARM64 was just another rationale for not being
overzealous with the dependency.

But I see that this is an orthogonal discussion to this patch, so this
should not block it. I will meditate over both patches again, since I
have the gut feeling that the end result is fine.

Cheers,
Andre

> 
> > So shall we just completely remove the "depends" line for those, and
> > let SUNXI_CCU do that job? Or use use !RISCV || COMPILE_TEST?  
> 
> That, or we could add MACH_SUN8I to the condition. I don't have a strong
> opinion.
> 
> Regards,
> Samuel
> 

