Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA7673441
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjASJVP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Jan 2023 04:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjASJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:21:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2507A5412A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:21:10 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-280-X0-dLLTkMYurBUVT-7NQTQ-1; Thu, 19 Jan 2023 09:21:07 +0000
X-MC-Unique: X0-dLLTkMYurBUVT-7NQTQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Jan
 2023 09:21:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Thu, 19 Jan 2023 09:21:06 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tejun Heo' <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Richard Clark <richard.xnu.clark@gmail.com>,
        =?iso-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        "Andrey Grodzovsky" <andrey.grodzovsky@amd.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org," <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] workqueue: fix enum type for gcc-13
Thread-Topic: [PATCH] workqueue: fix enum type for gcc-13
Thread-Index: AQHZKpKFluEYnxF+H0aveYqsdFdjha6j5uGAgAESbYCAAH4KkA==
Date:   Thu, 19 Jan 2023 09:21:06 +0000
Message-ID: <0f84c480eb3c4972bbd34b45ddf258f2@AcuMS.aculab.com>
References: <20230117164041.1207412-1-arnd@kernel.org>
 <99ea6e86d2594b40a6de96cc821c447b@AcuMS.aculab.com>
 <Y8ggiF+7k0rViXcY@slm.duckdns.org>
 <a1d48420-862e-47e6-9435-462e23bb6be3@app.fastmail.com>
 <Y8if47fU4C+06JNz@slm.duckdns.org>
In-Reply-To: <Y8if47fU4C+06JNz@slm.duckdns.org>
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

From: Tejun Heo
> Sent: 19 January 2023 01:42
> 
> On Wed, Jan 18, 2023 at 09:32:45PM +0100, Arnd Bergmann wrote:
> > the enum type has to be compatible with 'long long' because
> > anything shorter would not fit both -1 and -1u (UINT_MAX).
> > A and B were both signed types to match the signedness of the
> > enum type, but A was actually a 32-bit integer since that is
> > sufficient, while B was also a 64-bit type since it exceeds
> > INT_MAX. Now they are both the same type.
> 
> Yeah, the new behavior makes total sense.
> 
> > I don't think there is a chance they will revert to the old behavior,
> > though we could try asking for an command line flag to warn about
> > cases where this changes code generation.
> 
> but the way that it's transitioning doesn't really make sense to me. We do
> phase out support for old compilers, so it isn't that difficult to manage
> this transition smoothly - add a compat option in the new versions, switch
> code later once old compilers are phased out and drop the compat flag.
> 
> The way it's currently done causes situations which can't be handled
> logically - we end up having to regroup enums based on their value range
> rather than the logical type they need to be because there's no way to
> override the enum type on older compilers.

Didn't someone say that either C++ or C23 defines a syntax to explicitly
set the type of the enum.
IIRC gcc-13 doesn't support that.

If gcc-13 supported explicit setting of the type and also generated a
warn/error enum with 'large' values when the type wasn't specified
(ie where the gcc extension had been used) then at least there would
be no obscure surprises.
Getting an old gcc to ignore the type is easy.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

