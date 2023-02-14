Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB7A6958C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjBNGIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBNGIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:08:04 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DCC6A5F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:08:03 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id v81so7460014vkv.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676354882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+nVV5Ba3Z7LEjnraYcY3XOVAg4sdVrhWrxDDszwimc=;
        b=FNiC/1wrGp4NJ8oCUZdHlK/+r38iPxWS8UfDndQGWukyI4wyamp7X2ltuHwIwMRIp5
         vuK7K52MlVn4QfRTzEym05tDXEWm5QEPV0YRelm1LzM930Xk69zadhZDonD7PIGz9+TJ
         e2dmbLK6O+JkEhu81A8gsDSznUjDu0s3Bt9xOtk+VtCORdXJEhx1xIw4exI37/BmmOqE
         X33KY3jxhiokmVVSmo5Mxd6ML81n9ktXJ2bjmjdKIY2t3z1/FoXIGSNo8Bee10c0er1A
         2BkVXefCOWE4MYvILmkRIJES48vvjFLHKRq5QceeTJfMBNv54ce6k4z8jGm0FC3itZ8m
         hitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676354882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+nVV5Ba3Z7LEjnraYcY3XOVAg4sdVrhWrxDDszwimc=;
        b=xM6mNWWIOie211nXkRKg+EBJLh2/I80OaCzYob8qMxep7Z+yAXNdGCMUpUgDHTKgqs
         CfnaREEHuPlIsULnPeKU/238KtK7vy7WXPXTcAQRycUxKhmHhJpi4tzIIwFRARXRS8e8
         djAUEgh07EymgeDL0mSBCR7IEK1enpuWGsKJ1bfxVX6ksm3PYMsLmGi9QbdaRQY3cEL7
         c91teJwcJRULYXLu3HuilYjLbFTU1payrokNPkOGQZ51sjMquaOKZfWYMtrpjkht95zB
         5ltqgwi6dhJB2Stpz4JGG1C4akacxtciz9hi5c978Ocz2LyXX5Ly+maAqTu3LRPk3BfJ
         TZOw==
X-Gm-Message-State: AO0yUKXpj/hHk8ygrjFaGaGrdUzx81xuTZbZ+3qSuZ+LaXO+6nI6pKdT
        7TjQk0lJUzpByCZXfcEmRDCoRi5A4FlnxuF/H5SD7w==
X-Google-Smtp-Source: AK7set/ovk8zGfBhnXCZ5kjifb1AK0CSWtL1GQ956rLYgMhdqnq2dvJx+6I9gn5rWGg48BJEGan7qFp8aOgSfRBDFG8=
X-Received: by 2002:a1f:2012:0:b0:401:5cb7:dc92 with SMTP id
 g18-20020a1f2012000000b004015cb7dc92mr191751vkg.1.1676354881939; Mon, 13 Feb
 2023 22:08:01 -0800 (PST)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
In-Reply-To: <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Feb 2023 07:07:25 +0100
Message-ID: <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     Peter Collingbourne <pcc@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, 14 Feb 2023 at 02:21, Peter Collingbourne <pcc@google.com> wrote:
>
> On Tue, Oct 18, 2022 at 10:17 AM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Switch KUnit-compatible KASAN tests from using per-task KUnit resources
> > to console tracepoints.
> >
> > This allows for two things:
> >
> > 1. Migrating tests that trigger a KASAN report in the context of a task
> >    other than current to KUnit framework.
> >    This is implemented in the patches that follow.
> >
> > 2. Parsing and matching the contents of KASAN reports.
> >    This is not yet implemented.
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > ---
> >
> > Changed v2->v3:
> > - Rebased onto 6.1-rc1
> >
> > Changes v1->v2:
> > - Remove kunit_kasan_status struct definition.
> > ---
> >  lib/Kconfig.kasan     |  2 +-
> >  mm/kasan/kasan.h      |  8 ----
> >  mm/kasan/kasan_test.c | 85 +++++++++++++++++++++++++++++++------------
> >  mm/kasan/report.c     | 31 ----------------
> >  4 files changed, 63 insertions(+), 63 deletions(-)
> >
> > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > index ca09b1cf8ee9..ba5b27962c34 100644
> > --- a/lib/Kconfig.kasan
> > +++ b/lib/Kconfig.kasan
> > @@ -181,7 +181,7 @@ config KASAN_VMALLOC
> >
> >  config KASAN_KUNIT_TEST
> >         tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
> > -       depends on KASAN && KUNIT
> > +       depends on KASAN && KUNIT && TRACEPOINTS
>
> My build script for a KASAN-enabled kernel does something like:
>
> make defconfig
> scripts/config -e CONFIG_KUNIT -e CONFIG_KASAN -e CONFIG_KASAN_HW_TAGS
> -e CONFIG_KASAN_KUNIT_TEST
> yes '' | make syncconfig
>
> and after this change, the unit tests are no longer built. Should this
> use "select TRACING" instead?

I think we shouldn't select TRACING, which should only be selected by
tracers. You'd need CONFIG_FTRACE=y.

Since FTRACE is rather big, we probably also shouldn't implicitly
select it. Instead, at least when using kunit.py tool, we could add a
mm/kasan/.kunitconfig like:

CONFIG_KUNIT=y
CONFIG_KASAN=y
CONFIG_KASAN_KUNIT_TEST=y
# Additional dependencies.
CONFIG_FTRACE=y

Which mirrors the KFENCE mm/kfence/.kunitconfig. But that doesn't help
if you want to run it with something other than KUnit tool.
