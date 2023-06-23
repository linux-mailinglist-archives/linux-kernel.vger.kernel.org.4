Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6897F73B896
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjFWNQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFWNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:16:42 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEF059D;
        Fri, 23 Jun 2023 06:16:40 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qCgeU-0002sl-00; Fri, 23 Jun 2023 15:16:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D8D90C0346; Fri, 23 Jun 2023 15:09:38 +0200 (CEST)
Date:   Fri, 23 Jun 2023 15:09:38 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net, "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts
Message-ID: <20230623130938.GC11636@alpha.franken.de>
References: <20230622175934.71601-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622175934.71601-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 07:59:34PM +0200, Paul Cercueil wrote:
> Commit 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node
> names") caused the VDDCORE power supply (regulated by the ACT8600's
> DCDC1 output) to drop from a voltage of 1.2V configured by the
> bootloader, to the 1.1V set in the Device Tree.
> 
> According to the documentation, the VDDCORE supply should be between
> 0.99V and 1.21V; both values are therefore within the supported range.
> 
> However, VDDCORE being 1.1V results in the CI20 being very unstable,
> with corrupted memory, failures to boot, or reboots at random. The
> reason might be succint drops of the voltage below the minimum required.
> 
> Raising the minimum voltage to 1.125 volts seems to be enough to address
> this issue, while still keeping a relatively low core voltage which
> helps for power consumption and thermals.
> 
> Fixes: 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node names")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> ---
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index cec0caa2350c..a141a699b790 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -298,8 +298,8 @@ act8600: act8600@5a {
>  
>  		regulators {
>  			vddcore: DCDC1 {
> -				regulator-min-microvolt = <1100000>;
> -				regulator-max-microvolt = <1100000>;
> +				regulator-min-microvolt = <1125000>;
> +				regulator-max-microvolt = <1125000>;
>  				vp1-supply = <&vcc_33v>;
>  				regulator-always-on;
>  			};
> -- 
> 2.40.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
