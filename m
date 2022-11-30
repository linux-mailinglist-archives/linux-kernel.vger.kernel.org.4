Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B204563E391
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiK3Wjr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 17:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiK3Wjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:39:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBE8E592
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 14:39:43 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-50-6YXDDUj9OhOl-PdOYMK1rg-1; Wed, 30 Nov 2022 22:39:39 +0000
X-MC-Unique: 6YXDDUj9OhOl-PdOYMK1rg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 22:39:38 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Wed, 30 Nov 2022 22:39:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: RE: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
Thread-Topic: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
Thread-Index: AQHZBD5MKfvjUBqLyk+xAMt8s9EHVq5YDxQQ
Date:   Wed, 30 Nov 2022 22:39:38 +0000
Message-ID: <310b91f650424d338e56794b8861a088@AcuMS.aculab.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-2-Jason@zx2c4.com> <87cz95v2q2.ffs@tglx>
In-Reply-To: <87cz95v2q2.ffs@tglx>
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
> Sent: 29 November 2022 22:02
> 
> Jason!
> 
> On Tue, Nov 29 2022 at 22:06, Jason A. Donenfeld wrote:
> > +
> > +/********************************************************************
> > + *
> > + * vDSO support helpers.
> > + *
> > + * The actual vDSO function is defined over in lib/vdso/getrandom.c,
> > + * but this section contains the kernel-mode helpers to support that.
> > + *
> > + ********************************************************************/
> > +
> > +#ifdef CONFIG_VGETRANDOM_ALLOC_SYSCALL
> > +/**
> > + * vgetrandom_alloc - allocate opaque states for use with vDSO getrandom().
> > + *
> > + * @num: on input, a pointer to a suggested hint of how many states to
> > + * allocate, and on output the number of states actually allocated.
> > + *
> > + * @size_per_each: the size of each state allocated, so that the caller can
> > + * split up the returned allocation into individual states.
> > + *
> > + * @flags: currently always zero.
> 
> NIT!
> 
> I personally prefer and ask for it in stuff I maintain:
> 
>  * @num:		On input, a pointer to a suggested hint of how many states to
>  *			allocate, and on output the number of states actually allocated.
>  *
>  * @size_per_each: 	The size of each state allocated, so that the caller can
>  * 			split up the returned allocation into individual states.
>  *
>  * @flags: 		Currently always zero.
> 
> But your turf :)
> 
> > + *
> > + * The getrandom() vDSO function in userspace requires an opaque state, which
> > + * this function allocates by mapping a certain number of special pages into
> > + * the calling process. It takes a hint as to the number of opaque states
> > + * desired, and provides the caller with the number of opaque states actually
> > + * allocated, the size of each one in bytes, and the address of the first
> > + * state.
> 
> make W=1 rightfully complains about:
> 
> > +
> 
> drivers/char/random.c:182: warning: bad line:
> 
> > + * Returns a pointer to the first state in the allocation.
> 
> I have serious doubts that this statement is correct.
> 
> Think about this comment and documentation as a boiler plate for the
> mandatory man page for a new syscall (hint...)
> 
> > + *
> > + */
> 
> and W=1 also complains rightfully here:
> 
> > +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned int __user *, num,
> > +		unsigned int __user *, size_per_each, unsigned int, flags)
> 
> drivers/char/random.c:188: warning: expecting prototype for vgetrandom_alloc(). Prototype was for
> sys_vgetrandom_alloc() instead
> 
> > +{
> > diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
> > new file mode 100644
> > index 000000000000..5f04c8bf4bd4
> > --- /dev/null
> > +++ b/include/vdso/getrandom.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> > + */
> > +
> > +#ifndef _VDSO_GETRANDOM_H
> > +#define _VDSO_GETRANDOM_H
> > +
> > +#include <crypto/chacha.h>
> > +
> > +struct vgetrandom_state {
> > +	union {
> > +		struct {
> > +			u8 batch[CHACHA_BLOCK_SIZE * 3 / 2];
> > +			u32 key[CHACHA_KEY_SIZE / sizeof(u32)];
> > +		};
> > +		u8 batch_key[CHACHA_BLOCK_SIZE * 2];
> > +	};
> > +	unsigned long generation;
> > +	u8 pos;
> > +	bool in_use;
> > +};
> 
> Again, please make this properly tabular:
> 
> struct vgetrandom_state {
> 	union {
> 		struct {
> 			u8	batch[CHACHA_BLOCK_SIZE * 3 / 2];
> 			u32	key[CHACHA_KEY_SIZE / sizeof(u32)];
> 		};
> 		u8	batch_key[CHACHA_BLOCK_SIZE * 2];
> 	};
> 	unsigned long	generation;
> 	u8		pos;
> 	bool		in_use;
> };
> 
> Plus some kernel doc which explains what this is about.

That structure looks horrid - especially for something shared
between entities.
The 'unsigned long' should be either u32 or u64.
There is 'hidden' padding at the end.
If 'pos' is an index into something (longer name would be
better) then there is no reason to squeeze the value into
1 byte - it doesn't save anything and might make things bigger.

(I think Jason might have blocked my emails, he doesn't like
critisicism/feedback.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

