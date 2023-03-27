Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93EE6CB299
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjC0XpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC0XpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:45:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1E531B8;
        Mon, 27 Mar 2023 16:45:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB4ACC14;
        Mon, 27 Mar 2023 16:46:03 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6556C3F73F;
        Mon, 27 Mar 2023 16:45:17 -0700 (PDT)
Date:   Tue, 28 Mar 2023 00:44:45 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dt-bindings: mfd: x-powers,axp152: Document the
 AXP313a variant
Message-ID: <20230328002802.5ae4961b@slackpad.lan>
In-Reply-To: <460ee8a7-23a8-fc70-1eb6-88bbaa99b35a@linaro.org>
References: <20230324113013.254371-1-andre.przywara@arm.com>
 <20230324113013.254371-2-andre.przywara@arm.com>
 <460ee8a7-23a8-fc70-1eb6-88bbaa99b35a@linaro.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2023 12:40:38 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi,

> On 24/03/2023 12:30, Andre Przywara wrote:
> > From: Martin Botka <martin.botka@somainline.org>
> > 
> > The X-Powers AXP313a is a PMIC used on some devices with the Allwinner
> > H616 or H313 SoC.
> > According to the datasheet, the DC/DC converter PWM frequency is fixed
> > (to 3 MHz), so disallow the property that lets us set this frequency
> > for the other PMICs.
> > 
> > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../devicetree/bindings/mfd/x-powers,axp152.yaml     | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > index b7a8747d5fa0e..4b4f42cb09ef7 100644
> > --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > @@ -79,6 +79,17 @@ allOf:
> >        required:
> >          - interrupts
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: x-powers,axp313a
> > +
> > +    then:
> > +      not:
> > +        required:
> > +          - x-powers,dcdc-freq  
> 
> Should be simpler x-powers,dcdc-freq: false

Ah, many thanks! I was a bit concerned about "not required" not sounding
quite right, but I indeed copied from the other cases and verified that
it worked as expected.
But yours is indeed much better, thanks for the other patch!

Cheers,
Andre

> I'll fix the other cases.
> 
> Best regards,
> Krzysztof
> 

