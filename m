Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D6649E88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiLLMRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiLLMRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:17:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D01D4C;
        Mon, 12 Dec 2022 04:17:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf42so18259896lfb.1;
        Mon, 12 Dec 2022 04:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLoVQdA43+DAdLnOXjusrfGfaOuKpLXuC0KL/7/HUtg=;
        b=bDB0NPkQZdALht8DdxM4T7Baja7XRm9jOcFTq48a2qzmRngDoCI1a+Q6n5GYZiEOSC
         GIeoAnk5SUS5Wv1OOcLA+lHlR8cCWOLDGAANgKO3XAFhiqaCJAhZf/w06TqIOzDVBlw+
         /tWyW0ZabTn9zMJjeunhgq0CGWBV6tJbpMw4ybR0P/RHalLDwQvmo2dyJsU0DiL7HJqn
         bG4ZS+n1Qe9d277e1MfrBYPYF38NNuvV9FaOIj5V1lvyiM1kGqwV948xjDgOTYkv8eW5
         qoLr2uvUMm1El/nC9r/96yhstN51b83vqiH3zuryeQ5qeqndiV6EoxEONqufFK1RYblq
         +ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLoVQdA43+DAdLnOXjusrfGfaOuKpLXuC0KL/7/HUtg=;
        b=dcm19Xg7/wXXZNxwNMpmLXXKDu35BsUkZJFmxM82lEva+LefTzgLxmCDKIJqcmriu7
         2xhQDs8V7Gqhu69miQVbFHMDxT+lgpku9sx4cgJ+n4q91oxRnxzZnW7fPIcmzgjY7O0f
         AA5MM9M27l6k6sd1cczZWWiYkVfDJL3CJlPJHYGdL5FwbF+8QLSdi5d1Vsky4Ft1amuu
         JUlPt4hf4aYb/e6Y4AKJQi/m7Muh+q8+caPDGZYCsCootxICNnJ26iVwzL6HSWmjE62f
         lL6fFgFQqoRkdqaqygBxpOx0pUGyj5MpbiOR5Tzxj+h1cd15TWuTSd7HYV4a84V1OR8+
         iX4w==
X-Gm-Message-State: ANoB5pmayy8LKSFGOg/1BhS/3ycPTxIB6EmsNVZmco+rGyEXm6NKHBS4
        br6rNmH3mZdcGsN09WB7pps=
X-Google-Smtp-Source: AA0mqf7srrqLiokCn07h7tnuEgkMDFOQrdo9vI7b4FR3FOOkfExlDf/xLDw1nFhxJvi2+werjdCpPA==
X-Received: by 2002:a05:6512:750:b0:4a4:68b7:d649 with SMTP id c16-20020a056512075000b004a468b7d649mr3548078lfs.48.1670847421751;
        Mon, 12 Dec 2022 04:17:01 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u9-20020ac25bc9000000b004b561202ea2sm1630017lfn.182.2022.12.12.04.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:17:01 -0800 (PST)
Date:   Mon, 12 Dec 2022 15:16:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dw: select SS0 when gpio cs is used
Message-ID: <20221212121659.cc3ts54ztwmmzwol@mobilestation>
References: <20221202094859.7869-1-edmund.berenson@emlix.com>
 <20221209114625.32ww2laxfr72uqnb@mobilestation>
 <20221209121354.fcpwh54khx4y5g7q@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209121354.fcpwh54khx4y5g7q@emlix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 01:13:54PM +0100, Edmund Berenson wrote:
