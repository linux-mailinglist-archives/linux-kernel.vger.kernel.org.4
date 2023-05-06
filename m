Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085386F9447
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjEFV6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFV6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 17:58:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13D0F191E6;
        Sat,  6 May 2023 14:58:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC8FC1FB;
        Sat,  6 May 2023 14:59:14 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 364DF3F5A1;
        Sat,  6 May 2023 14:58:27 -0700 (PDT)
Date:   Sat, 6 May 2023 22:58:11 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/6] dt-bindings: spi: sun6i: add DT bindings for
 Allwinner R329 SPI
Message-ID: <20230506225811.4e928e46@slackpad.lan>
In-Reply-To: <e38cbcdf-5963-fb00-d7b2-66d4129f9fce@linaro.org>
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
        <20230506073018.1411583-2-bigunclemax@gmail.com>
        <e38cbcdf-5963-fb00-d7b2-66d4129f9fce@linaro.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 May 2023 12:53:07 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi Maksim,

> On 06/05/2023 09:30, Maksim Kiselev wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > Allwinner R329 SPI has two controllers, and the second one has helper
> > functions for MIPI-DBI Type C.  
> 
> I wonder what is the difference of DBI compatible. You refer to "helper
> functions", which sounds like driver... do you mean some parts of SPI
> controller?

So I checked the manuals, all of the D1, T113-s and R329 are the same
in this respect:
- There are two SPI controllers, the "first" one is what this series
  fully supports.
- The second SPI controller has some additional registers and two
  extra bits in the control register to drive the DBI extension, but is
  otherwise compatible to the first one:

So I'd suggest to introduce the following compatible string
combinations to the binding *now*. We don't support the DBI bits (yet),
but this would be the correct hardware description:

For the R329:
spi0: spi@4025000 {
	compatible = "allwinner,sun50i-r329-spi";
	....
spi1: spi@4026000 {
	compatible = "allwinner,sun50i-r329-spi-dbi",
		     "allwinner,sun50i-r329-spi";
For the D1/T113s:
spi0: spi@4025000 {
	compatible = "allwinner,sun20i-d1-spi",
		     "allwinner,sun50i-r329-spi";
	....
spi1: spi@4026000 {
	compatible = "allwinner,sun20i-d1-spi-dbi",
		     "allwinner,sun50i-r329-spi-dbi",
		     "allwinner,sun50i-r329-spi";

I leave that as an exercise to the reader to convert that into the
minimal set of DT schema lines ;-)
I would suggest to add both the D1/T113s and the R329 bindings in this
one patch, to reduce the churn. I guess if you do this, you could even
drop Icenowy's authorship on this patch, since it has not much to do
with the original version anymore.

Cheers,
Andre


> > Add compatible strings for these controllers
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
> > ---
> >  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml        | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> > index de36c6a34a0f..2c1b8da35339 100644
> > --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> > @@ -21,6 +21,8 @@ properties:
> >      oneOf:
> >        - const: allwinner,sun6i-a31-spi
> >        - const: allwinner,sun8i-h3-spi
> > +      - const: 
> > +      - const: allwinner,sun50i-r329-spi-dbi  
> 
> As Conor pointed out, nothing improved here.
> 
> Best regards,
> Krzysztof
> 

