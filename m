Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0F46C6CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCWQHP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCWQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:07:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2EB6302B4;
        Thu, 23 Mar 2023 09:07:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2D12F4;
        Thu, 23 Mar 2023 09:07:55 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 222053F766;
        Thu, 23 Mar 2023 09:07:09 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:07:06 +0000
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
Subject: Re: [PATCH v8 3/3] regulator: axp20x: Add support for AXP313a
 variant
Message-ID: <20230323160706.3d8d900f@donnerap.cambridge.arm.com>
In-Reply-To: <CAGb2v64QDXNq-CHuCqoXu5C73rnTNQena49vQx5cHFPVc4KvHQ@mail.gmail.com>
References: <20230120184500.1899814-1-martin.botka@somainline.org>
        <20230120184500.1899814-4-martin.botka@somainline.org>
        <CAGb2v649yQVcNn7uv1eKtnEDnb=D4X9yGYB1eOC3zeAe+encFg@mail.gmail.com>
        <20230323135919.4e21f587@donnerap.cambridge.arm.com>
        <CAGb2v64QDXNq-CHuCqoXu5C73rnTNQena49vQx5cHFPVc4KvHQ@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 22:21:44 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

Hi,

> On Thu, Mar 23, 2023 at 9:59 PM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > On Sat, 28 Jan 2023 01:24:18 +0800
> > Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi,
> >  
> > > On Sat, Jan 21, 2023 at 2:45 AM Martin Botka
> > > <martin.botka@somainline.org> wrote:  
> > > >
> > > > The AXP313a is your typical I2C controlled PMIC, although in a lighter
> > > > fashion compared to the other X-Powers PMICs: it has only three DCDC
> > > > rails, three LDOs, and no battery charging support.
> > > >
> > > > The AXP313a datasheet does not describe a register to change the DCDC
> > > > switching frequency, and talks of it being fixed at 3 MHz. The BSP
> > > > driver hints at a register being able to change that, but we haven't
> > > > verified that, so leave that one out. It can be added later, if needed
> > > > and/or required.  
> > >
> > > The datasheet released by MangoPi says this isn't configurable. The
> > > thing that is configurable is spread-spectrum operation, and mode
> > > switching between fixed PWM and hybrid PFM/PWM. So just drop the
> > > DCDC frequency stuff and use the default code path.  
> >
> > The default code path is fatal to the driver, so we can't really do this.
> > axp20x_set_dcdc_freq is *always* called, even when the property is missing,
> > in this case the frequency will just be 0.
> > If we don't specify the variant ID in the switch/case, we get an error and
> > the driver bails out with -EINVAL.
> > So the minimal implementation would be:
> >         case AXP313A_ID:
> >                 return 0;
> > To be a bit more robust and catch cases where people try to specify some
> > DCDC frequency, I added this extra check for 3MHz or 0 (no property).  
> 
> Given that it's fixed, it really shouldn't be specified as a property.

I agree, I guess this means we need to disallow it in the DT binding then?