> Hi Serge,
> 
> On Fri, Dec 09, 2022 at 02:46:25PM +0300, Serge Semin wrote:
> > Hello Edmund
> > 
> > On Fri, Dec 02, 2022 at 10:48:59AM +0100, Edmund Berenson wrote:
> > > SER register contains only 4-bit bit-field for enabling 4 SPI chip selects.
> > > If gpio cs are used the cs number may be >= 4. To ensure we do not write
> > > outside of the valid area, we choose SS0 in case of gpio cs to start
> > > spi transfer.
> > 
> > Next time please don't forget to add me to the whole series Cc-list. I
> > am missing the patch #2 in my inbox.
> > 
> I am sorry, I probably made some mistake when sending the mail.
> I forwarded you patch 2 as well.
> > > 
> > > Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> > > Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> > > Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> > > ---
> > >  drivers/spi/spi-dw-core.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > index 99edddf9958b..57c9e384d6d4 100644
> > > --- a/drivers/spi/spi-dw-core.c
> > > +++ b/drivers/spi/spi-dw-core.c
> > > @@ -94,6 +94,10 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
> > >  {
> > >  	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
> > >  	bool cs_high = !!(spi->mode & SPI_CS_HIGH);
> > > +	u8 enable_cs = 0;
> > > +
> > > +	if (!spi->cs_gpiod)
> > > +		enable_cs = spi->chip_select;
> > >  
> > >  	/*
> > >  	 * DW SPI controller demands any native CS being set in order to
> > > @@ -103,7 +107,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
> > >  	 * support active-high or active-low CS level.
> > >  	 */
> > >  	if (cs_high == enable)
> > 
> > > -		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
> > > +		dw_writel(dws, DW_SPI_SER, BIT(enable_cs));
> > 
> > No, it's not that easy. By applying this patch we'll get a regression
> > for the platforms which make use of both the GPIO-based and native
> > chip-selects. Consider the next platform setup:
> >  +--------------+
> >  | SoC X        |
> >  |              |    +-------------+
> >  |   DW SSI CS0-+----+ SPI-slave 0 |
> >  |              |    +-------------+
> >  |              |    +-------------+
> >  |        GPIOn-+----+ SPI-slave 1 |
> >  |              |    +-------------+
> >  +--------------+
> > 
> > If we apply this patch then the communications targeted to the
> > SPI-slave 1 will also reach the SPI-slave 0 device, which isn't what
> > we'd want.
> > 
> > That's why currently the DW SSI driver activates the native CS line
> > with the corresponding ID irrespective whether it is a GPIO-based
> > CS or a native one.

> Okay that is actually true... but we will have to guard against CS>4 as only two
> bits are reserved for cs in the register.

Firstly note that DW SSI can be synthesized with having up to 16
slaves. The number of available native chip-selects is normally
defined by the "num-cs" DT-property. (Though the DT-bindings
incorrectly set the upper limit to 4 slaves only.)

Secondly if you want to have a sanity check of the specific slave ID
then I'd suggest to use the dw_spi_setup() method for that. Just add
the conditional statement like "if (spi->chip_select >= dws->num_cs)
return -EINVAL" in there. Note this modification will solidify the
semantic of having less than num_cs chip-selects.

Thirdly also note the number of native chip-selects is auto-detectable
by writing FFs to the SER register. So we can avoid defaulting the
num_cs to 4 in the spi-dw-mmio.c driver and try to auto-detect the
number of chip-selects (the dw_spi_hw_init() method is the best
candidate for that procedure), if no "num-cs" property was specified.

> If both gpio and native cs are used at least one native cs
> has to be empty otherwise we will have at least one double activation.
> I am not sure if there is a "clean" way to determine which native cs is unused
> inside the driver. Do you think it would be an acceptable workaround to
> add an entry to the device tree like native-gpio cs?

Currently the DW SSI driver implies having a native CS behind each
GPIO-based chip-select. It is used to activate the communications.
That semantic is implicitly advertised to the SPI subsystem core by
setting the SPI_MASTER_GPIO_SS flag.

Before thinking of a best way to implement what you suggest I need to
ask: Do you really need to have the extended number of CSs support? Do
you have any practical need in that? If you don't, then I would
suggest to leave things as is. (The suggested sanity check might be
useful though.) If you do, then we'll need to come up with a algo,
which would imply detecting the GPIO-based chip-selects in the
controller probe procedure and using one of their native counterpart
(for instance the very last one or very first one) to activate either
all the GPIO-based CS transfer exceeding the number of available
native chip-selects, or just all the GPIO-based communications.

-Serge(y)

> > 
> > -Serge(y)
> > 
> > >  	else
> > >  		dw_writel(dws, DW_SPI_SER, 0);
> > >  }
> > > -- 
> > > 2.37.4
> > > 
