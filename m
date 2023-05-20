Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27F70A914
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjETQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E115918C;
        Sat, 20 May 2023 09:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B69D0619E0;
        Sat, 20 May 2023 16:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D388DC433D2;
        Sat, 20 May 2023 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684600094;
        bh=cJZpEEFzsfD8lCjNgKENQ3mel7UzhmXW1jVWuTGoWEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JInoDV3y8FmEf+3ELZHCa+0XsraKuYQ0ikcJpyWAYs+eWaCzTKE2KoUiszBef8pqs
         nG7kxJ/Y/KdAgd24j9PJRimfEqpjbTCFfCtkwf4GI9E4Pq1ePWqaJu7Olrrnq8j6Di
         qzVVokxQv6HSRNXgxbDailOgyI8y8jasz+BjI+C+biM0QBRxHw9kgRhVUxuxm10+sZ
         OpC3nYs8s+HhUzgxyT768j6pdKaAEWQ3MGWRNJFV5CdVuKFo71RJ8Bn92pZFdbSFku
         FjRm8ZcaSMMSB/IcDo+3ylHUNeLIZaD2eFrlkf/aemsyo4FYusceMo3I/8SHCcF/3N
         en1tt1Z4RHakg==
Date:   Sat, 20 May 2023 17:44:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <20230520174422.4313cd83@jic23-huawei>
In-Reply-To: <2594162f0e44148cffb1fb05f1d6edfde6bd11bc.1683541225.git.mazziesaccount@gmail.com>
References: <cover.1683541225.git.mazziesaccount@gmail.com>
        <2594162f0e44148cffb1fb05f1d6edfde6bd11bc.1683541225.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 13:39:29 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> Add initial support for the ROHM BU27008 color sensor.
>  - raw_read() of RGB and clear channels
>  - triggered buffer w/ DRDY interrtupt
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> 
> Please, check the way trigger handling is now implemented. I've verified
> it works for one user-space user, but I am no longer confident on how
> the triggers are intended to be used.
> 
> When testing the trigger passing iio_trigger_generic_data_rdy_poll() as
> a handler in devm_request_irq() I saw an IRQ storm. The threaded handler
> given in devm_iio_triggered_buffer_setup() [bu27008_trigger_handler()] got
> never called and system hung just looping in
> iio_trigger_generic_data_rdy_poll(). Hence, this version disables the
> IRQ in the handler registered at devm_request_irq(), before cascading
> into iio_trigger_poll(). IRQ is now re-enabled in trigger's .reenable
> callback. Feedback is appreciated!

What you have makes sense to me.

A few trivial things inline I'll tidy up whilst applying.


> +static int bu27008_trigger_set_state(struct iio_trigger *trig,
> +				     bool state)
> +{
> +	struct bu27008_data *data = iio_trigger_get_drvdata(trig);
> +	int ret = 0;

No need to initialize ret.

> +
> +	if (state)
> +		ret = bu27008_set_drdy_irq(data, BU27008_INT_EN);
> +	else
> +		ret = bu27008_set_drdy_irq(data, BU27008_INT_DIS);
> +	if (ret)
> +		dev_err(data->dev, "Failed to set trigger state\n");
> +
> +	return ret;
> +}
> +
> +static void bu27008_trigger_reenable(struct iio_trigger *trig)
> +{
> +	struct bu27008_data *data = iio_trigger_get_drvdata(trig);
> +
> +	enable_irq(data->irq);
> +}


> +static irqreturn_t bu27008_data_rdy_poll(int irq, void *private)
> +{
> +	/*
> +	 * The BU27008 keeps IRQ asserted until we read the VALID bit from
> +	 * a register. We need to keep the IRQ disabled until this

Half sentence.   If this is all that comes up I'll change it to.

We need to keep the IRQ disable until then.

> +	 */
> +	disable_irq_nosync(irq);
> +	iio_trigger_poll(private);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bu27008_setup_trigger(struct bu27008_data *data, struct iio_dev *idev)
> +{
> +	struct iio_trigger *itrig;
> +	char *name;
> +	int ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
> +					      &iio_pollfunc_store_time,
> +					      bu27008_trigger_handler,
> +					      &bu27008_buffer_ops);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +			     "iio_triggered_buffer_setup_ext FAIL\n");
> +
> +	itrig = devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d",
> +				       idev->name, iio_device_id(idev));
> +	if (!itrig)
> +		return -ENOMEM;
> +
> +	data->trig = itrig;
> +
> +	itrig->ops = &bu27008_trigger_ops;
> +	iio_trigger_set_drvdata(itrig, data);
> +
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bu27008",
> +			      dev_name(data->dev));
> +
> +	ret = devm_request_irq(data->dev, data->irq,
> +			       &bu27008_data_rdy_poll,
> +			       0, name, itrig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> +
> +	ret = devm_iio_trigger_register(data->dev, itrig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Trigger registration failed\n");
> +
> +	/* set default trigger */
> +	idev->trig = iio_trigger_get(itrig);
> +
> +	return 0;
> +}

