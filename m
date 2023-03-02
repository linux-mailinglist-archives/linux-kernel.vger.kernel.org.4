Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1536A8C0A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCBWlo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Mar 2023 17:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCBWln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:41:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DCD4DE0C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:41:41 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-264-PvAjbCtRPHihBSSlL2U9CA-1; Thu, 02 Mar 2023 22:41:38 +0000
X-MC-Unique: PvAjbCtRPHihBSSlL2U9CA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Thu, 2 Mar
 2023 22:41:36 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Thu, 2 Mar 2023 22:41:36 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        John Stultz <jstultz@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        "Midas Chien" <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Anton Vorontsov" <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Thread-Topic: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Thread-Index: AQHZTUSK7fWJqBV/U0q1fZmOSFQwN67oEXJw
Date:   Thu, 2 Mar 2023 22:41:36 +0000
Message-ID: <dcf2fa0bde1e49a286c57c1e7d4a78d3@AcuMS.aculab.com>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230302082414.77613351@gandalf.local.home>
        <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
 <20230302152103.2618f1b7@gandalf.local.home>
In-Reply-To: <20230302152103.2618f1b7@gandalf.local.home>
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

From: Steven Rostedt
> Sent: 02 March 2023 20:21
...
> There's no harm in spinning, as the task can still be preempted, and
> there's no issue of priority inversion, because the spinners will not be on
> the same CPU as the owner and the top waiter, if they only spin if those
> two tasks are also running on a CPU.

ISTM that a spinlock should spin - even on an RT kernel.
If it might spin for longer than it takes to do a process
switch it shouldn't be a spinlock at all.
(I bet there are quite a few that do spin for ages...)
Adaptive spinning for a sleep lock (as an optimisation)
is entirely different.

I changed some very old driver code that used sema4 (which
always sleep) to mutex (which quite often spin) and got a
massive performance gain.

I've also had terrible problems trying to get a multithreaded
user program to work well [1].
Because you don't have spinlocks (userpace can always be preempted)
you can't bound the time mutex are held for.
So any vaguely 'hot' lock (maybe just used to remove an item
from a list) can get interrupted by a hardware interrupt.
The only way to make it work is to use atomic operations
instead of mutex.

I can't help feeing that the RT kernel suffers from the
same problems if the system is under any kind of load.
You might get slightly better RT response, but the overall
amount of 'work' a system can actually do will be lower.

[1] Test was 36 threads on a 40 cpu system that need to
spend about 90% of the time processing RTP (UDP) audio.
This also involves 500k ethernet packets/sec (tx and rx).
It is all possible, but there were a lot of pitfalls.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

