Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88E070D0B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjEWBym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjEWByj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD41CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 166B86226C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C548C433D2;
        Tue, 23 May 2023 01:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684806877;
        bh=o2ebCMeC0Gg/ghiaUxjGr45XpfzvcXPIaHpwpcgIJfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lPbDVLevbzTScK5ZPAqhHvPw/7A0H3fmSJL/niJYQgy+Fb63BDQbBtpHumQDTeWvi
         cqoAbvXaGVSR20Kk8iAYHYT1Vt3bIEMHSWTZaX46VDezfz6X/8KjObGuU1xwC0xazD
         uDSkNsyl5Xf3qyBzbjPOeObg7tmsHUezd4DVXBgkZFkOYiaQY6Zo+WPBUSAhPRKk+d
         JK+Yl07hQA3Bwh3BkG5stLSKENFGK1i32uokDksxExsex1/4yascF0E2GiJXD0v3jC
         gNERi78lPoKqCp331mZkHW6Y8vraLfj6VW9Gct69VvfvodyB6U61elq8jyQu4nXJ1Z
         NbUZpSEZMFe/g==
Date:   Mon, 22 May 2023 18:54:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        arinc9.unal@gmail.com, Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 00/30] net: dsa: mt7530: improve, trap BPDU &
 LLDP, and prefer CPU port
Message-ID: <20230522185435.3b2a8d07@kernel.org>
In-Reply-To: <ZGuwy/0FGh0c4wXk@shell.armlinux.org.uk>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
        <20230522140917.er7f5ws24b2eeyvs@soft-dev3-1>
        <ZGuwy/0FGh0c4wXk@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 19:13:31 +0100 Russell King (Oracle) wrote:
> > I have noticed that in many patches of the series you have:
> > Tested-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >=20
> > Where you also have:
> > Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >=20
> > I think you can drop Tested-by as the SoB will imply that. I think you
> > got a similar comment some time ago to a different patch series. =20
>=20
> Signed-off-by in no way implies a tested-by. Signed-off-by has a very
> distinct definition that is in submitting-patches.rst.
>=20
> Clearly, if one is working on infrastructure where there are numerous
> drivers involved, one probably doesn't have all the hardware, and one
> may have to send patches that have only been build tested, but never
> tested against real hardware.
>=20
> While we may attempt to elicit testing, most of the time this seems
> to be a waste of time and effort - or at least that's my experience.
> Even if you Cc people who have recently been active with hardware,
> that is no guarantee that there will be any reaction.
>=20
> That has got to the point now where I just don't bother trying to
> elicit help from others to test driver changes. If people want to
> test, they need to do so when they see a patch on the mailing list,
> preferably before it gets applied. If not, and if it breaks something,
> then we'll have to generate a patch to fix the breakage.
>=20
> So no, please stop thinking that SoB implies that the patch has been
> tested.

Dunno, I had the same reaction as Horatiu. Adding "Compile tested only"
in the commit messages of patches which author wasn't able to test seems
more natural than assuming that nothing is tested by default.

It's not a hard requirement, e.g. seems fairly common sense that cross-
-driver work comes with limited testing coverage. But for someone
working on a single driver, assuming not tested by default, again,=20
to me - feels odd.
