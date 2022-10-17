Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F93600DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJQLYn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Oct 2022 07:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJQLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:24:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2723AF596
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:24:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-BqPzGUwBNCKi-Bbkr5fcZQ-1; Mon, 17 Oct 2022 12:24:28 +0100
X-MC-Unique: BqPzGUwBNCKi-Bbkr5fcZQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Oct
 2022 12:24:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Mon, 17 Oct 2022 12:24:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v2] driver core: allow kobj_to_dev() to take a const
 pointer
Thread-Topic: [PATCH v2] driver core: allow kobj_to_dev() to take a const
 pointer
Thread-Index: AQHY4f8XIXg/6yYeA0Sep9oqtEQttq4ScXHw
Date:   Mon, 17 Oct 2022 11:24:26 +0000
Message-ID: <b13c5bb641d64433a85c52f694a838e7@AcuMS.aculab.com>
References: <20221016104126.1259809-1-gregkh@linuxfoundation.org>
 <Y00KTAobXJ0/Jgv3@paasikivi.fi.intel.com> <Y00Mfgymi+Xv6El3@kroah.com>
In-Reply-To: <Y00Mfgymi+Xv6El3@kroah.com>
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

From: Greg Kroah-Hartman
> Sent: 17 October 2022 09:04
> 
> On Mon, Oct 17, 2022 at 07:54:52AM +0000, Sakari Ailus wrote:
> > Hi Greg,
> >
> > On Sun, Oct 16, 2022 at 12:41:26PM +0200, Greg Kroah-Hartman wrote:
> > > If a const * to a kobject is passed to kobj_to_dev(), we want to return
> > > back a const * to a device as the driver core shouldn't be modifying a
> > > constant structure.  But when dealing with container_of() the pointer
> > > const attribute is cast away, so we need to manually handle this by
> > > determining the type of the pointer passed in to know the type of the
> > > pointer to pass out.
> >
> > Alternatively container_of() could be fixed, but that will likely produce
> > lots of warnings currently.
> 
> Yeah, we can not do that because, as you found out, there's just too
> many warnings that it would cause.  Let's work on the individual
> subsystems to clean them all up first before worrying about the core
> container_of() macro as that should fix the majority of the build
> warnings.

Is it possible to generate a fixed container_of() with a
different name and then use that to clean up the subsystems?
Then finally rename it back?

That you probably be a lot less churn.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

