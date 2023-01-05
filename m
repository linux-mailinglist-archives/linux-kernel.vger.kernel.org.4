Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9A565EEFA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjAEOlx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Jan 2023 09:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjAEOlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:41:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702E42678
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:41:47 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-267-TONGIBv5N4Gn3vUIarjFdA-1; Thu, 05 Jan 2023 14:41:44 +0000
X-MC-Unique: TONGIBv5N4Gn3vUIarjFdA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 5 Jan
 2023 14:41:43 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Thu, 5 Jan 2023 14:41:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Vetter' <daniel@ffwll.ch>
CC:     'Jani Nikula' <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        'Andrzej Hajda' <andrzej.hajda@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [Intel-gfx] [PATCH 1/5] linux/minmax.h: add non-atomic version of
 xchg
Thread-Topic: [Intel-gfx] [PATCH 1/5] linux/minmax.h: add non-atomic version
 of xchg
Thread-Index: AQHZC+X/n2yHksRnF0Csd/+tl8P8Ka5qAX6ggCX6JSGAAADCAIAAC3eAgAAFAzA=
Date:   Thu, 5 Jan 2023 14:41:43 +0000
Message-ID: <6617dfb150f94cbb9654a585843e3287@AcuMS.aculab.com>
References: <20221209154843.4162814-1-andrzej.hajda@intel.com>
 <f58ab17e5c6c4a4e8b0d687b44618c51@AcuMS.aculab.com>
 <Y7bK8drngH/NIlOa@phenom.ffwll.local> <875ydlw1p4.fsf@intel.com>
 <733cd0037bd14a269b54d701e1b80323@AcuMS.aculab.com>
 <Y7ba8UlkhjpJI4F0@phenom.ffwll.local>
In-Reply-To: <Y7ba8UlkhjpJI4F0@phenom.ffwll.local>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter
> Sent: 05 January 2023 14:13
...
> > > So here we are, with Andrzej looking to add the common helper. And the
> > > same concerns crop up. What should it be called to make it clear that
> > > it's not atomic? Is that possible?
> >
> > old_value = read_write(variable, new_value);
> >
> > But two statements are much clearer.
> 
> Yeah this is my point for fetch_and_zero or any of the other proposals.
> We're essentially replacing these two lines:
> 
> 	var = some->pointer->chase;
> 	some->pointer->chase = NULL;
> 
> with a macro. C is verbose, and sometimes painfully so,

Try ADA or VHDL :-)

> if the pointer
> chase is really to onerous then I think that should be refactored with a
> meaningfully locally name variable, not fancy macros wrapped around to
> golf a few characters away.

Provided 'var' is a local the compiler is pretty likely to only do the
'pointer chase' once.
You can also do:
	var = NULL;
	swap(some->pointer->chase, var);
and get pretty much the same object code.

> But what about swap() you ask? That one needs a temp variable, and it does
> make sense to hide that in a ({}) block in a macro.

Sometimes, but not enough for the 'missed opportunity for swap()'
message. 

> But for the above two
> lines I really don't see a point outside of obfuscated C contexts.

Indeed.

Isn't the suggested __xchg() in one of the 'reserved for implementation'
namespaces - so shouldn't be a function that might be expected to be
actually used.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

