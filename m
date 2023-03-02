Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99A46A8512
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCBPRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCBPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:17:50 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B5497EC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:17:49 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-536bbe5f888so432611977b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swy0Vvp7k1UShoRmUJ7j46CPAn/D6prvkxRY/qzs/SE=;
        b=CF2YWaUfaNqcOG3qLv84WuxL0ySDJynMHCuWXjDb6SBI6/hv9XsBfe7dnNpWQ75sYt
         RUBUbfEpveBvA3RMYD7fBkKlwx27eOJnrBYxHupNj2G/pgsT+ygbEk5Thhnk9x/7OB0v
         rn3/Q4c88hafo04aQczG5eI7ps3iCD1jgVntZ+0nTpDmxcKweFS4aCssk0rjGWPobWi8
         chTNOSmRE3M8Lj3Dx5DVEQr6l4FxGjn5YU3xDAc65gIh47YSl1p+IY8CT4iqLvvyfRVO
         kNhOOfR+j6eQ9KlDg1HKESImS6URfOLplYCbFVLs1gqTbMnTdGuCmwXEvNTaFUFbCVDt
         6h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swy0Vvp7k1UShoRmUJ7j46CPAn/D6prvkxRY/qzs/SE=;
        b=0o2kiwIf0JO6vwjCFrQvtesVr9vu0hyZb5otv+TFOsFqGCRcbcs2WIPRjKRXuu6LHc
         wOY06LyIbxvWoSnaXGPUgbVMyejHHf68JsJe+QATRn+AIhMmUMy+TFXEaGySmfvvBheu
         WRax87ag2plDAwkiSSde2zkfQYbyyWovFZTIm/KRtEbPxKriumOclLYJaeoFLZ0zBMJH
         pVkvLUq5juSAse2CQJaTzWxvkcPQHrmI4ZntbvGvtmY26S8i5hfp4XB1hBgwiqY18VB+
         NSzPzbgXZyJEEnb+iremGj0BIJWnRT8S7jZNhFv+VJEj+6Km5M5EY3PjMs0qT08G/MBA
         BuDg==
X-Gm-Message-State: AO0yUKWrNDqTCUiFUxSkDejKmOBx9JfZHRJyY/BKvFwRzZQkC/lrLcTY
        E8g9DGSh4ld/H4Pc3biPyB4Z8OmUIqM9rXk8Sb26SDCGV43Uut5I
X-Google-Smtp-Source: AK7set+3VrU1WkPMjDY7pE36z7iW24+fggQzrZ99elu49Vgl4quWaYlSQGHbSXoNkwjoVUmRjlbIWCDcD/wyj3OoPO8=
X-Received: by 2002:a81:ad58:0:b0:52a:9f66:80c6 with SMTP id
 l24-20020a81ad58000000b0052a9f6680c6mr6418676ywk.9.1677770268490; Thu, 02 Mar
 2023 07:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com> <CANpmjNMR5ExTdo+EiLs=_b0M=SpN_gKAZTbSZmyfWFpBh4kN-w@mail.gmail.com>
 <CAG_fn=U9H2bmUxkJA6vyD15j+=GJTkSgKuMRbd=CWVZsRwR7TQ@mail.gmail.com> <CANpmjNMtXudXbVy4cZDAUUVjHX+hQ0P+FY6La3bsp2zp4t-pZw@mail.gmail.com>
In-Reply-To: <CANpmjNMtXudXbVy4cZDAUUVjHX+hQ0P+FY6La3bsp2zp4t-pZw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Mar 2023 16:17:11 +0100
Message-ID: <CAG_fn=Ubagz667ZEM2wyabshZhY-wyJRFUzqxZkBj3AES+KnXg@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: kmsan: Don't rename memintrinsics in
 uninstrumented files
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, kasan-dev@googlegroups.com,
        Kees Cook <keescook@chromium.org>
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

On Thu, Mar 2, 2023 at 4:13=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> On Thu, 2 Mar 2023 at 15:28, Alexander Potapenko <glider@google.com> wrot=
e:
> >
> > On Thu, Mar 2, 2023 at 12:14=E2=80=AFPM Marco Elver <elver@google.com> =
wrote:
> > >
> > > On Wed, 1 Mar 2023 at 15:39, Alexander Potapenko <glider@google.com> =
wrote:
> > > >
> > > > KMSAN should be overriding calls to memset/memcpy/memmove and their
> > >
> > > You mean that the compiler will override calls?
> > > All supported compilers that have fsanitize=3Dkernel-memory replace
> > > memintrinsics with __msan_mem*() calls, right?
> >
> > Right. Changed to:
> >
> > KMSAN already replaces calls to to memset/memcpy/memmove and their
> > __builtin_ versions with __msan_memset/__msan_memcpy/__msan_memmove in
> > instrumented files, so there is no need to override them.
>
> But it's not KMSAN - KMSAN is the combined end result of runtime and
> compiler - in this case we need to be specific and point out it's the
> compiler that's doing it. There is no code in the Linux kernel that
> does this replacement.

Agreed. I'll replace with "clang -fsanitize=3Dkernel-memory"
