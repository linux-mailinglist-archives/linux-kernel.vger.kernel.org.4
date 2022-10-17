Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18B600C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJQKaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJQKaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:30:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BEF21E26;
        Mon, 17 Oct 2022 03:30:01 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrY7y1c6Bz67kTG;
        Mon, 17 Oct 2022 18:26:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 12:29:59 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 11:29:58 +0100
Date:   Mon, 17 Oct 2022 11:29:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
CC:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH 3/3] iio: temperature: ltc2983: support more parts
Message-ID: <20221017112958.000034ff@huawei.com>
In-Reply-To: <007bd4e6-62ce-5c06-4912-9f782fc29742@gmail.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
        <20221014123724.1401011-4-demonsingur@gmail.com>
        <20221014164435.000016a1@huawei.com>
        <007bd4e6-62ce-5c06-4912-9f782fc29742@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
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

On Mon, 17 Oct 2022 09:59:27 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On 10/14/22 18:44, Jonathan Cameron wrote:
> > On Fri, 14 Oct 2022 15:37:24 +0300
> > Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >   
> >> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >>
> >> Add support for the following parts:
> >>   * LTC2984
> >>   * LTC2986
> >>   * LTM2985
> >>
> >> The LTC2984 is a variant of the LTC2983 with EEPROM.
> >> The LTC2986 is a variant of the LTC2983 with only 10 channels,
> >> EEPROM and support for active analog temperature sensors.
> >> The LTM2985 is software-compatible with the LTC2986.
> >>
> >> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>  
> > 
> > ...
> > 
> > Hi Cosmin,
> > 
> > Looks good except, I think we are still in the position that
> > regmap for spi doesn't guarantee to bounce buffer the bulk accesses
> > (last time I checked it actually did do so, but before that it didn't
> > and there are obvious optimizations to take it back to not doing so -
> > IRC Mark Brown's answer was we shouldn't rely on it..)
> > 
> > Anyhow, the existing driver has instances of this so its no worse
> > but we should really clean those up.
> > 
> > Jonathan
> >   
> 
> I can submit another patch for it. Although I'm pretty sure that
> SPI regmap implementation doesn't need DMA safe access for it,
> as I checked when I wrote the code.

It doesn't today (last time I checked it didn't anyway and that matches
with what you found), but it did in the past and there are no guarantees
it won't require DMA safe buffers in the future.  I doubt I'll find the
reference but we had a discussion with Mark Brown about this for a similar
case a year or two back and he confirmed we should continue to assume
that DMA safe buffers should be used. 

Jonathan

> 
> >   
> >>   
> >> +static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
> >> +			      unsigned int wait_time, unsigned int status_reg,
> >> +			      unsigned long status_fail_mask)
> >> +{
> >> +	__be32 bval = cpu_to_be32(LTC2983_EEPROM_KEY);
> >> +	unsigned long time;
> >> +	unsigned int val;
> >> +	int ret;
> >> +
> >> +	ret = regmap_bulk_write(st->regmap, LTC2983_EEPROM_KEY_REG, &bval,
> >> +				sizeof(bval));  
> > 
> > SPI device and I was clearly dozing on existing driver but normally
> > we avoid assuming that regmap will always use a bounce buffer for bulk
> > accessors. Hence this should be a DMA safe buffer.
> > 
> >   
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	reinit_completion(&st->completion);
> >> +
> >> +	ret = regmap_write(st->regmap, LTC2983_STATUS_REG,
> >> +			   LTC2983_STATUS_START(true) | cmd);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	time = wait_for_completion_timeout(&st->completion,
> >> +					   msecs_to_jiffies(wait_time));
> >> +	if (!time) {
> >> +		dev_err(&st->spi->dev, "EEPROM command timed out\n");
> >> +		return -ETIMEDOUT;
> >> +	}
> >> +
> >> +	ret = regmap_read(st->regmap, status_reg, &val);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (val & status_fail_mask) {
> >> +		dev_err(&st->spi->dev, "EEPROM command failed: 0x%02X\n", val);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +  
> >   

