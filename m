Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47B6EBF1F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDWLVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDWLVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F216510EC;
        Sun, 23 Apr 2023 04:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9168060EA2;
        Sun, 23 Apr 2023 11:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94649C433D2;
        Sun, 23 Apr 2023 11:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682248877;
        bh=H60wn/w8cSR+c1cvPwYBTXPWBkB4knkYJRoOAcwfJp0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T0JPLOZTLa3743v5XJfY1TXTYOT0p6eh4GHtksNOiO67JlMUh+udlXlv7TRB2LImD
         YCTuiSvE+a4Kf3z7gbHUgAJ87jVfo07LvofJa9d+Rzu3nPkbZyGf/4NJwfcPXr+Vdl
         OJFXxf0dGHYnuxpskPNSBG0bIVbvql8wTlaH7DOoeYjxHemTeHtkGyT3r0EsoGmxM9
         IjwPJxF+oWaxLbwEWbeKCkToPDwYKaduxrXgjX1e29Ye0JZbkeUAo2Hcd61gWYoI3l
         UUnrz6KYAzmjebatCelLYG2NjFFIHHRN3ylB81zuAfMM7BSDPRMZZP65K44LuzkE2n
         CpQ+6Tl5cWV7Q==
Date:   Sun, 23 Apr 2023 12:36:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH 2/2] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20230423123652.15bbab1b@jic23-huawei>
In-Reply-To: <3c9bd414-29dd-6e9e-5e6b-8dba27d730bc@tweaklogic.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
        <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
        <20230415183543.6d5e3392@jic23-huawei>
        <3c9bd414-29dd-6e9e-5e6b-8dba27d730bc@tweaklogic.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 17:25:50 +0800
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Thank you Jonathan for the review.
> Answering only to the Big questions.
> >>
> >> Software reset feature is not implemented as it causes I2C bus error,
> >> the I2C bus driver throws an ugly error message.  
> > 
> > That's unfortunate and perhaps something we should consider fixing
> > at the i2c layer.  Could you point to where it happens?
> > 
> > We have a lot of drivers where reset causes an error (Ack missing normally
> > due to simple state machines in the devices).  
> 
> Below function which cause the error:
> regmap_field_write(data->reg_sw_reset, 1);
> regmap_write(data->regmap, APDS9306_MAIN_CTRL, 0x10);
> i2c_smbus_write_byte_data(data->client, APDS9306_MAIN_CTRL, 0x10);
> 
> Error messages:
> [ 3340.426180] stm32f7-i2c 40012000.i2c: <stm32f7_i2c_isr_error>: Bus error accessing addr 0x52
> [ 3340.433880] stm32f7-i2c 40012000.i2c: Trying to recover bus
> 
> The function which gets called:
> https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-stm32f7.c#L1622
> 
> There is an errata associated with I2C for STM32MP157C (Section 2.19.2, Pg 35):
> https://www.st.com/resource/en/errata_sheet/es0438-stm32mp151x3x7x-device-errata-stmicroelectronics.pdf
> It speaks about - "Spurious bus error detection in master mode". But I
> don't think it has got anything to do with our case.
> 
> I use STM32MP157C-DK2 board as my reference device.
> The Reference manual to the STM32MP157C:
> https://www.st.com/resource/en/reference_manual/DM00327659.pdf
> 
> stm32f7_i2c_isr_error() handler gets called because a control bit is set
> ERRIE which enables interrupts from the I2C controller for Buss errors,
> Arbitration losses, Overrun/Underrun PEC error, Timeout, etc.
> 
> I am not sure about other chips.
> A possible way to mitigate these kind of issues would be to pass a flag
> from upper layers to the i2c bus driver (I2C_SMBUS_REPORT_ERR_OFF or
> something on those lines). The drivers can then implement in
> struct i2c_algorithm in smbus_xfer() function where they can check for
> the flag and disable error checking.
> 
> I don't have in depth knowledge on this subject so excuse my lack
> of understanding.

No problem and thanks for the details.

So there is an existing flag: I2C_M_IGNORE_NAK but I'm not sure that's
suitable and isn't supported by this particular bus driver.
https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/msp3400-driver.c#L100
is an example of it being used in a reset routine.

It might be sufficient to just check that flag in the stm32f7 i2c driver and not
print an error message if it is set.

+CC Wolfram for input on this.




> 
> >   
> >>
> >> Could not locate the Lux calculations from datasheet, only exporting
> >> raw values.  
> > 
> > Ah. That's annoying as userspace is generally not able to do much with
> > the raw values.  Any other known code supporting this device that you
> > can raid for info?
> > 
> > If not, then this ist he best we can do.
> >   
> This device is similar to LTRF216A.
> If I use the calculation in ltrf216a then I would have to verify them
> with Lux meter and controlled light source or ltrf216a.
> This will be bit difficult for me at this moment.

