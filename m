Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83DE6AB98A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCFJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCFJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:19:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85159ED7;
        Mon,  6 Mar 2023 01:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85BB4B80D11;
        Mon,  6 Mar 2023 09:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0D9C433D2;
        Mon,  6 Mar 2023 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678094329;
        bh=e7DGMlyFuT+Xr9OW9k1dxZOnlGNZRMNJeB3ZVMN6oOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMbSvP2qCbz7V6Je/+xoXoEb8fFTTErzI0eOeN+qo4rlvVQZPcokuOycud03oIt44
         eHlNjNuF1GsFPGU4371sCaIJ+yeJzRTrhUh+6FF1MgiE1Nljs0WSmX2TpjhtDUpsJR
         1R4b5v38swtVFVrkrLKI3D/x66X1DPStxH9QM6k8IA6hgrksJSTHmndUDEOeIxhCLz
         0Sc0GJ3LpV5/095jW0z4qAAu6Rq2yw3aWEu/irt/vc2y2X/zSdsxN8gBAs0sfGGeHj
         GDUvRX2hJq1rVSOthLdyKh8gddj6itI+bJSdjbjiRqYesWFPf5ikVRQJ+t8SGMIAIY
         +1BWsiJOZhiLA==
Date:   Mon, 6 Mar 2023 09:18:43 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 02/10] mfd: rt5033: Fix chip revision readout
Message-ID: <20230306091843.GE9667@google.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
 <a667a64d0cbeef00baed2d4b117ba9f50eaf3988.1677620677.git.jahau@rocketmail.com>
 <20230305104704.GG2574592@google.com>
 <96c54beb-228c-d606-5b9c-613ee2bc5e70@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96c54beb-228c-d606-5b9c-613ee2bc5e70@rocketmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Mar 2023, Jakob Hauser wrote:

> Hi Lee,
> 
> On 05.03.23 11:47, Lee Jones wrote:
> > On Tue, 28 Feb 2023, Jakob Hauser wrote:
> > 
> > > After reading the data from the DEVICE_ID register, mask 0x0f needs to be
> > > applied to extract the revision of the chip [1].
> > > 
> > > The other part of the DEVICE_ID register, mask 0xf0, is a vendor identification
> > > code. That's how it is set up at similar products of Richtek, e.g. RT9455 [2]
> > > page 21 top.
> > > 
> > > [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_core.c#L484
> > > [2] https://www.richtek.com/assets/product_file/RT9455/DS9455-00.pdf
> > > 
> > > Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> > > ---
> > >   drivers/mfd/rt5033.c               | 8 +++++---
> > >   include/linux/mfd/rt5033-private.h | 4 ++++
> > >   2 files changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
> > > index 8029d444b794..d32467174cb5 100644
> > > --- a/drivers/mfd/rt5033.c
> > > +++ b/drivers/mfd/rt5033.c
> > > @@ -55,7 +55,8 @@ static const struct regmap_config rt5033_regmap_config = {
> > >   static int rt5033_i2c_probe(struct i2c_client *i2c)
> > >   {
> > >   	struct rt5033_dev *rt5033;
> > > -	unsigned int dev_id;
> > > +	unsigned int data;
> > 
> > In terms of nomenclature, this is a regression.
> > 
> > 'data' is a terrible variable name.  Why not keep it as-is?
> 
> While not having a datasheet for RT5033 available, in similar products like
> RT9455 the register is called "Device ID", the first part of that is
> "VENDOR_ID" and the second part "CHIP_REV", [1] page 23 top. Or in RT5036
> preliminary data sheet the register is called "ID", the first part
> "VENDOR_ID" and the second part "CHIP_REV_ID", [2] page 27 top.
> 
> I wanted to avoid confusion between "dev_id" and "chip_rev". Therefore in
> the patch it's written as getting some "data" from the register and extract
> "chip_rev" from that data.
> 
> I could change it to "reg_data"? Or something in that direction? I still
> think that getting "chip_rev" out of "dev_id" would be confusing.

You're reading from a register called RT5033_REG_DEVICE_ID.  I don't see
any reason why the variable you read into can't reflect that.

> [1] https://www.richtek.com/assets/product_file/RT9455/DS9455-00.pdf
> [2] https://media.digikey.com/pdf/Data%20Sheets/Richtek%20PDF/RT5036%20%20Preliminary.pdf
> 
> > 
> > > +	unsigned int chip_rev;
> > >   	int ret;
> > >   	rt5033 = devm_kzalloc(&i2c->dev, sizeof(*rt5033), GFP_KERNEL);
> > > @@ -73,12 +74,13 @@ static int rt5033_i2c_probe(struct i2c_client *i2c)
> > >   		return PTR_ERR(rt5033->regmap);
> > >   	}
> > > -	ret = regmap_read(rt5033->regmap, RT5033_REG_DEVICE_ID, &dev_id);
> > > +	ret = regmap_read(rt5033->regmap, RT5033_REG_DEVICE_ID, &data);
> > >   	if (ret) {
> > >   		dev_err(&i2c->dev, "Device not found\n");
> > >   		return -ENODEV;
> > >   	}
> > > -	dev_info(&i2c->dev, "Device found Device ID: %04x\n", dev_id);
> > > +	chip_rev = data & RT5033_CHIP_REV_MASK;
> > > +	dev_info(&i2c->dev, "Device found (rev. %d)\n", chip_rev);
> > 
> > Why not print both?
> 
> As described above, the data "dev_id" consists of a first part which is a
> vendor ID and a second part which is the chip revision.
> 
> The vendor ID is of no interest here. These bits[7:4] contain binary value
> 1000 (decimal value 8) and I'd expect that to be the same on all RT5033
> devices.
> 
> Contrary to this, the chip revision is an important information. The
> downstream Android driver applies some quirks depending on the chip
> revision. This seemed not yet necessary in the upstream driver. So far I've
> seen chip rev. 6 on samsung-serranove & samsung-e7 and chip rev. 5 on
> samsung-grandmax & samsung-fortuna, the behavior of the chip revisions are
> slightly different.
> 
> Accordingly, the downstream Android driver as well reads [3] and prints [4]
> the chip revision only – confusingly calling it "rev id".
> [3] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_core.c#L484
> [4] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_core.c#L486
> 
> > >   	ret = regmap_add_irq_chip(rt5033->regmap, rt5033->irq,
> > >   			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > > diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
> > > index 2d1895c3efbf..d18cd4572208 100644
> > > --- a/include/linux/mfd/rt5033-private.h
> > > +++ b/include/linux/mfd/rt5033-private.h
> > > @@ -71,6 +71,10 @@ enum rt5033_reg {
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > g
> 
> What does the "g" mean, was this on purpose? I didn't get the meaning of it.
> 
> > >   /* RT5033 CHGCTRL2 register */
> > >   #define RT5033_CHGCTRL2_CV_MASK		0xfc
> > > +/* RT5033 DEVICE_ID register */
> > > +#define RT5033_VENDOR_ID_MASK		0xf0
> > > +#define RT5033_CHIP_REV_MASK		0x0f
> > > +
> > >   /* RT5033 CHGCTRL3 register */
> > >   #define RT5033_CHGCTRL3_CFO_EN_MASK	0x40
> > >   #define RT5033_CHGCTRL3_TIMER_MASK	0x38
> > > -- 
> > > 2.39.1
> > > 
> > 
> 
> Kind regards,
> Jakob

-- 
Lee Jones [李琼斯]
