Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A6E623DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiKJIup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiKJIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:50:42 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39616582;
        Thu, 10 Nov 2022 00:50:40 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EFCE3C000D;
        Thu, 10 Nov 2022 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668070239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6R3bK3NsSGu68vXayq2WfqZZ9Uy4g07o50EORmeW7Q=;
        b=iQD5zYRBxcME416I7SmtNcFWEd2Ph4AghuwHTrsvEXUIAUpSlSg63+vZgiqmM5hNxMR8kD
        0hGaOe8ipcYTw7ZniV3/kObGtOMjBvfNC/quDAMx+xCK4oZyYMQBZ4W9Qy2WBQTOgzrdHo
        bYkyH/TzoV9rKMm7Oz7Fa7JR5Cc5Q88I3f9LXEcfJimb+SXfZrAcB0z/4Cai3tmmh5MuVL
        ibz6Pnh4/tidD4DXjMba6iidUVQ20l6pjDRF+q1BE7rzNUJPY43kbKyR+i6myw49N0Q1mo
        ccgF5HnUdvNBVomT2QmPjhzobhX7WZyHqIm4CpZPr56IHXBv5/LXCfkGROnVCg==
Date:   Thu, 10 Nov 2022 09:50:34 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: nvmem: add YAML schema for the ONIE
 tlv layout
Message-ID: <20221110095034.7a80163a@xps-13>
In-Reply-To: <20221110040055.GA3436769-robh@kernel.org>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
        <20221104163833.1289857-7-miquel.raynal@bootlin.com>
        <20221110040055.GA3436769-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Wed, 9 Nov 2022 22:00:55 -0600:

> On Fri, Nov 04, 2022 at 05:38:33PM +0100, Miquel Raynal wrote:
> > Add a schema for the ONIE tlv NVMEM layout that can be found on any ONIE
> > compatible networking device.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
> >  .../nvmem/layouts/onie,tlv-layout.yaml        | 115 ++++++++++++++++++
> >  2 files changed, 116 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/oni=
e,tlv-layout.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layo=
ut.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > index f64ea2fa362d..8512ee538c4c 100644
> > --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > @@ -19,6 +19,7 @@ description: |
> > =20
> >  oneOf:
> >    - $ref: kontron,sl28-vpd.yaml
> > +  - $ref: onie,tlv-layout.yaml
> > =20
> >  properties:
> >    compatible: true
> > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-l=
ayout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layou=
t.yaml
> > new file mode 100644
> > index 000000000000..1d91277324ac
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.y=
aml
> > @@ -0,0 +1,115 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/nvmem/layouts/onie,tlv-layout.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVMEM layout of the ONIE tlv table
> > +
> > +maintainers:
> > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > +
> > +description:
> > +  Modern networking hardware implementing the Open Compute Project ONIE
> > +  infrastructure shall provide a non-volatile memory with a table whos=
e the
> > +  content is well specified and gives many information about the manuf=
acturer
> > +  (name, country of manufacture, etc) as well as device caracteristics=
 (serial
> > +  number, hardware version, mac addresses, etc). The underlaying devic=
e type
> > +  (flash, EEPROM,...) is not specified. The exact location of each val=
ue is also
> > +  dynamic and should be discovered at run time because it depends on t=
he
> > +  parameters the manufacturer decided to embed.
> > +
> > +properties:
> > +  compatible:
> > +    const: onie,tlv-layout
> > +
> > +  product-name: true =20
>=20
> This is a node? If so, you need:
>=20
> type: object
> additionalProperties: false

I thought referencing a schema under a property would be enough?

Indeed in nvmem.yaml we create the property nvmem-layout and make it
reference nvmem-layout.yaml. Then, in nvmem-layout.yaml:

	 oneOf:
	  - $ref: kontron,sl28-vpd.yaml
	  - $ref: onie,tlv-layout.yaml

we reference the different layouts that may apply (very much like what
you proposed to list the mtd partition parsers, if I got it right).

Isn't it enough?

Then if you look below there is an "additionalProperties: false"
defined.

> > +
> > +  part-number: true
> > +

[...]

> > +  service-tag: true
> > +
> > +  vendor-extension: true
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false

(here)

> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        eeprom@56 {
> > +            compatible =3D "atmel,24c64";
> > +            read-only;
> > +            reg =3D <0x56>;
> > +
> > +            nvmem-layout {
> > +                compatible =3D "onie,tlv-layout";
> > +
> > +                serial-number {
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +  - |
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        flash@0 {
> > +            compatible =3D "m25p80", "jedec,spi-nor";
> > +            reg =3D <0>;
> > +
> > +            otp {
> > +                compatible =3D "user-otp";
> > +
> > +                nvmem-layout {
> > +                    compatible =3D "onie,tlv-layout";
> > +
> > +                    mac-address {
> > +                        #nvmem-cell-cells =3D <1>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > +...
> > --=20
> > 2.34.1
> >=20
> >  =20


Thanks,
Miqu=C3=A8l
