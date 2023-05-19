Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD527708F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjESFOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESFOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:14:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA1A18D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 22:14:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QMw4M0Km2z4x2j;
        Fri, 19 May 2023 15:14:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684473251;
        bh=XtmiIOF/NA3HEuw+9jphgAkHCsadnEGKvOejGiS/vBI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RQrmE5/7IQ9bHGm6Pg5nzKRS/MrnD7O62plkaE4ISC71znarStIv1c+rqH2eD21Ay
         BoSVycIDYj6++q91gMxaMW8tzGjKmn+SvAyr1OTzL/FcJ36O6uFSlSjO6ZPcwy46CK
         V9IseUAeKcQzyanwocprzA2s51mzkrUD5ABcIT8OciKKvQNnsEU880OUUzVK34Htru
         u6aYBYybBkBP3b7teFgYlIwGLVHKsTDk0UBcHC5zheI0DFrGgbp8BVZ6lqSWQUnKpR
         MaQvJ7GxK0lGxJqjJszIHK7PI7DUNxOXr5WfircZfyz086GeBt2U1zKAGDhFX3U5YY
         JKj3OO3SKnwhA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     "glider@google.com" <glider@google.com>,
        "elver@google.com" <elver@google.com>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] mm: kfence: Fix false positives on big endian
In-Reply-To: <20230517152028.86b6d2d5afa4541b4269131b@linux-foundation.org>
References: <20230505035127.195387-1-mpe@ellerman.id.au>
 <826f836f41db41eeb0fc32061994ac39@AcuMS.aculab.com>
 <20230517152028.86b6d2d5afa4541b4269131b@linux-foundation.org>
Date:   Fri, 19 May 2023 15:14:06 +1000
Message-ID: <87o7mgzyw1.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:
> On Fri, 5 May 2023 16:02:17 +0000 David Laight <David.Laight@ACULAB.COM> wrote:
>
>> From: Michael Ellerman
>> > Sent: 05 May 2023 04:51
>> > 
>> > Since commit 1ba3cbf3ec3b ("mm: kfence: improve the performance of
>> > __kfence_alloc() and __kfence_free()"), kfence reports failures in
>> > random places at boot on big endian machines.
>> > 
>> > The problem is that the new KFENCE_CANARY_PATTERN_U64 encodes the
>> > address of each byte in its value, so it needs to be byte swapped on big
>> > endian machines.
>> > 
>> > The compiler is smart enough to do the le64_to_cpu() at compile time, so
>> > there is no runtime overhead.
>> > 
>> > Fixes: 1ba3cbf3ec3b ("mm: kfence: improve the performance of __kfence_alloc() and __kfence_free()")
>> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> > ---
>> >  mm/kfence/kfence.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
>> > index 2aafc46a4aaf..392fb273e7bd 100644
>> > --- a/mm/kfence/kfence.h
>> > +++ b/mm/kfence/kfence.h
>> > @@ -29,7 +29,7 @@
>> >   * canary of every 8 bytes is the same. 64-bit memory can be filled and checked
>> >   * at a time instead of byte by byte to improve performance.
>> >   */
>> > -#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(0x0706050403020100))
>> > +#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(le64_to_cpu(0x0706050403020100)))
>> 
>> What at the (u64) casts for?
>> The constants should probably have a ul (or ull) suffix.
>> 
>
> I tried that, didn't fix the sparse warnings described at
> https://lkml.kernel.org/r/202305132244.DwzBUcUd-lkp@intel.com.
>
> Michael, have you looked into this?

I haven't sorry, been chasing other bugs.

> I'll merge it upstream - I guess we can live with the warnings for a while.

Thanks, yeah spurious WARNs are more of a pain than some sparse warnings.

Maybe using le64_to_cpu() is too fancy, could just do it with an ifdef? eg.

diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 392fb273e7bd..510355a5382b 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -29,7 +29,11 @@
  * canary of every 8 bytes is the same. 64-bit memory can be filled and checked
  * at a time instead of byte by byte to improve performance.
  */
-#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(le64_to_cpu(0x0706050403020100)))
+#ifdef __LITTLE_ENDIAN__
+#define KFENCE_CANARY_PATTERN_U64 (0xaaaaaaaaaaaaaaaaULL ^ 0x0706050403020100ULL)
+#else
+#define KFENCE_CANARY_PATTERN_U64 (0xaaaaaaaaaaaaaaaaULL ^ 0x0001020304050607ULL)
+#endif
 
 /* Maximum stack depth for reports. */
 #define KFENCE_STACK_DEPTH 64


cheers
