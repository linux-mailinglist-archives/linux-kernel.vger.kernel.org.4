Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC15970F6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjEXMyb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 08:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjEXMy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:54:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAED5AA
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:54:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-239-Yfj8il36OwiJ2kUaRuBpBw-1; Wed, 24 May 2023 13:54:21 +0100
X-MC-Unique: Yfj8il36OwiJ2kUaRuBpBw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 May
 2023 13:54:20 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 May 2023 13:54:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, "LTP List" <ltp@lists.linux.it>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        X86 ML <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: RE: qemu-x86_64 compat: LTP: controllers: RIP: 0010:__alloc_pages
Thread-Topic: qemu-x86_64 compat: LTP: controllers: RIP: 0010:__alloc_pages
Thread-Index: AQHZjjGxuHnxTw0F/kqC+Nbr0ednxK9pYAcQ
Date:   Wed, 24 May 2023 12:54:20 +0000
Message-ID: <8414a2adfee94b589458766b52f49421@AcuMS.aculab.com>
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
 <3a055da0-fd88-4ec0-b006-9ccd382e9cc6@app.fastmail.com>
In-Reply-To: <3a055da0-fd88-4ec0-b006-9ccd382e9cc6@app.fastmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann
> Sent: 24 May 2023 12:18
> 
> On Wed, May 24, 2023, at 11:02, Naresh Kamboju wrote:
> > While running LTP controllers following kernel crash noticed on qemu-x86_64
> > compat mode with stable-rc 6.3.4-rc2.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> >  Linux version 6.3.4-rc2 (tuxmake@tuxmake) (x86_64-linux-gnu-gcc
> > (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1
> > SMP PREEMPT_DYNAMIC @1684862676
> > ..
> > ./runltp -f controllers
> > ...
> > cpuset_inherit 11 TPASS: cpus: Inherited information is right!
> > cpuset_inherit 13 TPASS: mems: Inherited information is right!
> > <4>[ 1130.117922] int3: 0000 [#1] PREEMPT SMP PTI
> > <4>[ 1130.118132] CPU: 0 PID: 32748 Comm: cpuset_inherit_ Not tainted
> > 6.3.4-rc2 #1
> > <4>[ 1130.118216] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.14.0-2 04/01/2014
> > <4>[ 1130.118320] RIP: 0010:__alloc_pages+0xeb/0x340
> > <4>[ 1130.118605] Code: 48 c1 e0 04 48 8d 84 01 00 13 00 00 48 89 45
> > a8 8b 05 d9 31 cf 01 85 c0 0f 85 05 02 00 00 89 d8 c1 e8 03 83 e0 03
> > 89 45 c0 66 <90> 41 89 df 41 be 01 00 00 00 f6 c7 04 75 66 44 89 e6 89
> > df e8 ec
> 
> I haven't figured out what is going on here, but I tracked down
> the trapping instruction <90> to the middle of the 'xchg   %ax,%ax'
> two-byte nop in:
> 
> ffffffff814218f4:       83 e0 03                and    $0x3,%eax
> ffffffff814218f7:       89 45 c0                mov    %eax,-0x40(%rbp)
> ffffffff814218fa:       66 90                   xchg   %ax,%ax
> ffffffff814218fc:       41 89 df                mov    %ebx,%r15d
> ffffffff814218ff:       41 be 01 00 00 00       mov    $0x1,%r14d
> 
> which in turn is the cpusets_enabled() check in prepare_alloc_pages().

Does that code actually match the call/return stack?

It is pretty much impossible to get a trap on an 0x90 byte.
I think you'd need to jump to it and then get a page fault.

So I bet that isn't the code that was actually being executed.
So either the fault address is garbage or something horrid(tm)
has happened to the page tables.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

