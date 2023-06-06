Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC31A723FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjFFKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbjFFKgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:36:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB4E67;
        Tue,  6 Jun 2023 03:35:53 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb6Jw5wDQz67j66;
        Tue,  6 Jun 2023 18:33:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 11:35:50 +0100
Date:   Tue, 6 Jun 2023 11:35:50 +0100
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
Message-ID: <20230606113550.00003634@Huawei.com>
In-Reply-To: <f62be66979db433eac86f32cc8587892@analog.com>
References: <20230605130755.92642-1-kimseer.paller@analog.com>
        <20230605130755.92642-3-kimseer.paller@analog.com>
        <20230605202413.5eb0c0f3@jic23-huawei>
        <f62be66979db433eac86f32cc8587892@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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



> >   
> > > +	struct mutex		lock;
> > > +	struct regmap		*regmap;
> > > +	int			vref_mv;
> > > +	/*
> > > +	 * DMA (thus cache coherency maintenance) requires the
> > > +	 * transfer buffers to live in their own cache lines.  
> > 
> > You are looking at an old kernel I guess - we fixed all of these - and
> > introduced IIO_DMA_MINALIGN for __aligned(IIO_DMA_MINALIGN) to
> > make it easier to fix any such problems in future.
> > 
> > Upshot is that ___cacheline_aligned aligns to the l1 cacheline length.
> > Some fun systems (such as the big servers I use in my dayjob) have higher
> > cacheline sizes for their larger / further from CPU caches.
> > One group of SoCs out there is known to both do non coherent DMA and
> > have a larger line size for the bit relevant to that than ___cacheline_aligned
> > gives you. So on that rare platform this is currently broken.  
> 
> It's good to know. Given this information, is there anything specific that I 
> need to change in the code or implementation related to 
> the ___cacheline_aligned part?

Replace it with __aligned(IIO_DMA_MINALIGN) as has hopefully now been done
in all upstream drivers.

> >   

> > > +}
> > > +
> > > +static int max14001_reg_update(struct max14001_state *st,
> > > +				unsigned int reg_addr,
> > > +				unsigned int mask,
> > > +				unsigned int val)
> > > +{
> > > +	int ret;
> > > +
> > > +	/* Enable SPI Registers Write */
> > > +	ret = max14001_write(st, MAX14001_WEN,  
> > MAX14001_WRITE_WEN);
> > 
> > Mixing regmap and non regmap rather defeats the point of having a standard
> > interface.  Use regmap_read and regmap_write throughout or not at all.  
> 
> I found it difficult to implement the regmap interface due to the timing diagram 
> requirements. The chip select needs to be changed between transfers, which, 
> as far as I know, does not work with regmap. Perhaps, I will consider sticking 
> to the non-regmap approach.

That may be sensible if there are odd requirements or just call regmap_write()
which will call your max14001_write() anyway and opencode the timing
requirements etc by multiple remap calls.  Obviously benefits of regmap reduced
though so may not be worth bothering unless it is worth using the caching or similar.

Jonathan



