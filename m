Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021546820CD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAaAgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjAaAgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:36:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E96522A28;
        Mon, 30 Jan 2023 16:36:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 192BCB818BF;
        Tue, 31 Jan 2023 00:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66E7C433D2;
        Tue, 31 Jan 2023 00:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675125361;
        bh=winm19U7j/1SrLM33+LHutRtt1r14B9o9myRfOllwWM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aCyjcqCjxnVQ8w/xZDqPFiYemSX/BMOgjjM6FSRSGqmfPlinxqB+XMZrM/g8W9qTB
         uOMQSbrtIA17dxunmnIzx/zeAoU4Im/xJ83cPHApTqD4GFzrk4tw2c5Vb+S0kpYxcp
         f7iqLDA2tGdCnhoAwps0Ay+hPA5OBilaT3H6X+g7RkP41BgR4VHJGyWoKY51ZFiIzt
         ixHhw6iUHd5RQJuzL6L40TcvllTvA/C/dPI4IjrATKirCaGBs/oQqHIjW3gYnWMMmT
         HDZe81mmyl8ItKfe1CNdqNpFM7uqU+Ziv8+y+PomXb2Bm5VcQjkYJjfJgMlms3fYI7
         W8JNFDLqBZUmw==
Message-ID: <f6f558a0daafa454c02fe29cd904cfcd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0e77bf23-b359-9884-6a8c-368e31d718a4@starfivetech.com>
References: <20230120024445.244345-1-xingyu.wu@starfivetech.com> <20230120024445.244345-4-xingyu.wu@starfivetech.com> <5bb5263d26b157548d7ba39f80989c69.sboyd@kernel.org> <0e77bf23-b359-9884-6a8c-368e31d718a4@starfivetech.com>
Subject: Re: [PATCH v1 03/11] clk: starfive: Add StarFive JH7110 System-Top-Group clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Mon, 30 Jan 2023 16:35:59 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xingyu Wu (2023-01-30 00:02:28)
> On 2023/1/26 10:33, Stephen Boyd wrote:
> > Quoting Xingyu Wu (2023-01-19 18:44:37)
> >> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-stg.c b/drivers/=
clk/starfive/clk-starfive-jh7110-stg.c
> >> new file mode 100644
> >> index 000000000000..c2740f44e796
> >> --- /dev/null
> >> +++ b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
[...]
> >> +                               parents[i].fw_name =3D "nocstg_bus";
> >> +                       else if (pidx =3D=3D JH7110_STGCLK_APB_BUS)
> >> +                               parents[i].fw_name =3D "apb_bus";
> >=20
> > Can this be an array lookup instead of a pile of conditions?
> >=20
> >       if (pidx < JH7110_STGCLK_END)
> >               ...
> >       else
> >               parents[i].fw_name =3D fw_table[pidx - JH7110_STGCLK_END];
> >=20
> > Or even better, don't use strings at all and just make the 'pidx' number
> > (possibly minus the end constant) be the 'clocks' property index that
> > you want.
>=20
> It seen to be a good way that there uses an array.
> Based on the another way, can I use the 'pidx' number to get the 'clock-n=
ames' property
> to be the parent clock name?

The binding is your design. It is incorrect if the binding is referencing c=
locks
provided by the same node though. If that's the case, simply use the hw
pointer directly.

>=20
> >=20
> >> +               }
> >> +
> >> +               clk->hw.init =3D &init;
> >> +               clk->idx =3D idx;
> >> +               clk->max_div =3D max & JH71X0_CLK_DIV_MASK;
> >> +
> >> +               ret =3D devm_clk_hw_register(&pdev->dev, &clk->hw);
> >> +               if (ret)
> >> +                       return ret;
> >> +       }
> >> +
> >> +       ret =3D devm_of_clk_add_hw_provider(&pdev->dev, jh7110_stgclk_=
get, priv);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       return jh7110_reset_controller_register(priv, "reset-stg", 2);
> >=20
> > Is this also devm-ified?
>=20
> No, it need to be freed actively. I will advise Hal Feng this.
>=20

Oh, that's not good.
