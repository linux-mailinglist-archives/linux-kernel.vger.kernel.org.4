Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05821744D3B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGBK25 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Jul 2023 06:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGBK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:28:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DD91B0;
        Sun,  2 Jul 2023 03:28:53 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv4vP3zydz67GCQ;
        Sun,  2 Jul 2023 18:25:37 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 11:28:48 +0100
Date:   Sun, 2 Jul 2023 18:28:43 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <Marius.Cristea@microchip.com>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230702182843.000049b0@Huawei.com>
In-Reply-To: <6ab2ec4a9389bbcf9acfbf16291eef088908f1b8.camel@microchip.com>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
        <20230519160145.44208-3-marius.cristea@microchip.com>
        <20230520161509.4c704656@jic23-huawei>
        <6ab2ec4a9389bbcf9acfbf16291eef088908f1b8.camel@microchip.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 11:32:11 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi Jonathan,
> 
>    Please see my comments bellow.
> 
> Thanks,
> Marius
> 
> On Sat, 2023-05-20 at 16:15 +0100, Jonathan Cameron wrote:
> > > +
> > > +What:               
> > > /sys/bus/iio/devices/iio:deviceX/calibscale_available
> > > +KernelVersion:       6.4
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Reading returns a range with the possible values for
> > > the gain
> > > +             error digital calibration register.
> > > +
> > > +What:               
> > > /sys/bus/iio/devices/iio:deviceX/boost_current
> > > +KernelVersion:       6.4
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             This attribute is used to set the biasing circuit of
> > > the
> > > +             Delta-Sigma modulator. The different BOOST settings
> > > are applied
> > > +             to the entire modulator circuit, including the
> > > voltage reference
> > > +             buffers.
> > > +
> > > +What:               
> > > /sys/bus/iio/devices/iio:deviceX/boost_current_available
> > > +KernelVersion:       6.4
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Reading returns a list with the possible values for
> > > +             the current biasing circuit of the Delta-Sigma
> > > modulator.
> > > +
> > > +             "x0.5",   - ADC channel has current x 0.5  
> > 
> > Keep just numbers in the attr.  It should be named in a fashion that
> > makes it apparent that it's a multiplier, not an absolute current.
> > 
> > New ABI like this is best avoided if we can. I see from a quick
> > glance at the
> > datasheet that there is advice on controlling this to allow for
> > different
> > clock settings, but I'm not sure if that's a simple relationship or
> > not.
> > From
> > https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3461-2-4-Two-Four-Eight-Channel-153.6-ksps-Low-Noise-16-Bit-Delta-Sigma-ADC-Data-Sheet-20006180D.pdf
> > figures 2-20 onwards, it looks like this effectively trades off power
> > consumption
> > against max frequency, so maybe we could set it automatically?
> >   
> 
> Here being a trade off between power consumption and bandwidth I would
> like it to be somehow programmable and let the user to set it. Maybe
> the user wants to "monitor" a channel (have low power consumption) and
> other channels to be benefit from a larger bandwidth. It don't think it
> can be set automatically.

Hmm. Whilst it's certainly possible a user wants to do this sort of
mix the trade off against extra complexity of the interface (and hence
the chance that anyone actually uses it being reduced, makes me wonder
if it is worth while).  If you just configured this for all channels
then could be done automatically from sampling_frequency control which
is standard ABI.  

I don't really mind something custom if necessary though, but I find it very
unlikely that this particular interface generalizes long term as it's
a multiplier of 'something magic' - if we could make these actual
currents that would be better but I have no idea if we can.

> 
> >   
> > > +
> > > +             "x0.66",  - ADC channel has current x 0.66
> > > +
> > > +             "x1",     - ADC channel has current x 1 (default)
> > > +
> > > +             "x2"      - ADC channel has current x 2
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/current_bias  
> > 
> > Another bit of custom ABI with the normal problems of it being
> > unknown
> > to standard userspace software.  You could perhaps use an output
> > channel for
> > this and just treat it like a current DAC, with a label that makes
> > it's relationship
> > to the inputs obvious.  
> 
> 
> I could use an output channel to setup the current. Is it OK to have
> both ADC and "DAC" functionality in "iio/adc"?

Yes. That's fine if it's primarily an ADC - I think we have some
existing examples (definitely do in other classes of sensor, but maybe
not ADCs).

> 

> > > +
> > > +What:               
> > > /sys/bus/iio/devices/iio:deviceX/enable_auto_zeroing_mux
> > > +KernelVersion:       6.4
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             This attribute is used to enable the analog input
> > > multiplexer
> > > +             auto-zeroing algorithm. Write '1' to enable it, write
> > > '0' to
> > > +             disable it.  
> > If you can explain what auto zeroing is that would be great. It's not
> > something
> > I recall seeing in other drivers.  
> 
> I will add this description:
>        "This attribute is used to enable the chopping algorithm for the
> internal voltage reference buffer. This setting has no effect
> when external voltage reference is selected.

Don't present it when that's the case an no need to talk about it
in this description as a result.

> Internal voltage reference buffer injects a certain quantity of
> 1/f noise into the system that can be modulated with the
> incoming input signals and can limit the SNR performance at
> higher Oversampling Ratio values (over 256). To overcome this
> limitation, the buffer includes an auto-zeroing algorithm that
> greatly reduces (cancels out) the 1/f noise and cancels the
> offset value of the reference buffer. As a result, the SNR of
> the system is not affected by this 1/f noise component of the
> reference buffer, even at maximum oversampling ratio values.
> Write '1' to enable it, write '0' to disable it."

Indeed a new one to me.  We've had devices that modulate
the input a little in the past.  Dumb question though - why
wouldn't you turn this on?  Do we need to provide the option.



> > > +What:               
> > > /sys/bus/iio/devices/iio:deviceX/enable_auto_zeroing_ref
> > > +KernelVersion:       6.4
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             This attribute is used to enable the chopping
> > > algorithm for the
> > > +             internal voltage reference buffer.  Write '1' to
> > > enable it,
> > > +             write '0' to disable it.
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/hardwaregain
> > > +KernelVersion:       6.4
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             This attribute is used to set the hardware applied
> > > gain factor.
> > > +             It is shared across all channels.  
> > This attr is pretty much only used when the gain is not directly
> > related to the
> > value being used.  An example being a time of flight sensor where the
> > amplitude
> > of the measured signal doesn't directly matter as we are looking for
> > the timing of the
> > peak, we just need it to be big enough to measure. Otherwise scale is
> > what you want.
> >   
> 
> The MCP3564 has internally an input amplifier with programmable gain.
> Because we can measure a difference between 2 channels, we have clients
> that measure the output of load cells. This output is quite small am we
> need to amplify it before conversion is done.
> 
> I was thinking that because we name it "hardwaregain" this will be be
> somehow connected to a configurable gain that could be set in hardware.
> Is better to have a separate info strictly related to  hardware
> amplification.

Not an interface that any standard software will control.  If you can
either treat it as _scale (which implies that it is relevant to the _raw
calculation) or as _calibscale (which implies that it is a tweak to correct
for device differences or external circuitry but should not be applied by
software to the _raw value) then you will have a control that is
the same as being used for any other device.   Many ADCs have programmable
gain - we deliberately expose that only via _scale because userspace doesn't
care 'how' a gain results, just what it is.


Jonathan

