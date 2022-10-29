Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D3612250
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ2LXM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 29 Oct 2022 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2LXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:23:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F418CD2EC
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:23:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-2-oskDvvDuMcG4CvHtLEYEfA-1; Sat, 29 Oct 2022 12:23:07 +0100
X-MC-Unique: oskDvvDuMcG4CvHtLEYEfA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 29 Oct
 2022 12:23:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Sat, 29 Oct 2022 12:23:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Sa, Nuno'" <Nuno.Sa@analog.com>, Deepak R Varma <drv@mailo.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: iio: ad5933: Use div64_ul instead of do_div
Thread-Topic: [PATCH] staging: iio: ad5933: Use div64_ul instead of do_div
Thread-Index: AQHY6ks4nrCWT2KFn0+DLX/dNrKI2K4jloMggAGkz5A=
Date:   Sat, 29 Oct 2022 11:23:06 +0000
Message-ID: <5740bcb3490d4c17bd9bc731e79b174b@AcuMS.aculab.com>
References: <Y1r4EaDvEipzhaaf@ubunlion>
 <SJ0PR03MB6778EAAB4132374270E96FFB99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB6778EAAB4132374270E96FFB99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
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

> > -----Original Message-----
> > From: Deepak R Varma <drv@mailo.com>
> >
> > [External]
> >
> > do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> > which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> > to avoid a possible truncation. Issue was identified using the
> > coccicheck tool.

These changes should all get nacked unless the domain of the values
can be shown to be out of range.

The entire point of do_div() is that because division is expensive
using a limited range division is significantly faster.

Even on Intel 64 bit cpu the 64 by 32 divide is significantly
faster then a full 64 bit divide for the same input values.

One might also question why the divisor is actually 'unsigned long'
at all. The code is almost certainly expected to compile for 32bit
so the domain of the value should fit in 32 bits.
So either the type could be unsigned int, or it really doesn't matter
that the value is truncated to 32bit because it can never be larger.

	David


> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

