Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B7C6F32BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjEAPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEAPUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A39D;
        Mon,  1 May 2023 08:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0BDD60F57;
        Mon,  1 May 2023 15:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683E0C433EF;
        Mon,  1 May 2023 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682954436;
        bh=cXKx8RHLfWUL+DcWZDzIKJ2jk/FY5c2pwahXmdny2Gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nkvOUfde2tNSTHI+ibNL3QEV+eC8UCOlGBVkR0/xNaBj6oj3DTobvAah+oqDmArCP
         nrKq95J8NwXyFDvHS5nc6C9cdgzssZiv8PUhK0dNhDs4ksDyCA8IIdVcsx50HKHk6F
         MB2VKyceLVayBTP7mV/IZx8oR1VnOcFpVzzdcnBDtbB59kQAyR4ugpNUvF/1bVR9tR
         v7ML4lcVO473iKfrfDFdATMtd+f03cnjJ3sAbfSgn6whZrAuLauZLiY3/im2HzGwGP
         aBQxuzDX/mvop35k76kLSuwEBYJvpNtU+cEOzAieIe6AbfOEFro9bYB7EJJzklDDAz
         braydZW30U9lQ==
Date:   Mon, 1 May 2023 16:36:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: light: ROHM BU27008 color sensor
Message-ID: <20230501163621.52c311b8@jic23-huawei>
In-Reply-To: <e47b367f-717b-387e-2d6a-40c998795440@gmail.com>
References: <cover.1682067567.git.mazziesaccount@gmail.com>
        <28ace0e26267df5618fbd23625425292391ad7f0.1682067567.git.mazziesaccount@gmail.com>
        <20230423135706.008206da@jic23-huawei>
        <e47b367f-717b-387e-2d6a-40c998795440@gmail.com>
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

On Mon, 24 Apr 2023 13:14:56 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 4/23/23 15:57, Jonathan Cameron wrote:
> > On Fri, 21 Apr 2023 12:39:36 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> >> and IR) with four configurable channels. Red and green being always
> >> available and two out of the rest three (blue, clear, IR) can be
> >> selected to be simultaneously measured. Typical application is adjusting
> >> LCD backlight of TVs, mobile phones and tablet PCs.
> >>
> >> Add initial support for the ROHM BU27008 color sensor.
> >>   - raw_read() of RGB and clear channels
> >>   - triggered buffer w/ DRDY interrtupt
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> +
> >> +static int bu27008_meas_set(struct bu27008_data *data, bool enable)
> >> +{
> >> +	if (enable)
> >> +		return regmap_set_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> >> +				       BU27008_MASK_MEAS_EN);
> >> +
> >> +	return regmap_clear_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> >> +				 BU27008_MASK_MEAS_EN);  
> > 
> > Might be cleaner with regmap_update_bits()
> >   
> >> +}  
> 
> Hm. I need to disagree on this although I think it depends on what one 
> is used to :)
> 
> For me adding a variable for value to be used is slightly more complex 
> than just using clear or set function depending on the enable/disable. I 
> remember thinking the same as you and preferring the update_bits also on 
> enable/disable cases - until I wrote my first power-supply driver and 
> Sebasian Reichel told me to not do:
> 
> int val;
> 
> if (foo)
> 	val = mask;
> else
> 	val = 0;
> 
> return regmap_update_bits(regmap, reg, mask, val);
> 
> but use set/clear bits. This allows killing the 'int val;'. I remember I 
> had to sleep over night on it but I later started seeing the set/clear 
> bits as a simpler thing.
> 
> Sure we could also do
> 
> if (foo)
> 	return regmap_update_bits(map, reg, mask, mask);
> else
> 	return regmap_update_bits(map, reg, mask, 0);
> 
> - but here we just replace:
> 
> regmap_set_bits(map, reg, mask) with
> regmap_update_bits(map, reg, mask, mask)
> 
> and
> 
> regmap_clear_bits(map, reg, mask)
> regmap_update_bits(map, reg, mask, 0)
> 
> with longer but functionally same variants - which kind of says "I think 
> the "regmap_set_bits() and regmap_clear_bits()" are useless ;)
> 
> After saying this - I can use the regmap_update_bits() if you insist, 
> but in my (not always so) humble opinion this does not improve the function.

Makes sense.  Leave it as it stands.


> 
> 
> >> +
> >> +static int bu27008_set_drdy_irq(struct bu27008_data *data, bool state)
> >> +{
> >> +	if (state)
> >> +		return regmap_set_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> >> +					BU27008_MASK_INT_EN);
> >> +	return regmap_clear_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> >> +				 BU27008_MASK_INT_EN);  
> > regmap_update_bits() maybe with the mask and value supplied.  
> 
> Same weak objection here as was with the bu27008_meas_set(). Eg, can 
> change if required but please reconsider :)
Sure. Was a 'maybe' :)

> 
> >> +}
> >> +  


> >> +
> >> +static irqreturn_t bu27008_irq_thread_handler(int irq, void *private)
> >> +{
> >> +	struct iio_dev *idev = private;
> >> +	struct bu27008_data *data = iio_priv(idev);
> >> +	irqreturn_t ret = IRQ_NONE;
> >> +
> >> +	mutex_lock(&data->mutex);
> >> +	if (data->trigger_enabled) {
> >> +		iio_trigger_poll_nested(data->trig);  
> > 
> > Add a comment here on why it makes sense to hold the mutex whilst
> > calling this.  
> 
> After revising this - I don't think it makes. Nor do I think we need the 
> trigger_enable flag so we don't propably need the mutex in buffer enable 
> either as all raw-write configs are claiming the direct mode.

Clearing this out meant I noticed the oddity of doing this in the thread
at all.  So all good in the end ;)

Jonathan
