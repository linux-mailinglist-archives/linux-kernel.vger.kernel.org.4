Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B0367EA05
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjA0Pvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjA0Pv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:51:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D694A86256;
        Fri, 27 Jan 2023 07:51:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F837B807E4;
        Fri, 27 Jan 2023 15:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251D1C433D2;
        Fri, 27 Jan 2023 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674834679;
        bh=IW0tQWKLcqGw/S8oUUD4S9kO5J98FlyPY+T0QPayjA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbKKnT47GjJgGQ2zTPOlDLQzTBtmr4ssjQW5toFrQRmIzH/Fp5a0Z6AS02AOblo6I
         qL5ixqPPPH3REnkLr/70L8Nh00Rngb955FHGNFqr0TwMX4ieJ4zN9PH4OTMUQaZbiG
         mhV6JXayl88dgGsz0ySJv4zffOrHz9VpRU4rSaTu+pQJ5xl5yvXOG+Q63GhilkMwAj
         7gOF3Q0EcbIjhJN28oDE/E6B56muhAeE78MYPfjHszKrVKqJgEYwK1BGaNootP+gbz
         LpG6xlKeO/L/ULzDne2dVCPUVOwUbxtoNEA7SlVzmnYFIFF0X+kX2kAtKyISePQ+81
         EicuRx2osBbHg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pLR0h-0001Nw-RU; Fri, 27 Jan 2023 16:51:28 +0100
Date:   Fri, 27 Jan 2023 16:51:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/24] rtc: pm8xxx: add support for nvmem offset
Message-ID: <Y9Py/+GpI8x8ldDG@hovoldconsulting.com>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-17-johan+linaro@kernel.org>
 <Y9PpQkW3Rtm+bi2V@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9PpQkW3Rtm+bi2V@mail.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:09:54PM +0100, Alexandre Belloni wrote:
> On 26/01/2023 15:20:49+0100, Johan Hovold wrote:
> > On many Qualcomm platforms the PMIC RTC control and time registers are
> > read-only so that the RTC time can not be updated. Instead an offset
> > needs be stored in some machine-specific non-volatile memory, which the
> > driver can take into account.
> > 
> > Add support for storing a 32-bit offset from the Epoch in an nvmem cell
> > so that the RTC time can be set on such platforms.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/rtc/rtc-pm8xxx.c | 134 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 123 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> > index 922aef0f0241..09816b9f6282 100644
> > --- a/drivers/rtc/rtc-pm8xxx.c
> > +++ b/drivers/rtc/rtc-pm8xxx.c
> > @@ -3,6 +3,7 @@
> >   */
> >  #include <linux/of.h>
> >  #include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> >  #include <linux/init.h>
> >  #include <linux/rtc.h>
> >  #include <linux/platform_device.h>
> > @@ -49,6 +50,8 @@ struct pm8xxx_rtc_regs {
> >   * @alarm_irq:		alarm irq number
> >   * @regs:		register description
> >   * @dev:		device structure
> > + * @nvmem_cell:		nvmem cell for offset
> > + * @offset:		offset from epoch in seconds
> >   */
> >  struct pm8xxx_rtc {
> >  	struct rtc_device *rtc;
> > @@ -57,8 +60,60 @@ struct pm8xxx_rtc {
> >  	int alarm_irq;
> >  	const struct pm8xxx_rtc_regs *regs;
> >  	struct device *dev;
> > +	struct nvmem_cell *nvmem_cell;
> > +	u32 offset;
> >  };
> >  
> > +static int pm8xxx_rtc_read_nvmem_offset(struct pm8xxx_rtc *rtc_dd)
> > +{
> > +	size_t len;
> > +	void *buf;
> > +	int rc;
> > +
> > +	buf = nvmem_cell_read(rtc_dd->nvmem_cell, &len);
> > +	if (IS_ERR(buf)) {
> > +		rc = PTR_ERR(buf);
> > +		dev_err(rtc_dd->dev, "failed to read nvmem offset: %d\n", rc);
> 
> You removed many dev_err strings in your previous patch and now this is
> verbose. Honestly, there is not much to do apart from reying the
> operation so I don't think the strings are worth it.

There's a difference. The SPMI ones are basically equivalent to mmio
reads, which we also don't expect to fail (and other spmi drivers also
ignore them).

These nvmem error paths I actually hit during development and it could
help someone trying to enable this feature on a new platform.
 
> > +		return rc;
> > +	}
> > +
> > +	if (len != sizeof(u32)) {
> > +		dev_err(rtc_dd->dev, "unexpected nvmem cell size %zu\n", len);
> > +		kfree(buf);
> > +		return -EINVAL;
> > +	}
> > +
> > +	rtc_dd->offset = get_unaligned_le32(buf);
> > +
> > +	kfree(buf);
> > +
> > +	return 0;
> > +}

> > @@ -380,9 +478,23 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
> >  	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
> >  						      "allow-set-time");
> >  
> > +	rtc_dd->nvmem_cell = devm_nvmem_cell_get(&pdev->dev, "offset");
> 
> Maybe we should get something more specific than just "offset" so this
> could be parsed in the RTC core at some point (this is the second RTC to
> behave like this)

Yes, that thought crossed my mind, but it's an nvmem cell name (label)
and not a generic devicetree property. If you look at the binding
document I think the name makes sense given the current description, and
I'm not sure changing to something like 'base' would be much of an
improvement.

I also don't expect there to be more broken RTCs out there like these
ones. Hopefully Qualcomm will even get this fixed at some point
themselves.

And I assume you were think of the old Atmel driver which uses a timer
counter and a scratch register as a base? That one is also a bit
different in that the timer can be reset, just not set.

> > +	if (IS_ERR(rtc_dd->nvmem_cell)) {
> > +		rc = PTR_ERR(rtc_dd->nvmem_cell);
> > +		if (rc != -ENOENT)
> > +			return rc;
> > +		rtc_dd->nvmem_cell = NULL;
> > +	}

Johan
