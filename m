Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2057D64EE39
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiLPPxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiLPPxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:53:16 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9FD7B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:52 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-417b63464c6so38399867b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOP93QaAQMcfYeKQh80Wnem5s5Ji+Q2nkQ3zFddX4zk=;
        b=MKvZJHiNxZPJHwFTNcCzAaRZYl8dantlYJp+WuJ0YpxrlF3J3BGhZHdGPiuOJrWbvX
         +8tqQXXp61xQOT1Jn6kCtb0D4RybGNBAkbJHDvhaShXjMJvAyHUZwXh9sDagYpTTkrjf
         npQWkSC0poPowZYA1GEOY9ze3gtstcwzLLXwKAdVOSI0IKoUSTZqfKnOjak1rqGYSlaG
         DyF+fnHwyXVdeTk7CNh6gvT4cZM3YTabPutd1r7JINmKv0Gb1Kn494iCHJoT4One3Rhp
         KPJ5fXd2k0RQb/ZL7bfc4ZEdK4rfLRXiObKUEIRQ8d+6iaD0dXsDDCjQ26eU9evSTEz5
         uQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOP93QaAQMcfYeKQh80Wnem5s5Ji+Q2nkQ3zFddX4zk=;
        b=R4QthZIvsJXylROE8w2MTMUueBCrETWfuJm2o4Uh8fgI1ONKtQXh14S/DIKS803Pbn
         PXXQ2g/0qBYP2CzZ5XKLdTt+WbyFBHkNwmkZ8IkCbuBk7qpH7AF3lc/DXp7ti2EXyNVa
         W1H2ONld9HBWjxAwGFOZDgZZFnbC7BgtRYhIk3zIFUBDHsazHxdgpHRejxve4SGNFaFy
         7pCaerrgNLkH894cdu4nATpwGW0qFuL5mfNCv5M6vpMuiSed8vXbqjZSorGvYtbNbleq
         Luyxe+97KY/tkLe/aP5q4Av1t+dIFGWnlkUr2yWJZqIbU+2ayPN9YMTBDcAdzH4Po2Kb
         +sNQ==
X-Gm-Message-State: ANoB5pkhaZWc0kH9YqC9BLOvgRWAzXwmpGaTsfnRYv/Js2qVrv2n+TaG
        QpE5JJypnoDZ5aim5wqQJsmwQ8vtI+Ujm0do3MHemQ==
X-Google-Smtp-Source: AA0mqf4NT/WUJA4BsEuDv9Kxa3YRL+8dvPVPAG4WB8NHQO7/cYMhs8sJcwfXtGtZdsfL6BBoXYrfyWiif6RFqUpIxH4=
X-Received: by 2002:a0d:f781:0:b0:373:6e8a:e7db with SMTP id
 h123-20020a0df781000000b003736e8ae7dbmr9775062ywf.144.1671205971474; Fri, 16
 Dec 2022 07:52:51 -0800 (PST)
MIME-Version: 1.0
References: <cad03d25-0ea0-32c4-8173-fd1895314bce@I-love.SAKURA.ne.jp>
 <CAMuHMdUH4CU9EfoirSxjivg08FDimtstn7hizemzyQzYeq6b6g@mail.gmail.com> <86bdfea2-7125-2e54-c2c0-920f28ff80ce@I-love.SAKURA.ne.jp>
In-Reply-To: <86bdfea2-7125-2e54-c2c0-920f28ff80ce@I-love.SAKURA.ne.jp>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 16 Dec 2022 16:52:14 +0100
Message-ID: <CAG_fn=VJrJDNSea6DksLt5uBe_sDu0+8Ofg+ifscOyDdMKj3XQ@mail.gmail.com>
Subject: Re: [PATCH] fbcon: Use kzalloc() in fbcon_prepare_logo()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Dec 16, 2022 at 3:03 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/12/15 18:36, Geert Uytterhoeven wrote:
> > The next line is:
> >
> >         scr_memsetw(save, erase, array3_size(logo_lines, new_cols, 2));
> >
> > So how can this turn out to be uninitialized later below?
> >
> >         scr_memcpyw(q, save, array3_size(logo_lines, new_cols, 2));
> >
> > What am I missing?
>
> Good catch. It turned out that this was a KMSAN problem (i.e. a false pos=
itive report).
>
> On x86_64, scr_memsetw() is implemented as
>
>         static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
>         {
>                 memset16(s, c, count / 2);
>         }
>
> and memset16() is implemented as
>
>         static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
>         {
>                 long d0, d1;
>                 asm volatile("rep\n\t"
>                              "stosw"
>                              : "=3D&c" (d0), "=3D&D" (d1)
>                              : "a" (v), "1" (s), "0" (n)
>                              : "memory");
>                 return s;
>         }
>
> . Plain memset() in arch/x86/include/asm/string_64.h is redirected to __m=
san_memset()
> but memsetXX() are not redirected to __msan_memsetXX(). That is, memory i=
nitialization
> via memsetXX() results in KMSAN's shadow memory being not updated.
>
> KMSAN folks, how should we fix this problem?
> Redirect assembly-implemented memset16(size) to memset(size*2) if KMSAN i=
s enabled?
>

I think the easiest way to fix it would be disable memsetXX asm
implementations by something like:

---------------------------------------------------------------------------=
----------------------
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string=
_64.h
index 888731ccf1f67..5fb330150a7d1 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -33,6 +33,7 @@ void *memset(void *s, int c, size_t n);
 #endif
 void *__memset(void *s, int c, size_t n);

+#if !defined(__SANITIZE_MEMORY__)
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
@@ -68,6 +69,7 @@ static inline void *memset64(uint64_t *s, uint64_t
v, size_t n)
                     : "memory");
        return s;
 }
+#endif

 #define __HAVE_ARCH_MEMMOVE
 #if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
---------------------------------------------------------------------------=
----------------------

This way we'll just pick the existing C implementations instead of
reinventing them.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
