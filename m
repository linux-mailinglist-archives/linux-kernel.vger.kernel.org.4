Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56961722368
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjFEK2F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjFEK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:28:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B23FA6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:28:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-263-SIO9pMM2PmCSq1FrXnM_pA-1; Mon, 05 Jun 2023 11:27:57 +0100
X-MC-Unique: SIO9pMM2PmCSq1FrXnM_pA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 5 Jun
 2023 11:27:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 5 Jun 2023 11:27:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
CC:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Steven Noonan <steven@uplinklabs.net>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: Direct rdtsc call side-effect
Thread-Topic: Direct rdtsc call side-effect
Thread-Index: AQHZlHOrHGvpd378GUKTvqmuipgWK698BnPA
Date:   Mon, 5 Jun 2023 10:27:46 +0000
Message-ID: <353732783fde46919fdcf698c326b7ed@AcuMS.aculab.com>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
 <87mt1jeax1.ffs@tglx>
In-Reply-To: <87mt1jeax1.ffs@tglx>
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

...
> Who would have thought that rdtsc() in applications can be a problem.
> Interfaces to query time exist for a reason and it's documented by
> Microsoft:
> 
> https://learn.microsoft.com/en-us/windows/win32/dxtecharts/game-timing-and-multicore-processors
> 
> But sure, reading documentation is overrated...

That eve says:
   "Multiprocessor and dual-core systems do not guarantee synchronization
   of their cycle counters between cores."

.
> Synchronizing TSC by writing the TSC MSR is fragile as hell. This has
> been tried so often and never reliably passed all synchronization tests
> on a wide range of systems.
> 
> It kinda works on single socket, but not on larger systems.
> 
> We spent an insane amount of time to make timekeeping correct and I'm
> not interested at all to deal with the fallout of such a mechanim.

I've wondered whether the TSC ought to be deliberately mis-synchronised?
So the high order bits are effectively the cpu number.

It has to be said that using it as a time source was fundamentally
a bad idea.
Sometimes (eg micro benchmarks) you really want a TSC.
You can extract one from the performance counters, but it is hard,
root only, and the library functions have high and variable overhead.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

