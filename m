Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53C95EE0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiI1Pur convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Sep 2022 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1Puo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:50:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA778262B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:50:42 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-265-epL-6jk9N7WF2cxyMBC7Tg-1; Wed, 28 Sep 2022 16:50:40 +0100
X-MC-Unique: epL-6jk9N7WF2cxyMBC7Tg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 28 Sep
 2022 16:50:36 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 28 Sep 2022 16:50:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Zaidman' <michael.zaidman@gmail.com>,
        "jikos@kernel.org" <jikos@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "Guillaume Champagne" <champagne.guillaume.c@gmail.com>
Subject: RE: [PATCH v2 2/7] HID: ft260: improve i2c write performance
Thread-Topic: [PATCH v2 2/7] HID: ft260: improve i2c write performance
Thread-Index: AQHY00mUw0Kqs3OAvUmX6aS0EWBX1630/Gwg
Date:   Wed, 28 Sep 2022 15:50:36 +0000
Message-ID: <f9be53a647cd4b698ed820a70b67b7d4@AcuMS.aculab.com>
References: <20220928144854.5580-1-michael.zaidman@gmail.com>
 <20220928144854.5580-3-michael.zaidman@gmail.com>
In-Reply-To: <20220928144854.5580-3-michael.zaidman@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Zaidman
> Sent: 28 September 2022 15:49
> 
> The patch improves i2c writing performance by about 30 percent by revising
> the sleep time in the ft260_hid_output_report_check_status() in the
> following ways:

Spinning in kernel for several milliseconds isn't friendly at all.

	David

> 
> 1. Reduce the sleep time and start to poll earlier:
> 
>   Before:
>     $ sudo ./i2cperf -f 2 -o 2 -s 32 -r 0-0xff 13 0x51 -S
> 
>       Fill block with increment via i2ctransfer by chunks
>       -------------------------------------------------------------------
>       data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
>       -------------------------------------------------------------------
>       40510           80             256           8           32
> 
>   After:
>     $ sudo ./i2cperf -f 2 -o 2 -s 32 -r 0-0xff 13 0x51 -S
> 
>       Fill block with increment via i2ctransfer by chunks
>       -------------------------------------------------------------------
>       data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
>       -------------------------------------------------------------------
>       52584           80             256           8           32
> 
> 2. Do not sleep when the calculated sleep time is below 2 ms:
> 
>   Before:
>     $ sudo ./i2cperf -f 2 -o 2 -s 16 -r 0-0xff 13 0x51 -S
> 
>       Fill block with increment via i2ctransfer by chunks
>       -------------------------------------------------------------------
>       data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
>       -------------------------------------------------------------------
>       26707           73             256           16          16
> 
>   After:
>     $ sudo ./i2cperf -f 2 -o 2 -s 16 -r 0-0xff 13 0x51 -S
> 
>       Fill block with increment via i2ctransfer by chunks
>       -------------------------------------------------------------------
>       data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
>       -------------------------------------------------------------------
>       37034           73             256           16          16
> 
> Link to the i2cperf - https://github.com/MichaelZaidman/i2cperf
> 
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
> Tested-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
> ---
>  drivers/hid/hid-ft260.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index a35201d68b15..44106cadd746 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -345,7 +345,7 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
>  static int ft260_hid_output_report_check_status(struct ft260_device *dev,
>  						u8 *data, int len)
>  {
> -	int ret, usec, try = 3;
> +	int ret, usec, try = 100;
>  	struct hid_device *hdev = dev->hdev;
> 
>  	ret = ft260_hid_output_report(hdev, data, len);
> @@ -356,10 +356,14 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
>  		return ret;
>  	}
> 
> -	/* transfer time = 1 / clock(KHz) * 10 bits * bytes */
> -	usec = 10000 / dev->clock * len;
> -	usleep_range(usec, usec + 100);
> -	ft260_dbg("wait %d usec, len %d\n", usec, len);
> +	/* transfer time = 1 / clock(KHz) * 9 bits * bytes */
> +	usec = len * 9000 / dev->clock;
> +	if (usec > 2000) {
> +		usec -= 1500;
> +		usleep_range(usec, usec + 100);
> +		ft260_dbg("wait %d usec, len %d\n", usec, len);
> +	}
> +
>  	do {
>  		ret = ft260_xfer_status(dev);
>  		if (ret != -EAGAIN)
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

