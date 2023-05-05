Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BED6F8654
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjEEQCZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 May 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjEEQCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:02:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFADD11D9F
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:02:22 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-313-b_0hsLUQOnitoawNGLcfRA-1; Fri, 05 May 2023 17:02:19 +0100
X-MC-Unique: b_0hsLUQOnitoawNGLcfRA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 5 May
 2023 17:02:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 5 May 2023 17:02:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Ellerman' <mpe@ellerman.id.au>,
        "glider@google.com" <glider@google.com>,
        "elver@google.com" <elver@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] mm: kfence: Fix false positives on big endian
Thread-Topic: [PATCH] mm: kfence: Fix false positives on big endian
Thread-Index: AQHZfwT1fw2Bof1hQEOCEaNqiVuD7a9L1zDg
Date:   Fri, 5 May 2023 16:02:17 +0000
Message-ID: <826f836f41db41eeb0fc32061994ac39@AcuMS.aculab.com>
References: <20230505035127.195387-1-mpe@ellerman.id.au>
In-Reply-To: <20230505035127.195387-1-mpe@ellerman.id.au>
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

From: Michael Ellerman
> Sent: 05 May 2023 04:51
> 
> Since commit 1ba3cbf3ec3b ("mm: kfence: improve the performance of
> __kfence_alloc() and __kfence_free()"), kfence reports failures in
> random places at boot on big endian machines.
> 
> The problem is that the new KFENCE_CANARY_PATTERN_U64 encodes the
> address of each byte in its value, so it needs to be byte swapped on big
> endian machines.
> 
> The compiler is smart enough to do the le64_to_cpu() at compile time, so
> there is no runtime overhead.
> 
> Fixes: 1ba3cbf3ec3b ("mm: kfence: improve the performance of __kfence_alloc() and __kfence_free()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  mm/kfence/kfence.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 2aafc46a4aaf..392fb273e7bd 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -29,7 +29,7 @@
>   * canary of every 8 bytes is the same. 64-bit memory can be filled and checked
>   * at a time instead of byte by byte to improve performance.
>   */
> -#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(0x0706050403020100))
> +#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(le64_to_cpu(0x0706050403020100)))

What at the (u64) casts for?
The constants should probably have a ul (or ull) suffix.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

