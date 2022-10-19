Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5065E604979
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiJSOki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJSOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:40:12 -0400
X-Greylist: delayed 1352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 07:25:22 PDT
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3229614BB45;
        Wed, 19 Oct 2022 07:24:59 -0700 (PDT)
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 565FACF123;
        Wed, 19 Oct 2022 13:50:33 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3F97BFF802;
        Wed, 19 Oct 2022 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666187350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uo5vUbCyibE+xZVdyWGVX9rsXGhib6+cN7eZspzdP3o=;
        b=EpLip1lAQ1rmIPiB/LyTK2KSXCl5b6GpPyNqoQadisnvx4talzvG+ejYnWE91SAr1Hyq3A
        E8OFTkQkoTDS0v/yX7vxjZTOZk0mNCttm1W+vTsq/37VLeQ83k/LuXIkoZAsOGbuhAMlCN
        ordhNiNtEiKGBRMiwu2ylN4Cs5bQxwIUmdfDkimdIKoQita7PcivuH5wtixAsZ7ylrYoN+
        8JntszdROv0+w7DL2GxR4a/wM7RGOxlRccececIUmlVa+eU/WWg+b5HjXYh3v+X3YOGQE3
        kSraTbjzaSqwc6l7xgk5ZN13HOLLFiNUx6FTVr29PY/w+2EABMxsZHYoBLFaCA==
Date:   Wed, 19 Oct 2022 15:49:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mtd tree with the mtd-fixes
 tree
Message-ID: <20221019154907.33bbcb52@xps-13>
In-Reply-To: <20221019180807.6dac24a0@canb.auug.org.au>
References: <20221019092812.7d370b06@canb.auug.org.au>
        <23d311953ef13608be2283a05b2e853d@milecki.pl>
        <20221019180807.6dac24a0@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sfr@canb.auug.org.au wrote on Wed, 19 Oct 2022 18:08:07 +1100:

> Hi Rafa=C5=82,
>=20
> On Wed, 19 Oct 2022 07:31:57 +0200 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki=
.pl> wrote:
> >
> > this isn't exactly the correct fix, of_node_get() is still needed.
> >=20
> > I'll make sure we let Linus know about this conflict (and solution) when
> > sending 6.2 pull request.
> >=20
> >=20
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index 07249af4f890..20fcedc3021e 100644
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -559,7 +559,7 @@ static void mtd_check_of_node(struct mtd_info *mtd)
> >   	if (!mtd_is_partition(mtd))
> >   		return;
> >=20
> > -	parent_dn =3D mtd_get_of_node(mtd->parent);
> > +	parent_dn =3D of_node_get(mtd_get_of_node(mtd->parent));
> >   	if (!parent_dn)
> >   		return;
> >  =20
>=20
>=20
> Thanks for checking.  I have added that to my resolution for tomorrow
> onward.

Thanks Rafa=C5=82 for the right resolution and Stephen for carrying the fix.
I'll send the fixes PR soon and rebase on top of an -rc containing it
to avoid this conflict resolution to be needed when sending the final
PR to Linus during the next MW.

Thanks,
Miqu=C3=A8l
