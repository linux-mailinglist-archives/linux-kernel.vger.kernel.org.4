Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C86664290
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjAJN5j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Jan 2023 08:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbjAJN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:57:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513BD7CBDD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:56:27 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-k2zbIh7EPl6qw9HqQJiSaQ-1; Tue, 10 Jan 2023 13:56:24 +0000
X-MC-Unique: k2zbIh7EPl6qw9HqQJiSaQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 13:56:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 10 Jan 2023 13:56:22 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ingo Molnar' <mingo@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
Thread-Topic: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
Thread-Index: AQHZJOEDM1xGq8F5SkWRN5D465Sv8a6XrDDg
Date:   Tue, 10 Jan 2023 13:56:22 +0000
Message-ID: <7c9f48a6d13f4d8eabca045141fa55d5@AcuMS.aculab.com>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk>
 <Y7vvKHYXpe7KmwCI@gmail.com>
 <alpine.DEB.2.21.2301091946360.65308@angie.orcam.me.uk>
 <Y71COYApLufn2SLu@gmail.com>
In-Reply-To: <Y71COYApLufn2SLu@gmail.com>
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

From: Ingo Molnar
> Sent: 10 January 2023 10:47
> 
> 
> * Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> 
> > Jason,
> >
> >  Would you mind commenting on the below?
> >
> > On Mon, 9 Jan 2023, Ingo Molnar wrote:
> >
> > > > For x86 kernel stack offset randomization uses the RDTSC instruction,
> > > > which causes an invalid opcode exception with hardware that does not
> > > > implement this instruction:
> > >
> > > > @@ -85,7 +86,8 @@ static inline void arch_exit_to_user_mod
> > > >  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
> > > >  	 * 6 (ia32) bits.
> > > >  	 */
> > > > -	choose_random_kstack_offset(rdtsc() & 0xFF);
> > > > +	if (cpu_feature_enabled(X86_FEATURE_TSC))
> > > > +		choose_random_kstack_offset(rdtsc() & 0xFF);
> > > >  }
> > >
> > > While this is an obscure corner case, falling back to 0 offset silently
> > > feels a bit wrong - could we at least attempt to generate some
> > > unpredictability in this case?
> > >
> > > It's not genuine entropy, but we could pass in a value that varies from
> > > task to task and which is not an 'obviously known' constant value like the
> > > 0 fallback?
> > >
> > > For example the lowest 8 bits of the virtual page number of the current
> > > task plus the lowest 8 bits of jiffies should vary from task to task, has
> > > some time dependence and is cheap to compute:
> > >
> > > 	(((unsigned long)current >> 12) + jiffies) & 0xFF
> > >
> > > This combined with the per-CPU forward storage of previous offsets:
> > >
> > > #define choose_random_kstack_offset(rand) do {                          \
> > >         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
> > >                                 &randomize_kstack_offset)) {            \
> > >                 u32 offset = raw_cpu_read(kstack_offset);               \
> > >                 offset ^= (rand);                                       \
> > >                 raw_cpu_write(kstack_offset, offset);                   \
> > >         }                                                               \
> > >
> > > Should make this reasonably hard to guess for long-running tasks even if
> > > there's no TSC - and make it hard to guess even for tasks whose creation an
> > > attacker controls, unless there's an info-leak to rely on.
> >
> > Sure, I'm fine implementing it, even in such a way so as not to cause a
> > code size/performance regression for X86_TSC configurations.  But is the
> > calculation really unpredictable enough? [...]
> 
> It's not binary: it's obviously not as good as a TSC, but my point is that
> 'something cheap & variable' is clearly better than 'zero offset all the
> time'.

Does it really matter if running on anything as old as a real 486?
In reality they'll only be used for testing.
There are more modern 486-class cpu for embedded use, but they
almost certainly have a TSC.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

