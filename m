Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB86D1114
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjC3VxN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 17:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjC3VxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:53:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A61042E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:53:08 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-13-XNRIvLOrOXesN_kJbVyF0A-1; Thu, 30 Mar 2023 22:53:05 +0100
X-MC-Unique: XNRIvLOrOXesN_kJbVyF0A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 30 Mar
 2023 22:53:04 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 30 Mar 2023 22:53:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Gow <davidgow@google.com>
Subject: RE: [PATCH 0/4] log2: make is_power_of_2() more generic
Thread-Topic: [PATCH 0/4] log2: make is_power_of_2() more generic
Thread-Index: AQHZY0DwWI19nDCca0eIs2l7T1UA9K8T1qTw
Date:   Thu, 30 Mar 2023 21:53:03 +0000
Message-ID: <549987e4967d45159573901d330c96a0@AcuMS.aculab.com>
References: <20230330104243.2120761-1-jani.nikula@intel.com>
 <20230330125041.83b0f39fa3a4ec1a42dfd95f@linux-foundation.org>
In-Reply-To: <20230330125041.83b0f39fa3a4ec1a42dfd95f@linux-foundation.org>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton
> Sent: 30 March 2023 20:51
> 
> On Thu, 30 Mar 2023 13:42:39 +0300 Jani Nikula <jani.nikula@intel.com> wrote:
> 
> > is_power_of_2() only works for types <= sizeof(unsigned long) and it's
> > also not a constant expression. There are a number of places in kernel
> > where is_power_of_2() is called on u64, which fails on 32-bit
> > builds. Try to remedy that. While at it, make it a constant expression
> > when possible.
> 
> Yes, the current `is_power_of_2(unsigned long n)' isn't very general.
> 
> But wouldn't all these issues be addressed by simply doing
> 
> #define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
> 
> ?
> 
> (With suitable tweaks to avoid evaluating `n' more than once)

I think you need to use the 'horrid tricks' from min() to get
a constant expression from constant inputs.

For non-constants this looks ok (see https://godbolt.org/z/G73MTr9jn)

	David

static inline int lisp2(unsigned long n)
{
    return n && !(n & (n - 1));
}

static inline int llisp2(unsigned long long lln)
{
#if 0  // I think this looks worse, esp. for gcc on x86
    return lln && !(lln & (lln - 1));
#else
    unsigned long n = lln;
    if (lln >= 1ull << 32) {
        if (n)
            return 0;
        n = lln >> 32; 
    }
    return lisp2(n);
#endif
}

#define isp2(n) (sizeof ((n)+0) == sizeof (long) ? lisp2(n) : llisp2(n))

int is12(unsigned long long  i)
{
    return isp2(i);
}

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

