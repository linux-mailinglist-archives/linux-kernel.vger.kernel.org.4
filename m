Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64A744D6B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 13:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGBLHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGBLHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 07:07:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23730DC;
        Sun,  2 Jul 2023 04:07:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv5nT5Y0rz6J6ns;
        Sun,  2 Jul 2023 19:05:33 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 12:07:08 +0100
Date:   Sun, 2 Jul 2023 19:07:04 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 0/7] iio: add iio backend device type
Message-ID: <20230702190704.000071ba@Huawei.com>
In-Reply-To: <20230702185618.00002453@Huawei.com>
References: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
        <20230702185618.00002453@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Sun, 2 Jul 2023 18:56:18 +0800
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 23 Jun 2023 16:09:36 +0200
> Olivier Moysan <olivier.moysan@foss.st.com> wrote:
> 
> > This RFC re-opens an old discussion regarding channel scaling
> > management in STM32 DFSDM driver [1]
> > 
> > The DFSDM is a peripheral provided by the STM32MP1x SoC family.
> > One objective is also to prepare the introduction of its successor in
> > the STM32MP12x SoC family: the MDF (Multi-function Digital Filter).
> > The MDF driver will have the same requirements as the DFSDM regarding
> > channel scaling management. So, the solution proposed here will apply
> > also for the future MDF driver.
> > 
> > [1]
> > https://patchwork.kernel.org/project/linux-iio/patch/20200204101008.11411-5-olivier.moysan@st.com/
> > 
> > As a short reminder of our previous discussion, the two main options
> > emerging were the following ones:
> > 
> > - Option1: Use the DFSDM as an hardware accelerator and expose the
> > scaled channels on SD modulator side.
> > Drawbak: this solution is leading to an very complex datapath, especially
> > for scan mode.
> > 
> > - Option2: Introduce a new IIO device type (so-called backend)
> > Retrieve scaling information from SD modulator scaling to expose a single
> > IIO device on DFSDM side. This solution is derivated from rcar-gyroadc
> > example, but with a more standard approach.
> > This was discussed in 
> > https://lore.kernel.org/lkml/20210919191414.09270f4e@jic23-huawei/  
> 
> Naming probably needs a rethink given the actual hardware we are talking about
> here is normally called a frontend and so people will be confused...

Hmm. I think the basic approach looks fine but needs fleshing out and
perhaps one or two more examples implemented to be sure that we have
something flexible enough to stand the test of time...

Jonathan

> 
> I'm traveling at the moment, so only going to take a fairly superficial first
> look at what you have here.
> 
> Jonathan
> 
> > 
> > The patchset proposed in this RFC implements option2 (backend) solution.
> > These patches provide a minimal API implemented as a template.
> > The intented use of this API is illustrated through the DFSDM channel
> > scaling support basic implementation.
> > 
> > For sake of simplicity I did not include the related DT binding
> > in this serie. 
> > 
> > Below are some use case examples.
> > 
> > * DFSDM with SD modulator backend:
> >   -------------------------------
> > This use case corresponds to the example implemented in this RFC.
> > The channel attributes are retrieved from backend by the dfsdm, and
> > the resulting scaling is exposed through DFSDM IIO device sysfs
> > 
> > - Single channel:
> > +-------------+  ch attr   +--------+  sysfs (compound scaling)
> > | sd0 backend | ---------> | dfsdm0 | -------------------------->
> > +-------------+            +--------+
> > 
> > - Scan mode:
> > +-------------+  ch attr   +-------------+  sysfs (compound scaling)
> > | sd1 backend | ---------> |   dfsdm1    | -------------------------->
> > +-------------+            +-------------+
> >                              ^
> >                              |
> > +-------------+  ch attr     |
> > | sd2 backend |--------------+
> > +-------------+
> > 
> > 
> > * Voltage divider in front of an adc:
> >   ----------------------------------
> > By way of example, here is a comparison on scaling management with
> > a iio-rescale device, and how it could be managed with a backend device.
> > 
> > - iio-rescale implementation
> > Scaling is exposed both on ADC and iio-rescale IIO devices.
> > On iio-rescale device we get the compound scaling
> > 
> > +---------------------------+  ch attr   +------+  sysfs
> > |     iio-rescale (div)     | <--------- | adc0 | ------->
> > +---------------------------+            +------+
> >   |
> >   | sysfs (compound scaling)
> >   v
> > 
> > - Backend implementation:
> > Compound scaling is exposed on ADC IIO device.
> > No scaling exposed on backend device
> > 
> > +---------------+  ch attr   +------+  sysfs (compound scaling)
> > | backend (div) | ---------> | adc0 | -------------------------->
> > +---------------+            +------+
> > 
> > 
> > * Cascaded backends:
> >   -----------------
> > Backends may be cascaded to allow computation of the whole chain scaling
> > This is not part of this RFC, but it is identified as a potential
> > future use case.
> > 
> > +---------------+  attr   +-------------+  attr   +--------+  sysfs
> > | backend (div) | ------> | sd0 backend | ------> | dfsdm0 | ------->
> > +---------------+         +-------------+         +--------+
> > 
> > Olivier Moysan (7):
> >   iio: introduce iio backend device
> >   of: property: add device link support for io-backends
> >   iio: adc: stm32-dfsdm: manage dfsdm as a channel provider
> >   iio: adc: stm32-dfsdm: adopt generic channel bindings
> >   iio: adc: sd_adc_modulator: change to iio backend device
> >   iio: adc: stm32-dfsdm: add scaling support to dfsdm
> >   ARM: dts: stm32: add dfsdm iio suppport
> > 
> >  arch/arm/boot/dts/stm32mp157c-ev1.dts |  62 +++++++++
> >  drivers/iio/Makefile                  |   2 +
> >  drivers/iio/adc/sd_adc_modulator.c    |  92 +++++++++++---
> >  drivers/iio/adc/stm32-dfsdm-adc.c     | 176 ++++++++++++++++----------
> >  drivers/iio/industrialio-backend.c    |  59 +++++++++
> >  drivers/of/property.c                 |   2 +
> >  include/linux/iio/backend.h           |  29 +++++
> >  7 files changed, 336 insertions(+), 86 deletions(-)
> >  create mode 100644 drivers/iio/industrialio-backend.c
> >  create mode 100644 include/linux/iio/backend.h
> >   
> 
> 

