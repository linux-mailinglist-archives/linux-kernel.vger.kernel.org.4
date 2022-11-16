Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7339662B7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiKPKWx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Nov 2022 05:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiKPKWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:22:05 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE3B12A9D;
        Wed, 16 Nov 2022 02:22:03 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBzYk0lwNz6HJ9N;
        Wed, 16 Nov 2022 18:19:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 11:22:01 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 10:22:01 +0000
Date:   Wed, 16 Nov 2022 10:22:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Message-ID: <20221116102200.00003d16@Huawei.com>
In-Reply-To: <6d76cc6d-9db7-5b18-e4f1-dc220b3929a3@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-6-linux@rasmusvillemoes.dk>
        <20221112170705.7efe1673@jic23-huawei>
        <095a454b55cf497392a621649f24e067@analog.com>
        <20221114194447.2528f699@jic23-huawei>
        <0d6b3e4047df9f560079a562bc167bd7a0bf2d28.camel@gmail.com>
        <20221115161052.00002633@Huawei.com>
        <6d76cc6d-9db7-5b18-e4f1-dc220b3929a3@rasmusvillemoes.dk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 20:10:53 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 15/11/2022 17.10, Jonathan Cameron wrote:
> > On Tue, 15 Nov 2022 15:49:46 +0100
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> >   
> >> On Mon, 2022-11-14 at 19:44 +0000, Jonathan Cameron wrote:  
> >>> On Mon, 14 Nov 2022 13:52:26 +0000
> >>> "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:
> >>>     
> >>>>>
> >>>>> I'm a little confused on polarity here.  The pin is a !reset so
> >>>>> we need to drive it low briefly to trigger a reset.
> >>>>> I'm guessing for your board the pin is set to active low? (an
> >>>>> example
> >>>>> in the dt would have made that clearer) Hence the pulse
> >>>>> in here to 1 is actually briefly driving it low before restoring
> >>>>> to high?
> >>>>>
> >>>>> For a pin documented as !reset that seems backwards though you
> >>>>> have
> >>>>> called it reset so that is fine, but this description doesn't
> >>>>> make that
> >>>>> celar.      
> >>>>
> >>>> My opinion is that the driver shouldn't exactly know the polarity
> >>>> of the reset,
> >>>> and just assume that setting the reset GPIO to 1 means putting it
> >>>> in reset,
> >>>> and setting it to 0 means bringing out of reset.    
> >>>
> >>> Agreed. I'd just like a comment + example in the dt-binding to make
> >>> the point
> >>> that the pin is !reset.
> >>>
> >>> Preferably with an example in the dt binding of the common case of it
> >>> being wired
> >>> up to an active low pin.
> >>>
> >>> The main oddity here is the need to pulse it rather than request it
> >>> directly as
> >>> in the reset state and then just set that to off.
> >>>
> >>>     
> >>
> >> Agreed... In theory we should be able to request the gpio with
> >> GPIOD_OUT_HIGH and then just bring the device out of reset  
> > 
> > If I recall correctly the datasheet specifically calls out that a pulse
> > should be used.  No idea if that's actually true, or if it was meant
> > to be there just to say it needs to be set for X nsecs.  
> 
> So the data sheet says
> 
>   The hardware reset is initiated by pulsing the RESET pin low. The
> RESET pulse width must comply with the specifications in Table 11.
> 
> and table 11 says that the pulse must be min 50us, max 1ms. We don't
> really have any way whatsoever to ensure that we're not rescheduled
> right before pulling the gpio high again (deasserting the reset), so the
> pulse could effectively be much more than 1ms. But I have a hard time
> believing that that actually matters (i.e., what state would the chip be
> in if we happen to make a pulse 1234us wide?).

Test it maybe?  Otherwise we'd have to play games to do it again if the
timing was too long to ensure after a couple of goes we do get a suitable
width pulse.

> But what might be
> relevant, and maybe where that 1ms figure really comes from, can perhaps
> be read in table 10, which lists a "device reset time" of 1ms, with the
> description
> 
>   Time taken for device reset and calibration memory upload to complete
> hardware or software reset events after the device is powered up
> 
> so perhaps we should ensure a 1ms delay after the reset (whether we used
> the software or gpio method). But that would be a separate fix IMO (and
> I'm not sure we actually need it).
> 
> I don't mind requesting the gpio with GPIOD_OUT_HIGH, but I'd still keep
> the gpiod_set_value(, 1) in the reset function, otherwise it's a bit too
> magic for my taste.

Without testing I'd worry that it really does need a pulse so probably better
to leave it doing so. 

Jonathan

> 
> Rasmus
> 

