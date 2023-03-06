Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5076A6ACC82
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCFS0h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 13:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCFS0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:26:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BC174A47;
        Mon,  6 Mar 2023 10:26:03 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PVkTq6Jy8z6J7Kr;
        Tue,  7 Mar 2023 00:26:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 6 Mar
 2023 16:26:33 +0000
Date:   Mon, 6 Mar 2023 16:26:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <Marius.Cristea@microchip.com>
CC:     <jic23@kernel.org>, <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Message-ID: <20230306162632.00005edd@Huawei.com>
In-Reply-To: <2f1a14522a7a8d46e3b037a285af4c3dd9b17cbc.camel@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
        <20230220123232.413029-2-marius.cristea@microchip.com>
        <c38afa67-d24f-0390-f18a-81bee15b7eca@kernel.org>
        <20230225171723.15e822ec@jic23-huawei>
        <2f1a14522a7a8d46e3b037a285af4c3dd9b17cbc.camel@microchip.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Mon, 6 Mar 2023 13:53:27 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi Jonathan,
> 
>    Thank you so much! I'm happy to contribute to IIO.
> 
> I will remove some section because I agree with the propose solution.
> For the rest I will comment below..
> 
> 
> 
> On Sat, 2023-02-25 at 17:17 +0000, Jonathan Cameron wrote:
> > > > +
> > > > +  microchip,samp-rate:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: Sampling rate for all device's channels.  
> > > 
> > > What are the units? rate is usually in hz, which should be
> > > expressed in
> > > unit suffix (property name)]  
> > 
> > It's unusual for sampling rate to be a property of the hardware and
> > hence
> > suitable for DT binding. Normally we make this a userspace control
> > instead.
> > If there is a reason for doing it from DT, that wants to be mentioned
> > here.
> >   
> 
> Here I could change it into the datarate (as in
> iio/adc/ti,ads1015.yaml). The units are samples per second. My
> intention was to be alingned with the datasheet.
> 
> My intention was to let the user configure the sample rate as soon as
> posile during the startup (the PAC device's own power consumtion will
> increase with the sampling rate - default the chip will start with the
> maximum samples per second).

Feel free to have the driver set it to the minimum frequency unconditionally
in probe.

> 
> 
> >   
> 
> >   
> > >   
> > > > +
> > > > +      microchip,bi-directional:
> > > > +        description: Whether the channel is bi-directional.  
> > > 
> > > Describe here what is a "bi-directional" channel for ADC... Maybe
> > > it is
> > > obvious, maybe not. For me it is not and none of other devices have
> > > it.
> > >   
> > From datasheet this seems to be a novel description of whether the
> > ADC
> > is measuring just positive or allows for negative voltage as well
> > (i.e.
> > the current through the shut resistor is going on the other
> > direction).
> > Can we relate this to a biopolar / unipolar decision on a simple
> > voltage ADC?
> > For that we have standard DT bindings in iio/adc/adc.yaml
> >   
> 
> Yes, the PAC device can measure voltages as unipolar or bipolar but
> also current as unidirectional or bidirectional (we are measuring the
> voltage across a shunt resistor). We are also reporting power and is
> not a "usual" thing to report power as unipolar or bipolar. Bi-
> directional power makes more sens if you are thinking to monitor a
> charge discharge cycle for a battery pack.

I'm still a little confused. If you are bipolar and hence can measure
postive and negative voltage between two pins, how is that different
to bidirectional? Other than for bidirection we are talking current
rather than voltage.

> 
> 
> 
> Thanks,
> Marius

