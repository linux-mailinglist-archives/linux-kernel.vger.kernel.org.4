Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122FB730F56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbjFOGao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFOGal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:30:41 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B7C7;
        Wed, 14 Jun 2023 23:30:38 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 6060D207A7;
        Thu, 15 Jun 2023 08:30:32 +0200 (CEST)
Date:   Thu, 15 Jun 2023 08:30:27 +0200
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
Subject: Re: [PATCH v2 4/5] arm64: dts: ti: add verdin am62 dahlia
Message-ID: <ZIqwA3uC8nz2s9IN@francesco-nb.int.toradex.com>
References: <20230601131332.26877-1-francesco@dolcini.it>
 <20230601131332.26877-5-francesco@dolcini.it>
 <b6ebaf92-39ed-01af-6aa9-52232a2e3ea7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ebaf92-39ed-01af-6aa9-52232a2e3ea7@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:52:22AM +0530, Vignesh Raghavendra wrote:
> 
> 
> On 01/06/23 18:43, Francesco Dolcini wrote:
> 
> [...]
> 
> > +/* Verdin I2C_1 */
> > +&main_i2c1 {
> > +	status = "okay";
> > +
> > +	/* Audio Codec */
> > +	wm8904_1a: audio-codec@1a {
> > +		compatible = "wlf,wm8904";
> 
> This node doesn't have YAML bindings :(

Correct. I do not see a problem with that for this specific patch.

> > +		AVDD-supply = <&reg_1v8_sw>;
> > +		CPVDD-supply = <&reg_1v8_sw>;
> > +		DBVDD-supply = <&reg_1v8_sw>;
> > +		DCVDD-supply = <&reg_1v8_sw>;
> > +		MICVDD-supply = <&reg_1v8_sw>;
> 
> I dont see these properties in .txt bindings either.

Yes, the .txt file is not correct. See here for more details
https://lore.kernel.org/all/20230405200341.4911-1-danascape@gmail.com/

With that said they are required

$ grep -A5 wm8904_supply_names sound/soc/codecs/wm8904.c
static const char *wm8904_supply_names[WM8904_NUM_SUPPLIES] = {
	"DCVDD",
	"DBVDD",
	"AVDD",
	"CPVDD",
	"MICVDD",
--
		wm8904->supplies[i].supply = wm8904_supply_names[i];

	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8904->supplies),
				      wm8904->supplies);
	if (ret != 0) {
		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);


Francesco
