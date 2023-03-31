Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178776D18AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCaHdu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 03:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:33:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1451166B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:33:42 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-159-jibixo4mNCSA74dvMNHr1Q-1; Fri, 31 Mar 2023 08:33:40 +0100
X-MC-Unique: jibixo4mNCSA74dvMNHr1Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 31 Mar
 2023 08:33:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 31 Mar 2023 08:33:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>
CC:     Jani Nikula <jani.nikula@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Gow <davidgow@google.com>
Subject: RE: [PATCH 0/4] log2: make is_power_of_2() more generic
Thread-Topic: [PATCH 0/4] log2: make is_power_of_2() more generic
Thread-Index: AQHZY0DwWI19nDCca0eIs2l7T1UA9K8T1qTw///9RgCAAKpk8A==
Date:   Fri, 31 Mar 2023 07:33:38 +0000
Message-ID: <37671dff9b6b4e6bb07862c11cb69874@AcuMS.aculab.com>
References: <20230330104243.2120761-1-jani.nikula@intel.com>
        <20230330125041.83b0f39fa3a4ec1a42dfd95f@linux-foundation.org>
        <549987e4967d45159573901d330c96a0@AcuMS.aculab.com>
 <20230330151846.fdbc8edbfbaa6eaddb056dc7@linux-foundation.org>
In-Reply-To: <20230330151846.fdbc8edbfbaa6eaddb056dc7@linux-foundation.org>
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
> Sent: 30 March 2023 23:19
> 
> On Thu, 30 Mar 2023 21:53:03 +0000 David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > > But wouldn't all these issues be addressed by simply doing
> > >
> > > #define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
> > >
> > > ?
> > >
> > > (With suitable tweaks to avoid evaluating `n' more than once)
> >
> > I think you need to use the 'horrid tricks' from min() to get
> > a constant expression from constant inputs.
> 
> This
> 
> --- a/include/linux/log2.h~a
> +++ a/include/linux/log2.h
> @@ -41,11 +41,11 @@ int __ilog2_u64(u64 n)
>   * *not* considered a power of two.
>   * Return: true if @n is a power of 2, otherwise false.
>   */
> -static inline __attribute__((const))
> -bool is_power_of_2(unsigned long n)
> -{
> -	return (n != 0 && ((n & (n - 1)) == 0));
> -}
> +#define is_power_of_2(_n)				\
> +	({						\
> +		typeof(_n) n = (_n);			\
> +		n != 0 && ((n & (n - 1)) == 0);		\
> +	})
> 
>  /**
>   * __roundup_pow_of_two() - round up to nearest power of two
> _
> 
> worked for me in a simple test.
> 
> --- a/fs/open.c~b
> +++ a/fs/open.c
> @@ -1564,3 +1564,10 @@ int stream_open(struct inode *inode, str
>  }
> 
>  EXPORT_SYMBOL(stream_open);
> +
> +#include <linux/log2.h>
> +
> +int foo(void)
> +{
> +	return is_power_of_2(43);
> +}
> _
> 
> 
> foo:
> # fs/open.c:1573: }
> 	xorl	%eax, %eax	#
> 	ret
> 
> 
> Is there some more tricky situation where it breaks?

Try:
static int x = is_power_of_2(43);

I suspect that some (all?) of the compile-time assert checks won't
like ({...}) either.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

