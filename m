Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A16611907
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiJ1RNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJ1RN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:13:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5BD768CFE;
        Fri, 28 Oct 2022 10:12:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8A121FB;
        Fri, 28 Oct 2022 10:12:24 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A29C93F703;
        Fri, 28 Oct 2022 10:12:17 -0700 (PDT)
Date:   Fri, 28 Oct 2022 18:12:11 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 7/8] hwmon: (scmi) Register explicitly with Thermal
 Framework
Message-ID: <Y1wNWFmTi8O84rTA@e120937-lin>
References: <20221028140833.280091-1-cristian.marussi@arm.com>
 <20221028140833.280091-7-cristian.marussi@arm.com>
 <b914ea25-a9a8-f443-2ba0-615bdd6cc04f@roeck-us.net>
 <Y1v2ozURFdIk1PfU@e120937-lin>
 <e4040686-851c-d8b0-b274-ac71d38685e1@roeck-us.net>
 <Y1wAHyV/tLKQmo7l@e120937-lin>
 <7acc7a49-debb-abdb-f01c-f8adef4c1f0e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7acc7a49-debb-abdb-f01c-f8adef4c1f0e@roeck-us.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:34:05AM -0700, Guenter Roeck wrote:
> On 10/28/22 09:15, Cristian Marussi wrote:
> > On Fri, Oct 28, 2022 at 08:58:58AM -0700, Guenter Roeck wrote:
> > > On 10/28/22 08:35, Cristian Marussi wrote:
> > > [ ... ]
> > > > > > +	/*
> > > > > > +	 * Try to register a temperature sensor with the Thermal Framework:
> > > > > > +	 * skip sensors not defined as part of any thermal zone (-ENODEV) but
> > > > > > +	 * report any other errors related to misconfigured zones/sensors.
> > > > > > +	 */
> > > > > > +	tzd = devm_thermal_of_zone_register(dev, th_sensor->info->id, th_sensor,
> > > > > > +					    &scmi_hwmon_thermal_ops);
> > > > > > +	if (IS_ERR(tzd)) {
> > > > > > +		devm_kfree(dev, th_sensor);
> > > > > > +
> > > > > > +		if (PTR_ERR(tzd) != -ENODEV)
> > > > > > +			return PTR_ERR(tzd);
> > > > > > +
> > > > > > +		dev_info(dev, "Sensor '%s' not attached to any thermal zone.\n",
> > > > > > +			 sensor->name);
> > > > > 
> > > > > There were complaints about this message as it is noisy. If you send
> > > > > another version, please drop it unless attaching each sensor to a thermal
> > > > > zone is strongly expected. If you don't send another version, I'll drop it
> > > > > while applying.
> > > > > 
> > > > 
> > > > Ok fine for me. I am waiting to have some feedback from Sudeep too, but
> > > > I do not have plan for another version as of now.
> > > > 
> > > > As a side note, though, I understand the 'noisiness' argument, but,
> > > > sincerely this same message in the original HWMON code was the only
> > > > reason why I spotted that something was wrong with the SCMI/HWMON
> > > > interactions and discovered the indexes/ids mismatch...if not for
> > > > that it would have gone un-noticed that a perfectly configured
> > > > ThermalZone/Sensor was not working properly...
> > > > (un-noticed at least until something would have been burnt to fire
> > > >    in my house .. joking :P)
> > > > 
> > > 
> > > Good point.
> > > 
> > > Did you ever check the returned error code ? Maybe we could use it to
> > > distinguish "it is not attached to a thermal zone because it is not
> > > associated with one" from "attaching to a thermal zone failed because
> > > its configuration is bad/incomplete".
> > > 
> > 
> > Yes, it is what I do already indeed, in this regards I mimicked what
> > the hwmon-thermal bridge was doing.
> > 
> > In scmi_thermal_sensor_register() this message is printed out only
> > if Thermal registration returned -ENODEV and no err is reported
> > (which means teh specified sensor was not found attached to any TZ),
> > while in the caller of scmi_thermal_sensor_register() for any error
> > returned but -ENOMEM I print:
> > 
> > 	"Thermal zone misconfigured for %s. err=%d\n",
> > 
> > since any error reported by Thermal other than ENODEV and ENOMEM
> > means the DT parsing unveiled some configuration anomaly.
> > 
> 
> Ok, then let's hope that this finds misconfigurations and drop the
> info message.

The mismatch of indexes at hand won't be catched being reported by
Thermal as misconfig but just as not found ENODEV.

Anyway it is fine for me to drop the message.

> 
> I just noticed another problem in your code:
> 
> +		if (ret == -ENOMEM)
> +			return ret;
> +		else if (ret)
> +			dev_warn(dev,
> +				 "Thermal zone misconfigured for %s. err=%d\n",
> +				 sensor->name, ret);
> 
> Static analyzers will rightfully notice that else after return is unnecessary.
> Please rewrite and drop the else. I think something like
> 

Ah yes...my bad.

> 		if (ret) {
> 			if (ret == -ENOMEM)
> 				return ret;
> 			dev_warn(dev,
> 				 "Thermal zone misconfigured for %s. err=%d\n",
> 				 sensor->name, ret);
> 		}
> 
> would be better since ret would only be evaluated once in the no-error case.
> 

I'll resend this one with the fix and the dropped message.

Thanks,
Cristian

