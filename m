Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E880A714A73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjE2Nfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjE2Nfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:35:45 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437CE8E
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:35:42 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685367340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ksXb/aDfBenqNlIYCSyFo4FSNvObLHlBdpOrdIIYaA=;
        b=nqyudWjs+n7T5Ria+tuZ4bewOSaoOgrLe3Aq9/K00/z8FMTtF4yGN0LmhkWjn2x2up8q2V
        Bl0YmE6w+ubPXn4MZx/8+eBZjcoF9qrnIK3Jdr9w2q+S8E/7gs5iUPT3Mtf6y0EM2SoGTy
        4ozwTNfbbN+7JRN6yQ2TTshVWfA0Wv+5FEbTOc7Bp20pKZEdU/dTKTbwsvWMYdn13UU2QS
        9IklMKELBWLtLVuep/Jhk3C3NEKReFAmWJqXEJPZX9YnfzRBWgelgHQBmTVYciPIbXKk31
        /qd2rgwsG+VyISkdHBb1L/xIbD0I8kxb7pIHqMLzVjBaatzrED0+CdkW6Owzfg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30EC0240002;
        Mon, 29 May 2023 13:35:40 +0000 (UTC)
Date:   Mon, 29 May 2023 15:35:39 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <20230529153539.1c9aeee2@xps-13>
In-Reply-To: <2023052953-average-fade-8b07@gregkh>
References: <20230523100239.307574-1-miquel.raynal@bootlin.com>
        <20230523100239.307574-3-miquel.raynal@bootlin.com>
        <2023052351-doze-purist-9780@gregkh>
        <20230523191402.0728443a@xps-13>
        <20230529121226.4a74a3bb@xps-13>
        <2023052953-average-fade-8b07@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

gregkh@linuxfoundation.org wrote on Mon, 29 May 2023 14:05:30 +0100:

> On Mon, May 29, 2023 at 12:12:26PM +0200, Miquel Raynal wrote:
> > Hi Greg,
> >=20
> > miquel.raynal@bootlin.com wrote on Tue, 23 May 2023 19:14:02 +0200:
> >  =20
> > > Hi Greg,
> > >=20
> > > gregkh@linuxfoundation.org wrote on Tue, 23 May 2023 17:58:51 +0100:
> > >  =20
> > > > On Tue, May 23, 2023 at 12:02:39PM +0200, Miquel Raynal wrote:   =20
> > > > > +/* Cell attributes will be dynamically allocated */
> > > > > +static struct attribute_group nvmem_cells_group =3D {
> > > > > +	.name		=3D "cells",
> > > > > +};
> > > > > +
> > > > >  static const struct attribute_group *nvmem_dev_groups[] =3D {
> > > > >  	&nvmem_bin_group,
> > > > > +	NULL, /* Reserved for exposing cells, if any */     =20
> > > >=20
> > > > Please don't do this, but rather use the is_visible callback to
> > > > determine if it should be shown or not.   =20
> > >=20
> > > Ah, excellent point. Don't know why I overlooked that member. =20
> >=20
> > Actually, the .is_visible callback only acts on the files and
> > not the directories (created based on the group name). =20
>=20
> That is true, I have a non-working patch somewhere around here that will
> not create the directory if no files are in that directory, and need to
> get that working someday...

I see, indeed that would be a nice addition.

> > This
> > means whether they are visible or not, the attributes must be
> > valid, the nvmem core cannot just toggle a boolean value with
> > .is_visible because the sysfs core makes a number of checks
> > regarding the content of the attributes, without checking if
> > they are visible at all. =20
>=20
> You can't toggle a value, that's not how is_visible works.  It's a
> callback at the creation time, you do know if you should, or should not,
> show the files at creation time, right?

I think I should be able to do that.

> If so, all should be fine, just ignore the empty directory, it's fine.

Ok.

> And hopefully one day, it will not be created if there are no files in
> it.  If I can ever get that patch working...
>=20
> > I can however expose the "cells" bin group by default by having
> > it listed in the static bin_attribute list and discard it by
> > overwriting the list member with NULL (ie. the opposite of the current
> > solution). =20
>=20
> Ick, no, please don't do that.  attribute lists should be able to be put
> into read-only memory, and are not set up to be dynamically messed with
> like this at all.

I get the idea, makes sense.

However in my case, the list of attribute groups can lay into RO
memory, that's fine, but the attribute group for the cells
will not. Indeed, the .bin_attrs list must be populated at run time
as we do not know it's size at compilation time.

I hope this is acceptable.

Thanks,
Miqu=C3=A8l
