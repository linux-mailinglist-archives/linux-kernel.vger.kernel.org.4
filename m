Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7B96B0ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCHORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCHORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:17:49 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55961B7;
        Wed,  8 Mar 2023 06:17:47 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5B3B3100005;
        Wed,  8 Mar 2023 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678285064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ckkizSkqfpuXz8Zx7JuXXhRPSLg148Bi0uyN9GWvRkY=;
        b=Ye3jjzSRHlTOHCsl1IB74N9vmV2LrUMuAsXM5yKHN7ARBB0v4S77tRtpZwtTLpfGpxDp1a
        JZK5Kk493uko8aQf/VxTCJ5sld/Utp3aRm3fC4+4tvNS+6rzTNkOjOWmAsSzHLor44dFCw
        yLhX1niT43lbts5DmVAHuIin581W7gtBGy4L6JK5CX8eIwF5BSSbCnbfPpDgza2kzqCI5V
        wH4WWm6ScN9ubEF5pbmCar8Pkb/5ZHOxlc8IMwrLoesTV4ZRtEfdkHovuxKdA9mO0+hxnN
        wT6JnJAsG2flx4N8hLeNvuMt2swTfzd3w4cYQxVAybVY88M4wSGH2m3NeuGCGQ==
Date:   Wed, 8 Mar 2023 15:17:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/21] of: Rename of_modalias_node()
Message-ID: <20230308151740.673f863f@xps-13>
In-Reply-To: <20230308001903.GA513330-robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
        <20230307165359.225361-4-miquel.raynal@bootlin.com>
        <20230308001903.GA513330-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Tue, 7 Mar 2023 18:19:03 -0600:

> On Tue, Mar 07, 2023 at 05:53:41PM +0100, Miquel Raynal wrote:
> > This helper does not produce a real modalias, but tries to get the
> > "product" compatible part of the "vendor,product" compatibles only. It
> > is far from creating a purely useful modalias string and does not seem
> > to be used like that directly anyway, so let's try to give this helper a
> > more meaningful name before moving there a real modalias helper (already
> > existing under of/device.c).
> >=20
> > Also update the various documentations to refer to the strings as
> > "aliases" rather than "modaliases" which has a real meaning in the Linux
> > kernel.
> >=20
> > There is no functional change.
> >=20
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: Wolfram Sang <wsa@kernel.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/acpi/bus.c                |  7 ++++---
> >  drivers/gpu/drm/drm_mipi_dsi.c    |  2 +-
> >  drivers/hsi/hsi_core.c            |  2 +- =20
>=20
> These should not have been using this function. The matching on just the=
=20
> product was a relic from I2C and SPI which we don't want to propogate.=20
> No clue why ACPI needed it...
>=20
> If you respin or want to fixup while applying, can you add a kerneldoc=20
> comment to not add new users of the function. Not that anyone will=20
> follow that... :(

I extensively scratched my forehead while trying to understand the use
of this function. I've added this to my v3:

  * It does this by stripping the manufacturer prefix (as delimited by a ',=
')
  * from the first entry in the compatible list property.
  *
+ * Note: The matching on just the "product" side of the compatible is a re=
lic
+ * from I2C and SPI. Please do not add any new user.
+ *
  * Return: This routine returns 0 on success, <0 on failure.
  */

> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> >  drivers/i2c/busses/i2c-powermac.c |  2 +-
> >  drivers/i2c/i2c-core-of.c         |  2 +-
> >  drivers/of/base.c                 | 15 ++++++++-------
> >  drivers/spi/spi.c                 |  4 ++--
> >  include/linux/of.h                |  2 +-
> >  8 files changed, 19 insertions(+), 17 deletions(-) =20


Thanks,
Miqu=C3=A8l
