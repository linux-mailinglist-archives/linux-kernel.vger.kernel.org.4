Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A044F737A87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 07:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjFUFHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjFUFHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674DB4;
        Tue, 20 Jun 2023 22:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF8961472;
        Wed, 21 Jun 2023 05:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3606C433C9;
        Wed, 21 Jun 2023 05:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687324012;
        bh=466ny7ZdGjJiia1iDVnrT67B4C+6fygPr1B75zITi6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCVnTSHD7yl7ERA4Xe8Ii7X4xpCbCMY5FzVPhNbzzG2jUK6YbzckIzg2ECIxLuwhQ
         Cma6VM0cAOpeX8fGhNilnefdVBP4OT3qPqEqGqgGmRKoq556gUHLXaBV35lovdCJ13
         YijFI4GuQhtkVFL/JhctTAEvu/xZhcxzckNcWKdXkrlyQ5a2F1TEREgCqrJu21cwPt
         ZP2jqdDA4YHrOTNpAAAfsfZH4cVv0Z2l+a9DS91P79BwMaS4tj9CLk+D/oXJ4iDRhB
         WAa/vlnNKBxMxO8OAc+f0Dg3Fp+00b3WL57sZytF//bJxRGdBusmSb4WnLLayWbCpa
         Uzk4HB7j34Cxg==
Date:   Tue, 20 Jun 2023 22:06:50 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:17:51AM +0200, Daniel Lezcano wrote:
> 
> 
> 
> Hi Eduardo,
> 
> On 08/06/2023 19:44, Eduardo Valentin wrote:
> 
> [ ... ]
> 
> > > Do you have a use case with some measurements to spot an issue or is it
> > > a potential issue you identified ?
> > 
> > 
> > yes, a governor that is using I2C device as input, behind I2C fast mode (100KHz)
> > and needs to update the zone every 100ms. Each read in this bus, if done alone
> > would be around 500us, takes 10bytes to read the device, it is 10 clocks per byte,
> > well technically 9, but rounding for the sake of the example, which gets you
> > 50 / 100KHz = 500 us. That is for a single read. You add one single extra
> > userspace read triggering an unused device update, that is already a 1ms drift.
> > Basically you looking at 0.5% for each extra userspace read competing in this
> > sysfs node. You add extra devices in the same I2C bus, your governor is looking
> > at more than 1% overhead. And I am talking also about a main CPU of ~800MHz.
> > I did not even include the lock overhead considered for this CPU ;-)
> > 
> > Again, this is not about controlling the DIE temperature of the CPU you
> > are running the thermal subsystem. This is about controlling
> > a target device.
> 
> Ok. The target device is on a bus which is slow and prone to contention.
> 
> This hardware is not designed to be monitored with a high precision, so
> reading the temperature at a high rate does not really make sense.

On the contrary, it needs even more precision and any extra delay adds to
loss on accuracy :-)

> 
> Moreover (putting apart a potential contention), the delayed read does
> not change the time interval, which remains the same from the governor
> point of view.

It does not change the governor update interval and that is a property of
the thermal zone. Correct. And that is the intention of the change.
The actual temperature updates driven by the governor will always
result in a driver call. While a userspace call will not be in the way
of the governor update.

Sysfs reads, However, with the current code as is, it may cause
jittering on the actual execution of the governor throttle function.
 causing the computation of the desired outcome cooling device being skewed.

> 
> In addition, i2c sensors are usually handled in the hwmon subsystem
> which are registered in the thermal framework from there. Those have
> most of their 'read' callback with a cached value in a jiffies based way
> eg. [1].

I guess what you are really saying is: go read the hwmon sysfs node,
or, hwmon solves this for us, which unfortunately is not true for all devices.


> 
> So the feature already exists for slow devices and are handled in the
> drivers directly via the hwmon subsystem.
> 
> From my POV, the feature is not needed in the thermal framework.

The fact that hwmon does it in some way is another evidence of the
actual problem. Telling that this has to be solved by another subsystem
for a sysfs node that is part of thermal subsystem does not really solve
the problem. Also as I mentioned, this is not common on all hwmon
devices, and not all I2C devices are hwmon devices. In fact, I2C
was just one example of a slow device. There are more I can quote
that are not necessarily under the hwmon case.


Not sure if you missed, but an alternative for the difference of
opinion on how this should behave is to have caching for response
of sysfs read of tz/temp  as an option/configuration. Then we let
userspace to choose which behavior it wants.

> 
> 
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/hwmon/lm95234.c#n163
> 
> 
> 
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
All the best,
Eduardo Valentin
