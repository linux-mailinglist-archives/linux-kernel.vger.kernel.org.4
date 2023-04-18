Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185C36E55B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDRAWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDRAWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9B44C11;
        Mon, 17 Apr 2023 17:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A8C9625AD;
        Tue, 18 Apr 2023 00:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE6EC4339B;
        Tue, 18 Apr 2023 00:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681777323;
        bh=6B9H24R54yv+r+KBdloI2WZn+iJMLoHViIQTdOdI35o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JV548fxoNPBFu/4qd9yOffE648bfbnpyWs5PGAt02g2PT1WIQqU0JDmdGDteL7Iup
         dd7Gr8B1bs2TZmQ8mY78mFZqHiWE1cJk0K1j+zbfAtP5wbtvwXXFYY3tbz2GaDKwws
         dBKMLa0jFb2TVLJ6qi6XjosEQGA4pi1wo2W/rq9SIiSsKvOmzHejqNxc1g7W5BD1u1
         9J0lULT9ngVNlOw+OoqQMNggNipqlm67pLocsg1AicCB4v4/xV3EdEbkFvK8DxTdWn
         IJgW+G3Gc/OXGdZBwVw017N7rXO9gPsHNGrzQuDVEAeb8y5d1d5Jgv4Jdq2soZnRUa
         cm+UCH+hIDO2g==
Message-ID: <0fe42faa3b34f82cc2fb73ae61460bf2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230417-bolster-vitality-89d279146497@wendy>
References: <20230417074115.30786-1-hal.feng@starfivetech.com> <20230417074115.30786-2-hal.feng@starfivetech.com> <20230417-buckwheat-wilt-92a4e85a5ca0@wendy> <83c5a35a-c646-cbc7-83f9-c02fcb24e069@starfivetech.com> <20230417-bolster-vitality-89d279146497@wendy>
Subject: Re: [PATCH v1 1/2] clk: starfive: Fix RESET_STARFIVE_JH7110 can't be selected in a specified case
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-mm@kvack.org, Michael Turquette <mturquette@baylibre.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-kernel@vger.kernel.org
To:     Conor Dooley <conor.dooley@microchip.com>,
        Hal Feng <hal.feng@starfivetech.com>
Date:   Mon, 17 Apr 2023 17:22:01 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2023-04-17 03:18:35)
> On Mon, Apr 17, 2023 at 06:06:29PM +0800, Hal Feng wrote:
> > On Mon, 17 Apr 2023 10:54:09 +0100, Conor Dooley wrote:
> > > On Mon, Apr 17, 2023 at 03:41:14PM +0800, Hal Feng wrote:
> > >> When (ARCH_STARFIVE [=3Dn] && COMPILE_TEST [=3Dy] && RESET_CONTROLLE=
R [=3Dn]),
> > >> RESET_STARFIVE_JH7110 can't be selected by CLK_STARFIVE_JH7110_SYS
> > >> and CLK_STARFIVE_JH7110_AON.
> > >>=20
> > >> Considering RESET_STARFIVE_JH7110 is not a necessary option for comp=
ilation
> > >> test, we should select it only if ARCH_STARFIVE=3Dy. Also, delete re=
dundant
> > >> selected options of CLK_STARFIVE_JH7110_AON because these options are
> > >> already selected by the dependency.
> > >>=20
> > >> Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system cloc=
k driver")
> > >> Fixes: b2ab3c94f41f ("clk: starfive: Add StarFive JH7110 always-on c=
lock driver")
> > >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > >> ---
> > >>  drivers/clk/starfive/Kconfig | 5 +----
> > >>  1 file changed, 1 insertion(+), 4 deletions(-)
> > >>=20
> > >> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kco=
nfig
> > >> index 71c1148ee5f6..3fad4adee841 100644
> > >> --- a/drivers/clk/starfive/Kconfig
> > >> +++ b/drivers/clk/starfive/Kconfig
> > >> @@ -26,7 +26,7 @@ config CLK_STARFIVE_JH7110_SYS
> > >>    depends on ARCH_STARFIVE || COMPILE_TEST
> > >>    select AUXILIARY_BUS
> > >>    select CLK_STARFIVE_JH71X0
> > >> -  select RESET_STARFIVE_JH7110
> > >> +  select RESET_STARFIVE_JH7110 if ARCH_STARFIVE
> > >=20
> > > Hmm, I don't really follow the logic above.
> > > Why not just make the if be `if RESET_CONTROLLER` rather than
> > > ARCH_STARFIVE?
> > > I'm probably missing some obvious reason why not.
> >=20
> > Note that RESET_CONTROLLER is selected by ARCH_STARFIVE. Thanks.
>=20
> Aye, just the explicit dependency seems like it'd be less fragile and
> more obvious in the future.

Agreed. Be explicit so we don't have to hunt down select dependencies.
