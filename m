Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8A6F9D7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjEHBot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEHBoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:44:46 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289F083FD
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:44:43 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230508014440epoutp04fe4f3541d0e6cf1c08980ad5cb536a59~dB64yJhzm2141421414epoutp04G
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:44:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230508014440epoutp04fe4f3541d0e6cf1c08980ad5cb536a59~dB64yJhzm2141421414epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683510280;
        bh=VMbyO2NgYAIXy4+h0cOhx721nE7JCLzEfchB8xU0VBA=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=S3q0MRCGPw0uvTNuMnZuNAad1OmuViamgJ4xVvc+B3LMlSFuThJW8yap/HuwHrVyF
         VStajfSouguXdH6bYVRZEvsIHn20vhASM/fx/vPjMQ6JTNJybHwtG+C9H5FTUFIY+l
         biOFnx5Jt6AaaypqujJVlNTGjYlRjbk/eB5IEDZw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230508014438epcas2p4eaa0543e12020fd896df98d23c2a1ca2~dB63Po95_0862908629epcas2p4w;
        Mon,  8 May 2023 01:44:38 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QF3xf06zsz4x9Q1; Mon,  8 May
        2023 01:44:38 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.E7.08199.50458546; Mon,  8 May 2023 10:44:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230508014437epcas2p3078ac91705aba3019cbad406a5bf2cef~dB62HLt271205912059epcas2p3Q;
        Mon,  8 May 2023 01:44:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230508014437epsmtrp29d7fb3656d9cc1a00cb5dd7c6687301e~dB62Gjph40870408704epsmtrp2X;
        Mon,  8 May 2023 01:44:37 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-d0-64585405a293
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.CA.28392.50458546; Mon,  8 May 2023 10:44:37 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230508014437epsmtip2abb7d743f3c27bccb759e4d1aba4a164~dB613xSPa0503305033epsmtip2v;
        Mon,  8 May 2023 01:44:37 +0000 (GMT)
