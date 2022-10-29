Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA2612256
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ2LX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2LX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:23:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178275DF30;
        Sat, 29 Oct 2022 04:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EA9D2CE0690;
        Sat, 29 Oct 2022 11:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0552C433C1;
        Sat, 29 Oct 2022 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667042629;
        bh=0E7xlx8DnILOZgkcZBHQ6ptwIL0kf2yQR2NNwpYQpjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R5pgCi8CL6C0Sb1kiVNZcGZV0tzASQEl8BL8phOUAXUJqcOsqg3KmrvcdJf6xg5ax
         fNObPxIgMi7fm1c0rG/6DTCOBoFx2gT3ZAqt1u9hAmvvH4Atbj04dSRR77MjKIsZ/n
         tYj1+FqI9jYxH5QbM8j7r6h9nsqh00dtcS9CWWYHhhoTSdRrbJNQFLDGpGCJj5RUCi
         5fxImhwX7gE6dQXNZlBMc/nLL10wSEhCka10dFGgrEs5xjoGtNRdrpczHEc5PvLIuZ
         ww2DNTfimz05Z1NAXDr3qCNIE2+88M1v92Aw77q+Lvn7HfIvWu8OICxfG7HQfYptBd
         93KVsWyiPxirw==
Date:   Sat, 29 Oct 2022 12:35:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221029123542.335f0bea@jic23-huawei>
In-Reply-To: <df01792b-fb9c-017c-1feb-ee8f5d8eb692@fi.rohmeurope.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
        <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
        <20221023124316.239427a7@jic23-huawei>
        <df01792b-fb9c-017c-1feb-ee8f5d8eb692@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 05:44:21 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> Good Morning Jonathan,
> 
> On 10/23/22 14:43, Jonathan Cameron wrote:
> > On Fri, 21 Oct 2022 14:22:49 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
> >> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> >> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> >> ranges (2, 4, 8 and 16g), and probably some other cool features.
> >>
> >> Add support for the basic accelerometer features such as getting the
> >> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> >> using the WMI IRQ).
> >>
> >> Important things to be added include the double-tap, motion
> >> detection and wake-up as well as the runtime power management.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > 
> > Hi Matti,
> > 
> > A few things from me on this read through to add to those last few comments
> > from Andy.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> >> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> >> new file mode 100644
> >> index 000000000000..6510f8d62b85
> >> --- /dev/null
> >> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> >> @@ -0,0 +1,51 @@  
> >   
> >> +
> >> +MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
> >> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_IMPORT_NS(KIONIX_ACCEL);  
> > Not sure why I didn't noticed this before, but after various debates we
> > ended up prefixing namespaces to limit them to IIO. Also, there are other kionix
> > drivers already and may be more in future. Better to limit this to scope of this
> > driver,  
> 
> Prefixing with IIO_ is all fine. And I was thinking of using the KX022A 
> but ended up with KIONIX as I am pretty sure this same driver will be 
> extended to cover the old 022 (without A) and probably also 122 (at 
> least)...
> 
> ...After that being said - I have been doing this same naming by 
> part-name with ROHM PMIC drivers. As an example, first IC I was working 
> with after jumping from Nokia to ROHM was BD71837. After the driver was 
> written I encountered BD71847 - which was almost identical but just 
> omitted few BUCKs. So, I renamed driver to BD718x7 and added the support.
> 
> As you can probably guess, this was not the end of the story. Next came 
> BD71850 - which is pretty much the BD71847 with different OTP. I think I 
> used some defines with BD718XX_...
> 
> ...and later I did drivers for BD71815, BD71827, BD71828 ... - which all 
> were completely different from the ones supported by bd718x7 driver.
> 
> What I learned was - either use the exact part name in file/defines 
> (even when supporting many ICs) or use completely abstract name with no 
> part name. It seems to be impossible to do correct wildcards unless you 
> can dictate the IC naming :)
Yup.  I'd stick to exact as event really generic ends up messy as it can
imply coverage of devices that are entirely separate.

> 
> > 
> > IIO_KX022A >
> > seems like a reaonsable choice.
> >   
> 
> Long babbling just to say: "Yes".
> We can use IIO_KX022A even if we support many ICs. I don't plan to 
> change the file/function/define naming when adding support to new ICs :)
> 

Absolutely.  We have lots of drivers like this where naming is after one
part but they support many different parts (in some cases even from different
manufacturers though that is rarer.)

