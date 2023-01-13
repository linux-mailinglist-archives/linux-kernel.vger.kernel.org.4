Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D84669A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAMO05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAMOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:25:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E11D0EB;
        Fri, 13 Jan 2023 06:17:07 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntk4J5kGHz67bbZ;
        Fri, 13 Jan 2023 22:16:32 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 14:16:41 +0000
Date:   Fri, 13 Jan 2023 14:16:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <hvilleneuve@dimonoff.com>,
        <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7924: add Texas Instruments
 ADS7924 driver
Message-ID: <20230113141640.00006fb1@Huawei.com>
In-Reply-To: <20230112143357.6d6204f19eb622333bfd2f47@hugovil.com>
References: <20230110160124.3853593-1-hugo@hugovil.com>
        <20230110160124.3853593-2-hugo@hugovil.com>
        <20230112190030.37b9ea2f@jic23-huawei>
        <20230112143357.6d6204f19eb622333bfd2f47@hugovil.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
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


> > > +		break;
> > > +	}
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		vref_uv = regulator_get_voltage(data->vref_reg);
> > > +		if (vref_uv < 0) {
> > > +			/* dummy regulator "get_voltage" returns -EINVAL */
> > > +			ret = -EINVAL;  
> > 			return -EINVAL;  
> > > +		} else {
> > > +			*val =  vref_uv / 1000; /* Convert reg voltage to mV */
> > > +			*val2 = ADS7924_BITS;
> > > +			ret = IIO_VAL_FRACTIONAL_LOG2;  
> > 			return IIO_VAL_FR...
> >   
> > > +		}
> > > +		break;
> > > +	default:
> > > +		ret = -EINVAL;  
> > 		return -EINVAL;  
> > > +		break;
> > > +	}
> > > +
> > > +	return ret;
> > > +}  
> 
> Done. With these changes, I propose to also remove last "return ret" (like in rcar-gyroadc.c). Then, maybe also remove break statements?

Definitely to both. I was just being lazy whilst commenting ;)  No breaks after returns, and as you
have noted, the last return ret is unreachable.

> > > +
> > > +	if (num_channels > 0) {
> > > +		dev_dbg(dev, "found %d ADC channels\n", num_channels);
> > > +		return 0;
> > > +	} else {  
> > 
> > As per other review.  Give us what we expect which is error paths
> > as out of line.  
> 
> Already done as suggested by Christophe:
> 
>     if (num_channels <= 0)
>         return -EINVAL;

This is an out of line error path because it's indented more than the normal
flow.

> 
>     dev_dbg(dev, "found %d ADC channels\n", num_channels);
>     return 0;
> 
> Although I do not fully understand what you mean by "...error paths as out of line"? Do you mean to drop the debug message?
See above.

> 
> >   
> > > +		return -EINVAL;
> > > +	}
> > > +}  