> 
> > > > The third LDO, RTCLDO, is fixed, and cannot even be turned on or off,
> > > > programmatically. On top of that, its voltage is customisable (either
> > > > 1.8V or 3.3V), which we cannot describe easily using the existing
> > > > regulator wrapper functions. This should be fixed properly, using
> > > > regulator-{min,max}-microvolt in the DT, but this requires more changes
> > > > to the code. As some other PMICs (AXP2xx, AXP803) seem to paper over the
> > > > same problem as well, we follow suit here and pretend it's a fixed 1.8V
> > > > regulator. A proper fix can follow later. The BSP code seems to ignore
> > > > this regulator altogether.
> > > >
> > > > Describe the AXP313A's voltage settings and switch registers, how the
> > > > voltages are encoded, and connect this to the MFD device via its
> > > > regulator ID.
> > > >
> > > > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > ---
> > > >  drivers/regulator/axp20x-regulator.c | 60 ++++++++++++++++++++++++++++
> > > >  1 file changed, 60 insertions(+)
> > > >
> > > > diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> > > > index d260c442b788..3087bc98694f 100644
> > > > --- a/drivers/regulator/axp20x-regulator.c
> > > > +++ b/drivers/regulator/axp20x-regulator.c
> > > > @@ -134,6 +134,11 @@
> > > >  #define AXP22X_PWR_OUT_DLDO4_MASK      BIT_MASK(6)
> > > >  #define AXP22X_PWR_OUT_ALDO3_MASK      BIT_MASK(7)
> > > >
> > > > +#define AXP313A_DCDC1_NUM_VOLTAGES     107
> > > > +#define AXP313A_DCDC23_NUM_VOLTAGES    88
> > > > +#define AXP313A_DCDC_V_OUT_MASK                GENMASK(6, 0)
> > > > +#define AXP313A_LDO_V_OUT_MASK         GENMASK(4, 0)
> > > > +
> > > >  #define AXP803_PWR_OUT_DCDC1_MASK      BIT_MASK(0)
> > > >  #define AXP803_PWR_OUT_DCDC2_MASK      BIT_MASK(1)
> > > >  #define AXP803_PWR_OUT_DCDC3_MASK      BIT_MASK(2)
> > > > @@ -638,6 +643,48 @@ static const struct regulator_desc axp22x_drivevbus_regulator = {
> > > >         .ops            = &axp20x_ops_sw,
> > > >  };
> > > >
> > > > +static const struct linear_range axp313a_dcdc1_ranges[] = {
> > > > +       REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
> > > > +       REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
> > > > +       REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
> > > > +};
> > > > +
> > > > +static const struct linear_range axp313a_dcdc2_ranges[] = {
> > > > +       REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
> > > > +       REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
> > > > +};
> > > > +
> > > > +/*
> > > > + * This is deviating from the datasheet. The values here are taken from the
> > > > + * BSP driver and have been confirmed by measurements.
> > > > + */
> > > > +static const struct linear_range axp313a_dcdc3_ranges[] = {
> > > > +       REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
> > > > +       REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
> > > > +};
> > > > +
> > > > +static const struct regulator_desc axp313a_regulators[] = {
> > > > +       AXP_DESC_RANGES(AXP313A, DCDC1, "dcdc1", "vin1",
> > > > +                       axp313a_dcdc1_ranges, AXP313A_DCDC1_NUM_VOLTAGES,
> > > > +                       AXP313A_DCDC1_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
> > > > +                       AXP313A_OUTPUT_CONTROL, BIT(0)),
> > > > +       AXP_DESC_RANGES(AXP313A, DCDC2, "dcdc2", "vin2",
> > > > +                       axp313a_dcdc2_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
> > > > +                       AXP313A_DCDC2_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
> > > > +                       AXP313A_OUTPUT_CONTROL, BIT(1)),
> > > > +       AXP_DESC_RANGES(AXP313A, DCDC3, "dcdc3", "vin3",
> > > > +                       axp313a_dcdc3_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
> > > > +                       AXP313A_DCDC3_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
> > > > +                       AXP313A_OUTPUT_CONTROL, BIT(2)),
> > > > +       AXP_DESC(AXP313A, LDO1, "ldo1", "vin1", 500, 3500, 100,
> > > > +                AXP313A_ALDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
> > > > +                AXP313A_OUTPUT_CONTROL, BIT(3)),  
> > >
> > > The datasheet says this one is called ALDO1 ...
> > >  
> > > > +       AXP_DESC(AXP313A, LDO2, "ldo2", "vin1", 500, 3500, 100,
> > > > +                AXP313A_DLDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
> > > > +                AXP313A_OUTPUT_CONTROL, BIT(4)),  
> > >
> > > ... and this one DLDO1.  
> >
> > Fixed.
> >
> >  
> > > > +       AXP_DESC_FIXED(AXP313A, RTC_LDO, "rtc-ldo", "vin1", 1800),
> > > > +};
> > > > +
> > > >  /* DCDC ranges shared with AXP813 */
> > > >  static const struct linear_range axp803_dcdc234_ranges[] = {
> > > >         REGULATOR_LINEAR_RANGE(500000,
> > > > @@ -1040,6 +1087,15 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
> > > >                 def = 3000;
> > > >                 step = 150;
> > > >                 break;
> > > > +       case AXP313A_ID:
> > > > +               /* The DCDC PWM frequency seems to be fixed to 3 MHz. */
> > > > +               if (dcdcfreq != 3000000 && dcdcfreq != 0) {
> > > > +                       dev_err(&pdev->dev,
> > > > +                               "DCDC frequency on AXP313a is fixed to 3 MHz.\n");
> > > > +                       return -EINVAL;
> > > > +               }
> > > > +
> > > > +               return 0;  
> > >
> > > As mentioned above, please drop this.  
> >
> > As mentioned above, we need at least the variant ID and a "return 0;". Do
> > you want me to drop the extra checks as well? Doesn't really hurt, and
> > provides extra info in case people try something stupid.  
> 
> Ah, OK. In that case let's allow the "no property" case, and error out
> for all any other value set.

OK, will do.

Thanks,
Andre

> 
> ChenYu
> 
> > > Besides the bits mentioned above, this looks OK.  
> >
> > Thanks!
> > Andre
> >  
> > >  
> > > >         default:
> > > >                 dev_err(&pdev->dev,
> > > >                         "Setting DCDC frequency for unsupported AXP variant\n");
> > > > @@ -1232,6 +1288,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
> > > >                 drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
> > > >                                                   "x-powers,drive-vbus-en");
> > > >                 break;
> > > > +       case AXP313A_ID:
> > > > +               regulators = axp313a_regulators;
> > > > +               nregulators = AXP313A_REG_ID_MAX;
> > > > +               break;
> > > >         case AXP803_ID:
> > > >                 regulators = axp803_regulators;
> > > >                 nregulators = AXP803_REG_ID_MAX;
> > > > --
> > > > 2.39.0
> > > >  
> >  