Message-ID: <b93d7b1f-c0b1-7704-2beb-c574f87a06e8@samsung.com>
Date:   Mon, 8 May 2023 10:42:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] spi: s3c64xx: support interrupt based pio mode
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <53b60eca-e8ab-3ff3-61a4-019ccac6cd65@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmhS5rSESKwd2TFhYP5m1js1j84zmT
        xdSHT9gsLu/Xttj7eiu7xabH11gtLu+aw2Yx4/w+JovGjzfZHTg9ri/5xOyxaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWl
        eel6eaklVoYGBkamQIUJ2Rlvm/6yFOxUrtg4YTVLA2OzdBcjJ4eEgIlEf8NU5i5GLg4hgR2M
        Evu6J7GCJIQEPjFK7FgVAJH4zChx9/UeNpiOY482M0EU7WKUmL9EAqLoNaPEjGePmEESvAJ2
        EguPtLOD2CwCKhIv3n9lhIgLSpyc+YQFxBYViJZYvG8KmC0s4CXxZ3cTE8ggEYHFjBILru5k
        B3GYBTYySmxumgo2iVlAXOLWk/lgq9kEtCW+r18MdCsHByfQtgsXJSBK5CW2v50D9o+EwFwO
        ifYPk9ghznaR6F/7AcoWlnh1fAuULSXx+d1eqNeyJdqn/2GFsCskLm6YDRU3lpj1rJ0RZBez
        gKbE+l36IKaEgLLEkVssEGv5JDoO/2WHCPNKdLQJQTSqSdyfeg5qiIzEpCMrmSBKPCSm7Cud
        wKg4CylQZiF5cRaSX2YhrF3AyLKKUSy1oDg3PbXYqMAYHtXJ+bmbGMGJVct9B+OMtx/0DjEy
        cTAeYpTgYFYS4V2VEJYixJuSWFmVWpQfX1Sak1p8iNEUGDUTmaVEk/OBqT2vJN7QxNLAxMzM
        0NzI1MBcSZxX2vZkspBAemJJanZqakFqEUwfEwenVAOTVMyXZi+Wq/+zdqz6sfxn83m/M2tK
        ZNk6V91efZJdUGPpp83TKiTOn9QW3249S2S+iMSPqL/n2BsW5G9SlrOvuSMvser+BWO1f1N/
        nv59R2fVPY6LFxfcX67YLqZu3V86y2u9Zq360Xtp1qG9hoZ9V7/y2+5xfytmHH3zsseh2T41
        x737+7/Unv6rZdGxXNDEmGH9rq8ffvumenSEmqz5Ymc65UjLS9eYT++eF1U6rr9f+ebe/9yF
        X5ljeEu4J62+7fWo+/yZ36sdlod7yX83qF8XayX9znSz1WsJUdHk05EVu0Kn7Y7f9Mrl4dFN
        X78Gn3jM4+wToun5w+ekU8jG5c3Ju/8vSLP/8/mEjcJUPiWW4oxEQy3mouJEABtd3J41BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXpc1JCLF4PgmGYsH87axWSz+8ZzJ
        YurDJ2wWl/drW+x9vZXdYtPja6wWl3fNYbOYcX4fk0Xjx5vsDpwe15d8YvbYtKqTzePOtT1s
        HpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxtumvywFO5UrNk5YzdLA2CzdxcjJISFg
        InHs0WYmEFtIYAejxKb3lhBxGYnlz/rYIGxhifstR1ghal4ySsyaFg9i8wrYSSw80s4OYrMI
        qEi8eP+VESIuKHFy5hMWEFtUIFrixvJvYPOFBbwk/uxuArK5OEQEFjNKTGzcBuYwC2xklFh5
        fT0ziCMk8JtR4vetx2CjmAXEJW49mQ/WziagLfF9/WKgMzg4OIFWX7goAVFiJtG1tQuqXF5i
        +9s5zBMYhWYhOWQWkkmzkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
        cERpae1g3LPqg94hRiYOxkOMEhzMSiK8qxLCUoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6
        GS8kkJ5YkpqdmlqQWgSTZeLglGpgWljBdktOOpWnOSvD47OZY2p70+nsjpSw9p23+hRWrIq/
        kmHeG2rLZPPscfcf0+l7VfdKi+S0zghNnl9r86rV3sXy3kL9X1enhW2dNKM7t1uC/+ebu/0f
        LxSnH/rzen72MrkFu3x1FtlJ6v1e8/XffLvjua5/64QswnWOH35h86pkmkBuk/aNiz6LjvRW
        tbyN1a5wWbF5ruC8U5aKPH9rz66rcX6hLOb4ckr1jw6+Z4dPTuSJPSQh2Mvwa2mNW0/Y3t/b
        T8uuZ1pR6Mm7gT3rd0hS7yGdFxlCJ9f1t7Hf49l37yjHVBehl0bTG9sSo8o3rJEQuhdpnfb5
        4oeWKQ8NN6w8w75lj3iiQLVVCr+dEktxRqKhFnNRcSIATjDzQRcDAAA=
X-CMS-MailID: 20230508014437epcas2p3078ac91705aba3019cbad406a5bf2cef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
        <CGME20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f@epcas2p3.samsung.com>
        <20230502062813.112434-4-jaewon02.kim@samsung.com>
        <53b60eca-e8ab-3ff3-61a4-019ccac6cd65@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 5. 5. 18:47, Krzysztof Kozlowski wrote:
