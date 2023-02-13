Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5029B6945FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBMMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBMMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:36:46 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CFF1A973;
        Mon, 13 Feb 2023 04:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dwTZwIt/s082g2VJHyhB1aVLmAYe+39YavUh4WqOoto=; b=B7CX2K17TiDCFaqu+wy8HA9+u2
        1Xg/1EfqdMMGGcr/5naNPzSOcJ4NnNoR3gYawYhjN8MZ+SBlVFFFE+/QFyGUVVzh/i/BIyFTaRd/j
        MHPVKeVM+v4BjTbsmE5RxEN3aVX3WViLqK3xG+xMbpE2mazBd/C2PEGdblnl7OG31zgMG9ecufO0j
        JJfHozJ+Vfz9HkYd/kYXQxkKzm8jY3OML9RNwC5fH64mqRI7php8a9qfyf1u78gKD6VgzFgogvIl7
        auH4dFJrV09St+Gv+6jtKttN4oCmTSxdya3vuNvnRtoclrDxPIfePCFGDWW5qbGNZyjCvKoy+RH6s
        r9Sr1hlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pRY39-009IPX-1r;
        Mon, 13 Feb 2023 12:35:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 079C9300033;
        Mon, 13 Feb 2023 13:35:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBC1E2010F0F0; Mon, 13 Feb 2023 13:35:55 +0100 (CET)
Date:   Mon, 13 Feb 2023 13:35:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH -tip] kasan: Emit different calls for instrumentable
 memintrinsics
Message-ID: <Y+ouq8ooI7UH4cL+@hirez.programming.kicks-ass.net>
References: <20230208184203.2260394-1-elver@google.com>
 <Y+aaDP32wrsd8GZq@tucnak>
 <CANpmjNO3w9h=QLQ9NRf0QZoR86S7aqJrnAEQ3i2L0L3axALzmw@mail.gmail.com>
 <Y+oYlD0IH8zwEgqp@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+oYlD0IH8zwEgqp@tucnak>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:01:40PM +0100, Jakub Jelinek wrote:

> The current gcc behavior is that operations like aggregate copies, or
> clearing which might or might not need memcpy/memset/memmove under the hood
> later are asan instrumented before the operation (in order not to limit the
> choices on how it will be expanded), uses of builtins (__builtin_ prefixed
> or not) are also instrumented before the calls unless they are one of the
> calls that is recognized as always instrumented.  None for hwasan,
> for asan:
> index, memchr, memcmp, memcpy, memmove, memset, strcasecmp, strcat, strchr,
> strcmp, strcpy, strdup, strlen, strncasecmp, strncat, strncmp, strcspn,
> strpbrk, strspn, strstr, strncpy
> and for those builtins gcc disables inline expansion and enforces a library
> call (but until the expansion they are treated in optimizations like normal
> builtins and so could be say DCEd, or their aliasing behavior is considered
> etc.).  kasan behaves the same I think.
> 
> Now, I think libasan only has __asan_ prefixed
> __asan_memmove, __asan_memset and __asan_memcpy, nothing else, so most of
> the calls from the above list even can't be prefixed.
> 
> So, do you want for --param asan-kernel-mem-intrinsic-prefix=1 to __asan_
> prefix just memcpy/memmove/memset and nothing else?  Is it ok to emit
> memcpy/memset/memmove from aggregate operations which are instrumented
> already at the caller (and similarly is it ok to handle those operations
> inline)?

I'm thinking it is trivial to add more __asan prefixed functions as
needed, while trying to untangle the trainwreck created by assuming the
normal functions are instrumented is much more work.
