Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B366104BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiJ0VvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiJ0VvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA15AA2F;
        Thu, 27 Oct 2022 14:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A7BF6252A;
        Thu, 27 Oct 2022 21:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CB4C433D6;
        Thu, 27 Oct 2022 21:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907465;
        bh=dfc6sN7IKtvTc96eRcZ3+e6dIvqIeD4PYPkGlwcyomI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NVQpBTITd8G5pJ+mHEuyxMzTb9gviM1z+irHM16asXHfHb10kG+eyAniGeVpOcdvj
         2gam5ROgnJAkj6vlmFm8VxR5ByOmZYWVd8edc6JOjNZ6NY4ZxbEMK6/t8oi/SGWCMa
         37JfbNT2eyR2imMx1T2zkOByFcqkI8HaqtQTyF+3IcCcjhlz/004r3Pp9LXOP8q5Tj
         Hh3A0zeYQvWLnVQZUzHTzKZv2Q/kZr5EwGxGfUHR1NEY+QLDL/65xX0K6Eq4GwkUVS
         mxIlpSp8YTdqkveVXafCnKC/BiwLrMmOg+MeyiP2J4E/BF+wod5f2yVKo+++pFLGif
         xco7S2HFgbvFw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <sWPMeZZ7NP5UXWBsE8t41AGkBkpYIgpG@localhost>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com> <20221026194345.243007-2-aidanmacdonald.0x0@gmail.com> <0GWEKR.T961XCYIYOL52@crapouillou.net> <sWPMeZZ7NP5UXWBsE8t41AGkBkpYIgpG@localhost>
Subject: Re: [PATCH v2 1/6] clk: ingenic: Make PLL clock "od" field optional
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Date:   Thu, 27 Oct 2022 14:51:02 -0700
User-Agent: alot/0.10
Message-Id: <20221027215104.E8CB4C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-10-27 14:40:02)
>=20
> Paul Cercueil <paul@crapouillou.net> writes:
>=20
> > Hi Aidan,
> >
> > Le mer. 26 oct. 2022 =C3=A0 20:43:40 +0100, Aidan MacDonald
> > <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
> >> Add support for defining PLL clocks with od_bits =3D 0, meaning that
> >> OD is fixed to 1 and there is no OD field in the register. In this
> >> case od_max must also be 0, which is enforced with BUG_ON().
> >> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> >> ---
> >> v1 -> v2: Simplify od lookup in ingenic_pll_recalc_rate() and
> >>           enforce od_max =3D=3D 0 when od_bits is zero.
> >>  drivers/clk/ingenic/cgu.c | 21 +++++++++++++++------
> >>  drivers/clk/ingenic/cgu.h |  3 ++-
> >>  2 files changed, 17 insertions(+), 7 deletions(-)
> >> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> >> index 861c50d6cb24..3481129114b1 100644
> >> --- a/drivers/clk/ingenic/cgu.c
> >> +++ b/drivers/clk/ingenic/cgu.c
> >> @@ -83,7 +83,7 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned =
long
> >> parent_rate)
> >>      const struct ingenic_cgu_clk_info *clk_info =3D to_clk_info(ingen=
ic_clk);
> >>      struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> >>      const struct ingenic_cgu_pll_info *pll_info;
> >> -    unsigned m, n, od_enc, od;
> >> +    unsigned m, n, od, od_enc =3D 0;
> >>      bool bypass;
> >>      u32 ctl;
> >> @@ -96,8 +96,11 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned=
 long
> >> parent_rate)
> >>      m +=3D pll_info->m_offset;
> >>      n =3D (ctl >> pll_info->n_shift) & GENMASK(pll_info->n_bits - 1, =
0);
> >>      n +=3D pll_info->n_offset;
> >> -    od_enc =3D ctl >> pll_info->od_shift;
> >> -    od_enc &=3D GENMASK(pll_info->od_bits - 1, 0);
> >> +
> >> +    if (pll_info->od_bits > 0) {
> >> +            od_enc =3D ctl >> pll_info->od_shift;
> >> +            od_enc &=3D GENMASK(pll_info->od_bits - 1, 0);
> >> +    }
> >>      if (pll_info->bypass_bit >=3D 0) {
> >>              ctl =3D readl(cgu->base + pll_info->bypass_reg);
> >> @@ -112,7 +115,11 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsign=
ed long
> >> parent_rate)
> >>              if (pll_info->od_encoding[od] =3D=3D od_enc)
> >>                      break;
> >>      }
> >
> > I'd add a space there.
> >
> > With that:
> > Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> >
>=20
> Already done; the space is there in my outbox and on lore.kernel.org.
> I think you might've accidentally removed it. Stephen's already
> applied the series anyway, so...
>=20

I fixed the whitespace.
