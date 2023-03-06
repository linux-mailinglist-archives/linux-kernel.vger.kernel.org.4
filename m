Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F026ABDAD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCFLGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCFLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:06:08 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998311ADEE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:06:02 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8821920012;
        Mon,  6 Mar 2023 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678100760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qb2Hdhx8UQsFd5rz53oW2MFWr/yNsB2YoLuzM6NAUc=;
        b=K1u1OcRQwV8LvxFRdcaUP/g/B7X2Lt3wheEs3GfvkdCyh60rK59o2R0fEuox/Vlp5QpI6w
        ixVxsim2gtA/Sh3gaJ+riNqIOLCRAGceNKGZJkV+yE1aGB7NSQJiU1GIFHrLkUGA+iY6Pb
        eHcQmrLvSyKQ51NgA3ej2nRt6N+5xVxiKkS0ieKyUM01Qm/j2MCgH84a1xLCmfFBSLLR6P
        UtZQjV3WrsFX8uODL9kq52mgiK7gkA7cg873WNNRn0aiOPItSs/K7SOyyrv6TyjoGIcsMK
        4VDQn8bBiy45LFugqvhU/VfoZ9La6HbQrM6KdYt3bvvbiN5tQ1Q0vh171dNnLw==
Date:   Mon, 6 Mar 2023 12:05:58 +0100
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
Message-ID: <20230306120558.00f614fb@xps-13>
In-Reply-To: <ZAWuvRHVVV3hTm0e@kroah.com>
References: <20230208160230.2179905-1-gregkh@linuxfoundation.org>
        <f60870dee13900252e0b13fb2f5f05b5@walle.cc>
        <ZAWNtv0g6vmADGnb@kroah.com>
        <20230306093336.523832b0@xps-13>
        <ZAWuvRHVVV3hTm0e@kroah.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

Hi Greg,

gregkh@linuxfoundation.org wrote on Mon, 6 Mar 2023 10:13:33 +0100:

> On Mon, Mar 06, 2023 at 09:33:36AM +0100, Miquel Raynal wrote:
> > Hi Greg,
> >=20
> > gregkh@linuxfoundation.org wrote on Mon, 6 Mar 2023 07:52:38 +0100:
> >  =20
> > > On Wed, Feb 08, 2023 at 05:15:41PM +0100, Michael Walle wrote: =20
> > > > Am 2023-02-08 17:02, schrieb Greg Kroah-Hartman:   =20
> > > > > When calling debugfs_lookup() the result must have dput() called =
on it,
> > > > > otherwise the memory will leak over time.  To solve this, remove =
the
> > > > > lookup and create the directory on the first device found, and th=
en
> > > > > remove it when the module is unloaded.
> > > > >=20
> > > > > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> > > > > Cc: Pratyush Yadav <pratyush@kernel.org>
> > > > > Cc: Michael Walle <michael@walle.cc>
> > > > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > Cc: Richard Weinberger <richard@nod.at>
> > > > > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > > > > Cc: linux-mtd@lists.infradead.org
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>   =
=20
> > > >=20
> > > > Reviewed-by: Michael Walle <michael@walle.cc>
> > > >=20
> > > > one nit below I didn't notice earlier, no need to send a new
> > > > patch version just for that.
> > > >=20
> > > > ..
> > > >    =20
> > > > > +void spi_nor_debugfs_shutdown(void)
> > > > > +{
> > > > > +	if (rootdir)
> > > > > +		debugfs_remove(rootdir);   =20
> > > >=20
> > > > debugfs_remove() already has a check for NULL.
> > > >    =20
> > >=20
> > > Ah, good catch, I merged this in when I applied it to my tree, thanks=
! =20
> >=20
> > Any reasons why you did apply this patch to your tree? It is a spi-nor
> > fix, I would have expected it to go through mtd. =20
>=20
> It's been sitting around for a month, I assumed it was lost, so I picked
> it up.

Sorry if it took too long, the merge window also happened during that
time, we are collecting patches now that 6.3-rc1 has been released.
Next time don't hesitate to ping first ;-)

> I can revert it if you don't want me to take it for 6.3-final
> through my driver core tree.

I'll let spi-nor maintainers decide what they prefer.

Thanks,
Miqu=C3=A8l
