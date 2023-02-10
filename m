Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE520692580
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjBJSlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjBJSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:41:22 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0146211E8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:41:21 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-52ee632329dso5660267b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HoyBTwj66Ay0J3w/gr1HIoKq5C1qctdqphazc4onVf8=;
        b=iRmtp991KmxEx0dOBrpH1g6b6EdUK4j8Wp9fZ66mBCVPfNmsYORt0SSta+4mrRDGwR
         tyB1WFfPyIw6QQeUc0r96dotmtbpBGf7ipwUfhTmn7LHt88IvVJ0hXO7mF2OFso63GDd
         3zV2AJUxXqTafq6Ds0LCAGNAoSvLrmVDOW+o7iE6hWarrNNV6fvjH8E/YrAca/Ko9gL5
         VXB6BQ+oRY++j+4pIN1G4dRIZVDxMM/3SOeYfc09VSkTqBg8nzPOPkNm+FPzUZnKa8RJ
         zCds5uIodyz/JBOXF0CTYV6GpGYhAupwNJXt0H3KaZNhClmVxCqM9JsMdv1MgDmN29EG
         HVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoyBTwj66Ay0J3w/gr1HIoKq5C1qctdqphazc4onVf8=;
        b=vZhqN2AbFBCUEf9zJ1+ChPoGi7Kf7Bh8kU9r7puUyeKQ9HGfUAyZfcWEtLwpgOMpmV
         dpMwO02bNbZX5IA7e04T8sfKdpVG0yuEnwSZnHyqdEW6ifDDQJn5Qzx5clcbDbrcz81r
         N37IIM9dHC6X2Gd4orz1SFzJqMFEEpSajhLbB1js6VFPJWvCe4Jhn3JDuoMYKZFIN+6I
         BMSdNLH36c4OqLj9g/2ZIqncWRYR/UCx3f+1kkcVm4IkHBvzwVpnlD5QGCKgaeRpPmWZ
         pXGYaIKqcMM+b0/3DdzeMLLQtIX+9oHK20zG6PRqJ7Ekh4lbc7zElJK03MN8F7shEtE5
         isNQ==
X-Gm-Message-State: AO0yUKX6TTjFmeeED8zqe0B9qVHAddd7fa7hG9c89M3LJ/ASeMzsuLrT
        ukGswTzv/UVoMJFEQaiy0QMOHvJG5idjLaDy8+MeLA==
X-Google-Smtp-Source: AK7set+XALIOg+YZHD0C3umzElPccXtvGEpiGklhX9RSc5MDbads2a2nFgpHbx+mkz4Yp5WFFV1zzFXykk/lm9/IKYI=
X-Received: by 2002:a81:7406:0:b0:52e:e6ed:30ae with SMTP id
 p6-20020a817406000000b0052ee6ed30aemr17351ywc.558.1676054480876; Fri, 10 Feb
 2023 10:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20230208184203.2260394-1-elver@google.com> <CA+fCnZeU=pRcyiBpj3nyri0ow+ZYp=ewU3dtSVm_6mh73y1NTA@mail.gmail.com>
 <CANpmjNP_Ka6RTqHNRD7xx93ebZhY+iz69GHBusT=A8X1KvViVA@mail.gmail.com> <CA+fCnZcNF5kNxNuphwj41P45tQEhQ9wX00ZA4g=KTX4sbUirQg@mail.gmail.com>
In-Reply-To: <CA+fCnZcNF5kNxNuphwj41P45tQEhQ9wX00ZA4g=KTX4sbUirQg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Feb 2023 19:40:44 +0100
Message-ID: <CANpmjNNH-O+38U6zRWJUCU-eJTfMhUosy==GWEOn1vcu=J2dcw@mail.gmail.com>
Subject: Re: [PATCH -tip] kasan: Emit different calls for instrumentable memintrinsics
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 at 17:13, Andrey Konovalov <andreyknvl@gmail.com> wrote:
[...]
> > Probably the same should be done for SW_TAGS, because arm64 will be
> > GENERIC_ENTRY at one point or another as well.
>
> Yes, makes sense. I'll file a bug for this once I fully understand the
> consequences of these changes.
>
> > KASAN + GCC on x86 will have no mem*() instrumentation after
> > 69d4c0d32186, which is sad, so somebody ought to teach it the same
> > param as above.
>
> Hm, with that patch we would have no KASAN checking within normal mem*
> functions (not the ones embedded by the compiler) on GENERIC_ENTRY
> arches even with Clang, right?

Yes, that's the point - normal mem*() functions cannot be instrumented
with GENERIC_ENTRY within noinstr functions, because the compiler
sometimes decides to transform normal assignments into
memcpy()/memset(). And if mem*() were instrumented (as it was before
69d4c0d32186), that'd break things for these architectures.

But since most code is normally instrumented, with the right compiler
support (which the patch here enables), we just turn mem*() in
instrumented functions into __asan_mem*(), and get the instrumentation
as before. 69d4c0d32186 already added those __asan functions. The fact
that KASAN used to override mem*() is just the wrong choice in a world
where compilers decide to inline or outline these. From an
instrumentation point of view at the compiler level, we need to treat
them like any other instrumentable instruction (loads, stores,
atomics, etc.): transform each instrumentable instruction into
something that does the right checks. Only then can we be sure that we
don't accidentally instrument something that shouldn't be (noinstr
functions), because instead of relying on the compiler, we forced
instrumentation on every mem*().
