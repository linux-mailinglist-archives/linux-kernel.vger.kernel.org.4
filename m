Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5380564823B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLIMOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLIMOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:14:00 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BCF43848;
        Fri,  9 Dec 2022 04:13:57 -0800 (PST)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 279FB63F3C;
        Fri,  9 Dec 2022 13:13:55 +0100 (CET)
Date:   Fri, 9 Dec 2022 13:13:54 +0100
From:   Edmund Berenson <edmund.berenson@emlix.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dw: select SS0 when gpio cs is used
Message-ID: <20221209121354.fcpwh54khx4y5g7q@emlix.com>
References: <20221202094859.7869-1-edmund.berenson@emlix.com>
 <20221209114625.32ww2laxfr72uqnb@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209114625.32ww2laxfr72uqnb@mobilestation>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Fri, Dec 09, 2022 at 02:46:25PM +0300, Serge Semin wrote:
> Hello Edmund
> 
> On Fri, Dec 02, 2022 at 10:48:59AM +0100, Edmund Berenson wrote:
> > SER register contains only 4-bit bit-field for enabling 4 SPI chip selects.
> > If gpio cs are used the cs number may be >= 4. To ensure we do not write
> > outside of the valid area, we choose SS0 in case of gpio cs to start
> > spi transfer.
> 
> Next time please don't forget to add me to the whole series Cc-list. I
> am missing the patch #2 in my inbox.
> 
I am sorry, I probably made some mistake when sending the mail.
I forwarded you patch 2 as well.
> > 
> > Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> > Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> > Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> > ---
> >  drivers/spi/spi-dw-core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index 99edddf9958b..57c9e384d6d4 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -94,6 +94,10 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
> >  {
> >  	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
> >  	bool cs_high = !!(spi->mode & SPI_CS_HIGH);
> > +	u8 enable_cs = 0;
> > +
> > +	if (!spi->cs_gpiod)
> > +		enable_cs = spi->chip_select;
> >  
> >  	/*
> >  	 * DW SPI controller demands any native CS being set in order to
> > @@ -103,7 +107,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
> >  	 * support active-high or active-low CS level.
> >  	 */
> >  	if (cs_high == enable)
> 
> > -		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
> > +		dw_writel(dws, DW_SPI_SER, BIT(enable_cs));
> 
> No, it's not that easy. By applying this patch we'll get a regression
> for the platforms which make use of both the GPIO-based and native
> chip-selects. Consider the next platform setup:
>  +--------------+
>  | SoC X        |
>  |              |    +-------------+
>  |   DW SSI CS0-+----+ SPI-slave 0 |
>  |              |    +-------------+
>  |              |    +-------------+
>  |        GPIOn-+----+ SPI-slave 1 |
>  |              |    +-------------+
>  +--------------+
> 
> If we apply this patch then the communications targeted to the
> SPI-slave 1 will also reach the SPI-slave 0 device, which isn't what
> we'd want.
> 
> That's why currently the DW SSI driver activates the native CS line
> with the corresponding ID irrespective whether it is a GPIO-based
> CS or a native one.
Okay that is actually true... but we will have to guard against CS>4 as only two
bits are reserved for cs in the register.
If both gpio and native cs are used at least one native cs
has to be empty otherwise we will have at least one double activation.
I am not sure if there is a "clean" way to determine which native cs is unused
inside the driver. Do you think it would be an acceptable workaround to
add an entry to the device tree like native-gpio cs?
> 
> -Serge(y)
> 
> >  	else
> >  		dw_writel(dws, DW_SPI_SER, 0);
> >  }
> > -- 
> > 2.37.4
> > 
