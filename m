Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3C35EC8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiI0P6p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Sep 2022 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiI0P6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:58:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C01B86BE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:58:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-5-y36asnyBNqmjpPeNW1Btjg-1; Tue, 27 Sep 2022 16:58:35 +0100
X-MC-Unique: y36asnyBNqmjpPeNW1Btjg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 27 Sep
 2022 16:58:33 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Tue, 27 Sep 2022 16:58:33 +0100
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
Thread-Index: AQHY0oauCPu6lqkmBkuKoE4b1f9eoq3zbbUQ
Date:   Tue, 27 Sep 2022 15:58:33 +0000
Message-ID: <38114d1b752c497eba1640360daf5b9e@AcuMS.aculab.com>
References: <20220925153151.2467884-1-me@inclyc.cn>
 <20220927153338.4177854-1-me@inclyc.cn>
In-Reply-To: <20220927153338.4177854-1-me@inclyc.cn>
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
> Sent: 27 September 2022 16:34
> 
> WG14 N2350 made very clear that it is an UB having type definitions with
> in "offsetof". This patch change the implementation of macro
> "TYPE_ALIGN" to builtin "_Alignof" to avoid undefined behavior.

Interesting - what justification do they give?
Linux kernel requires that the compiler add no unnecessary padding
so that structure definitions are well defined.

IIRC that standard allows arbitrary padding between members.
So using a type definition inside offsetof() won't give a
useful value - but it still isn't really UB.

...
>  #define CHECK_MEMBER_AT_END_OF(TYPE, MEMBER) \
> -	BUILD_BUG_ON(sizeof(TYPE) != ALIGN(offsetofend(TYPE, MEMBER), \
> -					   TYPE_ALIGN(TYPE)))
> +	BUILD_BUG_ON(sizeof(TYPE) !=         \
> +		     ALIGN(offsetofend(TYPE, MEMBER), _Alignof(TYPE)))

Has that ever worked?
Given:
	struct foo {
		int a;
		char b;
		char c;
	};
I think CHECK_MEMBER_AT_END_OF_TYPE(struct foo, b) is true.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