> 
> >> +int kx022a_probe_internal(struct device *dev)
> >> +{
> >> +	static const char * const regulator_names[] = {"io-vdd", "vdd"};
> >> +	struct iio_trigger *indio_trig;
> >> +	struct fwnode_handle *fwnode;
> >> +	struct kx022a_data *data;
> >> +	struct regmap *regmap;
> >> +	unsigned int chip_id;
> >> +	struct iio_dev *idev;
> >> +	int ret, irq;
> >> +	char *name;
> >> +
> >> +	regmap = dev_get_regmap(dev, NULL);
> >> +	if (!regmap) {
> >> +		dev_err(dev, "no regmap\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> >> +	if (!idev)
> >> +		return -ENOMEM;
> >> +
> >> +	data = iio_priv(idev);
> >> +
> >> +	/*
> >> +	 * VDD is the analog and digital domain voltage supply and
> >> +	 * IO_VDD is the digital I/O voltage supply.
> >> +	 */
> >> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> >> +					     regulator_names);
> >> +	if (ret && ret != -ENODEV)
> >> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> >> +
> >> +	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> >> +
> >> +	if (chip_id != KX022A_ID) {
> >> +		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	fwnode = dev_fwnode(dev);
> >> +	if (!fwnode)
> >> +		return -ENODEV;
> >> +
> >> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> >> +	if (irq > 0) {
> >> +		data->inc_reg = KX022A_REG_INC1;
> >> +		data->ien_reg = KX022A_REG_INC4;
> >> +
> >> +		if (fwnode_irq_get_byname(fwnode, "INT2") > 0)
> >> +			dev_warn(dev, "Only one IRQ supported\n");  
> > 
> > Why?  If you get the both, only the first one will be used by the driver.
> > Not really worth warning about the lack of features...  
> 
> My thinking regarding developing new device went along the lines:
> 
> Precondition: The HW (and data-sheet) explain how there is two INT pins.
> 1. Board designer reads the data-sheet and uses both INT pins.
> 2. SW engineer finds the driver and reads the DT-binding description.
> 3. SW engineer writes the DT-description and hopes everything "just 
> works". (Amount of hope is probably inversely proportional to the amount 
> of experience XD).
> 4) SW engineer gives a first go to the sensor SW and notices everything 
> does not just magically work.

Ah but it does "work". We simply don't use one of the IRQs.  That's not
normally a problem as there are lots of other features we don't fully
support.  Not using something is not normally considered a problem.

> 
> I think there is important difference between following options:
> 4a) Log shows print "Only one IRQ supported" from the kx022a driver
> 4b) Log shows no errors.
> 
> The amount of work potentially avoided by the check here is probably 
> again inversely proportional to the SW engineer's experience - but I 
> think it may be significant. OTOH, the amount of problems caused by this 
> check is (in my opinion) negligible. Well, the additional print string 
> does eat up few bytes of space - and I know people/systems that do not 
> like this. I am still tempted to say that those systems can opt to 
> disable the config for this driver though.
> 
> Well, this is not a point I would like to start fighting over though. If 
> this email does not convince the audience about usefulness of the print 
> - then I'll just drop it from the v5 :)

So far I'm not seeing anything that doesn't work because we only support
one IRQ.  There may be combinations of interrupts that are tricky to handle
on one IRQ line (or may not be supported at the same time on a single line)
but so far you don't support those anyway..  Adding a more informative warning
when adding those features would be reasonable

"Feature X not supported as only a single IRQ line available".

> 
> >> +	ret = devm_iio_device_register(data->dev, idev);
> >> +	if (ret < 0)
> >> +		return dev_err_probe(dev, ret,
> >> +				     "Unable to register iio device\n");
> >> +
> >> +	/*
> >> +	 * No need to check for NULL. request_threadedI_irq() defaults to  
> > Why I?
> >   
> 
> NoI_idea(). I'll fix this, thanks! :)
> 
> >> +	 * dev_name() should the alloc fail.
> >> +	 */
> >> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-kx022a",
> >> +			      dev_name(data->dev));
> >> +
> >> +	ret = devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
> >> +					&kx022a_irq_thread_handler,
> >> +					IRQF_ONESHOT, name, idev);  
> > 
> > You are requesting the irq 'after' exposing the userspace interfaces.
> > Technically that potentially introduces a race as we might in theory successfully
> > trigger an interrupt before requesting it.
> > 
> > Obviously that would be challenging to pull off given likely short window, but
> > good to close it anyway!  Rule of thumb is that devm_iio_device_register()
> > is always the last thing to call in problem.  The very rare exceptions need
> > a comment to explain why they are there...
> > 
> > Note that the devm_iio_trigger_register() also exposes the userspace part of the
> > trigger so if you allow that to be used by other drivers you'd need the irq registration
> > before that as well.
> >   
> 
> Thanks! I did overlook this. In a few cases handling the IRQs use 
> subsystem facilities established during driver registration. In those 
> cases the dependencies and the race goes the other way around. Thus it 
> is almost a habit for me to register IRQs as last thing and purge them 
> as first thing.

Hmm. If that's at the subsystem level and results in anything other than
an error that needs handling (not ready yet) then those are probably race
conditions that need fixing - unless the subsystem has some way of ensuring
the userspace interfaces aren't used until after the interrupts are registered
which would be unusual.

Ah well, care needed either way around.

Jonathan
> 
> I'll cook-up the v5 soon-ish :)
> 
> Yours
> 	-- Matti Vaittinen
> 

