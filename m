Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D4F7396BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjFVFQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFVFQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:16:50 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A96CE9;
        Wed, 21 Jun 2023 22:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1687411008; x=1718947008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXSa4QLaPeHRSIGngAkBe0zIJ6RCzTLgtQw4tPfpGj4=;
  b=e7IBghg0fb1mWZ4RAs3wFC7yAc6gVailOafPGo+tKmkHMRJn9tXybbkw
   gbtPmk5k3qlgu8o2XLd1+NASOcc9klO2G1rtI/Em9HLsu5Qa4YRw00lYh
   6mtOQvPA9WsA0z/O4X5rYKZHA3OcDapWag0v42C9NeWXq2LO0tv0TpT62
   DF0gjeN/BxyJ1aLRdKvPiggJpCx+HOA6Hp2G+0iGxTUZAE25WQBy5YxNC
   kyB51SRGqsMcI/eozLRvcy/K/9HQXBVsHNtEthIOf7YNPFgPxaJ7M2yN1
   e+V1w2eKjq/tOxJtJzws9I8JnvpkUIkiQ9xHmIFj8a3LXRGJzU4JoZO5c
   A==;
X-IronPort-AV: E=Sophos;i="6.00,262,1681164000"; 
   d="scan'208";a="31548948"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Jun 2023 07:16:46 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3052528007C;
        Thu, 22 Jun 2023 07:16:46 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Benjamin Bara <bbara93@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: misc: onboard-hub: support multiple power supplies
Date:   Thu, 22 Jun 2023 07:16:45 +0200
Message-ID: <8701196.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZJMPv6Fm3On0ITFi@google.com>
References: <20230620-hx3-v2-0-76a53434c713@skidata.com> <20230620-hx3-v2-1-76a53434c713@skidata.com> <ZJMPv6Fm3On0ITFi@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 21. Juni 2023, 16:57:03 CEST schrieb Matthias Kaehlcke:
> ********************
> Achtung externe E-Mail: =D6ffnen Sie Anh=E4nge und Links nur, wenn Sie wi=
ssen,
> dass diese aus einer sicheren Quelle stammen und sicher sind. Leiten Sie
> die E-Mail im Zweifelsfall zur Pr=FCfung an den IT-Helpdesk weiter.
> Attention external email: Open attachments and links only if you know that
> they are from a secure source and are safe. In doubt forward the email to
> the IT-Helpdesk to check it. ********************
>=20
> Hi,
>=20
> On Wed, Jun 21, 2023 at 04:26:27PM +0200, Benjamin Bara wrote:
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >=20
> > As some of the onboard hubs require multiple power supplies, provide the
> > environment to support them.
> >=20
> > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
>=20
> Overall this looks good to me, a few nits inside.
>=20
> > ---
> > v2:
> > - replace (err !=3D 0) with (err)
> > ---
> >=20
> >  drivers/usb/misc/onboard_usb_hub.c | 36
> >  ++++++++++++++++++++++++++++-------- drivers/usb/misc/onboard_usb_hub.h
> >  |  1 +
> >  2 files changed, 29 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/usb/misc/onboard_usb_hub.c
> > b/drivers/usb/misc/onboard_usb_hub.c index 12fc6eb67c3b..3de30356a684
> > 100644
> > --- a/drivers/usb/misc/onboard_usb_hub.c
> > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > @@ -27,6 +27,12 @@
> >=20
> >  #include "onboard_usb_hub.h"
> >=20
> > +#define SUPPLIES_NUM_MAX 2
>=20
> MAX_SUPPLIES?

Do we need this MAX_SUPPLIES macro at all? This essentially is=20
ARRAY_SIZE(supply_names), no? At least it should be
> #define MAX_SUPPLIES ARRAY_SIZE(supply_names)

