Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E146C3DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCUW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUW5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC46558C0D;
        Tue, 21 Mar 2023 15:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864A961ECB;
        Tue, 21 Mar 2023 22:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6823C433EF;
        Tue, 21 Mar 2023 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679439456;
        bh=NKhQb3E1vtSLgRSfK0SvtCpf6hWM8Pf1MdVe9cJDZ6Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=i9E0HRSbmCklr2PR7XiTJ2xXliHlxq1XEvl80QmNF3fTq4vuA6NHpopDWzFtDbdAQ
         C+qFh6sNS7d9pU/1cuV3D0KhF0D6/EClP3AEWp4w1CvzKnNxuY+Z4n5LPObg4utIZx
         ZLy0/nORBtXNXkRXR+Eo5ITOL8wr8fD5mMvFB+NfxPdcTaYXWsjqWQ9k8TS2GpSAZW
         UQV7Ok/RNfPpZlai2T/bj4qNw+9GfjlBDWcnU3hIim8D5yyhTz/cZwEHkkIdEg7B7s
         3d32m4qnBA8iJ0s52IVO4TKZJ6oJ/KBKCRauieDOSfdv3WFR5qh9npTyAV1Yse9UcT
         xu7jshOYS1meA==
Message-ID: <3a1d7b271a42324c056d983e1943b386.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321201022.1052743-5-noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com> <20230321201022.1052743-1-noltari@gmail.com> <20230321201022.1052743-5-noltari@gmail.com>
Subject: Re: [PATCH v3 4/4] clk: bcm: Add BCM63268 timer clock and reset driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez?= Rojas <noltari@gmail.com>
To:     devicetree@vger.kernel.org, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, william.zhang@broadcom.com,
        =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez?= Rojas <noltari@gmail.com>
Date:   Tue, 21 Mar 2023 15:57:34 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting =C3=81lvaro Fern=C3=A1ndez Rojas (2023-03-21 13:10:22)
> diff --git a/drivers/clk/bcm/clk-bcm63268-timer.c b/drivers/clk/bcm/clk-b=
cm63268-timer.c
> new file mode 100644
> index 000000000000..6a1fdd193cb5
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-bcm63268-timer.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BCM63268 Timer Clock and Reset Controller Driver
[...]
> +
> +static inline struct bcm63268_tclkrst_hw *
> +to_bcm63268_timer_reset(struct reset_controller_dev *rcdev)
> +{
> +       return container_of(rcdev, struct bcm63268_tclkrst_hw, rcdev);
> +}
> +
> +static int bcm63268_timer_reset_update(struct reset_controller_dev *rcde=
v,
> +                               unsigned long id, bool assert)
> +{
> +       struct bcm63268_tclkrst_hw *reset =3D to_bcm63268_timer_reset(rcd=
ev);
> +       unsigned long flags;
> +       uint32_t val;
> +
> +       spin_lock_irqsave(&reset->lock, flags);
> +       val =3D __raw_readl(reset->regs);

Use regular ol readl() here, unless you have some need for no barrires
or byte swapping.

> +       if (assert)
> +               val &=3D ~BIT(id);
> +       else
> +               val |=3D BIT(id);
> +       __raw_writel(val, reset->regs);

Same.

> +       spin_unlock_irqrestore(&reset->lock, flags);
> +
> +       return 0;
> +}
> +
[...]
> +
> +static int bcm63268_tclk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       const struct bcm63268_tclk_table_entry *entry, *table;
> +       struct bcm63268_tclkrst_hw *hw;
> +       struct clk_hw *clk;
> +       u8 maxbit =3D 0;
> +       int i, ret;
> +
> +       table =3D of_device_get_match_data(dev);

Use device_get_match_data() instead.

> +       if (!table)
> +               return -EINVAL;
> +
> +       for (entry =3D table; entry->name; entry++)
> +               maxbit =3D max(maxbit, entry->bit);
> +       maxbit++;
> +
> +       hw =3D devm_kzalloc(&pdev->dev, struct_size(hw, data.hws, maxbit),
> +                         GFP_KERNEL);
> +       if (!hw)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, hw);
> +
> +       spin_lock_init(&hw->lock);
> +
> +       hw->data.num =3D maxbit;
> +       for (i =3D 0; i < maxbit; i++)
> +               hw->data.hws[i] =3D ERR_PTR(-ENODEV);
> +
> +       hw->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(hw->regs))
> +               return PTR_ERR(hw->regs);
> +
> +       for (entry =3D table; entry->name; entry++) {
> +               clk =3D clk_hw_register_gate(dev, entry->name, NULL, 0,

Use devm?

> +                                          hw->regs, entry->bit,
> +                                          CLK_GATE_BIG_ENDIAN, &hw->lock=
);
> +               if (IS_ERR(clk)) {
> +                       ret =3D PTR_ERR(clk);
> +                       goto out_err;
> +               }
> +
> +               hw->data.hws[entry->bit] =3D clk;
> +       }
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                         &hw->data);
> +       if (ret)
> +               return ret;
> +
> +       hw->rcdev.of_node =3D dev->of_node;
> +       hw->rcdev.ops =3D &bcm63268_timer_reset_ops;
> +
> +       ret =3D devm_reset_controller_register(dev, &hw->rcdev);
> +       if (ret)
> +               dev_err(dev, "Failed to register reset controller\n");
> +
> +       return 0;
> +
> +out_err:
> +       for (i =3D 0; i < hw->data.num; i++) {
> +               if (!IS_ERR(hw->data.hws[i]))
> +                       clk_hw_unregister_gate(hw->data.hws[i]);

And then drop this?

> +       }
> +
> +       return ret;
> +}
> +
> +static const struct of_device_id bcm63268_tclk_dt_ids[] =3D {
> +       {
> +               .compatible =3D "brcm,bcm63268-timer-clocks",
> +               .data =3D &bcm63268_timer_clocks,

Are you planning on adding more SoCs to this driver? The data can
currently be always assumed to be bcm63268_timer_clocks

> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
