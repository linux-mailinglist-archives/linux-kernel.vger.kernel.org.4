Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFAF5ED722
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiI1IJN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Sep 2022 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiI1IJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:09:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C877118B0F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:09:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-67-6zoHn3j4OHOXZQky11Y5mw-1; Wed, 28 Sep 2022 09:09:05 +0100
X-MC-Unique: 6zoHn3j4OHOXZQky11Y5mw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 28 Sep
 2022 09:09:01 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 28 Sep 2022 09:09:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'YingChi Long' <me@inclyc.cn>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Thread-Topic: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Thread-Index: AQHY0oauCPu6lqkmBkuKoE4b1f9eoq3zbbUQ///9N4CAARHtMA==
Date:   Wed, 28 Sep 2022 08:09:01 +0000
Message-ID: <fc12d0d4c1064832955543217d0dbe4a@AcuMS.aculab.com>
References: <38114d1b752c497eba1640360daf5b9e@AcuMS.aculab.com>
 <20220927164411.99297-1-me@inclyc.cn>
In-Reply-To: <20220927164411.99297-1-me@inclyc.cn>
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

From: YingChi Long
> Sent: 27 September 2022 17:44
> 
> > Interesting - what justification do they give?
> > Linux kernel requires that the compiler add no unnecessary padding
> > so that structure definitions are well defined.
> 
> Yes, that's a clarification given in 2019.
> 
> > So using a type definition inside offsetof() won't give a
> > useful value - but it still isn't really UB.
> 
> WG14 may worry about commas and the scope of new definitions. So they provide
> new words into the standard and said:
> 
> > If the specified type defines a new type or if the specified member is a
> > bit-field, the behavior is undefined.
> 
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm

Except that the kernel requires it to be defined.

Did they clarify the clause that required offsetof() to return
a compile-time constant?
That stops you doing offsetof(struct x, member->array[expression]).
(Oh and the compiler for a common OS disallows any version of that
even when expression in an integer constant!)

> 
> I've provided this link in the patch.
> 
> > Has that ever worked?
> > Given:
> > 	struct foo {
> > 		int a;
> > 		char b;
> > 		char c;
> > 	};
> 
> TYPE_ALIGN(struct foo) evaluates to 4 in the previous approach (based on
> offsetof). _Align(struct foo) evaluates to the same value.
> 
> See https://godbolt.org/z/sqebhEnsq
> 
> > I think CHECK_MEMBER_AT_END_OF_TYPE(struct foo, b) is true.
> 
> Hmm, both the previous version and after this patch the macro gives me
> false. (See the godbolt link).

See https://godbolt.org/z/95shMx44j

It return 1 for a and 0 for b and c (and char d,e following b).
NFI what it is trying to do!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

