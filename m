Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B583722751
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjFENY3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 09:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjFENY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:24:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730B7EA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:24:22 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-2-O5Y6mELAM7an8ptyuTEDNw-1; Mon, 05 Jun 2023 14:24:19 +0100
X-MC-Unique: O5Y6mELAM7an8ptyuTEDNw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 5 Jun
 2023 14:24:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 5 Jun 2023 14:24:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
CC:     Dave Kleikamp <shaggy@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] jfs: Use unsigned variable for length calculations
Thread-Topic: [PATCH] jfs: Use unsigned variable for length calculations
Thread-Index: AQHZlKngOBVLl6H9ZkS0fkY79qOf5698NwmA
Date:   Mon, 5 Jun 2023 13:24:07 +0000
Message-ID: <a84cfb004c5f43589129d70b9b39c2b2@AcuMS.aculab.com>
References: <20230204183355.never.877-kees@kernel.org>
 <Y96/SUlPUl7xH1NO@gallifrey> <63e1486a.050a0220.7001.ca15@mx.google.com>
 <Y+FaEp2blurmgVlH@gallifrey> <202306010954.23972A710A@keescook>
In-Reply-To: <202306010954.23972A710A@keescook>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook
> Sent: 01 June 2023 17:55
> 
> On Mon, Feb 06, 2023 at 07:50:42PM +0000, Dr. David Alan Gilbert wrote:
> > * Kees Cook (keescook@chromium.org) wrote:
> > > On Sat, Feb 04, 2023 at 08:25:45PM +0000, Dr. David Alan Gilbert wrote:
...
> > > > > -	int ssize;		/* source pathname size */
> > > > > +	u32 ssize;		/* source pathname size */
> > > >
> > > > Had you considered using size_t - this is set from a strlen and used by a memcpy
> > > > that both talk size_t.
> > >
> > > I considered that, but I've had other maintainers upset about doubling
> > > the variable size.
> >
> > I bet at least on some platforms it's cheaper as the 64 bit.
> >
> > > I opted to keep the variable 32-bit here, so the
> > > machine code would only change to lose signed-ness.

On x86-64 'unsigned int' and 'signed long' are likely to
generate the best code.

If you use 'signed int' it will to have to be sign extended
if used in a 64-bit expression (eg as an array index).

(That is probably true of most 64bit arch.)

OTOH 'unsigned long' always requires a REX prefix - making the
code that bit larger.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

