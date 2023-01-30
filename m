Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E91F681B17
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjA3UIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjA3UI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:08:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59FB2FCD6;
        Mon, 30 Jan 2023 12:08:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5F9BCE19A4;
        Mon, 30 Jan 2023 20:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D44C4339B;
        Mon, 30 Jan 2023 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675109302;
        bh=lwwiB46eAVrTazcKlTvsvJfoI91MWMHkW92WZ37NlJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KfOG5/Fhk/5wKxTqYBDl4mki8ZSkSg6IeYkvPNI1+af5MjGUszPa6JB8vcbiJlTHC
         9SiMtCa+eb256014mzylZh1ole+aNa2qnFQy2Cq9YE7pNZJOYmOppMPrybjQqsF8wY
         DGN0n7dCQjzXAnqvEteX8LxlWzCQza5di5OEuEAGo4g5VcaNOuDWTp4UHNUVdU341d
         N+AXWZT/qKOrXN9Rwn5vxvo75D+FCVh6uRCfac0TFf4GXYYoHma3SElYA5aT0cqiVW
         E8lYmXkPNf5ZdKjvQwkYN2Ntg3W+fAyjcpRMQExEAqyEPBN7VVmtMWxqJHv2WXlmB0
         PwIeAzoP6z4LA==
Date:   Mon, 30 Jan 2023 20:22:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Feldner <pelzi@flying-snail.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH] iio: dht11: Read bit stream from IRQ on falling edges
 only
Message-ID: <20230130202216.42034309@jic23-huawei>
In-Reply-To: <Y9a0RZ+inWs44Kn8@debian-qemu.internal.flying-snail.de>
References: <Y9a0RZ+inWs44Kn8@debian-qemu.internal.flying-snail.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 19:05:23 +0100
Andreas Feldner <pelzi@flying-snail.de> wrote:

> Currently, IRQs for both falling and raising edges of the GPIO
> line connected to the DHT11 device are requested. However, the
> low states do not carry information, it is possible to determine
> 0 and 1 bits from the timing of two adjacent falling edges as
> well.
> 
> Doing so does no longer requires to read the GPIO line value
> within the IRQ handler, plus halves the number of IRQs to be
> handled at all.
> 
> Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>

+CC Harald  Not been that many years since Harald replied, so address
may still be good.


> ---
>  drivers/iio/humidity/dht11.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index c97e25448772..d1cd053c5dd4 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -30,13 +30,13 @@
>  
>  #define DHT11_DATA_VALID_TIME	2000000000  /* 2s in ns */
>  
> -#define DHT11_EDGES_PREAMBLE 2
> +#define DHT11_EDGES_PREAMBLE 1
>  #define DHT11_BITS_PER_READ 40
>  /*
>   * Note that when reading the sensor actually 84 edges are detected, but
>   * since the last edge is not significant, we only store 83:
>   */
> -#define DHT11_EDGES_PER_READ (2 * DHT11_BITS_PER_READ + \
> +#define DHT11_EDGES_PER_READ (DHT11_BITS_PER_READ + \
>  			      DHT11_EDGES_PREAMBLE + 1)
>  
>  /*
> @@ -46,6 +46,7 @@
>   * 1-bit: 68-75uS -- typically 70uS (AM2302)
>   * The acutal timings also depend on the properties of the cable, with
>   * longer cables typically making pulses shorter.
> + * Low time is constant 50uS.
>   *
>   * Our decoding depends on the time resolution of the system:
>   * timeres > 34uS ... don't know what a 1-tick pulse is
> @@ -63,7 +64,8 @@
>  #define DHT11_START_TRANSMISSION_MIN	18000  /* us */
>  #define DHT11_START_TRANSMISSION_MAX	20000  /* us */
>  #define DHT11_MIN_TIMERES	34000  /* ns */
> -#define DHT11_THRESHOLD		49000  /* ns */
> +#define DHT11_LOW		50000  /* ns */
> +#define DHT11_THRESHOLD		(49000 + DHT11_LOW)  /* ns */
>  #define DHT11_AMBIG_LOW		23000  /* ns */
>  #define DHT11_AMBIG_HIGH	30000  /* ns */
>  
> @@ -83,7 +85,7 @@ struct dht11 {
>  
>  	/* num_edges: -1 means "no transmission in progress" */
>  	int				num_edges;
> -	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
> +	struct {s64 ts; }	edges[DHT11_EDGES_PER_READ];
>  };
>  
>  #ifdef CONFIG_DYNAMIC_DEBUG
> @@ -99,7 +101,7 @@ static void dht11_edges_print(struct dht11 *dht11)
>  	for (i = 1; i < dht11->num_edges; ++i) {
>  		dev_dbg(dht11->dev, "%d: %lld ns %s\n", i,
>  			dht11->edges[i].ts - dht11->edges[i - 1].ts,
> -			dht11->edges[i - 1].value ? "high" : "low");
> +			"falling");
>  	}
>  }
>  #endif /* CONFIG_DYNAMIC_DEBUG */
> @@ -125,14 +127,8 @@ static int dht11_decode(struct dht11 *dht11, int offset)
>  	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
>  
>  	for (i = 0; i < DHT11_BITS_PER_READ; ++i) {
> -		t = dht11->edges[offset + 2 * i + 2].ts -
> -			dht11->edges[offset + 2 * i + 1].ts;
> -		if (!dht11->edges[offset + 2 * i + 1].value) {
> -			dev_dbg(dht11->dev,
> -				"lost synchronisation at edge %d\n",
> -				offset + 2 * i + 1);
> -			return -EIO;
> -		}
> +		t = dht11->edges[offset + i + 1].ts -
> +		    dht11->edges[offset + i].ts;
>  		bits[i] = t > DHT11_THRESHOLD;
>  	}
>  
> @@ -174,9 +170,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
>  	struct dht11 *dht11 = iio_priv(iio);
>  
>  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
> -		dht11->edges[dht11->num_edges].ts = ktime_get_boottime_ns();
> -		dht11->edges[dht11->num_edges++].value =
> -						gpiod_get_value(dht11->gpiod);
> +		dht11->edges[dht11->num_edges++].ts = ktime_get_boottime_ns();
>  
>  		if (dht11->num_edges >= DHT11_EDGES_PER_READ)
>  			complete(&dht11->completion);
> @@ -224,7 +218,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  			goto err;
>  
>  		ret = request_irq(dht11->irq, dht11_handle_irq,
> -				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				  IRQF_TRIGGER_FALLING,
>  				  iio_dev->name, iio_dev);
>  		if (ret)
>  			goto err;

