Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245116DDDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDKOXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDKOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:23:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B423A4C0E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:23:25 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1pmEtk-0000iH-T0; Tue, 11 Apr 2023 16:23:05 +0200
Message-ID: <b394b456540943b1022a7b093bf369924fca0566.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jun.li@nxp.com,
        haibo.chen@nxp.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 11 Apr 2023 16:22:37 +0200
In-Reply-To: <95b4afd4-c93e-628b-fd22-6fcbc1d1234e@linaro.org>
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
         <20230405112118.1256151-2-j.zink@pengutronix.de>
         <5398cbe0-c681-5dd7-0b3e-3a586cc4915f@linaro.org>
         <3f7257ee36dc44f162a87281c8279fd5bad91dea.camel@pengutronix.de>
         <95b4afd4-c93e-628b-fd22-6fcbc1d1234e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzystof,

thank you for your explanations. As I'm still quite new to writing
bindings, I still have some questions:

On Fri, 2023-04-07 at 11:03 +0200, Krzysztof Kozlowski wrote:
> On 05/04/2023 14:14, Johannes Zink wrote:
> > Hi Krysztof,
> > 
> > thanks for your review, please find my questions below.
> > 
> > On Wed, 2023-04-05 at 13:51 +0200, Krzysztof Kozlowski wrote:
> > > [snip]
> > > >        A phandle to the regulator for USB VBUS.
> > > >  
> > > > +  fsl,phy-tx-vref-tune:
> > > > +    description:
> > > > +      HS DC Voltage level adjustment
> > > 
> > > "Level" in what units?
> > > 
> > 
> > The datasheet just shows percent, ranging from -6 to +24%, in 2%
> > increments. What unit would you suggest?
> 
> percent
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

I am still a bit confused how to use this properly. How can I restrict
the values to multiples of 2 in order to avoid illegal values?

At the moment the only thing I could come up with is something like

fsl,phy-tx-vref-tune-percent:                 
  description: |                              
    Adjusts the high-speed DC level voltage   
  $ref: /schemas/types.yaml#/definitions/int32
  minimum: -6                                 
  maximum: 24                                 
  default: 0                                  

Does something like this work? I am not quite sure if I am on the right
track here, especially as this requires a signed int, of which I have
not seen many examples so far.

Also, as far as the description is concerned: This is almost the entire
information I there is in the datasheet. As I try to upstream some of
the vendor downstream patches, I do not have any additional
information.

> 
> > 
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
> > > > 15,
> > > > 16]
> > > > +
> > > > +  fsl,phy-tx-rise-tune:
> > > > +    description:
> > > > +      HS Transmitter Rise/Fall Time Adjustment
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [0, 1, 2, 3]
> > > > +
> > > > +  fsl,phy-tx-preemp-amp-tune:
> > > > +    description:
> > > > +      HS Transmitter Pre-Emphasis Current Control
> > > 
> > > If this is current then use standard unit suffixes.
> > 
> > According to the datasheet this is in "unit amonts" of 600uA,
> > basically
> > 0x600uA, 1x600uA etc. Should I just suffix it with uA then?
> 
> Yes
>  
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> 
> The register values can work sometimes fine but also do not scale at
> all. For any other variant all the meanings will differ. Any other
> IMX8
> phy will need new bindings and new description/values for your
> register-like-fields.

I think this particular property should work, probably its something
like

fsl,phy-tx-preemp-amp-tune-microamps:                                 
  description: |                                                      
    Transmitter Pre-Emphasis Current Control                          
    Controls the amount of current sourced to DPn and DMn after a J-to-
K or K-to-J transition.                                                
  $ref: /schemas/types.yaml#/definitions/uint32                       
  minimum: 0                                                          
  maximum: 1800                                                       
  default: 0                                                          

What's the right way to communicate that the value is in multiples of
600uA and that this is only an approximate Value? Add some free-text to
the description?


For some other properties, such as fsl,phy-pcs-tx-swing-full or
fsl,phy-pcs-tx-deemph-3p5db the datasheet provides no information at
all, neither on the unit nor on a valid range. What is the proper way
for something like them (I try to get some of the freescale downstream
patches to mainline, but they did not even provide bindings for their
driver...)


For fsl,phy-comp-dis-tune-percent, the actual values to not map well to
integer amount of percent, but I have not found a permill in property-
units. Also, as the steps appear quite arbitrary large, what is the
correct way of restricting the values to valid values that the hardware
can actually support? As reference, I have only seen stuff like the
st,trim-hs-current in Documentation/devicetree/bindings/phy/phy-stm32-
usbphyc.yaml so far...

Thanks for helping me and best regards
Johannes


> 
> Best regards,
> Krzysztof
> 
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

