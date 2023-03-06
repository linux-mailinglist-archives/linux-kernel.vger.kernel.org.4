Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B06AC43E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCFPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCFPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:00:31 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE672942E;
        Mon,  6 Mar 2023 07:00:27 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A200B6000F;
        Mon,  6 Mar 2023 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678114826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BefHmWwlwolt2Q8MDY8f9511nlrCyTt0yxbQu9ZrdDk=;
        b=X0NV08vCWUum3lsR8URLWYau3o2JCvuIGIOZ6sy9naH8d4gUxkxV7Cezg/op3d+VylIBBs
        DPLB2PFJcodIShEVjl4s+C97+GvEX4j2tjPxlRlMmgdOX7pCi0YilABtRSrzihb3O9/Xit
        s+tUb3hW8y0v8wM+TvvPmwYaLmrTHKYbHMzgFEpS+I8ZQ7Ol04d+Sf/YXgjxalvhb4fRpM
        bqqo0sE0hvipnHP5J5RUBlXpY4XZuNmqsGgQ5wXuDA6T7whXWag6khtbYPvHw0GV9XFhJe
        lbCsa7WYcewf2jfpKf/Eg/0rZ+o/Ny1u+xIqWoD+vL0weCu/e3rqhmFBrcO28g==
Date:   Mon, 6 Mar 2023 16:00:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
Message-ID: <20230306160023.40171f2e@xps-13>
In-Reply-To: <ZAXw4EHQldOi35gJ@kroah.com>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
        <88b8ed4babd8c2d00ff4a4d8876378ba@milecki.pl>
        <ZAXw4EHQldOi35gJ@kroah.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

gregkh@linuxfoundation.org wrote on Mon, 6 Mar 2023 14:55:44 +0100:

> On Mon, Mar 06, 2023 at 02:54:10PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> > On 2023-03-01 16:22, Miquel Raynal wrote: =20
> > > The base series on which these changes apply is still contained in [1=
],
> > > I would prefer to keep it as it was and apply this series on top of i=
t.
> > >=20
> > > (...)
> > >=20
> > > [1] https://github.com/miquelraynal/linux/tree/nvmem-next/layouts =20
> >=20
> > My experience with kernel development over all subsystems I touched is
> > that patches should be improved until being clean & acceptable. I never
> > sent a series with more recent patches fixing issues in earlier patches
> > of the same seriee.
> >=20
> > So my preference would be to get a new, clean & complete set of patches=
. =20
>=20
> I agree, don't break something and then fix it up in a later patch, that
> makes bisection impossible.

Apart from two rather small fixes which I can squash if that's what you
are requesting, most of the series is already fine on its own, fully
working and bisectable. On top of that initial series from Michael I am
adding support for compiling additional code as modules, which is
arguably another feature. I don't see the point in merging them both
besides mixing two different works. Looking at the code shows that every
step is pretty clean, there is nothing going back and forth.

I will anyway try to make it look like a single series with the changes
requested by Rob in v2.

Thanks,
Miqu=C3=A8l
