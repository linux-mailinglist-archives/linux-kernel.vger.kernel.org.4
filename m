Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738C0726344
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbjFGOtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbjFGOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:49:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75531FC3;
        Wed,  7 Jun 2023 07:49:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qbqwt0jznz6J7xn;
        Wed,  7 Jun 2023 22:49:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 7 Jun
 2023 15:49:22 +0100
Date:   Wed, 7 Jun 2023 15:49:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: max14001: New driver
Message-ID: <20230607154921.00007efe@Huawei.com>
In-Reply-To: <bdc11e51637e4249818be688e3cd7b59@analog.com>
References: <20230605130755.92642-1-kimseer.paller@analog.com>
        <20230605130755.92642-3-kimseer.paller@analog.com>
        <20230605202413.5eb0c0f3@jic23-huawei>
        <f62be66979db433eac86f32cc8587892@analog.com>
        <20230606113550.00003634@Huawei.com>
        <bdc11e51637e4249818be688e3cd7b59@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 11:17:33 +0000
"Paller, Kim Seer" <KimSeer.Paller@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Tuesday, June 6, 2023 6:36 PM
> > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; lars@metafoo.de;
> > krzysztof.kozlowski@linaro.org; broonie@kernel.org; lgirdwood@gmail.com;
> > linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 2/2] iio: adc: max14001: New driver
> > 
> > [External]
> > 
> > 
> >   
> > > >  
> > > > > +	struct mutex		lock;
> > > > > +	struct regmap		*regmap;
> > > > > +	int			vref_mv;
> > > > > +	/*
> > > > > +	 * DMA (thus cache coherency maintenance) requires the
> > > > > +	 * transfer buffers to live in their own cache lines.  
> > > >
> > > > You are looking at an old kernel I guess - we fixed all of these - and
> > > > introduced IIO_DMA_MINALIGN for __aligned(IIO_DMA_MINALIGN) to
> > > > make it easier to fix any such problems in future.
> > > >
> > > > Upshot is that ___cacheline_aligned aligns to the l1 cacheline length.
> > > > Some fun systems (such as the big servers I use in my dayjob) have higher
> > > > cacheline sizes for their larger / further from CPU caches.
> > > > One group of SoCs out there is known to both do non coherent DMA and
> > > > have a larger line size for the bit relevant to that than ___cacheline_aligned
> > > > gives you. So on that rare platform this is currently broken.  
> > >
> > > It's good to know. Given this information, is there anything specific that I
> > > need to change in the code or implementation related to
> > > the ___cacheline_aligned part?  
> > 
> > Replace it with __aligned(IIO_DMA_MINALIGN) as has hopefully now been
> > done
> > in all upstream drivers.  
> 
> When I attempted to implement this change, I encountered a checkpatch warning 
> in the latest kernel version. The warning indicated that externs should be avoided 
> in .c files and emphasized the need for an identifier name for the function 
> definition argument 'IIO_DMA_MINALIGN'. I attempted to define a macro with an 
> appropriate identifier name, but I still received the same checkpatch warning. 
> It's possible that I may have overlooked something in my approach. I would 
> appreciate your thoughts and insights on this matter. Thanks.

Ignore checkpatch for this one. Check patch is miss handling of
__aligned.

At a guess - needs an entry in this list:
https://elixir.bootlin.com/linux/latest/source/scripts/checkpatch.pl#L513

Though I'm never great at understanding the perl so may have that wrong.

Jonathan


