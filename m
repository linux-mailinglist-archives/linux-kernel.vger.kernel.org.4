Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8568EEFA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBHM3q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Feb 2023 07:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBHM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:29:44 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05AA2BF26
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:29:42 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-59-Hb1NbtNkMCGu2tgHQ7xvHQ-1; Wed, 08 Feb 2023 12:29:39 +0000
X-MC-Unique: Hb1NbtNkMCGu2tgHQ7xvHQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 8 Feb
 2023 12:29:38 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Wed, 8 Feb 2023 12:29:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/alternative: Support relocations in alternatives
Thread-Topic: [PATCH] x86/alternative: Support relocations in alternatives
Thread-Index: AQHZOjyzxl+xf7lExkaNEfzZDwBgqa7E+/6A
Date:   Wed, 8 Feb 2023 12:29:38 +0000
Message-ID: <693ce771113d49da92235a0f6d2e395f@AcuMS.aculab.com>
References: <Y+EXQlGSI9WUU8nn@hirez.programming.kicks-ass.net>
In-Reply-To: <Y+EXQlGSI9WUU8nn@hirez.programming.kicks-ass.net>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 06 February 2023 15:06
...
> +#define apply_reloc_n(n_, p_, d_)				\
> +	do {							\
> +		s32 v = *(s##n_ *)(p_);				\

You've added '_' suffixes to the parameters.
But these only refer to the body of the #define
so are never a problem.

OTOH the local 'v' will cause confusion if one of the
actual parameters is 'v'.
Which is why it is common to prefix locals with '_'.
(Which doesn't help with recursive expansions.)

Since this is only actually expended in the one .c file
it is unlikely to cause a problem.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