> On 02/05/2023 08:28, Jaewon Kim wrote:
>> Support interrupt based pio mode to optimize cpu usage.
>> When transmitting data size is larget than 32 bytes, operates with
>> interrupt based pio mode.
>>
>> By using the FIFORDY INT, an interrupt can be triggered when
>> the desired size of data has been received. Using this, we can support
>> interrupt based pio mode.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/spi/spi-s3c64xx.c | 66 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 58 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 2a8304678df9..323c6da9730b 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -58,6 +58,8 @@
>>   #define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
>>   #define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
>>   #define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
>> +#define S3C64XX_SPI_MODE_RX_RDY_LVL		GENMASK(16, 11)
>> +#define S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT	11
>>   #define S3C64XX_SPI_MODE_SELF_LOOPBACK		(1<<3)
>>   #define S3C64XX_SPI_MODE_RXDMA_ON		(1<<2)
>>   #define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
>> @@ -114,6 +116,8 @@
>>   
>>   #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
>>   
>> +#define S3C64XX_SPI_POLLING_SIZE	32
>> +
>>   #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>>   #define is_polling(x)	(x->cntrlr_info->polling)
>>   
>> @@ -552,7 +556,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
>>   }
>>   
>>   static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>> -				struct spi_transfer *xfer)
>> +				struct spi_transfer *xfer, bool use_irq)
>>   {
>>   	void __iomem *regs = sdd->regs;
>>   	unsigned long val;
>> @@ -573,6 +577,12 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>   	if (RX_FIFO_LVL(status, sdd) < xfer->len)
>>   		usleep_range(time_us / 2, time_us);
>>   
>> +	if (use_irq) {
>> +		val = msecs_to_jiffies(ms);
>> +		if (!wait_for_completion_timeout(&sdd->xfer_completion, val))
>> +			return -EIO;
>> +	}
>> +
>>   	val = msecs_to_loops(ms);
>>   	do {
>>   		status = readl(regs + S3C64XX_SPI_STATUS);
>> @@ -735,10 +745,13 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
>>   	void *rx_buf = NULL;
>>   	int target_len = 0, origin_len = 0;
>>   	int use_dma = 0;
>> +	bool use_irq = false;
>>   	int status;
>>   	u32 speed;
>>   	u8 bpw;
>>   	unsigned long flags;
>> +	u32 rdy_lv;
>> +	u32 val;
>>   
>>   	reinit_completion(&sdd->xfer_completion);
>>   
>> @@ -759,17 +772,46 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
>>   	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
>>   		use_dma = 1;
>>   
>> -	} else if (xfer->len > fifo_len) {
>> +	} else if (xfer->len >= fifo_len) {
> I don't fully understand this. If len equals to fifo_len, everything
> would fit into FIFO so no need for all this?

If the FIFO is filled with data, TX Overrun & RX Underrun interrupts 
will occur.

In CPU polling, there is no such issue because data is read before an 
interrupt occurs.

And, RDY_LVL has only 6 bits.(max. 63). we cannot set trigger level on 
the FIFO max size.


>>   		tx_buf = xfer->tx_buf;
>>   		rx_buf = xfer->rx_buf;
>>   		origin_len = xfer->len;
>> -
>>   		target_len = xfer->len;
>> -		if (xfer->len > fifo_len)
>> -			xfer->len = fifo_len;
>> +		xfer->len = fifo_len - 1;
>>   	}
>>   
>>   	do {
>> +		/* transfer size is greater than 32, change to IRQ mode */
>> +		if (xfer->len > S3C64XX_SPI_POLLING_SIZE)
>> +			use_irq = true;
>> +
>> +		if (use_irq) {
>> +			reinit_completion(&sdd->xfer_completion);
>> +
>> +			rdy_lv = xfer->len;
> Style is:
>
> /*
>   *
>
>> +			/* Setup RDY_FIFO trigger Level
>> +			 * RDY_LVL =
>> +			 * fifo_lvl up to 64 byte -> N bytes
>> +			 *               128 byte -> RDY_LVL * 2 bytes
>> +			 *               256 byte -> RDY_LVL * 4 bytes
> I don't understand it. Based on this equation for 256 bytes,
> RDY_LVL = RDY_LVL * 4?
> Didn't you mean xfer->len?

In v4, I will change it to the following

/*
  * Trigger Level =
  * (N = value of RDY_LVL field)
  * fifo_lvl up to 64 byte -> N bytes
  *               128 byte -> N * 2 bytes
  *               256 byte -> N * 4 bytes
  */

>
>
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

