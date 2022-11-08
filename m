Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C76620C25
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiKHJ0O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Nov 2022 04:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiKHJ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:26:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E88227DD1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:26:11 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-275-iyhD-bNnNIqZzr0HEwK7vA-1; Tue, 08 Nov 2022 09:26:08 +0000
X-MC-Unique: iyhD-bNnNIqZzr0HEwK7vA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 8 Nov
 2022 09:26:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 8 Nov 2022 09:26:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jann Horn' <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] exit: Put an upper limit on how often we can oops
Thread-Topic: [PATCH] exit: Put an upper limit on how often we can oops
Thread-Index: AQHY8uVtJeqm4QnZJEegjt8nfpQUG640wW1Q
Date:   Tue, 8 Nov 2022 09:26:06 +0000
Message-ID: <3e2f7e2cb4f6451a9ef5d0fb9e1f6080@AcuMS.aculab.com>
References: <20221107201317.324457-1-jannh@google.com>
In-Reply-To: <20221107201317.324457-1-jannh@google.com>
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

From: Jann Horn
> Sent: 07 November 2022 20:13
> 
> Many Linux systems are configured to not panic on oops; but allowing an
> attacker to oops the system **really** often can make even bugs that look
> completely unexploitable exploitable (like NULL dereferences and such) if
> each crash elevates a refcount by one or a lock is taken in read mode, and
> this causes a counter to eventually overflow.
> 
> The most interesting counters for this are 32 bits wide (like open-coded
> refcounts that don't use refcount_t). (The ldsem reader count on 32-bit
> platforms is just 16 bits, but probably nobody cares about 32-bit platforms
> that much nowadays.)
> 
> So let's panic the system if the kernel is constantly oopsing.

I think you are pretty much guaranteed to run out of memory
(or at least KVA) before any 32bit counter wraps.

That is probably even harder to diagnose than a refcount wrap!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

