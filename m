Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56966C3E46
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCUXGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCUXGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5741751C99;
        Tue, 21 Mar 2023 16:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E89D061E98;
        Tue, 21 Mar 2023 23:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7EDC433EF;
        Tue, 21 Mar 2023 23:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679439995;
        bh=1kuuohdBa2lD620Mx6QQkNA0T6fGHCRq7htdtSaaJZY=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=euxOws8G7812KpdQJQNbsyYQnT4rOtp5wpC0TRKLMjUXDTTslTIZmtEdyTgKI55qz
         46Ws7mL3OBMwfSYOdh+mHHAiBhid1PiYd5LsC22KCYBrRAZI57F/QZiv23yxZcvb/F
         /k6QeVCE+KtE2uCl4FoDvpTHTPtLAaXIcsyLObwwU5zfV20GnPki9nnzx5GMrSr25q
         Rf2IJgFOc9yzbKSD71Y1Itcjvrr61P4Bk1+qvKq/ceuFlVZVJ0dsIGuuHVybtCs10f
         AUXrzeXzEiQHTjhFD2n9GbepaMiF2IDm5AsXI1nQxkEveb6NyxNpoQMs1FZni5e2LG
         D5OL9AhjAoJQg==
Message-ID: <d06781c905adb23089a85a8d54b94461.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0071fdc1-fa53-e096-19c7-ecd1a9d56e86@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com> <20230321201022.1052743-1-noltari@gmail.com> <20230321201022.1052743-5-noltari@gmail.com> <3a1d7b271a42324c056d983e1943b386.sboyd@kernel.org> <0071fdc1-fa53-e096-19c7-ecd1a9d56e86@gmail.com>
Subject: Re: [PATCH v3 4/4] clk: bcm: Add BCM63268 timer clock and reset driver
From:   Stephen Boyd <sboyd@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, jonas.gorski@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        william.zhang@broadcom.com,
        =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez?= Rojas <noltari@gmail.com>
Date:   Tue, 21 Mar 2023 16:06:33 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Florian Fainelli (2023-03-21 16:00:29)
> On 3/21/23 15:57, Stephen Boyd wrote:
> > Quoting =C3=81lvaro Fern=C3=A1ndez Rojas (2023-03-21 13:10:22)
> >> diff --git a/drivers/clk/bcm/clk-bcm63268-timer.c b/drivers/clk/bcm/cl=
k-bcm63268-timer.c
> >> new file mode 100644
> >> index 000000000000..6a1fdd193cb5
> >> --- /dev/null
> >> +++ b/drivers/clk/bcm/clk-bcm63268-timer.c
> >> @@ -0,0 +1,232 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * BCM63268 Timer Clock and Reset Controller Driver
> > [...]
> >> +
> >> +static inline struct bcm63268_tclkrst_hw *
> >> +to_bcm63268_timer_reset(struct reset_controller_dev *rcdev)
> >> +{
> >> +       return container_of(rcdev, struct bcm63268_tclkrst_hw, rcdev);
> >> +}
> >> +
> >> +static int bcm63268_timer_reset_update(struct reset_controller_dev *r=
cdev,
> >> +                               unsigned long id, bool assert)
> >> +{
> >> +       struct bcm63268_tclkrst_hw *reset =3D to_bcm63268_timer_reset(=
rcdev);
> >> +       unsigned long flags;
> >> +       uint32_t val;
> >> +
> >> +       spin_lock_irqsave(&reset->lock, flags);
> >> +       val =3D __raw_readl(reset->regs);
> >=20
> > Use regular ol readl() here, unless you have some need for no barrires
> > or byte swapping.
>=20
> These SoCs are big-endian, require native endian register access and=20
> have no posted writes within their bus logic (UBUS) and require no=20
> barriers, hence the use of __raw_readl() and __raw_writel() is adequate.
>=20

Use ioread32be() then?
