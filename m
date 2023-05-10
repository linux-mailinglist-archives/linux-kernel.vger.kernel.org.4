Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DC76FDCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjEJLgP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 May 2023 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbjEJLgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:36:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99061B0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:36:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-323-7MEPhWXaOseOIC1jJ3PU8w-1; Wed, 10 May 2023 12:36:00 +0100
X-MC-Unique: 7MEPhWXaOseOIC1jJ3PU8w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 10 May
 2023 12:35:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 10 May 2023 12:35:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Uros Bizjak' <ubizjak@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] atomics: Use atomic_try_cmpxchg_release in
 rcuref_put_slowpath()
Thread-Topic: [PATCH] atomics: Use atomic_try_cmpxchg_release in
 rcuref_put_slowpath()
Thread-Index: AQHZgodhH2M1prck1UuVC7CPAwIZ1q9TYArw
Date:   Wed, 10 May 2023 11:35:59 +0000
Message-ID: <655cab1a213440f682eddc9cc1ad2d44@AcuMS.aculab.com>
References: <20230509150255.3691-1-ubizjak@gmail.com>
In-Reply-To: <20230509150255.3691-1-ubizjak@gmail.com>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uros Bizjak
> Sent: 09 May 2023 16:03
> 
> Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
> in rcuref_put_slowpath(). 86 CMPXCHG instruction returns success in
> ZF flag, so this change saves a compare after cmpxchg.  Additionaly,
> the compiler reorders some code blocks to follow likely/unlikely
> annotations in the atomic_try_cmpxchg macro, improving the code from
> 
>   9a:	f0 0f b1 0b          	lock cmpxchg %ecx,(%rbx)
>   9e:	83 f8 ff             	cmp    $0xffffffff,%eax
>   a1:	74 04                	je     a7 <rcuref_put_slowpath+0x27>
>   a3:	31 c0                	xor    %eax,%eax
> 
> to
> 
>   9a:	f0 0f b1 0b          	lock cmpxchg %ecx,(%rbx)
>   9e:	75 4c                	jne    ec <rcuref_put_slowpath+0x6c>
>   a0:	b0 01                	mov    $0x1,%al
> 
> No functional change intended.

While I'm not against the change I bet you can't detect
any actual difference. IIRC:
- The 'cmp+je' get merged into a single u-op.
- The 'lock cmpxchg' will take long enough that the instruction
  decoder won't be a bottleneck.
- Whether the je/jne is predicted taken is pretty much random.
  So you'll speculatively execute somewhere (could be anywhere)
  while the locked cycle completes.
So the only change is three less bytes of object code.
That will change the cache line alignment of later code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

