Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F07147C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjE2KMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2KMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:12:32 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1A583
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:12:29 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685355147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxlQGqk/ZjYPeSZuGk6DhPP1ziKTkwxGLUWRpoIAlkc=;
        b=K+fgGThzLBSuTlrSnjCDWPJx+yEKq1I3o3kTL9woETZn3n9XYqcGH9fEJgDSRF46Eai0Dh
        xePBbEABYAmKRSM/NRFXkChbIud2t/YvJxcSmqcBsMYGNObCSSJTS5zAotszAkpIRCWGjV
        aSKahP9Uy3dMV7GiJM6FovNufu5UyeAs+vfjezsFZDWOoxl8oqvXPaijQwX6qsU8guhF/p
        p0Th0UrjGrY4UM7Zu9QK+VAGRJoULlo2tHqG+1Tm3eE5XbVXGK6RkO2nYOwZwaoO2l8A+x
        Yi8EK8RuHIFOfjuWojc8I6ZO+BMAMDs4Ozaaw/mp/U8jYO0CcF/V63TOzIQoHw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A42F40006;
        Mon, 29 May 2023 10:12:27 +0000 (UTC)
Date:   Mon, 29 May 2023 12:12:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <20230529121226.4a74a3bb@xps-13>
In-Reply-To: <20230523191402.0728443a@xps-13>
References: <20230523100239.307574-1-miquel.raynal@bootlin.com>
        <20230523100239.307574-3-miquel.raynal@bootlin.com>
        <2023052351-doze-purist-9780@gregkh>
        <20230523191402.0728443a@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

miquel.raynal@bootlin.com wrote on Tue, 23 May 2023 19:14:02 +0200:

> Hi Greg,
>=20
> gregkh@linuxfoundation.org wrote on Tue, 23 May 2023 17:58:51 +0100:
>=20
> > On Tue, May 23, 2023 at 12:02:39PM +0200, Miquel Raynal wrote: =20
> > > +/* Cell attributes will be dynamically allocated */
> > > +static struct attribute_group nvmem_cells_group =3D {
> > > +	.name		=3D "cells",
> > > +};
> > > +
> > >  static const struct attribute_group *nvmem_dev_groups[] =3D {
> > >  	&nvmem_bin_group,
> > > +	NULL, /* Reserved for exposing cells, if any */   =20
> >=20
> > Please don't do this, but rather use the is_visible callback to
> > determine if it should be shown or not. =20
>=20
> Ah, excellent point. Don't know why I overlooked that member.

Actually, the .is_visible callback only acts on the files and
not the directories (created based on the group name). This
means whether they are visible or not, the attributes must be
valid, the nvmem core cannot just toggle a boolean value with
.is_visible because the sysfs core makes a number of checks
regarding the content of the attributes, without checking if
they are visible at all.

I can however expose the "cells" bin group by default by having
it listed in the static bin_attribute list and discard it by
overwriting the list member with NULL (ie. the opposite of the current
solution). This implies two things: I need to provide an empty list of
files (otherwise the core warns) and if no list is provided then the
"cells" folder will always appear, no matter if there are cells or not
exposed by this nvmem device. So the folder can be empty.

If this is fine, I can:

* Expose the "cells" bin group,=20
* Provide an empty .bin_attrs list (otherwise I get a complain from
  the sysfs core when the nvmem device does not expose any cell)
* Overwrite the dummy .bin_attrs member when the device expose cells,
  keep it empty otherwise.

Otherwise if we prefer avoiding empty folders, I can as well hide the
"cells" bin group by writing NULL to the relevant member of the
attribute_group list.

Let me know what is your preference.

Thanks,
Miqu=C3=A8l
