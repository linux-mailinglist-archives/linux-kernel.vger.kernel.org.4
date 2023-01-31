Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5B6829D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjAaKCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjAaKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:01:55 -0500
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 02:01:45 PST
Received: from mail.multiname.org (h4.multiname.org [94.130.68.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221834B19A;
        Tue, 31 Jan 2023 02:01:44 -0800 (PST)
Received: from webmail.multiname.org (unknown [10.0.10.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.multiname.org (Postfix) with ESMTPSA id 4P5gBf04bKzPLtZC;
        Tue, 31 Jan 2023 10:44:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ccbib.org; s=20220806;
        t=1675158298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u92+jTmd41zljmbXNuo5Urnc5+K1eFfPMB3du4y+R74=;
        b=mhQP+PBiE7mkse22lhpvhHcKOXJhwDbjsgVQnI7m/0bwvTvUNbw3vsKbyt2/CQMOFoW0zV
        YzGWlK5Vah9zvehcED7KrKNV902o9gDTAlcxGSetPMaHpvxCpE+HoLcIOiUC5qcYSUBbfq
        y5nExMivJr2ru+ykXsmmgqgWXWEvK39oxniZBOnIoRG7/dnpln/x/p0QqdH+rO+h8Zt6+I
        fRKAMnsa1i++oatCj0BXdJHULVNYKO8H143FkySe2mxB4GhWsYnEYaldnFIthZarBjDt0n
        Sa6tNP9xBLUkyZwRWQYglrV1WQ3ZqsRI/DdCaqYxDJNJYOHfGc/Ng5hTneMtzJv9INVDq0
        KnP7Nk0LFm2aVqj342Me/VLt1Zvtli2MpEeytXrET81QTjlOQYzljl/cJ39co9lNNUQNcO
        mTYl+u/x2QXPqByTnMy897XuR+r0KzuEacgR5ZPvrPV4dvuDhbXvo+47omSHfGevX7TN1L
        1s1ziuw0SFmYfqP9aib+j216zZNyLsBQUpkeY+pJVIKGKtGHC+y08v1m0t94RAp5iMUZDY
        0y85wyo2Qqx1YGd73A2pnyM1WbbSfkTeaeYVrN8DHv/+kGdA+FsplXfme25IC1cKdUgSXk
        hnmIWO24z5KrooYQGzN/mObG93RmLQdZR8bbfJNBLgVKHCK4U5u60=
MIME-Version: 1.0
Date:   Tue, 31 Jan 2023 10:44:57 +0100
From:   harald@ccbib.org
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Feldner <pelzi@flying-snail.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dht11: Read bit stream from IRQ on falling edges
 only
In-Reply-To: <20230130202216.42034309@jic23-huawei>
References: <Y9a0RZ+inWs44Kn8@debian-qemu.internal.flying-snail.de>
 <20230130202216.42034309@jic23-huawei>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <45efc11e5b4cdba3766f19190bb65840@ccbib.org>
X-Sender: harald@ccbib.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-30 21:22, Jonathan Cameron wrote:
> On Sun, 29 Jan 2023 19:05:23 +0100
> Andreas Feldner <pelzi@flying-snail.de> wrote:
> 
>> Currently, IRQs for both falling and raising edges of the GPIO
>> line connected to the DHT11 device are requested. However, the
>> low states do not carry information, it is possible to determine
>> 0 and 1 bits from the timing of two adjacent falling edges as
>> well.

This probably is true, but it wasn't obvious from reading the data
sheet, how constant the low times actually are. Back then the idea
also was, to use the low times to do recovery from line noise etc.
In the end the driver works reliably without, so we could make
this change.

However aside from the DHT11 there are also a number of different
chips sold as DHT22. I tried to get as many of them as possible
and made extensive tests to ensure they all work properly and
with different timer resolutions.

It would be quite an effort to replicate this for your new
algorithm. However, if you want to pursue this, the first step
would be to prove (probably by calculation), that no matter the
timer resolution (ie some systems have 32kHz timers only) the
new algorithm doesn't lead to decoding ambiguity in cases where
the current algorithm is unambiguous.

>> Doing so does no longer requires to read the GPIO line value
>> within the IRQ handler, plus halves the number of IRQs to be
>> handled at all.

This seems like a really small benefit. And we would lose the
low state timings in debug output, which I personally find quite
convenient. Unless there is data, that this change actually improves
something for somebody, I'd reject it.

Also if we ever are to support shared interrupts, we will need to
read the line value anyway.

>> Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
> 
> +CC Harald  Not been that many years since Harald replied, so address
> may still be good.

Thanks for including me in the discussion.

best regards,
Harald

>> ---
>>  drivers/iio/humidity/dht11.c | 28 +++++++++++-----------------
>>  1 file changed, 11 insertions(+), 17 deletions(-)
>> 
>> diff --git a/drivers/iio/humidity/dht11.c 
>> b/drivers/iio/humidity/dht11.c
>> index c97e25448772..d1cd053c5dd4 100644
>> --- a/drivers/iio/humidity/dht11.c
>> +++ b/drivers/iio/humidity/dht11.c
>> @@ -30,13 +30,13 @@
>> 
>>  #define DHT11_DATA_VALID_TIME	2000000000  /* 2s in ns */
>> 
>> -#define DHT11_EDGES_PREAMBLE 2
>> +#define DHT11_EDGES_PREAMBLE 1
>>  #define DHT11_BITS_PER_READ 40
>>  /*
>>   * Note that when reading the sensor actually 84 edges are detected, 
>> but
>>   * since the last edge is not significant, we only store 83:
>>   */
>> -#define DHT11_EDGES_PER_READ (2 * DHT11_BITS_PER_READ + \
>> +#define DHT11_EDGES_PER_READ (DHT11_BITS_PER_READ + \
>>  			      DHT11_EDGES_PREAMBLE + 1)
>> 
>>  /*
>> @@ -46,6 +46,7 @@
>>   * 1-bit: 68-75uS -- typically 70uS (AM2302)
>>   * The acutal timings also depend on the properties of the cable, 
>> with
>>   * longer cables typically making pulses shorter.
>> + * Low time is constant 50uS.
>>   *
>>   * Our decoding depends on the time resolution of the system:
>>   * timeres > 34uS ... don't know what a 1-tick pulse is
>> @@ -63,7 +64,8 @@
>>  #define DHT11_START_TRANSMISSION_MIN	18000  /* us */
>>  #define DHT11_START_TRANSMISSION_MAX	20000  /* us */
>>  #define DHT11_MIN_TIMERES	34000  /* ns */
>> -#define DHT11_THRESHOLD		49000  /* ns */
>> +#define DHT11_LOW		50000  /* ns */
>> +#define DHT11_THRESHOLD		(49000 + DHT11_LOW)  /* ns */
>>  #define DHT11_AMBIG_LOW		23000  /* ns */
>>  #define DHT11_AMBIG_HIGH	30000  /* ns */
>> 
>> @@ -83,7 +85,7 @@ struct dht11 {
>> 
>>  	/* num_edges: -1 means "no transmission in progress" */
>>  	int				num_edges;
>> -	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
>> +	struct {s64 ts; }	edges[DHT11_EDGES_PER_READ];
>>  };
>> 
>>  #ifdef CONFIG_DYNAMIC_DEBUG
>> @@ -99,7 +101,7 @@ static void dht11_edges_print(struct dht11 *dht11)
>>  	for (i = 1; i < dht11->num_edges; ++i) {
>>  		dev_dbg(dht11->dev, "%d: %lld ns %s\n", i,
>>  			dht11->edges[i].ts - dht11->edges[i - 1].ts,
>> -			dht11->edges[i - 1].value ? "high" : "low");
>> +			"falling");
>>  	}
>>  }
>>  #endif /* CONFIG_DYNAMIC_DEBUG */
>> @@ -125,14 +127,8 @@ static int dht11_decode(struct dht11 *dht11, int 
>> offset)
>>  	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
>> 
>>  	for (i = 0; i < DHT11_BITS_PER_READ; ++i) {
>> -		t = dht11->edges[offset + 2 * i + 2].ts -
>> -			dht11->edges[offset + 2 * i + 1].ts;
>> -		if (!dht11->edges[offset + 2 * i + 1].value) {
>> -			dev_dbg(dht11->dev,
>> -				"lost synchronisation at edge %d\n",
>> -				offset + 2 * i + 1);
>> -			return -EIO;
>> -		}
>> +		t = dht11->edges[offset + i + 1].ts -
>> +		    dht11->edges[offset + i].ts;
>>  		bits[i] = t > DHT11_THRESHOLD;
>>  	}
>> 
>> @@ -174,9 +170,7 @@ static irqreturn_t dht11_handle_irq(int irq, void 
>> *data)
>>  	struct dht11 *dht11 = iio_priv(iio);
>> 
>>  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 
>> 0) {
>> -		dht11->edges[dht11->num_edges].ts = ktime_get_boottime_ns();
>> -		dht11->edges[dht11->num_edges++].value =
>> -						gpiod_get_value(dht11->gpiod);
>> +		dht11->edges[dht11->num_edges++].ts = ktime_get_boottime_ns();
>> 
>>  		if (dht11->num_edges >= DHT11_EDGES_PER_READ)
>>  			complete(&dht11->completion);
>> @@ -224,7 +218,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>>  			goto err;
>> 
>>  		ret = request_irq(dht11->irq, dht11_handle_irq,
>> -				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +				  IRQF_TRIGGER_FALLING,
>>  				  iio_dev->name, iio_dev);
>>  		if (ret)
>>  			goto err;
