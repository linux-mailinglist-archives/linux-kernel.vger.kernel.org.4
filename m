Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0510B6A686D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCAHyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:54:08 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6215E2D153;
        Tue, 28 Feb 2023 23:54:06 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 25CDF1BF209;
        Wed,  1 Mar 2023 07:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677657244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIPfap46sgUfW41E+nfp3rnvHFuK/61fahDXhiCtyh8=;
        b=oYzlF/W6payIOjh2+itOFucKTzMNFPzCaGqb7H0IoZrzV+Vc6u8ZjpqKdX/+YlaLpvx89C
        eUCsWsF9GPquNd2hPU2QmEkAO6zmTGkLFsgJd8d1fyzIdFeztaZSRR6qTlQHNDb3EyKKDx
        mTwwSjs8IHOTD3yIex5plT8AnWxA8EGYy8Y7/dnZ1VWcUalQOFtQxBats2jOktfggN/YXq
        xPp0WeSHVnPpdCZFDV/d/qA54AK59xOGBKkY9Zm+upePBR7xppp9JuzmO9iWiF84SbKMHt
        ezYdYagJNw9WB0rvmk+tuF2UwRlAHvII6mOCST/OBaXrna54WkMz/Rg1NJty1Q==
Date:   Wed, 1 Mar 2023 08:56:40 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Jean Jacques Hiblot <jjhiblot@traphandler.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/irq: add missing of_node_put() for interrupt parent
 node
Message-ID: <20230301085640.52ccc334@fixe.home>
In-Reply-To: <CAL_Jsq+eTmbjkOxutCLjgSSQ34yOVEQQQBtSH3v93heM_BYHRQ@mail.gmail.com>
References: <20230117144929.423089-1-clement.leger@bootlin.com>
        <CAL_Jsq+eTmbjkOxutCLjgSSQ34yOVEQQQBtSH3v93heM_BYHRQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 28 Feb 2023 17:14:18 -0600,
Rob Herring <robh+dt@kernel.org> a =C3=A9crit :

> +Saravana, Jean
>=20
> On Tue, Jan 17, 2023 at 8:47=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <clement.=
leger@bootlin.com> wrote:
> >
> > After calling of_irq_parse_one(), the node provided in the of_phandle_a=
rgs
> > has a refcount increment by one. Add missing of_node_put in of_irq_get()
> > to decrement the refcount once used.
> >
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > ---
> >
> > While debugging a refcount problem with OF_DYNAMIC enabled (which is
> > actually the only case were node refcount are really used), I noticed t=
hat
> > platform_get_irq() was actually incrementing the refcount of an interru=
pt
> > controller node. Digging into that function shows that it calls
> > of_irq_get() which calls of_irq_parse_one() and finally of_irq_parse_ra=
w().
> > Since it seems sane that the node returned in the of_phandle_args has a
> > refcount incremented, I thought it is better to put the of_node_put() in
> > the user even though it was hard to find any user doing so. =20
>=20
> While investigating [1], I stumbled back on this. Was the failing case
> you had using interrupts-extended? It looks to me like that path has a
> get, but the 'interrupts' path does not. If so, this change is wrong.

In my case, it was with a classic "interrupts" property. I can take
another look at the internal code to be sure this fix is correct.

Cl=C3=A9ment

>=20
> Rob
>=20
> [1] https://lore.kernel.org/all/20230228174019.4004581-1-jjhiblot@traphan=
dler.com/
>=20
>=20
> >
> >  drivers/of/irq.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index e9bf5236ed89..174900072c18 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -438,10 +438,16 @@ int of_irq_get(struct device_node *dev, int index)
> >                 return rc;
> >
> >         domain =3D irq_find_host(oirq.np);
> > -       if (!domain)
> > -               return -EPROBE_DEFER;
> > +       if (!domain) {
> > +               rc =3D -EPROBE_DEFER;
> > +               goto out;
> > +       }
> >
> > -       return irq_create_of_mapping(&oirq);
> > +       rc =3D irq_create_of_mapping(&oirq);
> > +out:
> > +       of_node_put(oirq.np);
> > +
> > +       return rc;
> >  }
> >  EXPORT_SYMBOL_GPL(of_irq_get);
> >
> > --
> > 2.39.0
> > =20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
