Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C9A6AB869
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCFIdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCFIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:33:49 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDCAC7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:33:40 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AC4D31BF209;
        Mon,  6 Mar 2023 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678091619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcWfKaoaYJF0v6V/CLIllu4Udjau4ayfUZPBb67ggZU=;
        b=Lvs54cfBpYPuz2wbthklML07GL5D9Rqry14yl9XXygvd0sBnugBtwcwOLZl9FfKvnr6J0W
        rUiRj94xk/SILi48COHasuJLBB8KexQLwz0ZjkkixvfbTbD/ojEtkSgaUKt5wycuynSsnU
        CuOLaouV/i/sb5zCTQ1ZwSrTzqveB6/U4f1gD/TEmiX7xTztF7WzoPwTP+kcRM8LEnTRBr
        EJhEXOwoRcDpHdzmEPp0mewQnR6VbM1MXlhEtgWXik1Oq/HG1sMpbYnEGoNqCff3AfDAc9
        DhkyuNAbCrXiIfK0FVhR7sjFRq0jD+ZUqTCwnbELoCeysJAdyV8Wp53bGJdVCw==
Date:   Mon, 6 Mar 2023 09:33:36 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
Message-ID: <20230306093336.523832b0@xps-13>
In-Reply-To: <ZAWNtv0g6vmADGnb@kroah.com>
References: <20230208160230.2179905-1-gregkh@linuxfoundation.org>
        <f60870dee13900252e0b13fb2f5f05b5@walle.cc>
        <ZAWNtv0g6vmADGnb@kroah.com>
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

Hi Greg,

gregkh@linuxfoundation.org wrote on Mon, 6 Mar 2023 07:52:38 +0100:

> On Wed, Feb 08, 2023 at 05:15:41PM +0100, Michael Walle wrote:
> > Am 2023-02-08 17:02, schrieb Greg Kroah-Hartman: =20
> > > When calling debugfs_lookup() the result must have dput() called on i=
t,
> > > otherwise the memory will leak over time.  To solve this, remove the
> > > lookup and create the directory on the first device found, and then
> > > remove it when the module is unloaded.
> > >=20
> > > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> > > Cc: Pratyush Yadav <pratyush@kernel.org>
> > > Cc: Michael Walle <michael@walle.cc>
> > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Cc: Richard Weinberger <richard@nod.at>
> > > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > > Cc: linux-mtd@lists.infradead.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> =20
> >=20
> > Reviewed-by: Michael Walle <michael@walle.cc>
> >=20
> > one nit below I didn't notice earlier, no need to send a new
> > patch version just for that.
> >=20
> > ..
> >  =20
> > > +void spi_nor_debugfs_shutdown(void)
> > > +{
> > > +	if (rootdir)
> > > +		debugfs_remove(rootdir); =20
> >=20
> > debugfs_remove() already has a check for NULL.
> >  =20
>=20
> Ah, good catch, I merged this in when I applied it to my tree, thanks!

Any reasons why you did apply this patch to your tree? It is a spi-nor
fix, I would have expected it to go through mtd.

Thanks,
Miqu=C3=A8l
