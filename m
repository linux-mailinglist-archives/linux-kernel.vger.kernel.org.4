Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65826629E86
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKOQJt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Nov 2022 11:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiKOQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:09:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BF81C122;
        Tue, 15 Nov 2022 08:09:40 -0800 (PST)
Received: from frapeml500008.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBWKK4rH1z67tG2;
        Wed, 16 Nov 2022 00:07:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:09:39 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 16:09:38 +0000
Date:   Tue, 15 Nov 2022 16:09:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: frequency: adf4377: add support for ADF4377
Message-ID: <20221115160937.00000313@Huawei.com>
In-Reply-To: <2a6c721b8c27b4631f424e7c68e11a2409005261.camel@gmail.com>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
        <20221104092802.90725-3-antoniu.miclaus@analog.com>
        <3417a0fd87e6f13207690e49b797f2d2689f802a.camel@gmail.com>
        <20221106175139.093edcd9@jic23-huawei>
        <2a6c721b8c27b4631f424e7c68e11a2409005261.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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


> > > > +static int adf4377_probe(struct spi_device *spi)
> > > > +{
> > > > +       struct iio_dev *indio_dev;
> > > > +       struct regmap *regmap;
> > > > +       struct adf4377_state *st;
> > > > +       int ret;
> > > > +
> > > > +       indio_dev = devm_iio_device_alloc(&spi->dev,
> > > > sizeof(*st));
> > > > +       if (!indio_dev)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       regmap = devm_regmap_init_spi(spi,
> > > > &adf4377_regmap_config);
> > > > +       if (IS_ERR(regmap))
> > > > +               return PTR_ERR(regmap);
> > > > +
> > > > +       st = iio_priv(indio_dev);
> > > > +
> > > > +       indio_dev->info = &adf4377_info;
> > > > +       indio_dev->name = "adf4377";
> > > > +       indio_dev->channels = adf4377_channels;
> > > > +       indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
> > > > +
> > > > +       st->regmap = regmap;
> > > > +       st->spi = spi;
> > > > +       st->type = spi_get_device_id(spi)->driver_data;    
> > > 
> > > Hmm this is something that came up internally the other day. Are we
> > > guaranteed that this will always work? For OF I think it is but I'm
> > > not
> > > sure about ACPI? At first glance, it seems that it might be ok but
> > > I
> > > did not went too deep in the ACPI code.  
> > 
> > Better indeed to not assume it and indeed ACPI can't do this magic,
> > because
> > there isn't a match between the actual ACPI ID and the
> > spi_device_ids.
> > Not sure what it does with PRP0001 case (where it uses the
> > of_device_id table).  
> 
> Some comments/questions on the pattern:
> 
> > 
> > 
> >         st->type = device_get_match_id()->driver_data;  
> 
> Are we sure that device_get_match_id() (I guess you meant
> device_get_match_data()) cannot return NULL? I'm always a bit on the
> careful side with these dereferences...

Oops. Yes I got confused.  It can indeed return
NULL and when using right function we won't dereference it.
We'll just check st->type which will have been set NULL if that fails.

Jonathan
 
> 
> >         if (!st->type) {
> >                 const struct spi_device_id *id =
> > spi_get_device_id(spi);
> > 
> >                 if (!id)
> >                         return -EINVAL;
> > 
> >                 st->type = spi_get_device_id(spi)->driver_data;  
> 
> id->driver_data :)
> 
> >         }  
> 
> - Nuno Sá
> 
> 
> 
> 
> device_get_match_id()->driver_data;
> 
> 

