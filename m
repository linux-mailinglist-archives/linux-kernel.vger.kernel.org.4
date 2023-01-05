Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5873765ED23
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjAENek convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Jan 2023 08:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjAENei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:34:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FF52F79C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:34:36 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-76-LkZmLSiwP3mo41Bkd9-7GA-1; Thu, 05 Jan 2023 13:34:34 +0000
X-MC-Unique: LkZmLSiwP3mo41Bkd9-7GA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 5 Jan
 2023 13:34:33 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Thu, 5 Jan 2023 13:34:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jani Nikula' <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Arnd Bergmann <arnd@arndb.de>,
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
Thread-Index: AQHZC+X/n2yHksRnF0Csd/+tl8P8Ka5qAX6ggCX6JSGAAADCAA==
Date:   Thu, 5 Jan 2023 13:34:33 +0000
Message-ID: <733cd0037bd14a269b54d701e1b80323@AcuMS.aculab.com>
References: <20221209154843.4162814-1-andrzej.hajda@intel.com>
 <f58ab17e5c6c4a4e8b0d687b44618c51@AcuMS.aculab.com>
 <Y7bK8drngH/NIlOa@phenom.ffwll.local> <875ydlw1p4.fsf@intel.com>
In-Reply-To: <875ydlw1p4.fsf@intel.com>
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

From: Jani Nikula
> Sent: 05 January 2023 13:28
> 
> On Thu, 05 Jan 2023, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, Dec 12, 2022 at 09:38:12AM +0000, David Laight wrote:
> >> From: Andrzej Hajda <andrzej.hajda@intel.com>
> >> > Sent: 09 December 2022 15:49
> >> >
> >> > The pattern of setting variable with new value and returning old
> >> > one is very common in kernel. Usually atomicity of the operation
> >> > is not required, so xchg seems to be suboptimal and confusing in
> >> > such cases. Since name xchg is already in use and __xchg is used
> >> > in architecture code, proposition is to name the macro exchange.
> >>
> >> Dunno, if it is non-atomic then two separate assignment statements
> >> is decidedly more obvious and needs less brain cells to process.
> >> Otherwise someone will assume 'something clever' is going on
> >> and the operation is atomic.
> >
> > Yes, this also my take. The i915 code that uses this to excess is decidely
> > unreadable imo, and the macro should simply be replaced by open-coded
> > versions.
> >
> > Not moved into shared headers where even more people can play funny games
> > with it.
> 
> My stand in i915 has been that the local fetch_and_zero() needs to
> go. Either replaced by a common helper in core kernel headers, or open
> coded, I personally don't care, but the local version can't stay.
> 
> My rationale has been that fetch_and_zero() looks atomic and looks like
> it comes from shared headers, but it's neither. It's deceptive. It
> started small and harmless, but things like this just proliferate and
> get copy-pasted all over the place.
> 
> So here we are, with Andrzej looking to add the common helper. And the
> same concerns crop up. What should it be called to make it clear that
> it's not atomic? Is that possible?

old_value = read_write(variable, new_value);

But two statements are much clearer.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

