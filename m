Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF236E60B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjDRMJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjDRMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:08:39 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E23C2A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:07:34 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7606df33c42so53149039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681819654; x=1684411654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P5YkRvYf1yCuUPW+Kk1SNC+gRw+VoF5jM1xlyDbolaQ=;
        b=WOcobd9VuTYeoeolWhApTMmZDhAKpw9GEyyhfF7cQCdUNfz1RIY4dav6bNZoVjLKr2
         zXkYI/AJ1jTCUk6vYMxWQvX8Tf/SG21R477oZST/o/wvRfqCY7CIXcliCnuipdTIu450
         l+0tHwoWK4Jf2lDR+Z/7ChjGpd2IK8YBDHY/eLmESpzZnbRDLjFptVf74TleeNy9uBZG
         jj/naKWhxNSfSdD0lvumrAKdCUHPrnXhxC/a21XFO0c8isWr1AIV/yB31nFwAV3l35BK
         2PyDek6BcGpz1pz18+/wfo+aGzGWBJOeEmZNE6dTErfd4C70Uke6tMGEK7pWqTpPMBj+
         W/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819654; x=1684411654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5YkRvYf1yCuUPW+Kk1SNC+gRw+VoF5jM1xlyDbolaQ=;
        b=VJzKZoLp7cHfHi/a6VGk2PTeBGOCjegNNzntvsvzVYZwfcoqNxN7CNvIWvV1IpTD5S
         Iqbjy/ZqehJK+bJ9NsEnHTIWDIbXNLAbjW7Yl3/pe6oIhMq5PsbmV/Sn3OacMicD2Jix
         xrSIevR9oMKsWQQXRidgTt/rDxjfalCEgoAaEJ9p5lKktjk/eLq/ywOBRZJZIM4Nhgd4
         sdZSeD6AuJI92mnK6wK3ca6jlX5syF6nZF355eYztlrafZyTItFFxk5HwVwoAo4MXh5O
         4wrl6kVVTYBc3JSPY705vPAGJRGxrIrF+97r8R8zcoVT/NZVa23WlpIU2sA0Wkt28iha
         kuvw==
X-Gm-Message-State: AAQBX9e3kj1RscM1yIFr0AJDvEWcDIAPezh8LMf+hCZObBel9ySV37RL
        zUX5lWpl0Yb62BFZfeiEaZboIQaB/tipsaW7XmvHFg==
X-Google-Smtp-Source: AKy350aa0eGR3rVWgp5X55p+lwLOnj2E8Vot0GFoupjvl9G3FkOikipr6kPUR5xD0sUsnZ0CUJk+9WJe0KIsaNnh1hQ=
X-Received: by 2002:a6b:e216:0:b0:74c:8cec:548e with SMTP id
 z22-20020a6be216000000b0074c8cec548emr1574390ioc.4.1681819653797; Tue, 18 Apr
 2023 05:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230414082943.1341757-1-arnd@kernel.org> <20230414162605.GA2161385@dev-arch.thelio-3990X>
In-Reply-To: <20230414162605.GA2161385@dev-arch.thelio-3990X>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 14:06:57 +0200
Message-ID: <CANpmjNMwYosrvqh4ogDO8rgn+SeDHM2b-shD21wTypm_6MMe=g@mail.gmail.com>
Subject: Re: [PATCH] kasan: remove hwasan-kernel-mem-intrinsic-prefix=1 for clang-14
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 at 18:26, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Apr 14, 2023 at 10:29:27AM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Unknown -mllvm options don't cause an error to be returned by clang, so
> > the cc-option helper adds the unknown hwasan-kernel-mem-intrinsic-prefix=1
> > flag to CFLAGS with compilers that are new enough for hwasan but too
>
> Hmmm, how did a change like commit 0e1aa5b62160 ("kcsan: Restrict
> supported compilers") work if cc-option does not work with unknown
> '-mllvm' flags (or did it)? That definitely seems like a problem, as I
> see a few different places where '-mllvm' options are used with
> cc-option. I guess I will leave that up to the sanitizer folks to
> comment on that further, one small comment below.

Urgh, this one turns out to be rather ridiculous. It's only a problem
with hwasan...

If you try it for yourself, e.g. with something "normal" like:

> clang -Werror -mllvm -asan-does-not-exist -c -x c /dev/null -o /dev/null

It errors as expected. But with:

> clang -Werror -mllvm -hwasan-does-not-exist -c -x c /dev/null -o /dev/null

It ends up printing _help_ text, because anything "-h..." (if it
doesn't recognize it as a long-form argument), will make it produce
the help text.

> > old for this option. This causes a rather unreadable build failure:
> >
> > fixdep: error opening file: scripts/mod/.empty.o.d: No such file or directory
> > make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:252: scripts/mod/empty.o] Error 2
> > fixdep: error opening file: scripts/mod/.devicetable-offsets.s.d: No such file or directory
> > make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 2
> >
> > Add a version check to only allow this option with clang-15, gcc-13
> > or later versions.
> >
> > Fixes: 51287dcb00cc ("kasan: emit different calls for instrumentable memintrinsics")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > There is probably a better way to do this than to add version checks,
> > but I could not figure it out.
> > ---
> >  scripts/Makefile.kasan | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> > index c186110ffa20..2cea0592e343 100644
> > --- a/scripts/Makefile.kasan
> > +++ b/scripts/Makefile.kasan
> > @@ -69,7 +69,12 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
> >               $(instrumentation_flags)
> >
> >  # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
> > +ifeq ($(call clang-min-version, 150000),y)
> >  CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> > +endif
> > +ifeq ($(call gcc-min-version, 130000),y)
> > +CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> > +endif
>
> I do not think you need to duplicate this block, I think
>
>   ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
>   CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>   endif

We just need the clang version check. If the compiler is gcc, it'll do
the "right thing" (i.e. not print help text). So at a minimum, we need
if "clang version >= 15 or gcc". Checking if gcc is 13 or later
doesn't hurt though, so I don't mind either way.

So on a whole this patch is the right thing to do because fixing old
clang versions to not interpret unrecognized options that start with
"-h.." as help isn't something we can realistically do.

Thanks,
-- Marco
