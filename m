Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852BE614AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiKAMmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiKAMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:42:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AC11A397
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tsiePMENPo20/Aqx0vlDxCvA4WW1WHFkPzpPxVXbJzs=; b=GiogJX40g7WUd+PHjk1nWplVdl
        TV+XASDL7Y+wvsQFqUFa61PZ9nBE0WSAf/RS1lx5Ci5qlmJm76/KrXkAZjz5gwNU6BMIm/StG8QK6
        V12ZCWhjw+GHtEO8GuXr6U2GTeRAclpbDpmVscGK0rs87wpAcugOf/GwUkb9nY8jTFE6iGdUn8wMJ
        Pv7tbxx680xLJvG3fnDzlllizSVXGjYRl/Z2A9BSwUMnWHoKeWlLyq2BoqcRgWHkYjA5znHTUboHx
        dgV1WTHoAVKgRIMcszUkLe0jW4KTNxzVv0nHj9o4R+QjfmLseDylQwqRVSaiNhEYG/8uqhQOufa1n
        cvJNra/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opqaY-00885y-7J; Tue, 01 Nov 2022 12:41:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9783930007E;
        Tue,  1 Nov 2022 13:41:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7ABD22C83EAF2; Tue,  1 Nov 2022 13:41:52 +0100 (CET)
Date:   Tue, 1 Nov 2022 13:41:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 04/13] mm: Fix pmd_read_atomic()
Message-ID: <Y2EUEBlQXNgaJgoI@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.711181252@infradead.org>
 <CAHk-=whKxHeW3tx8Q2_0sf=NW9RGUQYC1S2Km3eLC9jJ=whSRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whKxHeW3tx8Q2_0sf=NW9RGUQYC1S2Km3eLC9jJ=whSRw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 10:30:51AM -0700, Linus Torvalds wrote:
> On Sat, Oct 22, 2022 at 4:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -258,6 +258,13 @@ static inline pte_t ptep_get(pte_t *ptep
> >  }
> >  #endif
> >
> > +#ifndef __HAVE_ARCH_PMDP_GET
> > +static inline pmd_t pmdp_get(pmd_t *pmdp)
> > +{
> > +       return READ_ONCE(*pmdp);
> > +}
> > +#endif
> 
> What, what, what?
> 
> Where did that __HAVE_ARCH_PMDP_GET come from?
> 
> I'm not seeing it #define'd anywhere, and we _really_ shouldn't be
> doing this any more.
> 
> Please just do
> 
>     #ifndef pmdp_get
>     static inline pmd_t pmdp_get(pmd_t *pmdp)
>     ..
> 
> and have the architectures that do their own pmdp_get(), just have that
> 
>    #define pmdp_get pmdp_get
> 
> to let the generic code know about it. Instead of making up a new
> __HAVE_ARCH_XYZ name.

So I've stuck the below on. There's a *TON* more to convert and I'm not
going to be doing that just now (seems like a clever enough script
should be able to), but this gets rid of the new one I introduced.

---

Subject: mm: Convert __HAVE_ARCH_P..P_GET to the new style
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Nov  1 12:53:18 CET 2022

Since __HAVE_ARCH_* style guards have been depricated in favour of
defining the function name onto itself, convert pxxp_get().

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h |    2 +-
 include/linux/pgtable.h                      |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -263,7 +263,7 @@ static inline pte_basic_t pte_update(str
 }
 
 #ifdef CONFIG_PPC_16K_PAGES
-#define __HAVE_ARCH_PTEP_GET
+#define ptep_get ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
 {
	pte_basic_t val = READ_ONCE(ptep->pte);
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -291,14 +291,14 @@ static inline void ptep_clear(struct mm_
	ptep_get_and_clear(mm, addr, ptep);
 }
 
-#ifndef __HAVE_ARCH_PTEP_GET
+#ifndef ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
 {
	return READ_ONCE(*ptep);
 }
 #endif
 
-#ifndef __HAVE_ARCH_PMDP_GET
+#ifndef pmdp_get
 static inline pmd_t pmdp_get(pmd_t *pmdp)
 {
	return READ_ONCE(*pmdp);

