Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719EF60C9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiJYKSQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Oct 2022 06:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiJYKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:17:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB419422E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:11:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-401-qTScbXqrP4K83qMr_k6SYQ-1; Tue, 25 Oct 2022 11:11:46 +0100
X-MC-Unique: qTScbXqrP4K83qMr_k6SYQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Oct
 2022 11:11:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 25 Oct 2022 11:11:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: cisco: do not assign -1 to unsigned char
Thread-Topic: [PATCH] wifi: cisco: do not assign -1 to unsigned char
Thread-Index: AQHY59R5xUZLlXp/uUKMcxzA+c8H1K4e4hAA
Date:   Tue, 25 Oct 2022 10:11:44 +0000
Message-ID: <6a1652ab408d4c5d8ba754f35680e792@AcuMS.aculab.com>
References: <20221024162843.535921-1-Jason@zx2c4.com>
In-Reply-To: <20221024162843.535921-1-Jason@zx2c4.com>
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

From: Jason A. Donenfeld
> Sent: 24 October 2022 17:29
> 
> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, we get a warning when assigning the
> unchecked output of hex_to_bin() to that unsigned char. Mark `key` as a
> `u8`, which matches the struct's type, and then check each call to
> hex_to_bin() before casting.
> 
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/net/wireless/cisco/airo.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> index 10daef81c355..fb2c35bd73bb 100644
> --- a/drivers/net/wireless/cisco/airo.c
> +++ b/drivers/net/wireless/cisco/airo.c
> @@ -5232,7 +5232,7 @@ static int get_wep_tx_idx(struct airo_info *ai)
>  	return -1;
>  }
> 
> -static int set_wep_key(struct airo_info *ai, u16 index, const char *key,
> +static int set_wep_key(struct airo_info *ai, u16 index, const u8 *key,
>  		       u16 keylen, int perm, int lock)
>  {
>  	static const unsigned char macaddr[ETH_ALEN] = { 0x01, 0, 0, 0, 0, 0 };
> @@ -5283,7 +5283,7 @@ static void proc_wepkey_on_close(struct inode *inode, struct file *file)
>  	struct net_device *dev = pde_data(inode);
>  	struct airo_info *ai = dev->ml_priv;
>  	int i, rc;
> -	char key[16];
> +	u8 key[16];
>  	u16 index = 0;
>  	int j = 0;
> 
> @@ -5311,12 +5311,22 @@ static void proc_wepkey_on_close(struct inode *inode, struct file *file)
>  	}
> 
>  	for (i = 0; i < 16*3 && data->wbuffer[i+j]; i++) {
> +		int val;
> +
> +		if (i % 3 == 2)
> +			continue;
> +
> +		val = hex_to_bin(data->wbuffer[i+j]);
> +		if (val < 0) {
> +			airo_print_err(ai->dev->name, "WebKey passed invalid key hex");
> +			return;
> +		}
>  		switch(i%3) {
>  		case 0:
> -			key[i/3] = hex_to_bin(data->wbuffer[i+j])<<4;
> +			key[i/3] = (u8)val << 4;
>  			break;
>  		case 1:
> -			key[i/3] |= hex_to_bin(data->wbuffer[i+j]);
> +			key[i/3] |= (u8)val;
>  			break;
>  		}
>  	}

That is about the crappiest loop I've seen.
I was just going to point out that the (u8) casts aren't needed.
Something like:
	for (i = 0, buf = data->wbuffer + j; i < 16; i++, buf += 3) {
		int val;
		if (!buf[0] || !buf[1])
			break;
		val = hex_to_bin(buf[0]) | hex_to_bin(buf[1]) << 8;
		if (val < 0) {
			airo_print_err(ai->dev->name, "WebKey passed invalid key hex");
			return;
		}
		key[i] = val;
		if (!buf[2])
			break;
	}

Although there should be a check for buf[2] being valid.
Any I worry about exactly what happens if there aren't 16 full bytes.

	David

		

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

