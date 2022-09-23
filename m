Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5F5E7987
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIWLZf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Sep 2022 07:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiIWLZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:25:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B8139415
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:24:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-88-mnhmMfK-PT2rPSHOtJFAFA-1; Fri, 23 Sep 2022 12:24:21 +0100
X-MC-Unique: mnhmMfK-PT2rPSHOtJFAFA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 23 Sep
 2022 12:24:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 23 Sep 2022 12:24:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'cambda@linux.alibaba.com'" <cambda@linux.alibaba.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
Subject: RE: Syscall kill() can send signal to thread ID
Thread-Topic: Syscall kill() can send signal to thread ID
Thread-Index: AQHYzwCNj4NIUfe8L0qIx1KiSNUBva3s3edg
Date:   Fri, 23 Sep 2022 11:24:18 +0000
Message-ID: <062228e73ef444dcafbcb6056bd6c37c@AcuMS.aculab.com>
References: <69E17223-F0CA-4A4C-AAD7-065D6E6266D9@linux.alibaba.com>
 <87k05v5sqn.fsf@email.froward.int.ebiederm.org>
 <59403595-9F9B-49C4-AB62-259DD2C40196@linux.alibaba.com>
In-Reply-To: <59403595-9F9B-49C4-AB62-259DD2C40196@linux.alibaba.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> And yes, I'm tracking a bug. A service monitor, like systemd or
> some watchdog, uses kill() to check if a pid is valid or not:
>   1. Store service pid into cache.
>   2. Check if pid in cache is valid by kill(pid, 0).
>   3. Check if pid in cache is the service to watch.
> 
> So if kill(pid, 0) returns success but no process info shows on 'ps'
> command, the service monitor could be confused. The monitor could
> check if pid is tid, but this means the odd behavior would be used
> intentionally. And this workaround may be unsafe on other OS?

That looks pretty broken to me.
On Linux a pid can be reused immediately a process exits.
So there is really no guarantee that the pid is the one you want.
IIRC there are some recent changes that mean opening /proc/<pid>
will stop the pid being reused - allowing checks before sending a signal.
(Netbsd won't reuse a pid for a reasonable number of forks
and then uses a semi-random pid allocator.
Don't know whether any other 'bsd picked up that change.)

Also using signals in multi-threaded programs is pretty much
non-portable.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

