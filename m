Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD36714B67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjE2OB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjE2OBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:01:51 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8477E4A
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:01:24 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685368858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XePuoKcIdwfXEvbTNtI0L9O/z29ezdJGrkcsNKOWJ0=;
        b=ARh89rvyL51+R6CP1AovxrOh2rEEvOe/MQMnVaiIR4Vu+DeHkAD9BfeLSO+K8KpMnTWsTq
        pHK+MKvK7zXd87f6RzHcaDgQ56mA17W0Z82hN5vOnJqI+DiaUXWrtmwkxdsCqHaUciMW92
        GspyQQe+LAmPsEe/liXx6RVfPzK4KbvvSkNDJvAt2vy1CrMmh/9LJ8ivU5dVQTniJLKFcY
        Z9Y7IC3lyS6ESpS/dG6RN8cI5WvE0CH17dYha+fmTh/7+J2Vnct4DlPz5bxa12MzZ6Hiem
        //c/Km8f/93gv1cKoj7dE71oEmyUomPclbk8KIaBvH1ztAQFxzElhJ/sJwANdw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0836C0003;
        Mon, 29 May 2023 14:00:57 +0000 (UTC)
Date:   Mon, 29 May 2023 16:00:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <20230529160057.4c030e1e@xps-13>
In-Reply-To: <2023052941-untoasted-alone-d2c5@gregkh>
References: <20230523100239.307574-1-miquel.raynal@bootlin.com>
        <20230523100239.307574-3-miquel.raynal@bootlin.com>
        <2023052351-doze-purist-9780@gregkh>
        <20230523191402.0728443a@xps-13>
        <20230529121226.4a74a3bb@xps-13>
        <2023052953-average-fade-8b07@gregkh>
        <20230529153539.1c9aeee2@xps-13>
        <2023052941-untoasted-alone-d2c5@gregkh>
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

gregkh@linuxfoundation.org wrote on Mon, 29 May 2023 14:43:51 +0100:

> On Mon, May 29, 2023 at 03:35:39PM +0200, Miquel Raynal wrote:
> > Hi Greg,
> >=20
> > gregkh@linuxfoundation.org wrote on Mon, 29 May 2023 14:05:30 +0100:
> >  =20
> > > On Mon, May 29, 2023 at 12:12:26PM +0200, Miquel Raynal wrote: =20
> > > > Hi Greg,
> > > >=20
> > > > miquel.raynal@bootlin.com wrote on Tue, 23 May 2023 19:14:02 +0200:
> > > >    =20
> > > > > Hi Greg,
> > > > >=20
> > > > > gregkh@linuxfoundation.org wrote on Tue, 23 May 2023 17:58:51 +01=
00:
> > > > >    =20
> > > > > > On Tue, May 23, 2023 at 12:02:39PM +0200, Miquel Raynal wrote: =
    =20
> > > > > > > +/* Cell attributes will be dynamically allocated */
> > > > > > > +static struct attribute_group nvmem_cells_group =3D {
> > > > > > > +	.name		=3D "cells",
> > > > > > > +};
> > > > > > > +
> > > > > > >  static const struct attribute_group *nvmem_dev_groups[] =3D {
> > > > > > >  	&nvmem_bin_group,
> > > > > > > +	NULL, /* Reserved for exposing cells, if any */       =20
> > > > > >=20
> > > > > > Please don't do this, but rather use the is_visible callback to
> > > > > > determine if it should be shown or not.     =20
> > > > >=20
> > > > > Ah, excellent point. Don't know why I overlooked that member.   =
=20
> > > >=20
> > > > Actually, the .is_visible callback only acts on the files and
> > > > not the directories (created based on the group name).   =20
> > >=20
> > > That is true, I have a non-working patch somewhere around here that w=
ill
> > > not create the directory if no files are in that directory, and need =
to
> > > get that working someday... =20
> >=20
> > I see, indeed that would be a nice addition.
> >  =20
> > > > This
> > > > means whether they are visible or not, the attributes must be
> > > > valid, the nvmem core cannot just toggle a boolean value with
> > > > .is_visible because the sysfs core makes a number of checks
> > > > regarding the content of the attributes, without checking if
> > > > they are visible at all.   =20
> > >=20
> > > You can't toggle a value, that's not how is_visible works.  It's a
> > > callback at the creation time, you do know if you should, or should n=
ot,
> > > show the files at creation time, right? =20
> >=20
> > I think I should be able to do that.
> >  =20
> > > If so, all should be fine, just ignore the empty directory, it's fine=
. =20
> >=20
> > Ok.
> >  =20
> > > And hopefully one day, it will not be created if there are no files in
> > > it.  If I can ever get that patch working...
> > >  =20
> > > > I can however expose the "cells" bin group by default by having
> > > > it listed in the static bin_attribute list and discard it by
> > > > overwriting the list member with NULL (ie. the opposite of the curr=
ent
> > > > solution).   =20
> > >=20
> > > Ick, no, please don't do that.  attribute lists should be able to be =
put
> > > into read-only memory, and are not set up to be dynamically messed wi=
th
> > > like this at all. =20
> >=20
> > I get the idea, makes sense.
> >=20
> > However in my case, the list of attribute groups can lay into RO
> > memory, that's fine, but the attribute group for the cells
> > will not. Indeed, the .bin_attrs list must be populated at run time
> > as we do not know it's size at compilation time. =20
>=20
> Ick.  I thought we had a way to update the size of a sysfs file
> dynamically but I guess not.  So that's ok for now.

To be exact, there is a hook to provide the size of a file at
runtime (and I use it), but here I am referring to the number of files
in the directory. In this case, the number of files depends on the
number of cells, which are discovered dynamically at run time. Hence,
the attribute_group for the cells needs a writable .bin_attrs member.

Thanks,
Miqu=C3=A8l
