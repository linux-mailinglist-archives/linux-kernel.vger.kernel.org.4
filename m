Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F349E68ED5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjBHKuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjBHKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:49:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260E4C1D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:49:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h3so8454431wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qNlDFjphkPPgSlyW73HkZzxJj0LeeYigCKsl5DJQD2k=;
        b=V/wcfAJ+B3ejXiP/uSfD0f3mlhtX/1eKti4YQCnFCRmy5WGaPxZsz0OgkhDFgCY66U
         aQX6i8F+uZYSeV0e+XsjV3WlV/FCr+ni1kkqGXJQof9zQBMk/oISjjw/ivyMzHqgyQF5
         GG+xw05IL+S1/ZCVXb4nmZ5+tII/YatsZ5EJp7cTqP4KKdffKSibJBfGz9j112dbv+9+
         J23e806jFvx0v2YOhyCIUHj4ti1J/gdjQVtGXWqW6hJ8bZMghCH24KmRRNi8yuYQdoGe
         SbQBGYVMt+eM4ENgjZZINBQBsQjLRt92JeGcPAFsKFhM1NqYoxw/ENqIYifvf7NdfzgO
         LWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNlDFjphkPPgSlyW73HkZzxJj0LeeYigCKsl5DJQD2k=;
        b=D9GLD/vc09EPtAGIt0VAfWss9PjQxyNjp1PYiqTonu34GAWuZJRGXXqxuX7v+ePXGs
         qjNNJ2QqnYFyfGaP1VnciCQG3yQOMEzP7EO7JUyOPLHBdI9E3/h5ZYub2njUd4YNZX77
         hM6KKFlRou/RTFKWR8zkpmOGEf1P/q7NuTLWujVJU1XfsD3MGRXFvIEin1Vk43jvkCYa
         ztachjIn/9XQyuN7ElmREfKGiuP6HHZVlzRin1wbvPSdx3pEiXjADGMOXpDqaPKFFyu/
         Y9KnvnQ3tGHc5Z2MnGrriynTD1nlIbNXZiAuu250zSu56Gm/QuMS/vbc8UHrl3L0I0dV
         qa2Q==
X-Gm-Message-State: AO0yUKW+qsoeMoeGDFa+XEe118CCPLBvN21leGtoOY0fZwrJkVKz/VrF
        b9RrtujL4DtOSOdtisk2+qjDlCb2AcWY8luB
X-Google-Smtp-Source: AK7set/92t5jngcZwgoLslgQdhy/znaaDjZlMsjVjgmpK0+lz/ifvwse2ofVCpN5DNO/mxKPv0asxA==
X-Received: by 2002:adf:e7ca:0:b0:2c4:489:fe93 with SMTP id e10-20020adfe7ca000000b002c40489fe93mr879939wrn.21.1675853362185;
        Wed, 08 Feb 2023 02:49:22 -0800 (PST)
Received: from linaro.org (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id p10-20020adff20a000000b002c4064f087esm23273wro.48.2023.02.08.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:49:21 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:49:19 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, lvjianmin@loongson.cn,
        wanghongliang@loongson.cn
Subject: Re: [PATCH v12 1/2] thermal: loongson-2: add thermal management
 support
Message-ID: <20230208104919.GA120053@linaro.org>
References: <20221114024709.7975-1-zhuyinbo@loongson.cn>
 <20230206135921.GA15176@linaro.org>
 <64d9782c-cafd-cdc3-3602-719c386d98cc@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64d9782c-cafd-cdc3-3602-719c386d98cc@loongson.cn>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:13:33AM +0800, zhuyinbo wrote:

[ ... ]

> > > +struct loongson2_thermal_data {
> > > +	struct thermal_zone_device *tzd;
> > 'tzd' won't be needed after taking into account the comments
> 
> The 'tzd' element is needed,  because the thermal_zone_device_update need
> pass a data->tzd element.
> 
> static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
> {
>         struct loongson2_thermal_data *data = dev;
> 
>         thermal_zone_device_update(data->tzd,
>                                    THERMAL_EVENT_UNSPECIFIED);
>         enable_irq(data->irq);
> 
>         return IRQ_HANDLED;
> }

After taking into account all the comments, enabled_irq() won't be
called, so 'data' won't be needed. 'tzd' will be passed to
devm_request_threaded_irq() instead of 'data'.

As loongson2_thermal_irq_thread() is the only place where 'tzd' is
needed and 'tzd' being local to the call site of
thermal_zone_device_register() and devm_request_threaded_irq(), there
is no need to store the pointer in the 'data' structure.

> > 
> > > +	int irq;
> > 'irq' won't be needed after taking into account the comments
> I will drop it.
> > > +	int id;
> > > +	void __iomem *regs;
> > > +	struct platform_device *pdev;
> > 'pdev' is not needed
> I will drop it.
> > 
> > > +	u16 ctrl_low_val;
> > > +	u16 ctrl_hi_val;
> > Those fields won't be needed after taking into account the comments
> I will drop it.
> > > +};
> > > +
> > > +static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> > > +					int low, int high, bool enable)
> > > +{
> > > +	u64 reg_ctrl = 0;
> > > +	int reg_off = data->id * 2;
> > > +
> > > +	if (low > high)
> > > +		return -EINVAL;
> > > +
> > > +	low = max(low, -100);
> > > +	high = min(high, 155);

Documentation says -40, 125

> > > +	low += 100;
> > > +	high += 100;
> > Why are those values added to the low and high ? Did you mean low += 0x100 ?
> > 
> > Mind to describe a bit the register layout?
> 
> node(cpu) temp = Thens0_out -100,
> 
> low and high is record node temp, so low and high need add '100' as
> Thens0_out.

If I refer to the documentation it is a raw value converted from
centigrade. The function has degree.

So it should be:

temp_deci = temp_milli / 10

raw = temp_to_raw(temp_deci);

-> temp_to_raw to be determined from temp = (raw * 731) / 0x4000 - 273

[ ... ]

> > > +static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> > > +{
> > > +	u32 reg_val;
> > > +	struct loongson2_thermal_data *data = tz->devdata;
> > > +
> > > +	reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);
> > > +	*temp = ((reg_val & 0xff) - 100) * 1000;
> > Why '-100' ?
> > 
> > Is the unit returned 'degrees' ?
> 
> node(cpu) temp = Thens0_out -100,
> 
> Here we need to get a node temp.

If I refer to the Loongson-3A5000 manual and assuming it is the right
one, the documentation says:

Temperature = Thens0_out * 731 / 0x4000 - 273

The unit is centigrade.

[ ... ]

> > > +	writeb(0xff, data->regs + LOONGSON2_TSENSOR_STATUS);
> > > +
> > > +	loongson2_thermal_set(data, 0, 0, false);
> > It would be nicer to use a reset line if it is available
> sorry, I don't get your meaning. Please describe more details about 'reset
> line'.

After a reset, the thermal controller should be in default state and the interrupt
flag cleared.

One example:

[1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/nvidia/tegra210.dtsi#n1560
[2] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/tegra/soctherm.c#n2169

Then search in the driver for:
     reset_control_assert(reset);
     reset_control_deassert(reset);


[ ... ]

Thanks

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
