Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A58688980
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjBBWDE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Feb 2023 17:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjBBWCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:02:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D046B0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:02:29 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-12-478z_lYPOei3OtwiRyw-yA-1; Thu, 02 Feb 2023 22:02:26 +0000
X-MC-Unique: 478z_lYPOei3OtwiRyw-yA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 2 Feb
 2023 22:02:25 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 2 Feb 2023 22:02:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Carpenter' <error27@gmail.com>
CC:     'Guru Mehar Rachaputi' <gurumeharrachaputi@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: pi433: modify bit_rate from u16 to u32
Thread-Topic: [PATCH] staging: pi433: modify bit_rate from u16 to u32
Thread-Index: AQHZNV2KzQ5LmfuLeUG1rTftT0qCPq66BnZAgAAPVoCAAiKyIA==
Date:   Thu, 2 Feb 2023 22:02:25 +0000
Message-ID: <08b38578bb0f4088aeedbf4b179d9c59@AcuMS.aculab.com>
References: <Y9h42l/8EcPqn63x@combine-ThinkPad-S1-Yoga>
 <Y9ilj812USHrSXe+@kroah.com> <Y9jrOKMGl7ITKxhP@combine-ThinkPad-S1-Yoga>
 <19e492521b4a4d31aa13c45e8616689b@AcuMS.aculab.com> <Y9pno7gZHa+r/Rg3@kadam>
In-Reply-To: <Y9pno7gZHa+r/Rg3@kadam>
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

From: Dan Carpenter
> Sent: 01 February 2023 13:23
> 
> On Wed, Feb 01, 2023 at 12:34:50PM +0000, David Laight wrote:
> > In reality having a uapi structure with embedded padding should
> > be banned.
> > But that would need a compiler attribute to enforce it.
> 
> It would be simple enough to grep the names of all the UAPI struct and
> use pahole to make a list of the existing structs which have holes.
> Then re-run the script every week and complain when new holey struct
> types are added.
> 
> You could do a similar thing with Smatch looking at copy_to/from_user()
> struct types.

Would it be possible to add aa attribute and check to sparse?

Might persuade people to use it instead of 'packed' for structures
that map defined byte layouts and so mustn't be holey - but are
never actually misaligned in memory.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

