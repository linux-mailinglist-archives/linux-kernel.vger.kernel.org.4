Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5185269C953
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjBTLNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBTLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:13:09 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265A0AD09;
        Mon, 20 Feb 2023 03:13:07 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5AED7FF808;
        Mon, 20 Feb 2023 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676891586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBNhxTT0X44tQOAptGeGNkb0fKbycyMGhTxjQUIviTw=;
        b=EKNJ3yyIlDeRNCSzP49IeP4CvxVi+8kybmIW0GmMNtL8azxxSOQNhyVpTCiz0SVeBefycQ
        UJ0I/emTfe9jHlHIQqnmas3nY/eejYoLlhO8BhVyJTDVdpRkl1C9aR91aMSLgXklTLjVTU
        0mUDlzxWs8hV79v1j3dWsIFH+VCNWF3jAo2wS7Q5zJ6ha8814mprMBKx0bRqXXz/3roNYM
        W2AX7FKbd3ISNx1zG6WbQDr8BjL/W2uLt7tFv/nHU0UU8rnrV7fdFgbfYx8bfGt4CTZIjO
        UX/wmqnRTDq2fvpn7w9SbS/fbvKGOefnk1XrgcijjnUSEnjIVvgxnapeclI6wA==
Date:   Mon, 20 Feb 2023 12:15:38 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] of: create of_root if no dtb provided
Message-ID: <20230220121538.36abab68@fixe.home>
In-Reply-To: <defd6445-a6e3-8d81-c9e7-f1dd343e7875@gmail.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
        <20220624034327.2542112-2-frowand.list@gmail.com>
        <20220624141320.3c473605@fixe.home>
        <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
        <20221011092654.6c7d7ec3@fixe.home>
        <20230109094009.3878c30e@fixe.home>
        <907b6b75-55bc-b38c-442b-4ccb036a3690@gmail.com>
        <20230110091206.72c3df24@fixe.home>
        <defd6445-a6e3-8d81-c9e7-f1dd343e7875@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

Le Tue, 24 Jan 2023 08:34:53 -0600,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> On 1/10/23 02:12, Cl=C3=A9ment L=C3=A9ger wrote:
> > Le Tue, 10 Jan 2023 00:27:16 -0600,
> > Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
> >  =20
> >> On 1/9/23 02:40, Cl=C3=A9ment L=C3=A9ger wrote: =20
> >>> Le Tue, 11 Oct 2022 09:26:54 +0200,
> >>> Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com> a =C3=A9crit :
> >>>    =20
> >>>> Le Fri, 24 Jun 2022 11:44:07 -0500,
> >>>> Frank Rowand <frowand.list@gmail.com> a =C3=A9crit : =20
>=20
> < snip >
>=20
> >>>> Any news on this series ?
> >>>>   =20
> >>>
> >>> Hi Frank,
> >>>
> >>> Do you plan on resubmitting this series ? If not, could I resubmit it
> >>> after fixing problems that were raised in the review ?   =20
> >>>> Thanks,   =20
> >>>    =20
> >>
> >> Thanks for the prod.  I'll re-spin it. =20
> >=20
> > Ok great, thanks Frank. =20
>=20
> My apologies, I haven't done this yet and I'm going on vacation for a wee=
k or so.
> I'll get back to this.

Hi Frank, any news on this ? I'm asking again, but if you do not have
time for this, do you mind if I re-spin your series ? This item is
important for us.

Thanks,

Cl=C3=A9ment

>=20
> This is one of the three items at the top of my devicetree todo list (alo=
ng with
> Lizhi Hou's "Generate device tree node for pci devices" patch series).
>=20
> -Frank
>=20
> >>
> >> If I properly captured all the comments, I'll have to implement
> >> Rob's suggestion:
> >>
> >>   "either CONFIG_OF_FLATTREE or CONFIG_OF_EARLY_FLATTREE will need=20
> >>   to become user selectable." =20
> >  =20
> >>
> >> -Frank =20
> >=20
> >=20
> >  =20
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
