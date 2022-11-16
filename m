Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7810F62CCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiKPV2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiKPV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:28:18 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3F1016;
        Wed, 16 Nov 2022 13:28:17 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1A213100002;
        Wed, 16 Nov 2022 21:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668634095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltzh9/l6lO1+cC4vvPq/qAQhaS+jbpgx9OzaL7mBjUc=;
        b=QnWrcUEujfbcQQ4c4G087swN9OF2fjWn6FETtVjI43Kxdd05+ggkpjiRaynpHUZZe0eswi
        K2CRQzI/ZIctaCIEUisW7qAOmIf5NnnW3gA9t7wA8fWHi44nqfzuyix8h+FCHU9WUKQjGF
        HISHtb0uep8KJFawdhWk3cth+JDuxzdcP6LxfsV/lHrJjihpX7PSN06pDVzfOg5vOMIQoF
        e2FnS4hLcy9Uh5gYZLfsdNZSI4+09o3ey0+j/7uBrN2D5omwPqll/o/MQPyHOKH4g4C+I9
        tdIO/J5iij7xw3z7PIkLTMQHTHpUJ6X4NzhpV3b79+VFjq+uwYtoTqTUdHTklg==
Date:   Wed, 16 Nov 2022 22:28:12 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: nvmem: add YAML schema for the sl28
 vpd layout
Message-ID: <20221116222812.45dbbcf9@xps-13>
In-Reply-To: <20221116205203.GA846642-robh@kernel.org>
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
        <20221114085659.847611-4-miquel.raynal@bootlin.com>
        <20221116205203.GA846642-robh@kernel.org>
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

Hi Rob, Srinivas,

robh@kernel.org wrote on Wed, 16 Nov 2022 14:52:03 -0600:

> On Mon, Nov 14, 2022 at 09:56:57AM +0100, Miquel Raynal wrote:
> > From: Michael Walle <michael@walle.cc>
> >=20
> > Add a schema for the NVMEM layout on Kontron's sl28 boards.
> >=20
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../nvmem/layouts/kontron,sl28-vpd.yaml       | 62 +++++++++++++++++++
> >  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  3 +
> >  2 files changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kon=
tron,sl28-vpd.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl=
28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-=
vpd.yaml
> > new file mode 100644
> > index 000000000000..fef795e79c36
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.=
yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/nvmem/layouts/kontron,sl28-vpd.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVMEM layout of the Kontron SMARC-sAL28 vital product data
> > +
> > +maintainers:
> > +  - Michael Walle <michael@walle.cc>
> > +
> > +description:
> > +  The vital product data (VPD) of the sl28 boards contains a serial
> > +  number and a base MAC address. The actual MAC addresses for the
> > +  on-board ethernet devices are derived from this base MAC address by
> > +  adding an offset.
> > +
> > +select: false
> > +
> > +properties:
> > +  compatible:
> > +    const: kontron,sl28-vpd
> > +
> > +  serial-number:
> > +    type: object =20
>=20
>        additionalProperties: false

Right, I missed that one.

> With that,
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for all the reviews!

Srinivas, would you add the above property while applying or do you
prefer me to send a v5?

Thanks,
Miqu=C3=A8l
