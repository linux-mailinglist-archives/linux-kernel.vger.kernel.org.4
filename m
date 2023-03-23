Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB826C6A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCWN77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCWN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:59:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBAEF1F924;
        Thu, 23 Mar 2023 06:59:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD7064B3;
        Thu, 23 Mar 2023 06:59:53 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428E23F6C4;
        Thu, 23 Mar 2023 06:59:07 -0700 (PDT)
Date:   Thu, 23 Mar 2023 13:59:04 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] mfd: axp20x: Add support for AXP313a PMIC
Message-ID: <20230323135904.05174c13@donnerap.cambridge.arm.com>
In-Reply-To: <CAGb2v6607ErP=Jr_-LC_iE2yVLgW0PF+8mpv=AQNSsVreZ42iA@mail.gmail.com>
References: <20230120184500.1899814-1-martin.botka@somainline.org>
        <20230120184500.1899814-3-martin.botka@somainline.org>
        <CAGb2v6607ErP=Jr_-LC_iE2yVLgW0PF+8mpv=AQNSsVreZ42iA@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2023 01:40:34 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

Hi Chen-Yu,

thanks for the review!

> On Sat, Jan 21, 2023 at 2:45 AM Martin Botka
> <martin.botka@somainline.org> wrote:
> >
> > The AXP313a is a PMIC chip produced by X-Powers, it can be connected via
> > an I2C bus.
> > The name AXP1530 seems to appear as well, and this is what is used in
> > the BSP driver. From all we know it's the same chip, just a different
> > name. However we have only seen AXP313a chips in the wild, so go with
> > this name.
> >
> > Compared to the other AXP PMICs it's a rather simple affair: just three
> > DCDC converters, three LDOs, and no battery charging support.
> >
> > Describe the regmap and the MFD bits, along with the registers exposed
> > via I2C. Eventually advertise the device using the new compatible
> > string.
> >
> > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/mfd/axp20x-i2c.c   |  2 ++
> >  drivers/mfd/axp20x.c       | 61 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/axp20x.h | 32 ++++++++++++++++++++
> >  3 files changed, 95 insertions(+)
> >
> > diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> > index f49fbd307958..f061177cb18e 100644
> > --- a/drivers/mfd/axp20x-i2c.c
> > +++ b/drivers/mfd/axp20x-i2c.c
> > @@ -63,6 +63,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
> >         { .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
> >         { .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
> >         { .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
> > +       { .compatible = "x-powers,axp313a", .data = (void *)AXP313A_ID},
> >         { .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
> >         { .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
> >         { },
> > @@ -76,6 +77,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
> >         { "axp209", 0 },
> >         { "axp221", 0 },
> >         { "axp223", 0 },
> > +       { "axp313a", 0 },
> >         { "axp803", 0 },
> >         { "axp806", 0 },
> >         { },
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index 01a6bbb6d266..ff15775f3c27 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -39,6 +39,7 @@ static const char * const axp20x_model_names[] = {
> >         "AXP221",
> >         "AXP223",
> >         "AXP288",
> > +       "AXP313a",
> >         "AXP803",
> >         "AXP806",
> >         "AXP809",
> > @@ -154,6 +155,24 @@ static const struct regmap_range axp806_writeable_ranges[] = {
> >         regmap_reg_range(AXP806_REG_ADDR_EXT, AXP806_REG_ADDR_EXT),
> >  };
> >
> > +static const struct regmap_range axp313a_writeable_ranges[] = {
> > +       regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),
> > +};
> > +
> > +static const struct regmap_range axp313a_volatile_ranges[] = {
> > +       regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),  
> 
> Why set the whole range as volatile? Why bother with a cache then?

Fixed.

> 
> > +};
> > +
> > +static const struct regmap_access_table axp313a_writeable_table = {
> > +       .yes_ranges = axp313a_writeable_ranges,
> > +       .n_yes_ranges = ARRAY_SIZE(axp313a_writeable_ranges),
> > +};
> > +
> > +static const struct regmap_access_table axp313a_volatile_table = {
> > +       .yes_ranges = axp313a_volatile_ranges,
> > +       .n_yes_ranges = ARRAY_SIZE(axp313a_volatile_ranges),
> > +};
> > +
> >  static const struct regmap_range axp806_volatile_ranges[] = {
> >         regmap_reg_range(AXP20X_IRQ1_STATE, AXP20X_IRQ2_STATE),
> >  };
> > @@ -272,6 +291,15 @@ static const struct regmap_config axp288_regmap_config = {
> >         .cache_type     = REGCACHE_RBTREE,
> >  };
> >
> > +static const struct regmap_config axp313a_regmap_config = {
> > +       .reg_bits = 8,
> > +       .val_bits = 8,
> > +       .wr_table = &axp313a_writeable_table,
> > +       .volatile_table = &axp313a_volatile_table,
> > +       .max_register = AXP313A_IRQ_STATE,
> > +       .cache_type = REGCACHE_RBTREE,
> > +};
> > +
> >  static const struct regmap_config axp806_regmap_config = {
> >         .reg_bits       = 8,
> >         .val_bits       = 8,
> > @@ -415,6 +443,16 @@ static const struct regmap_irq axp288_regmap_irqs[] = {
> >         INIT_REGMAP_IRQ(AXP288, BC_USB_CHNG,            5, 1),
> >  };
> >
> > +static const struct regmap_irq axp313a_regmap_irqs[] = {
> > +       INIT_REGMAP_IRQ(AXP313A, PEK_RIS_EDGE,          0, 7),
> > +       INIT_REGMAP_IRQ(AXP313A, PEK_FAL_EDGE,          0, 6),
> > +       INIT_REGMAP_IRQ(AXP313A, PEK_SHORT,             0, 5),
> > +       INIT_REGMAP_IRQ(AXP313A, PEK_LONG,              0, 4),
> > +       INIT_REGMAP_IRQ(AXP313A, DCDC3_V_LOW,           0, 3),
> > +       INIT_REGMAP_IRQ(AXP313A, DCDC2_V_LOW,           0, 2),
> > +       INIT_REGMAP_IRQ(AXP313A, DIE_TEMP_HIGH,         0, 0),
> > +};
> > +
> >  static const struct regmap_irq axp803_regmap_irqs[] = {
> >         INIT_REGMAP_IRQ(AXP803, ACIN_OVER_V,            0, 7),
> >         INIT_REGMAP_IRQ(AXP803, ACIN_PLUGIN,            0, 6),
> > @@ -548,6 +586,17 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
> >
> >  };
> >
> > +static const struct regmap_irq_chip axp313a_regmap_irq_chip = {
> > +       .name                   = "axp313a_irq_chip",
> > +       .status_base            = AXP313A_IRQ_STATE,
> > +       .ack_base               = AXP313A_IRQ_STATE,
> > +       .unmask_base            = AXP313A_IRQ_EN,
> > +       .init_ack_masked        = true,
> > +       .irqs                   = axp313a_regmap_irqs,
> > +       .num_irqs               = ARRAY_SIZE(axp313a_regmap_irqs),
> > +       .num_regs               = 1,
> > +};
> > +
> >  static const struct regmap_irq_chip axp803_regmap_irq_chip = {
> >         .name                   = "axp803",
> >         .status_base            = AXP20X_IRQ1_STATE,
> > @@ -676,6 +725,12 @@ static const struct mfd_cell axp152_cells[] = {
> >         },
> >  };
> >
> > +static struct mfd_cell axp313a_cells[] = {
> > +       {
> > +               .name = "axp20x-regulator",  
> 
> Lee asked for MFD_CELL_NAME() in v7 here.

Fixed.

> Could you also add the power button cell? This would make it an actual
> MFD, and also complete, since that is the only other function this
> PMIC has. Or at least add a note mentioning it. Implementing it will

Done.

> require a device that actually routes that pin out. AFAICT the MangoPi
> doesn't.
> 
> > +       },
> > +};
> > +
> >  static const struct resource axp288_adc_resources[] = {
> >         DEFINE_RES_IRQ_NAMED(AXP288_IRQ_GPADC, "GPADC"),
> >  };
> > @@ -892,6 +947,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
> >                 axp20x->regmap_irq_chip = &axp288_regmap_irq_chip;
> >                 axp20x->irq_flags = IRQF_TRIGGER_LOW;
> >                 break;
> > +       case AXP313A_ID:
> > +               axp20x->nr_cells = ARRAY_SIZE(axp313a_cells);
> > +               axp20x->cells = axp313a_cells;
> > +               axp20x->regmap_cfg = &axp313a_regmap_config;
> > +               axp20x->regmap_irq_chip = &axp313a_regmap_irq_chip;
> > +               break;
> >         case AXP803_ID:
> >                 axp20x->nr_cells = ARRAY_SIZE(axp803_cells);
> >                 axp20x->cells = axp803_cells;
> > diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> > index 2058194807bd..12e4fc3e8391 100644
> > --- a/include/linux/mfd/axp20x.h
> > +++ b/include/linux/mfd/axp20x.h
> > @@ -17,6 +17,7 @@ enum axp20x_variants {
> >         AXP221_ID,
> >         AXP223_ID,
> >         AXP288_ID,
> > +       AXP313A_ID,
> >         AXP803_ID,
> >         AXP806_ID,
> >         AXP809_ID,
> > @@ -91,6 +92,17 @@ enum axp20x_variants {
> >  #define AXP22X_ALDO3_V_OUT             0x2a
> >  #define AXP22X_CHRG_CTRL3              0x35
> >
> > +#define AXP313A_ON_INDICATE            0x00
> > +#define AXP313A_OUTPUT_CONTROL         0x10
> > +#define AXP313A_DCDC1_CONRTOL          0x13
> > +#define AXP313A_DCDC2_CONRTOL          0x14
> > +#define AXP313A_DCDC3_CONRTOL          0x15
> > +#define AXP313A_ALDO1_CONRTOL          0x16
> > +#define AXP313A_DLDO1_CONRTOL          0x17  
> 
> Please also add register 0x1a (note, some bits of this are volatile)
> and implement power off with bit 7. The current axp_power_off()
> function will not work for this PMIC.

Ah, good catch, thanks. Though I guess this will be unused (on 64-bit
SoCs), since PSCI poweroff takes precedence due to its higher firmware
priority.
Fixed anyway, need to test this with a hacked priority value.

Though the volatility of this register is a bit questionable, isn't it? It
just seems to apply to the poweroff and reset bits, that are self-reset.
Nobody cares for the former, and we don't use the reset (yet). I added it
to the volatile range anyway.

> This PMIC also supports software-triggered reset with bit 6 in the same
> register. This function would be nice to have, however there's no related
> code in the mfd driver right now, since IIRC none of the other ones had
> this.

What would be the use case? Who would trigger that reset? I guess it might
be more useful for management firmware like crust?

> > +#define AXP313A_OUTPUT_MONITOR         0x1d  
> 
> Not sure why you need this?

Removed.

> > +#define AXP313A_IRQ_EN                 0x20
> > +#define AXP313A_IRQ_STATE              0x21
> > +
> >  #define AXP806_STARTUP_SRC             0x00
> >  #define AXP806_CHIP_ID                 0x03
> >  #define AXP806_PWR_OUT_CTRL1           0x10
> > @@ -322,6 +334,16 @@ enum {
> >         AXP22X_REG_ID_MAX,
> >  };
> >
> > +enum {
> > +       AXP313A_DCDC1 = 0,
> > +       AXP313A_DCDC2,
> > +       AXP313A_DCDC3,
> > +       AXP313A_LDO1,  
> 
> This is called ALDO1 in the datasheet ...
> 
> > +       AXP313A_LDO2,  
> 
> ... and this one DLDO1.
> 
> You already have the registers named that way, so you might as well
> fix the names here as well.

Fixed.

Thanks,
Andre

> 
> 
> Thanks
> ChenYu
> 
> > +       AXP313A_RTC_LDO,
> > +       AXP313A_REG_ID_MAX,
> > +};
> > +
> >  enum {
> >         AXP806_DCDCA = 0,
> >         AXP806_DCDCB,
> > @@ -548,6 +570,16 @@ enum axp288_irqs {
> >         AXP288_IRQ_BC_USB_CHNG,
> >  };
> >
> > +enum axp313a_irqs {
> > +       AXP313A_IRQ_DIE_TEMP_HIGH,
> > +       AXP313A_IRQ_DCDC2_V_LOW = 2,
> > +       AXP313A_IRQ_DCDC3_V_LOW,
> > +       AXP313A_IRQ_PEK_LONG,
> > +       AXP313A_IRQ_PEK_SHORT,
> > +       AXP313A_IRQ_PEK_FAL_EDGE,
> > +       AXP313A_IRQ_PEK_RIS_EDGE,
> > +};
> > +
> >  enum axp803_irqs {
> >         AXP803_IRQ_ACIN_OVER_V = 1,
> >         AXP803_IRQ_ACIN_PLUGIN,
> > --
> > 2.39.0
> >  

