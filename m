Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2573114D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245267AbjFOHtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245293AbjFOHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:49:13 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C819358B;
        Thu, 15 Jun 2023 00:48:51 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 1F9D1207A7;
        Thu, 15 Jun 2023 09:48:49 +0200 (CEST)
Date:   Thu, 15 Jun 2023 09:48:44 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] arm64: dts: ti: add verdin am62
Message-ID: <ZIrCXA6kp2Z1Je6A@francesco-nb.int.toradex.com>
References: <20230601131332.26877-1-francesco@dolcini.it>
 <20230601131332.26877-4-francesco@dolcini.it>
 <62ca6112-0aca-788e-fc9b-8a2c3ce9ba1f@ti.com>
 <ZIq02whTEce8C1P8@francesco-nb.int.toradex.com>
 <bf392830-c157-b819-2de3-8db952adf39b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf392830-c157-b819-2de3-8db952adf39b@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:08:11PM +0530, Vignesh Raghavendra wrote:
> 
> 
> On 15/06/23 12:21, Francesco Dolcini wrote:
> > On Thu, Jun 15, 2023 at 11:38:00AM +0530, Vignesh Raghavendra wrote:
> >>
> >>
> >> On 01/06/23 18:43, Francesco Dolcini wrote:
> >>
> >> [...]
> >>
> >>> +/* Verdin I2C_1 */
> >>> +&main_i2c1 {
> >>> +	status = "okay";
> >>> +
> >>> +	/* Audio Codec */
> >>> +	nau8822_1a: audio-codec@1a {
> >>> +		compatible = "nuvoton,nau8822";
> >>> +		reg = <0x1a>;
> >>> +		pinctrl-names = "default";
> >>> +		pinctrl-0 = <&pinctrl_i2s1_mclk>; /* Configure AUDIO_EXT_REFCLK1 pin as output */
> >>> +		#sound-dai-cells = <0>;
> >>> +
> >>> +		/* POSTDIV4_16FF_MAIN_2_HSDIVOUT8_CLK -> AUDIO_EXT_REFCLK1 */
> >>> +		assigned-clocks = <&k3_clks 157 10>;
> >>> +		assigned-clock-parents = <&k3_clks 157 18>;
> >>> +		assigned-clock-rates = <25000000>; /* for 48KHz ± 1.7% */
> >>> +	};
> >>> +
> >>
> >> Oops, this node fails dtbs_check
> >>
> >> make ARCH=arm64 CROSS_COMPILE=$V8_CROSS CHECK_DTBS=y ti/k3-am625-verdin-nonwifi-dev.dtb
> >>
> >> /work/linux/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dtb: audio-codec@1a: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> >> 	From schema: /home/a0132425/workspace/k3-next/Documentation/devicetree/bindings/sound/nuvoton,nau8822.yaml
> >> /work/linux/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dtb: audio-codec@1a: 'anyOf' conditional failed, one must be fixed:
> >> 	'clocks' is a required property
> >> 	'#clock-cells' is a required property
> >> 	From schema: /work/.local/lib/python3.10/site-packages/dtschema/schemas/clock/clock.yaml
> > 
> > This properties are needed here, it will not work without.
> 
> Agree on the need. But, I cannot take the patch w/o binding update. We
> will end up with messy dts files that would have deviated from bindings.

Fine, however, one question, is this a new policy? Or a specific TI
branch policy? From what I can tell so far there was nothing mandatory
while the DT binding conversion from txt to yaml is in progress. 

> Could you please post an update to bindings yaml? I suggest to drop
> audio codec support and add it back once bindings are updated/fixed.
I will proceed like that, thanks. I would be happy to see the
verdin-am62 added in the next merge window.

Thanks for the review,
Francesco
