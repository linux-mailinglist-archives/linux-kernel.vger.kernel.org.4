Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4BB6E1439
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjDMSiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDMSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:38:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE02940E7;
        Thu, 13 Apr 2023 11:38:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46B26640CF;
        Thu, 13 Apr 2023 18:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBE7C433EF;
        Thu, 13 Apr 2023 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681411128;
        bh=dzjuCgvj32gFNE1zyb8VjhG7HjDoQx2QthY/c2I2Lpg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iwJvM8gYpu2NK3VPMKGHwKdDmGZiFn5eJ3XrHZUH00mPtJ5Cum9Rb/YsWI2GCjjxh
         +037VF3OBpkjeEqhoutZ7cvsZSPH1tAVQsOwLf2FkUcI/MoD2BU/BJMdrnn1Egx245
         aWZ1RLbknn9BvgxDVUI5cC7yn+oz8f59i6+/9588tFGnaZpiD7lg8o+KDhPmZs4cB2
         uNj/Mww9nsbepDK6X1rV81xlz+yiBTr4Uso9tGeaAxNTbypavIAArg5Z4VpQqeEUj6
         td2BEgRsAuRxsqzGoNJY9gBCntBELonP42VwdDhR0gVC5wOxkPRwreWM/gkpU/IP24
         tw52FMK+b25Mw==
Message-ID: <d70886f6ee13e70845a72354fe9a2b7d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4ed4d0e6-8da5-7eef-8713-44854b8d4a9b@starfivetech.com>
References: <20230411135558.44282-1-xingyu.wu@starfivetech.com> <20230411135558.44282-8-xingyu.wu@starfivetech.com> <683cbe934d1df9436e003466d2a419ef.sboyd@kernel.org> <463ee23c-f617-bed0-27a8-56c6fb40d092@starfivetech.com> <cd4a11ae65e186799145410969d40421.sboyd@kernel.org> <4ed4d0e6-8da5-7eef-8713-44854b8d4a9b@starfivetech.com>
Subject: Re: [PATCH v4 07/10] clk: starfive: Add StarFive JH7110 Video-Output clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Thu, 13 Apr 2023 11:38:45 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xingyu Wu (2023-04-13 06:31:12)
> On 2023/4/13 12:04, Stephen Boyd wrote:
> > diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/c=
lk/starfive/clk-starfive-jh7110-sys.c
> > index 5ec210644e1d..851b93d0f371 100644
> > --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > @@ -11,6 +11,9 @@
> >  #include <linux/init.h>
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include <soc/starfive/reset-starfive-jh71x0.h>
> > =20
> >  #include <dt-bindings/clock/starfive,jh7110-crg.h>
> > =20
> > @@ -335,26 +338,32 @@ static void jh7110_reset_unregister_adev(void *_a=
dev)
> >       struct auxiliary_device *adev =3D _adev;
> > =20
> >       auxiliary_device_delete(adev);
> > +     auxiliary_device_uninit(adev);
> >  }
> > =20
> >  static void jh7110_reset_adev_release(struct device *dev)
> >  {
> >       struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> > +     struct jh71x0_reset_adev *rdev =3D to_jh71x0_reset_adev(adev);
> > =20
> > -     auxiliary_device_uninit(adev);
> > +     kfree(rdev);
> >  }
> > =20
> >  int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
> >                                    const char *adev_name,
> >                                    u32 adev_id)
> >  {
> > +     struct jh71x0_reset_adev *rdev;
> >       struct auxiliary_device *adev;
> >       int ret;
> > =20
> > -     adev =3D devm_kzalloc(priv->dev, sizeof(*adev), GFP_KERNEL);
> > -     if (!adev)
> > +     rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
>=20
> Can there use 'devm_kzalloc'? Are you not using this because the struct i=
s public and clock driver
> and reset driver both use it. But I think the both clock driver and reset=
 driver are the same
> device and can use 'devm_kzalloc'.

No. The release function for the auxiliary_device is supposed to free
the memory. It shouldn't be tied to the lifetime of anything like the
lifetime of the clk driver being bound.
