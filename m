Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50D749984
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGFKaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjGFKav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:30:51 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A4C6123
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 03:30:48 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(801843:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 06 Jul 2023 18:30:41 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 6 Jul
 2023 18:30:40 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 6 Jul 2023 18:30:40 +0800
Date:   Thu, 6 Jul 2023 18:30:40 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <cy_huang@richtek.com>, <alina_yu@richtek.com>
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Message-ID: <20230706103040.GA32138@linuxcarl2.richtek.com>
References: <cover.1688569987.git.alina_yu@richtek.com>
 <341af3996c430549243365bb8204d33a15a482be.1688569987.git.alina_yu@richtek.com>
 <d3308334-aa91-f265-2469-8a6fbc727798@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3308334-aa91-f265-2469-8a6fbc727798@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 07:58:53PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2023 17:27, alina_yu@richtek.com wrote:
> > From: alinayu <alina_yu@richtek.com>
> > 
> > Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> You missed at least DT list (maybe more), so this won't be tested by our
> tools. Performing review on untested code might be a waste of time, thus
> I will skip this patch entirely till you follow the process allowing the
> patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.
> 
> Limited review follows.
> 

Sorry, I will add all necessary people to CC list to v3.

...

> > +      Buck and ldo vout selection is based on this value.
> > +      There are two independently programmable voltage settings named as mtp-sel0 and
> > +      mtp-sel1 for RTQ2208 bucks vout voltage. 0 which means this property isn't present
> > +      and 1 which means this property is present corresponds to different adjustable registers.
> > +
> > +      0 - DVS0 registers to adjust buck vout and BUCK_[A-H]_EN_NR_MTP_SEL0 register to en/disable vout.
> > +      1 - DVS1 registers to adjust buck vout and BUCK_[A-H]_EN_NR_MTP_SEL1 register to en/disable vout.
> 
> I read it three times and still don't understand. This is bool, not 0/1,
> so are these "0" refer to DVS0 or to presence of the property? Maybe
> Mark will understand it, I don't get it.
> 

Yes, "0" refers to DVS0 registers, and "1" refers to DVS1.
and there is only DVS0 and DVS1, so I use boolean to check which one is used.

Is it more understandable if I modify that to enum ? And description will be like this

richtek,mtp-sel:
  enum: [0, 1]
    description: |
      vout register selection besed on this value.
      0 - Using DVS0 register setting to adjust vout
      1 - Using DVS1 register setting to adjust vout

...

> > +
> > +      regulator-state-(mem):
> 
> That's not a pattern.
>

Should I revise that like this ?

patternProperties:
  "^regulator-state-mem$":


> > +        type: object
> > +        additionalProperties: true
> 
> Why?

Does "additionalProperties: true" mean I need to define my own property ?
If yes, I misunderstood additionalProperties as properties like "regulator-on-in-suspend" or "regulator-mode".

> 
> > +        properties:
> > +          regulator-on-in-suspend: false
> > +          regulator-mode: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - regulators
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      rtq2208@10 {
> 
> Node names should be generic. See also explanation and list of examples
> in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 

I'll modify the node name to 

regulator@10

in v3

> > +        compatible = "richtek,rtq2208";
> > +        reg = <0x10>;
> > +        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> > +        richtek,mtp-sel;
> > +
> > +        regulators {
> > +         BUCK_A:buck_A {
> 
> Drop labels.
> 
> 

BR,
Alina
