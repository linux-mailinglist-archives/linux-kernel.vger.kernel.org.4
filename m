Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C961789E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKCIYX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Nov 2022 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKCIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:24:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8896168
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:24:19 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-313-XVMppRVmPTmC9nCcaFVojQ-1; Thu, 03 Nov 2022 08:24:17 +0000
X-MC-Unique: XVMppRVmPTmC9nCcaFVojQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Nov
 2022 08:24:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Thu, 3 Nov 2022 08:24:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Deepak R Varma' <drv@mailo.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: rtl8192e: Use min_t/max_t macros for variable
 comparison
Thread-Topic: [PATCH] staging: rtl8192e: Use min_t/max_t macros for variable
 comparison
Thread-Index: AQHY7wupCXQamuU4VU+fXwTqUG6oz64s3Icw
Date:   Thu, 3 Nov 2022 08:24:15 +0000
Message-ID: <d8fa86bf71694f23b8f175245722e86f@AcuMS.aculab.com>
References: <Y2LxC2kziM1TznhO@qemulion>
In-Reply-To: <Y2LxC2kziM1TznhO@qemulion>
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

From: Deepak R Varma
> Sent: 02 November 2022 22:37
> 
> Simplify code by using min_t and max_t helper macros in place of lengthy
> if/else block oriented logical evaluation and value assignment. This
> issue is identified by coccicheck using the minmax.cocci file.
> 
> Use the *_t variants of min/max macros to avoid compiler warnings about
> data typecast.
> Also, use u32 as type for min_t macro to avoid any truncation of data
> associated with enum constant HT_AGG_SIZE_32K.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 62aa8e893c34..ccb86660ab48 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -587,17 +587,12 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
>  			else
>  				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
>  		} else {
> -			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
> -				pHTInfo->CurrentAMPDUFactor =
> -						 pPeerHTCap->MaxRxAMPDUFactor;
> -			else
> -				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_32K;
> +			pHTInfo->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
> +							    HT_AGG_SIZE_32K);

For min() to fail there must be a signed v unsigned mismatch.
Maybe that ought to be fixed.

>  		}
>  	}
> -	if (pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
> -		pHTInfo->current_mpdu_density = pHTInfo->MPDU_Density;
> -	else
> -		pHTInfo->current_mpdu_density = pPeerHTCap->MPDUDensity;
> +	pHTInfo->current_mpdu_density = max_t(u8, pHTInfo->MPDU_Density,
> +					      pPeerHTCap->MPDUDensity);

Using u8 with max_t() really doesn't make any sense.
The value will get promoted to signed int prior to the comparison.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

