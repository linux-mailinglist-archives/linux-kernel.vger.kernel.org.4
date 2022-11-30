Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6200163E39F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiK3WsV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 17:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiK3WsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:48:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866E02035A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 14:48:15 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-48-b7-QnvoZO7-9gfia73WI0A-1; Wed, 30 Nov 2022 22:48:12 +0000
X-MC-Unique: b7-QnvoZO7-9gfia73WI0A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 22:48:11 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Wed, 30 Nov 2022 22:48:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>
CC:     Andrei Vagin <avagin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] time/namespace: Forbid timens page faults under
 kthread_use_mm()
Thread-Topic: [PATCH 2/2] time/namespace: Forbid timens page faults under
 kthread_use_mm()
Thread-Index: AQHZBE/IlsN+XpW55U+9wjAjQGZIJa5YEbrw
Date:   Wed, 30 Nov 2022 22:48:11 +0000
Message-ID: <1c767e89dcf8475f90d2d817b9096a55@AcuMS.aculab.com>
References: <20221129191839.2471308-1-jannh@google.com>
 <20221129191839.2471308-2-jannh@google.com> <87fse1v4rf.ffs@tglx>
 <CAG48ez3UBb3Aq7+AFSmRj5a9czmew5b0PEdhWQ9qvQdeejnJZg@mail.gmail.com>
 <87y1rttid2.ffs@tglx>
In-Reply-To: <87y1rttid2.ffs@tglx>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner
> Sent: 30 November 2022 00:08
....
> >> None of those VDSO (user space) addresses are subject to be faulted in
> >> by anything else than the associated user space task(s).
> >
> > Are you saying that it's not possible or that it doesn't happen when
> > userspace is well-behaved?
> 
> My subconcious self told me that a kthread won't do that unless it's
> buggered which makes the vdso fault path the least of our problems, but
> thinking more about it: You are right, that there are ways that the
> kthread ends up with a vdso page address.... Bah!
> 
> Still my point stands that this is not a timens VDSO issue, but an issue
> of: kthread tries to fault in a VDSO page of whatever nature.

Isn't there also the kernel code path where one user thread
reads data from another processes address space.
(It does some unusual calls to the iov_import() functions.)
I can't remember whether it is used by strace or gdb.
But there is certainly the option of getting to access
an 'invalid' address in the other process and then faulting.

ISTR not being convinced that there was a correct check
for user/kernel addresses in it either.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

