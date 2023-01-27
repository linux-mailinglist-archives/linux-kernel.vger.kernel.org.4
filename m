Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07567EA62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjA0QFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjA0QFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:05:46 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDC615C81;
        Fri, 27 Jan 2023 08:05:09 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 317F46000B;
        Fri, 27 Jan 2023 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674835508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7zrntNDIwCezhSXegjIg8tMDPXn7cU5lgN2JgyTsdA8=;
        b=RRmvKgmWobbQmzwBs1BeYI+0h79fFfjoLfaVpacvI5vXJscbDtBcPABNiqYBkzcb04uwsR
        JaWXRuhWyLCBzwvE+c1EUJq9ipifgkY6Ezc3ouhgledR/825JTjG5ctP5ASmXB18Y8du4o
        0/kfa8za+6c5UfbBGNmgnGxvHBD+knQKLjemzUBMZzG0fPVas0yxM9OUeQAC/Onn/M3Gvg
        muOSx2uwiNitLm6dXg45QVMM9fXZP6Ayu7q1SkHfZiZpm6Obmix3iLG0RHDVWk0Kn/yDTT
        4lYNfGjI8buSxOzrw3ag6Fl/q8u3CB9RkybvV0YhojQnwuckvuJ0JQWrcEyhrg==
Date:   Fri, 27 Jan 2023 17:05:03 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <Y9P2L9sNiHIZt3On@mail.local>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-17-johan+linaro@kernel.org>
 <Y9PpQkW3Rtm+bi2V@mail.local>
 <Y9Py/+GpI8x8ldDG@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Py/+GpI8x8ldDG@hovoldconsulting.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 16:51:27+0100, Johan Hovold wrote:
> > > +static int pm8xxx_rtc_read_nvmem_offset(struct pm8xxx_rtc *rtc_dd)
> > > +{
> > > +	size_t len;
> > > +	void *buf;
> > > +	int rc;
> > > +
> > > +	buf = nvmem_cell_read(rtc_dd->nvmem_cell, &len);
> > > +	if (IS_ERR(buf)) {
> > > +		rc = PTR_ERR(buf);
> > > +		dev_err(rtc_dd->dev, "failed to read nvmem offset: %d\n", rc);
> > 
> > You removed many dev_err strings in your previous patch and now this is
> > verbose. Honestly, there is not much to do apart from reying the
> > operation so I don't think the strings are worth it.
> 
> There's a difference. The SPMI ones are basically equivalent to mmio
> reads, which we also don't expect to fail (and other spmi drivers also
> ignore them).
> 
> These nvmem error paths I actually hit during development and it could
> help someone trying to enable this feature on a new platform.
>  

then consider using dev_dbg, the end user will never see or act on those
error messages anyway. I'm on a quest to cut down the number of strings
in the kernel, at least in the RTC subsystem ;)

> > > +		return rc;
> > > +	}
> > > +
> > > +	if (len != sizeof(u32)) {
> > > +		dev_err(rtc_dd->dev, "unexpected nvmem cell size %zu\n", len);
> > > +		kfree(buf);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	rtc_dd->offset = get_unaligned_le32(buf);
> > > +
> > > +	kfree(buf);
> > > +
> > > +	return 0;
> > > +}
> 
> > > @@ -380,9 +478,23 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
> > >  	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
> > >  						      "allow-set-time");
> > >  
> > > +	rtc_dd->nvmem_cell = devm_nvmem_cell_get(&pdev->dev, "offset");
> > 
> > Maybe we should get something more specific than just "offset" so this
> > could be parsed in the RTC core at some point (this is the second RTC to
> > behave like this)
> 
> Yes, that thought crossed my mind, but it's an nvmem cell name (label)
> and not a generic devicetree property. If you look at the binding
> document I think the name makes sense given the current description, and
> I'm not sure changing to something like 'base' would be much of an
> improvement.
> 
> I also don't expect there to be more broken RTCs out there like these
> ones. Hopefully Qualcomm will even get this fixed at some point
> themselves.
> 
> And I assume you were think of the old Atmel driver which uses a timer
> counter and a scratch register as a base? That one is also a bit
> different in that the timer can be reset, just not set.

Nope, I'm thinking about the gamecube one and probably the nintendo
switch one which seems to behave similarly (no driver in the kernel
though).

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
