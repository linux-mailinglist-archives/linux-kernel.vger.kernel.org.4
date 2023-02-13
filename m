Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056F26943BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBMLDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBMLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E25417CE5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676286137;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=DPipqMIHUCjrlTLT8I3BRMh5RmQq64goImG0GQ1TK6U=;
        b=Gy7F5PqPXLN4fmYOJZIIwsEgP3iYPkLORDbPJJSHdW2OTveEKY4dQC96PXw3QT6S0zW2A1
        b6CwJ8OOI9BmQNftwk1cWVWt6I94Wu671JvK4EbHXEsDZg3vR3mUwcLBHFyLFnGXCLQHsw
        YyyGFJZm/6Tm5sCy8yHV3PhkXH+ihlk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-Iv_R5x0yN7SFfD4IufwsUQ-1; Mon, 13 Feb 2023 06:02:14 -0500
X-MC-Unique: Iv_R5x0yN7SFfD4IufwsUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 167C1811E9C;
        Mon, 13 Feb 2023 11:02:13 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AE071121318;
        Mon, 13 Feb 2023 11:02:03 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 31DB1nJ33945034
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 12:01:49 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 31DB1ee53945033;
        Mon, 13 Feb 2023 12:01:40 +0100
Date:   Mon, 13 Feb 2023 12:01:40 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Y+oYlD0IH8zwEgqp@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20230208184203.2260394-1-elver@google.com>
 <Y+aaDP32wrsd8GZq@tucnak>
 <CANpmjNO3w9h=QLQ9NRf0QZoR86S7aqJrnAEQ3i2L0L3axALzmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO3w9h=QLQ9NRf0QZoR86S7aqJrnAEQ3i2L0L3axALzmw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 09:07:14PM +0100, Marco Elver wrote:
> On Fri, 10 Feb 2023 at 20:25, Jakub Jelinek <jakub@redhat.com> wrote:
> >
> > On Wed, Feb 08, 2023 at 07:42:03PM +0100, Marco Elver wrote:
> > > Clang 15 will provide an option to prefix calls to memcpy/memset/memmove
> > > with __asan_ in instrumented functions: https://reviews.llvm.org/D122724
> > >
> > > GCC does not yet have similar support.
> >
> > GCC has support to rename memcpy/memset etc. for years, say on
> > following compiled with
> > -fsanitize=kernel-address -O2 -mstringop-strategy=libcall
> > (the last option just to make sure the compiler doesn't prefer to emit
> > rep mov*/stos* or loop or something similar, of course kernel can keep
> > whatever it uses) you'll get just __asan_memcpy/__asan_memset calls,
> > no memcpy/memset, while without -fsanitize=kernel-address you get
> > normally memcpy/memset.
> 
> > Or do you need the __asan_* functions only in asan instrumented functions
> > and normal ones in non-instrumented functions in the same TU?
> 
> Yes, exactly that: __asan_ in instrumented, and normal ones in
> no_sanitize functions; they can be mixed in the same TU. We can't
> rename normal mem*() functions everywhere. In no_sanitize functions
> (in particular noinstr), normal mem*() should be used. But in
> instrumented code, it should be __asan_mem*(). Another longer
> explanation I also just replied here:
> https://lore.kernel.org/all/CANpmjNNH-O+38U6zRWJUCU-eJTfMhUosy==GWEOn1vcu=J2dcw@mail.gmail.com/
> 
> At least clang has had this behaviour for user space ASan forever:
> https://godbolt.org/z/h5sWExzef - so it was easy to just add the flag
> to make it behave like in user space for mem*() in the kernel. It
> might also be worthwhile for GCC to emit __asan_ for user space, given
> that the runtimes are shared and the user space runtime definitely has
> __asan_. The kernel needs the param (asan-kernel-mem-intrinsic-prefix)
> though, to not break older kernels.

So, what exactly you want for gcc to do with
--param asan-kernel-mem-intrinsic-prefix=1 (note, in GCC case it can't be
without the =1 at the end)?

The current gcc behavior is that operations like aggregate copies, or
clearing which might or might not need memcpy/memset/memmove under the hood
later are asan instrumented before the operation (in order not to limit the
choices on how it will be expanded), uses of builtins (__builtin_ prefixed
or not) are also instrumented before the calls unless they are one of the
calls that is recognized as always instrumented.  None for hwasan,
for asan:
index, memchr, memcmp, memcpy, memmove, memset, strcasecmp, strcat, strchr,
strcmp, strcpy, strdup, strlen, strncasecmp, strncat, strncmp, strcspn,
strpbrk, strspn, strstr, strncpy
and for those builtins gcc disables inline expansion and enforces a library
call (but until the expansion they are treated in optimizations like normal
builtins and so could be say DCEd, or their aliasing behavior is considered
etc.).  kasan behaves the same I think.

Now, I think libasan only has __asan_ prefixed
__asan_memmove, __asan_memset and __asan_memcpy, nothing else, so most of
the calls from the above list even can't be prefixed.

So, do you want for --param asan-kernel-mem-intrinsic-prefix=1 to __asan_
prefix just memcpy/memmove/memset and nothing else?  Is it ok to emit
memcpy/memset/memmove from aggregate operations which are instrumented
already at the caller (and similarly is it ok to handle those operations
inline)?

	Jakub

