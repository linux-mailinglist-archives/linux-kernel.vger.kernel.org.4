Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A727507FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGLMTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjGLMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:18:59 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A91993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:18:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5268BC0006;
        Wed, 12 Jul 2023 12:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689164335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gq0Z4mZPFZKT0qdEh5lY2e3LmdPHcYoPfLYbx7JiAec=;
        b=SkrR+zXS7/7NqGbNg1HqcSlJh/W2zdMQrzdyeGEUj1/NxQPKxGSuETmK3I0Hide5xFj499
        R2VLinIuNC3fSJyoDtyyNV/7c2tG1hhzKs2izKS6hUZQPI3P60Gd3n8eTHsOA79Iw6nxGW
        14Mnf/doDDKpBt1MCxvf2OWyIlMr/IbFv+EU4MG7XaKeSsQEJBmgg5ic+35AZoFLRXna5N
        C/sOZSfbtFeO1qZ55/49g/RX9EQMQkBYscLPV5s2F0rTt4nTZ/qBDISIxqU8FBEe8sVcLG
        6fBKYjqGkg9x5piyYU0qnqdIbpkSRsKnxeyAE81zHK56Ij36wW98ShXm7L64RA==
Date:   Wed, 12 Jul 2023 14:18:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Yang Rong <yangrong@vivo.com>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: Re: [PATCH v3] mtd: core: Fix resource leak in a
 for_each_child_of_node() loop
Message-ID: <20230712141850.0f30c70c@xps-13>
In-Reply-To: <ffc8f6162a863179f88304ed8801d44f@milecki.pl>
References: <20230711020752.2344-1-yangrong@vivo.com>
        <ffc8f6162a863179f88304ed8801d44f@milecki.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

rafal@milecki.pl wrote on Tue, 11 Jul 2023 18:37:42 +0200:

> On 2023-07-11 04:03, Yang Rong wrote:
> > Ensure child node references are properly decremented in the error path
> >   of this function implementation. =20
>=20
> Nitpicking: it's actually a /success/ code path that misses
> of_node_put().

Please also add:

Cc: stable...

>=20
>=20
> > Fixes: 2df11f00100d ("mtd: core: try to find OF node for every MTD > pa=
rtition")
> > Signed-off-by: Yang Rong <yangrong@vivo.com> =20
>=20
> Acked-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
>=20
> > ---
> > v2: > https://lore.kernel.org/all/20230710061412.2272-1-yangrong@vivo.c=
om/
> > The modifications made copared to the previous version are as follows:
> > 1.Optimized the expression of the Subject, making it more accurate.
> > 2.Optimized the content of the commit message.
> > 3.Add the tag "Fixes".
> >=20
> >  drivers/mtd/mtdcore.c | 1 +
> >  1 file changed, 1 insertion(+)
> >  mode change 100644 =3D> 100755 drivers/mtd/mtdcore.c
> >=20
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index e00b12aa5ec9..b02cb8b1a38d
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -591,6 +591,7 @@ static void mtd_check_of_node(struct mtd_info *mtd)
> >  		if (plen =3D=3D mtd_name_len &&
> >  		    !strncmp(mtd->name, pname + offset, plen)) {
> >  			mtd_set_of_node(mtd, mtd_dn);
> > +			of_node_put(mtd_dn);
> >  			break;
> >  		}
> >  	} =20


Thanks,
Miqu=C3=A8l
