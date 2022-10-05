Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6565F505E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJEHfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJEHfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:35:05 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CD6248DE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 00:35:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8A30BC000E;
        Wed,  5 Oct 2022 07:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664955300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o51MC15nrQ0rN7I4frR2hsdNrjM5T/AKcMbBeqGeDko=;
        b=QX0S6gyDklGJzTclQHwqaNJvxme+8iqKh1ZDLop4A/edupHQ9noGXLrn/hUlidxPcMknKH
        bZ+JILYLs2XUSYhnd9MbHCt7AH2NkKsj3QSnMR6bs5pVT0mKHlKkvORMiK7jnntDwaE2fU
        rmgj38dSHeUD+CXwmNMXY4aj7DkcrCKcGDwS3XjgcMYgjRORY3jPr9Y8Y2E/Bnihv8+h29
        xOq+SK3tAHi0F5nSqoGHD1Tj5RgcPNqyWAKIlUzQYfBhUFwRK34+6XoQn5NkGO4aCAvoYB
        fjmJpmIOAbbtUtn0038U/ncMMLQwHUbT7l5YYtik++LBY8TQSN49og0EM6NV5A==
Date:   Wed, 5 Oct 2022 09:34:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        Tony O'Brien <Tony.OBrien@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: Use correct logic for
 nand-keep-config
Message-ID: <20221005093457.466e02a4@xps-13>
In-Reply-To: <55e5672f-b3e5-4c14-b5e9-01cdde2f4472@alliedtelesis.co.nz>
References: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
        <e234270c-4169-bddb-5c2d-9c6ac48467b6@alliedtelesis.co.nz>
        <20221004120212.6389b96a@xps-13>
        <953cbfc0-1ac0-9bc8-155f-57e1cd37dc70@alliedtelesis.co.nz>
        <55e5672f-b3e5-4c14-b5e9-01cdde2f4472@alliedtelesis.co.nz>
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

Hi Chris,

Chris.Packham@alliedtelesis.co.nz wrote on Tue, 4 Oct 2022 21:21:37
+0000:

> On 5/10/22 08:41, Chris Packham wrote:
> >
> > On 4/10/22 23:02, Miquel Raynal wrote: =20
> >> Hi Chris,
> >>
> >> Chris.Packham@alliedtelesis.co.nz wrote on Tue, 27 Sep 2022 02:54:40
> >> +0000:
> >> =20
> >>> On 27/09/22 15:47, Chris Packham wrote: =20
> >>>> From: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
> >>>>
> >>>> Originally the absence of the marvell,nand-keep-config property caus=
ed
> >>>> the setup_data_interface function to be provided. However when
> >>>> setup_data_interface was moved into nand_controller_ops the logic was
> >>>> unintentionally inverted. Update the logic so that only if the
> >>>> marvell,nand-keep-config property is present the bootloader NAND=20
> >>>> config
> >>>> kept.
> >>>>
> >>>> Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface()=20
> >>>> to nand_controller_ops")
> >>>> Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
> >>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>>> ---
> >>>>
> >>>> Notes:
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I think this is a bug that's been lur=
king for 4 years or so.=20
> >>>> I'm not
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sure that's particularly long in the =
life of an embedded=20
> >>>> device but it
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 does make me wonder if there have bee=
n other bug reports=20
> >>>> about it.
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We not=
iced this because we had a bootloader that used=20
> >>>> maxed out NAND
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timings which made the time it took t=
he kernel to do anything=20
> >>>> on the
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file system longer than we expected. =
=20
> >>> I think there might be a similar logic inversion bug in
> >>> drivers/mtd/nand/raw/denali.c but I lack the ability to test for that
> >>> platform. =20
> >> Agreed, the denali driver has the same issue. Could you please send a
> >> patch? =20
> > Sure although it'll be compile tested only. =20
> Actually looks like it was already fixed in commit d311e0c27b8f ("mtd:=20
> rawnand: denali: get ->setup_data_interface() working again").

Ok, perfect.

Thanks,
Miqu=C3=A8l
