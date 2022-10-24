Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E5F609E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJXJrA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Oct 2022 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJXJqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:46:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23A22B603
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:46:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-120-uHmcMPlPMjafKyj3wsslNg-1; Mon, 24 Oct 2022 10:46:42 +0100
X-MC-Unique: uHmcMPlPMjafKyj3wsslNg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Oct
 2022 10:46:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Mon, 24 Oct 2022 10:46:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Thread-Topic: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Thread-Index: AQHY54ozH4qdMwC1Yk+S6+0KOnujn64dR6XQ///w5gCAABLzkA==
Date:   Mon, 24 Oct 2022 09:46:40 +0000
Message-ID: <57360b976d5944babe1e85fc51b3f6f6@AcuMS.aculab.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com> <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
 <Y1ZZcL/Q7QJ+YYhJ@smile.fi.intel.com>
 <fbe735d131a44c2a95248cc4ad51485b@AcuMS.aculab.com>
 <Y1ZcyBd2Yjir/dNO@smile.fi.intel.com>
In-Reply-To: <Y1ZcyBd2Yjir/dNO@smile.fi.intel.com>
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

From: 'Andy Shevchenko'
> Sent: 24 October 2022 10:37
> ...
> 
> > > > > Wait, no one uses this macro, so why not just remove it entirely?
> > > >
> > > > Good question. It appears to be a (relatively) common pattern to look up
> > > > something and the return its containing object if the lookup was
> > > > successful. Doing a quick
> > > >
> > > > 	$ git grep 'container_of.*:' drivers include
> > > >
> > > > reveals more than 20 instances of the pattern. There are probably more
> > > > those that use if for testing for NULL. I guess people don't know about
> > > > this macro, apart from the developers of the staging driver it was added
> > > > for (commit 05e6557b8ed833546ee2b66ce6b58fecf09f439e).
> > >
> > > Maybe we can provide an example to keep this macro in the kernel, meaning
> > > convert one of the drivers / subsystem to actually use it?
> >
> > Adding _safe() to a function name doesn't actually tell you anything.
> > You still need to look up what it is 'safe' against.
> >
> > In this case the full code pattern is actually much clearer.
> >
> > It is also quite likely that it is followed by an:
> > 	if (!ptr)
> > 		return xxx;
> > You that can/should really be put before the container_of() call.
> 
> return statements in macros are no go. Or you meant something else?

I meant in the function itself.

It might be interesting to check how many of the function
can actually have a NULL pointer?
Especially in staging code might be being 'defensive'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

