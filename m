Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1101E742870
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjF2Oc0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjF2OcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:32:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A9A2D63
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:32:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-109-zbBpsLNbOwCDzi8T2c0qSg-1; Thu, 29 Jun 2023 15:32:14 +0100
X-MC-Unique: zbBpsLNbOwCDzi8T2c0qSg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 15:32:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 15:32:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: RE: [PATCH v1 1/1] kasan: Replace strreplace() with strchrnul()
Thread-Topic: [PATCH v1 1/1] kasan: Replace strreplace() with strchrnul()
Thread-Index: AQHZqdYu4WwBl+H04Ei+qjwMbhdjFK+h2Qxw
Date:   Thu, 29 Jun 2023 14:32:13 +0000
Message-ID: <6b241f45a61f40fe9b221696289fd658@AcuMS.aculab.com>
References: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko
> Sent: 28 June 2023 16:34
> 
> We don't need to traverse over the entire string and replace
> occurrences of a character with '\0'. The first match will
> suffice. Hence, replace strreplace() with strchrnul().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  mm/kasan/report_generic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 51a1e8a8877f..63a34eac4a8c 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -264,6 +264,7 @@ static void print_decoded_frame_descr(const char *frame_descr)
>  	while (num_objects--) {
>  		unsigned long offset;
>  		unsigned long size;
> +		char *p;
> 
>  		/* access offset */
>  		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> @@ -282,7 +283,7 @@ static void print_decoded_frame_descr(const char *frame_descr)
>  			return;
> 
>  		/* Strip line number; without filename it's not very helpful. */
> -		strreplace(token, ':', '\0');
> +		p[strchrnul(token, ':') - token] = '\0';

Isn't 'p' undefined here?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

