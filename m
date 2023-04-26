Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF7C6EF01A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbjDZIT2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbjDZITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:19:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668933A8C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:19:22 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-81-f59XHfplO1GBTvvR8VoUKw-1; Wed, 26 Apr 2023 09:19:18 +0100
X-MC-Unique: f59XHfplO1GBTvvR8VoUKw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Apr
 2023 09:19:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Apr 2023 09:19:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Danny Tsen' <dtsen@linux.ibm.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "leitao@debian.org" <leitao@debian.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "appro@cryptogams.org" <appro@cryptogams.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "ltcgcw@linux.vnet.ibm.com" <ltcgcw@linux.vnet.ibm.com>,
        "dtsen@us.ibm.com" <dtsen@us.ibm.com>
Subject: RE: [PATCH 1/5] An optimized Chacha20 implementation with 8-way
 unrolling for ppc64le.
Thread-Topic: [PATCH 1/5] An optimized Chacha20 implementation with 8-way
 unrolling for ppc64le.
Thread-Index: AQHZdt1hkavbjt5YJ0uOPniHUxI1nq89P9VQ
Date:   Wed, 26 Apr 2023 08:19:17 +0000
Message-ID: <0bb5f98165c3408fb191488f3cf0f76c@AcuMS.aculab.com>
References: <20230424184726.2091-1-dtsen@linux.ibm.com>
 <20230424184726.2091-2-dtsen@linux.ibm.com>
In-Reply-To: <20230424184726.2091-2-dtsen@linux.ibm.com>
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

From: Danny Tsen
> Sent: 24 April 2023 19:47
> 
> Improve overall performance of chacha20 encrypt and decrypt operations
> for Power10 or later CPU.
> 
> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
> ---
>  arch/powerpc/crypto/chacha-p10le-8x.S | 842 ++++++++++++++++++++++++++
>  1 file changed, 842 insertions(+)
>  create mode 100644 arch/powerpc/crypto/chacha-p10le-8x.S
...
> +.macro QT_loop_8x
> +	# QR(v0, v4,  v8, v12, v1, v5,  v9, v13, v2, v6, v10, v14, v3, v7, v11, v15)
> +	xxlor	0, 32+25, 32+25
> +	xxlor	32+25, 20, 20
> +	vadduwm 0, 0, 4
> +	vadduwm 1, 1, 5
> +	vadduwm 2, 2, 6
> +	vadduwm 3, 3, 7
> +	  vadduwm 16, 16, 20
> +	  vadduwm 17, 17, 21
> +	  vadduwm 18, 18, 22
> +	  vadduwm 19, 19, 23
> +
> +	  vpermxor 12, 12, 0, 25
> +	  vpermxor 13, 13, 1, 25
> +	  vpermxor 14, 14, 2, 25
> +	  vpermxor 15, 15, 3, 25
> +	  vpermxor 28, 28, 16, 25
> +	  vpermxor 29, 29, 17, 25
> +	  vpermxor 30, 30, 18, 25
> +	  vpermxor 31, 31, 19, 25
> +	xxlor	32+25, 0, 0
> +	vadduwm 8, 8, 12
> +	vadduwm 9, 9, 13
> +	vadduwm 10, 10, 14
> +	vadduwm 11, 11, 15
...

Is it just me or is all this code just complete jibberish?

There really ought to be enough comments so that it is possible
to check that the code is doing something that looks like chacha20
without spending all day tracking register numbers through
hundreds of lines of assembler.

I also wonder how much faster the 8-way unroll is?
On modern cpu with 'out of order' execute (etc) it is
not impossible to get the loop operations 'for free'
because they use execution units that are otherwise idle.

Massive loop unrolling is so 1980's.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

