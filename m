Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CCE6F328A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjEAPJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjEAPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D6F19A4;
        Mon,  1 May 2023 08:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CBC361DA3;
        Mon,  1 May 2023 15:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2769C433D2;
        Mon,  1 May 2023 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682953752;
        bh=cUsOqfxkIZKyqqJ02ZRf0fbQ0VVSONKVBQcffytJjtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LXsZT+m4RC1Wkzi4gGg7dhvNreN88Pqydx70S7nVYE3En1YazI1UXgrbDB/acgko4
         WdN0xFED3fL+1lqYjoNtpiWvpUkQHn0dNcr5Tiw7hziaTknpfeok8+ybqMSuDk83Sd
         D28ffSMdMstVcNMKRxmI5eeyRFOrp3EZhxj7ZMV+8YcjLMz6ursQFkWzgde7DSGk0+
         hURXmbJ6WJQSwV6dNCtmIFgI+DG/+9sVVEDGOxvPoDA4KmzUD/aQhENlLfkIB+k9z9
         aKemwGil86e9cGRezdqtMUWqZVbY0VyyvpxZHHfK1vCGk883WzoXbnogrMeBOyXKV/
         jwuPst3iBBYhg==
Date:   Mon, 1 May 2023 16:24:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 4/4] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230501162456.3448c494@jic23-huawei>
In-Reply-To: <20230424125216.0f279f82@bootlin.com>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
        <20230421124122.324820-5-herve.codina@bootlin.com>
        <20230422180814.61d24aa3@jic23-huawei>
        <20230424125216.0f279f82@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >   
> > > +static int simple_iio_aux_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	struct simple_iio_aux_chan *iio_aux_chan;
> > > +	struct simple_iio_aux *iio_aux;
> > > +	int count;
> > > +	u32 tmp;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	iio_aux = devm_kzalloc(&pdev->dev, sizeof(*iio_aux), GFP_KERNEL);
> > > +	if (!iio_aux)
> > > +		return -ENOMEM;
> > > +
> > > +	iio_aux->dev = &pdev->dev;
> > > +
> > > +	count = of_property_count_strings(np, "io-channel-names");
> > > +	if (count < 0) {
> > > +		dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names\n", np);
> > > +		return count;
> > > +	}
> > > +
> > > +	iio_aux->chans = devm_kmalloc_array(&pdev->dev, count,
> > > +					    sizeof(*iio_aux->chans), GFP_KERNEL);
> > > +	if (!iio_aux->chans)
> > > +		return -ENOMEM;
> > > +	iio_aux->num_chans = count;
> > > +
> > > +	for (i = 0; i < iio_aux->num_chans; i++) {
> > > +		iio_aux_chan = iio_aux->chans + i;
> > > +
> > > +		ret = of_property_read_string_index(np, "io-channel-names", i,
> > > +						    &iio_aux_chan->name);    
> > 
> > Whilst today this will be tightly couple with of, if you can use generic firmware
> > handling where possible (from linux/property.h) it will reduce what needs
> > to be tidied up if anyone fills in the gaps for IIO consumer bindings in ACPI
> > and then someone uses PRP0001 based ACPI bindings.  
> 
> No device_property_read_*() function family are available to get a value
> from an array using an index.

That feels like it might be a feature gap in the generic property handling that
should be solved.  Emtirely reasonable not to do it in this series however!



> 
> I would prefer to keep the of_property_read_*() function family I use for this
> first IIO auxiliary device support.
> 
> >   
> > > +		if (ret < 0) {
> > > +			dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names[%d]\n", np, i);    
> > 
> > dev_err_probe() would simplify these cases a little.  Not sure on ASOC view on using
> > that for cases that won't defer.  I tend to take the view it's nicer everywhere
> > for calls in probe() functions.  
> 
> I have the feeling that ASoC uses dev_err_probe() for cases that can defer.
> Mark, can you confirm ?
> 

Left as needs an answer from Mark.

Jonathan