no problem. We can add that later if needed.
> 
> >>
> >> Reading of the Status register clears the Data Ready and the Interrupt
> >> Status flags. It makes it tricky to read oneshot values together with
> >> interrupts enabled as the IRQ handler clears the status on receipt
> >> of an interrupt signal.
> >>   
> >> Not checking the status in IRQ handler will make the interrupt line
> >> unsharable and it does not reset the interrupt line if the Interrupt
> >> status flag is not cleared.  
> > 
> > Definitely need to check it but I'm not sure I follow why you can't
> > use it for both purposes with a slightly complex interrupt handler design.
> > Maybe the code makes it clear what the issue is here.  
> Answers are in below comment.
> 
> >> +
> >> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
> >> +{
> >> +	struct device *dev = &data->client->dev;
> >> +	int ret, delay, status, int_en;
> >> +	int retries = 4;
> >> +	u8 buff[3];
> >> +
> >> +	ret = apds9306_runtime_power(data, 1);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/*
> >> +	 * Whichever is greater - integration time period or
> >> +	 * sampling period.
> >> +	 */
> >> +	delay = max(apds9306_intg_time[data->intg_time_idx][1],
> >> +			apds9306_repeat_rate_period[data->repeat_rate_idx]);
> >> +
> >> +	/*
> >> +	 * If interrupts are enabled then Status resistor cannot be
> >> +	 * relied upon as all the status bits are cleared by the
> >> +	 * interrupt handler in case of an event.  
> > 
> > Ah.  I was assuming sane hardware (always an error :) that would issue
> > an interrupt on the data being ready.  I think we can make this work
> > but it is ugly.  Add some flags to the state structure. Then whenever
> > you read this register, set whether the two status flags are set of not.
> > Thus in the interrupt handler you can tell if this got there first and
> > here you can tell if the interrupt handler got their first.  
> If I have a flag in the state structure for this, then a timestamp would
> also be required or may be just a timestamp.

True - though given we are dealing with a race here, I'd imagine any wrong
timestamp issues will only make a small difference.

> 
> > 
> > One messy corner.  A status read resets the interrupt line, potentially before
> > we saw the interrupt. Oh goody - normally this silliness only happens as
> > a result of complex interrupt migration or errata. However it is understood
> > what to do about it.
> > 
> > If you see the interrupt status flag here, you have no way of knowing
> > if the interrupt line was high for long enough that the interrupt controller
> > saw it.  As such your only option is to assume it didn't and inject an extra
> > one.  Given a passing of the threshold could in theory have been noisy enough
> > to trigger two actual interrupts very close together userspace should be fine
> > with the extra event - we probably just wasted some cycles doing something twice.
> > 
> > The annoying bit will be testing as these races will be somewhat rare.  
> 
> As per my understanding the Status register has - "Observer effect"
> 
> The Status register has got 3 bits - Power On Status, ALS Interrupt
> and ALS Data.
> A single read of the register clears all three bits.
> 
> In case of an interrupt event, the interrupt line is held low (Active) by the
> device till the Status register is read. As this is an edge triggered interrupt,
> we stop receiving interrupts till we read the status register.
> This is why it is good to acknowledge the interrupt by reading the Status register
> in the ISR.
> 
> Reading the Status register in the ISR inadvertently clears the "ALS Data" bit
> as well.
> 
> What you are asking is to have a read flag in the static struct and a timestamp
> flag may be. In the isr, we check the flag and if the timestamp is within one
> integration period, if yes, we don't read the Status register any more from the
> isr.

Not quite. Reading the ISR should be safe even if we already read it from the read_raw()
path.  The worst that happens is we report one event rather than two, but they will
close enough together that won't matter.  Potentially races may mean we signal 2
events, but that's fine too. Just looks like a bit of noise on the analog signal
so shouldn't confuse software anyway.  To ensure the read raw path doesn't wait
for ever you'll also need to store a flag to say the data is good which is then
used to detect we have wiped that bit before read_raw saw it.  The read_raw path
can clear that flag so we know it's fresh if the interrupt sets it later.

> And in this function we read the Status register and update the read flag and
> the timestamp with current time.

If you see the bit that corresponds to the interrupt here, then you might never
see the interrupt (it might be too short to rise properly).   As such I think you'll
need to push the event from the read_raw path.  If the interrupt is seen then
we may find no bits set and that will be fine.

Need a bit of scribbling of timing diagrams to get all paths covered, but
I'm fairly sure it is possible.  Main challenge will be to keep it minimal and
not over engineer the solution!

> 
> Not sure if my understanding is correct but I will try the above.
> 
> >   
> >> +	 */
> >> +	ret = regmap_field_read(data->regfield_int_en, &int_en);
> >> +	if (ret) {
> >> +		dev_err(dev, "read interrupt status failed: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	if (!int_en) {
> >> +		while (retries--) {
> >> +			ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS,
> >> +					&status);
> >> +			if (ret) {
> >> +				dev_err(dev, "read status failed: %d\n", ret);
> >> +				return ret;
> >> +			}
> >> +			if (status & APDS9306_ALS_DATA_STAT_MASK)
> >> +				break;
> >> +			/*
> >> +			 * In case of continuous one-shot read from userspace,
> >> +			 * new data is available after sampling period.
> >> +			 * Delays are in the range of 25ms to 2secs.
> >> +			 */
> >> +			fsleep(delay);
> >> +		}
> >> +	} else
> >> +		fsleep(delay);
> >> +
> >> +	if (!retries)
> >> +		return -EBUSY;
> >> +
> >> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> >> +	if (ret) {
> >> +		dev_err(&data->client->dev, "read data failed\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	*val = get_unaligned_le24(&buff[0]);
> >> +
> >> +	ret = apds9306_runtime_power(data, 0);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return ret;
> >> +}
> >> +  
> 
> Regards,
> Subhajit Ghosh