>=20
> add empty line
>=20
> > +static const char * const supply_names[] =3D {
> > +	"vdd",
> > +	"vdd2",
> > +};
> > +
> >=20
> >  static void onboard_hub_attach_usb_driver(struct work_struct *work);
> > =20
> >  static struct usb_device_driver onboard_hub_usbdev_driver;
> >=20
> > @@ -40,7 +46,8 @@ struct usbdev_node {
> >=20
> >  };
> > =20
> >  struct onboard_hub {
> >=20
> > -	struct regulator *vdd;
> > +	struct regulator_bulk_data supplies[SUPPLIES_NUM_MAX];
> > +	unsigned int supplies_num;
>=20
> num_supplies?
>=20
> >  	struct device *dev;
> >  	const struct onboard_hub_pdata *pdata;
> >  	struct gpio_desc *reset_gpio;
> >=20
> > @@ -55,9 +62,9 @@ static int onboard_hub_power_on(struct onboard_hub *h=
ub)
> >=20
> >  {
> > =20
> >  	int err;
> >=20
> > -	err =3D regulator_enable(hub->vdd);
> > +	err =3D regulator_bulk_enable(hub->supplies_num, hub->supplies);
> >=20
> >  	if (err) {
> >=20
> > -		dev_err(hub->dev, "failed to enable regulator: %d\n",=20
err);
> > +		dev_err(hub->dev, "failed to enable supplies: %d\n", err);
> >=20
> >  		return err;
> >  =09
> >  	}
> >=20
> > @@ -75,9 +82,9 @@ static int onboard_hub_power_off(struct onboard_hub
> > *hub)
> >=20
> >  	gpiod_set_value_cansleep(hub->reset_gpio, 1);
> >=20
> > -	err =3D regulator_disable(hub->vdd);
> > +	err =3D regulator_bulk_disable(hub->supplies_num, hub->supplies);
> >=20
> >  	if (err) {
> >=20
> > -		dev_err(hub->dev, "failed to disable regulator: %d\n",=20
err);
> > +		dev_err(hub->dev, "failed to disable supplies: %d\n",=20
err);
> >=20
> >  		return err;
> >  =09
> >  	}
> >=20
> > @@ -232,6 +239,7 @@ static int onboard_hub_probe(struct platform_device
> > *pdev)>=20
> >  	const struct of_device_id *of_id;
> >  	struct device *dev =3D &pdev->dev;
> >  	struct onboard_hub *hub;
> >=20
> > +	unsigned int i;
> >=20
> >  	int err;
> >  =09
> >  	hub =3D devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> >=20
> > @@ -246,9 +254,21 @@ static int onboard_hub_probe(struct platform_device
> > *pdev)>=20
> >  	if (!hub->pdata)
> >  =09
> >  		return -EINVAL;
> >=20
> > -	hub->vdd =3D devm_regulator_get(dev, "vdd");
> > -	if (IS_ERR(hub->vdd))
> > -		return PTR_ERR(hub->vdd);
> > +	if (hub->pdata->supplies_num > SUPPLIES_NUM_MAX)
> > +		return dev_err_probe(dev, -EINVAL, "max %d supplies=20
supported!\n",
> > +				     SUPPLIES_NUM_MAX);
> > +	hub->supplies_num =3D 1;
> > +	if (hub->pdata->supplies_num > 1)
> > +		hub->supplies_num =3D hub->pdata->supplies_num;
>=20
> Please change the above to:
>=20
> 	if (hub->pdata->supplies_num !=3D 0)
> 		hub->supplies_num =3D hub->pdata->supplies_num;
> 	else
> 		hub->supplies_num =3D 1;
>=20

In the kernel there is also this style:
> hub->supplies_num =3D hub->pdata->supplies_num? : 1;

But it's up to you which one you prefer.

Best regards,
Alexander

> > +
> > +	for (i =3D 0; i < SUPPLIES_NUM_MAX; i++)
> > +		hub->supplies[i].supply =3D supply_names[i];
> > +
> > +	err =3D devm_regulator_bulk_get(dev, hub->supplies_num, hub-
>supplies);
> > +	if (err) {
> > +		dev_err(dev, "Failed to get regulator supplies: %d\n",=20
err);
> > +		return err;
> > +	}
> >=20
> >  	hub->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> >  =09
> >  						  GPIOD_OUT_HIGH);
> >=20
> > diff --git a/drivers/usb/misc/onboard_usb_hub.h
> > b/drivers/usb/misc/onboard_usb_hub.h index aca5f50eb0da..657190bf1799
> > 100644
> > --- a/drivers/usb/misc/onboard_usb_hub.h
> > +++ b/drivers/usb/misc/onboard_usb_hub.h
> > @@ -8,6 +8,7 @@
> >=20
> >  struct onboard_hub_pdata {
> > =20
> >  	unsigned long reset_us;		/* reset pulse width in us=20
*/
> >=20
> > +	unsigned int supplies_num;	/* num of supplies: 0 considered as 1=20
*/
>=20
> num_supplies?
>=20
> s/num of/number of/
>=20
> >  };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


