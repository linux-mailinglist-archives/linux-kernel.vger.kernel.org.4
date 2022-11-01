Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2F614BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiKAN3u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Nov 2022 09:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiKAN3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:29:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB6F120B9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:29:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-20-AfaSK5zRMHuT_5a8roxyow-1; Tue, 01 Nov 2022 13:29:43 +0000
X-MC-Unique: AfaSK5zRMHuT_5a8roxyow-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Nov
 2022 13:29:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 1 Nov 2022 13:29:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>
CC:     'Szabolcs Nagy' <szabolcs.nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: linux interprets an fcntl int arg as long
Thread-Topic: linux interprets an fcntl int arg as long
Thread-Index: AQHY7dH4b5GlkmHz9EyVI+/nub6Ts64p0qEQgAAgcACAAAds0IAAERqAgAADzNA=
Date:   Tue, 1 Nov 2022 13:29:41 +0000
Message-ID: <267402c9e66a4cac91a2e1df749dea6a@AcuMS.aculab.com>
References: <Y1/DS6uoWP7OSkmd@arm.com> <Y2B6jcLUJ1F2y2yL@mit.edu>
 <Y2DisyknbKxeCik4@arm.com>
 <a0693686d0ae41599fe1700680ec56ec@AcuMS.aculab.com>
 <Y2EGtE05hcVn3B3a@arm.com>
 <0030a20a94cd49628c5461d044bb28ed@AcuMS.aculab.com>
 <Y2EbR6YnQcgK4B8T@FVFF77S0Q05N>
In-Reply-To: <Y2EbR6YnQcgK4B8T@FVFF77S0Q05N>
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

From: Mark Rutland
> Sent: 01 November 2022 13:13
> 
> On Tue, Nov 01, 2022 at 12:19:51PM +0000, David Laight wrote:
> > From: 'Szabolcs Nagy' <szabolcs.nagy@arm.com>
> > > Sent: 01 November 2022 11:45
> > >
> > > The 11/01/2022 10:02, David Laight wrote:
> > > > From: Szabolcs Nagy
> 
> > > kernel code:
> > > ------------
> > > SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
> > > {
> >
> > That is just a wrapper and calls do_fcntl().
> > which needs changing to be add:
> > 	arg &= ~0U;
> > before the switch(cmd) {
> 
> Just to check, do you mean the switch in do_fcntl(), or the switch within memfd_fcntl() ?
> 
> The former handles other APIs which do expect arg to be a long (e.g.
> F_SET_RW_HINT and F_GET_RW_HINT expect it to hold a full 64-bit pointer), so
> that'd break things.

The assignment to argv is earlier.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

