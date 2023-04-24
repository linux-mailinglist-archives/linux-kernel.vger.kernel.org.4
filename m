Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007F86EC6BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjDXHDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjDXHDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:03:25 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00768A0;
        Mon, 24 Apr 2023 00:03:21 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 401B2240002;
        Mon, 24 Apr 2023 07:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682319800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSUHQtIwA/w5cK0iupKdjI9R53MDNctcBBJYngsGSKs=;
        b=hn1d5cMJ+oOsbAF5xmGkLtDl8+/c8FUYwxZnObLp0Q8vNGICq4/Bjkt64kF4RVp3q2uTro
        Rm4uoo18YKq18KUtzPYSRWyT2aolLhnurG+Bj1cO3nOmqIYcznYSJ7vvxqFitj8Ubg7bKA
        /sR0jEInB7qagF+X5W1gN1q5yxk2D5X2+1iXULxwe6N46geLgoLl8NAKyy6rRuKk9p6m2a
        KhJKgtDhEPBADefV9qH8ngOOmkwVEAYB8XjJ1vqYtSP8c8bQWwtywlo7FbVr5YvphIMx+3
        VdxDBqYUi7NeBzwfJHnDVRYE5MJDM8FGTQP1GGTR4qzwBpdIlrEp9HYolwl0pg==
Date:   Mon, 24 Apr 2023 09:03:18 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: potentiometer: Add the Renesas
 X9250 potentiometers
Message-ID: <20230424090318.4750a5e7@bootlin.com>
In-Reply-To: <20230422171807.510d7fa3@jic23-huawei>
References: <20230421085245.302169-1-herve.codina@bootlin.com>
        <20230421085245.302169-2-herve.codina@bootlin.com>
        <20230422171807.510d7fa3@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan, Krzysztof,

On Sat, 22 Apr 2023 17:18:07 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 21 Apr 2023 10:52:43 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > The Renesas X9250 is a quad digitally controlled potentiometers.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> Hi Herve,
> 
> Historically we've been a bit lax in IIO bindings in always making
> sure the per supplies are included.  As a result we frequently get
> them added later and it just makes things messier than they should
> be.
> 
> So please add vcc-supply from the start.  V+ and V- are a little trickier.
> I was expecting datasheet to say they should be symmetric about 0 but it
> doesn't. So they could be two independent supplies.
> 
> Also make it required as my current understanding is that we should
> do that for supplies that are definitely present even if we could
> rely on the fallback to regulator stubs if they aren't supplied.
> So add the 3 supplies to required as well.

Yes, I will add the following supplies in the next iteration:
 - 'vcc-supply' for VCC
 - 'avp-supply' for the analog V+
 - 'avn-supply' for the analog V-

and add them in the required list of properties.

Are the names correct for these power supplies (avp and avn) ?

> 
> Less of a requirement, but you might want to also provide an optional 
> gpio for the not WP pin on basis someone might wire it up to the host processor.

I will add the 'wp-gpios' property.

> 
> Beyond the comment Krzystof made on iio.yaml this otherwise looks good to me.

And for the Krzystof comment on iio.yaml, as he suggested, I will drop iio.yaml.

Thanks for the review,
Hervé

> 
> 
> 
> 
> > ---
> >  .../iio/potentiometer/renesas,x9250.yaml      | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> > new file mode 100644
> > index 000000000000..dfa36b23eb0d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/potentiometer/renesas,x9250.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas X9250 quad potentiometers
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description:
> > +  The Renesas X9250 integrates four digitally controlled potentiometers.
> > +  On each potentiometer, the X9250T has a 100 kOhms total resistance and the
> > +  X9250U has a 50 kOhms total resistance.
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> > +  - $ref: /schemas/iio/iio.yaml
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - renesas,x9250t
> > +      - renesas,x9250u
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#io-channel-cells':
> > +    const: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 2000000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#io-channel-cells'
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        potentiometer@0 {
> > +            compatible = "renesas,x9250t";
> > +            reg = <0>;
> > +            spi-max-frequency = <2000000>;
> > +            #io-channel-cells = <1>;
> > +        };
> > +    };  
> 
