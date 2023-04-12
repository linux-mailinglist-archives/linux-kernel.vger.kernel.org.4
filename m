Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6A6DF113
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDLJvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDLJvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668FF6A49;
        Wed, 12 Apr 2023 02:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC676326C;
        Wed, 12 Apr 2023 09:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C3CC4339C;
        Wed, 12 Apr 2023 09:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293074;
        bh=xFxPIGIGrRbwMnk/0zPROUNRBCfo1iBn9+kOWVdE0ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVJjV1/2DR71czIubDXSUSbaIS1KVNV0eFUNEhG0x7VkGmKFizB6SY7spcordXVBB
         h2ztd8SdkqfII9vEc/BLcFojKNw3qMllFhWOi7VlEtBgQRqisxYRGirkLkRnoB3Nkh
         Jdu7pnHOSMdtlWwSKeYCQwT1NWOr2Y/lTujEn+sl9n9mY/nZEqjNOKXkwamRjL71u+
         UcWraCghKAu8RVF7SiaE71STaBF7LWxBrWaRaT1ku3i+EVPlRPV4o++0Pkhg1ur1Bf
         kWDIiGXJNZzDayHGgHQ6nIFy6SqVMd88DG1loXfw4B7OoKJAQucR/VJJUgZCOtMmwD
         s1LAXNGNPEZCQ==
Date:   Wed, 12 Apr 2023 10:51:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 2/2] leds: max597x: Add support for max597x
Message-ID: <20230412095109.GY8371@google.com>
References: <20230328094416.3851801-1-Naresh.Solanki@9elements.com>
 <20230328094416.3851801-2-Naresh.Solanki@9elements.com>
 <20230405150706.GM8371@google.com>
 <375c6a74-c664-6ecc-cdcd-20cfa4568cd1@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <375c6a74-c664-6ecc-cdcd-20cfa4568cd1@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023, Naresh Solanki wrote:

> Hi Lee,
>
> On 05-04-2023 08:37 pm, Lee Jones wrote:
> > On Tue, 28 Mar 2023, Naresh Solanki wrote:
> >
> > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > >
> > > max597x is hot swap controller with indicator LED support.
> > > This driver uses DT property to configure led during boot time &
> > > also provide the LED control in sysfs.
> > >
> > > DTS example:
> > >      i2c {
> > >          #address-cells = <1>;
> > >          #size-cells = <0>;
> > >          regulator@3a {
> > >              compatible = "maxim,max5978";
> > >              reg = <0x3a>;
> > >              vss1-supply = <&p3v3>;
> > >
> > >              regulators {
> > >                  sw0_ref_0: sw0 {
> > >                      shunt-resistor-micro-ohms = <12000>;
> > >                  };
> > >              };
> > >
> > >              leds {
> > >                  #address-cells = <1>;
> > >                  #size-cells = <0>;
> > >                  led@0 {
> > >                      reg = <0>;
> > >                      label = "led0";
> > >                      default-state = "on";
> > >                  };
> > >                  led@1 {
> > >                      reg = <1>;
> > >                      label = "led1";
> > >                      default-state = "on";
> > >                  };
> > >              };
> > >          };
> > >      };
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > ...
> > > Changes in V3:
> > > - Remove of_node_put as its handled by for loop
> > > - Print error if an LED fails to register.
> > > - Update driver name in Kconfig description
> > > - Remove unneeded variable assignment
> > > - Use devm_led_classdev_register to reget led
> > > Changes in V2:
> > > - Fix regmap update
> > > - Remove devm_kfree
> > > - Remove default-state
> > > - Add example dts in commit message
> > > - Fix whitespace in Kconfig
> > > - Fix comment
> > > ---
> > >   drivers/leds/Kconfig        |  11 ++++
> > >   drivers/leds/Makefile       |   1 +
> > >   drivers/leds/leds-max597x.c | 112 ++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 124 insertions(+)
> > >   create mode 100644 drivers/leds/leds-max597x.c

[...]

> > > +
> > > +static int max597x_led_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device_node *np = dev_of_node(pdev->dev.parent);
> >
> > Why not have your own compatible string?
> This is leaf driver & MFD driver does has compatible string.

I can see that, but why not give this driver it's own one?

> > > +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> >
> > These "big" API calls are usually done outside of the allocation block.
> >
> > Please move it to just above the check for !regmap.
> >
> > > +	struct device_node *led_node;
> > > +	struct device_node *child;
> > > +	int ret = 0;
> >
> > Is it okay for an LED driver to not to register any LEDs?
> Yes. Usage of indication LED on the max5970/5978 is optional.
> >
> > Perhaps -ENODEV?
> This driver is loaded only if MFD driver is included. remap is setup by MFD
> driver & hence defer probe till MFD driver is loaded.
> >
> > > +	if (!regmap)
> > > +		return -EPROBE_DEFER;
> > > +
> > > +	led_node = of_get_child_by_name(np, "leds");
> > > +	if (!led_node)
> > > +		return -ENODEV;
> >
> > Ah, that's better.  So set ret to -ENODEV and use it here.
> Yes.
> >
> > > +	for_each_available_child_of_node(led_node, child) {
> > > +		u32 reg;
> > > +
> > > +		if (of_property_read_u32(child, "reg", &reg))
> > > +			continue;
> > > +
> > > +		if (reg >= MAX597X_NUM_LEDS) {
> > > +			dev_err(&pdev->dev, "invalid LED (%u >= %d)\n", reg,
> > > +				MAX597X_NUM_LEDS);
> > > +			continue;
> > > +		}
> > > +
> > > +		ret = max597x_setup_led(&pdev->dev, regmap, child, reg);
> > > +		if (ret < 0)
> > > +			dev_err(&pdev->dev, "Failed to initialize LED %u\n", reg);
> >
> > I think you (or I) are missing the point of the previous reviews.  It's
> > not okay to error out and continue executing.  Either this is okay (you
> > can warn and carry on) or it's not (return an error).  Your first
> > submission suggested that this was an error.  In which case you do need
> > to return.  I think Pavel was suggesting that you should unwind
> > (de-register) before retuning, rather than leaving things in an odd
> > half-registered state.  Not that you should blindly carry on as if the
> > issue never occurred.
> I did refer to other such implementations & some have used return on error &
> some just print on error & continue. I felt that continue executing with
> warning(on error) is better approach.

I think it should fail fast and with certainty.


--
Lee Jones [李琼斯]
