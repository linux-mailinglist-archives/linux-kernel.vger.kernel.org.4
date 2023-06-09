Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B872A120
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjFIRUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjFIRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:20:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A84DC1;
        Fri,  9 Jun 2023 10:20:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qd79h1hjrz6J7PH;
        Sat, 10 Jun 2023 01:19:36 +0800 (CST)
Received: from localhost (10.126.170.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 9 Jun
 2023 18:20:02 +0100
Date:   Fri, 9 Jun 2023 18:19:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v5 0/5] Support ROHM BU27008 RGB sensor
Message-ID: <20230609181959.00007c82@Huawei.com>
In-Reply-To: <0173eb2b-b6a5-b90a-9740-7a65f806fabc@gmail.com>
References: <cover.1683541225.git.mazziesaccount@gmail.com>
        <0173eb2b-b6a5-b90a-9740-7a65f806fabc@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2023 15:46:21 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 5/8/23 13:30, Matti Vaittinen wrote:
> > Add support for ROHM BU27008 RGB sensor.
> > 
> > The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> > and IR) with four configurable channels. Red and green being always
> > available and two out of the rest three (blue, clear, IR) can be
> > selected to be simultaneously measured. Typical application is adjusting
> > LCD backlight of TVs, mobile phones and tablet PCs.
> > 
> > This series supports reading the RGBC and IR channels using IIO
> > framework. However, only two of the BC+IR can be enabled at the same
> > time. Series adds also support for scale and integration time
> > configuration, where scale consists of impact of both the integration
> > time and hardware gain. The gain and time support is backed by the newly
> > introduced IIO GTS helper. This series depends on GTS helper patches
> > added in BU27034 support series which is already merged in iio/togreg
> > which this series is based on.  
> 
> I started adding support for the BU27010 RGBC + flickering sensor to the 
> BU27008 driver. While at it, I wrote some test(s) which try using also 
> the 'insane' gain settings.
> 
> What I found out is that the scale setting for BU27008 is broken for 
> smallest scales: 0.007812500 0.003906250 0.001953125
> 
> Reason is the accuracy.
> 
> The GTS helpers were made to use NANO scale accuracy. 999999999 is still 
> fitting in an 32 bit integer after all :) This allows to handle greater 
> "total gains".
> 
> The IIO scale setting interface towards the drivers seems to crop the 
> val2 to micros (6 digits). This means that when user writes scale 
> 0.001953125 via sysfs - the driver will get val = 0, val2 = 1953. 
> Currently the BU27008 driver (and probably also the BU27035 which I have 
> not yet checked) will pass this value to GTS-helpers - which try to use 
> it in computations where scale is tried to be converted to gain + 
> integration time settings. This will fail because of rounding error this 
> leads to.
> 
> Regarding the BU27* drivers I see this bug as annoying rather than 
> urgent. Bug will appear only with the very smallest of scales - which 
> means gains of magnitude ~1000X with the longest integration times - and 
> as someone once said - 1000X gains sound pretty insane as errors will 
> probably get quite big... Still, this is a bug - and it bothers me :)
> 
> What comes to fixing this - my first thought regarding "the right thing 
> to do" would be improving the IIO scale setting accuracy. I wonder if 
> there has been some heavy reason(s) to only provide 6 digits of val2?

History...

> (I 
> haven't yet looked how IIO formats the val2 from user input so I may be 
> very ignorant here). For userland this fix should be relatively 
> invisible - the write of for example 0.001953125 is seemingly successful 
> from the user-space POV. IIO does not warn about the excess accuracy.

IIO_VAL_INTO_PLUS_NANO might solve this
and you'll need to provide the callback write_raw_get_fmt() if you aren't
already so that the conversion from string to val and val2 takes into
account that the driver expects val2 to be *10^-9


> 
> I am not saying this change would be risk-free. For sure there is an 
> application somewhere passing this kind of 'high accuracy' scale values 
> to sysfs. And it may be we have a driver which is going to have a hiccup 
> is such value is passed to it - but I'd argue the driver should be fixed 
> then. It's easier for a driver to drop the excess digits by a division - 
> than it is to generate the missing digits...
> 
> ...which leads us to the other potential way of papering over this 
> issue. We could go on defining a set of "magic scale values" in the 
> bu27008 driver, namely the 1953, 3906 and 7812 - and when these are used 
> as val2 just assume it means 001953125, 003906250 and 007812500 
> respectively. This would be quick and simple fix - but it would also 
> mean this is a driver specific hack.

It's common for drivers to round to nearest to allow for subtle differences
due to precision. That may make sense here.

> 
> Finally, we could dive into GTS helpers and drop the accuracy of those 
> to MIRCO scale instead of the NANO. If this was to be done it might be 
> best to change the BU27008 and BU27034 intensity channel scales to start 
> from bigger integers. Yes, it would potentially break any existing user 
> of those intensity channels - but I suspect the amount of such users is 
> still 0.
> 
> Finally, if we really want to keep the accuracy of scales in micros and 
> not support nanos, then we probably should adjust the available scales 
> displaying to not accept IIO_VAL_INT_PLUS_NANO type lists...

Given that I think you just need to have the driver tell the core it wants
IIO_VAL_INT_PLUS_NANO.  Problem still occurs, but several orders of magnitude
smaller.

But I may be miss understanding.

Jonathan


> 
> Yours,
> 	-- Matti
> 

