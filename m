Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827AA6718EB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjARK0p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Jan 2023 05:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjARK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:26:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0385DC2A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:31:24 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-71-cy_NW6xyNAKHu3U4XRX-UA-1; Wed, 18 Jan 2023 09:31:20 +0000
X-MC-Unique: cy_NW6xyNAKHu3U4XRX-UA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Jan
 2023 09:31:18 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Wed, 18 Jan 2023 09:31:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>, Tejun Heo <tj@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Richard Clark <richard.xnu.clark@gmail.com>,
        =?iso-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        "Andrey Grodzovsky" <andrey.grodzovsky@amd.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] workqueue: fix enum type for gcc-13
Thread-Topic: [PATCH] workqueue: fix enum type for gcc-13
Thread-Index: AQHZKpKFluEYnxF+H0aveYqsdFdjha6j5uGA
Date:   Wed, 18 Jan 2023 09:31:18 +0000
Message-ID: <99ea6e86d2594b40a6de96cc821c447b@AcuMS.aculab.com>
References: <20230117164041.1207412-1-arnd@kernel.org>
In-Reply-To: <20230117164041.1207412-1-arnd@kernel.org>
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

From: Arnd Bergmann
> Sent: 17 January 2023 16:41
> 
> In gcc-13, the WORK_STRUCT_WQ_DATA_MASK constant is a signed 64-bit
> type on 32-bit architectures because the enum definition has both
> negative numbers and numbers above LONG_MAX in it:
> 
...
>  	/* convenience constants */
>  	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
> -	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
> +	WORK_STRUCT_WQ_DATA_MASK = (unsigned long)~WORK_STRUCT_FLAG_MASK,
>  	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,

How can that make any difference?
You aren't changing the value or type (which makes no difference)
of WORK_STRUCT_WQ_DATA_MASK.
Indeed you require it to have the high bit set.

So if the enum contains a -1 somewhere gcc-13 will promote
everything to s64.

Either declare gcc-13 as 'BROKEN' or change the:
	return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
to
	return (void *)(data & ~WORK_STRUCT_FLAG_MASK);

or use #defines.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

