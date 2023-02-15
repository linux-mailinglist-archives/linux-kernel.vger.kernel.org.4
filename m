Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8174697494
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjBOC4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBOC4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:56:09 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FB42B639
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:56:04 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id f10so7051846ilc.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AMRBoKkOIVB/WviH4IgQy3fBGZ0k4cThtcao32eLZ1A=;
        b=A42/UHcaUhHPECfMYj5xgYJtsyhU4ROtGUkJy2oFLsEYPH+s90qmrG/FRdIJC+dlWM
         48jVLQLFVG/R7lad6zuuNJkOExrByeoic6UAtbNPT6kwK6OACS01t6ld+rJ0Ze2ECL+a
         VbfBNc21x39cruzKn5ZEZUePdJa++g7QXKGmIXViWWvbwggtHgAWZcFNmbusCgTj4gsk
         R4lKlJob+E4p2WBi/BaCQVQ8r3Y1yRpnZH5xlUrs++vKPik3cxMWXOXme3MQ+T28C6JR
         6qomFUwjduRyT6EcYM+Cg2ArIVXRFrl9SsQk6Rb+RWNjTWpo/780wou34iawXzbKMQC1
         O5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMRBoKkOIVB/WviH4IgQy3fBGZ0k4cThtcao32eLZ1A=;
        b=Wrf13qlaA5wfg79Si4rWlB+9PpCcZOSKbD3IsDtsc78vF5TkwUayYHladv7WDKSSwh
         KaulN72wIwgGvGDzDE6+DytAY/MzuZGYMR3Emokauej2jAIw/Ke10FYgn96bRF/AkCdy
         wvla1Oyo/iwB/U3LOp/AlbWO99p8PFWevQ2aGqa/JfMDS26G/O60x2jDll2peT6zZ5Hr
         rjLio4fpfJUudFj/IkEi9F+liglACuY9sHoOQTmssEdQQDhLJDbphnoExrC3eZjIL5bU
         Be+6OCIJMfSlruJPeYnQa5O09MdCUOrXdJd4r1uG7TyBS3aN4pwYN7iqJmZd9mO9pKYM
         H0ew==
X-Gm-Message-State: AO0yUKX/Q9wyV96CTFmZ2LfM65d4IgufAU+IKssVFREgDWMx7TGd2rVb
        wmk7E13vZajaX0IRNRpel0kHMoF3eFHBtvKGSNx39g==
X-Google-Smtp-Source: AK7set8FGsHT0Rx9AJqcFaozjnLIXwCSODu3xXgw8RpWVwuU4EfG5MEbrWWU3xDNgpPxVioaX3AcAdcmB0SIRtlFY1w=
X-Received: by 2002:a92:8e04:0:b0:310:9d77:6063 with SMTP id
 c4-20020a928e04000000b003109d776063mr267413ild.5.1676429763604; Tue, 14 Feb
 2023 18:56:03 -0800 (PST)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com> <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
In-Reply-To: <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 14 Feb 2023 18:55:52 -0800
Message-ID: <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     Marco Elver <elver@google.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:08 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 14 Feb 2023 at 02:21, Peter Collingbourne <pcc@google.com> wrote:
> >
> > On Tue, Oct 18, 2022 at 10:17 AM <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Switch KUnit-compatible KASAN tests from using per-task KUnit resources
> > > to console tracepoints.
> > >
> > > This allows for two things:
> > >
> > > 1. Migrating tests that trigger a KASAN report in the context of a task
> > >    other than current to KUnit framework.
> > >    This is implemented in the patches that follow.
> > >
> > > 2. Parsing and matching the contents of KASAN reports.
> > >    This is not yet implemented.
> > >
> > > Reviewed-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > ---
> > >
> > > Changed v2->v3:
> > > - Rebased onto 6.1-rc1
> > >
> > > Changes v1->v2:
> > > - Remove kunit_kasan_status struct definition.
> > > ---
> > >  lib/Kconfig.kasan     |  2 +-
> > >  mm/kasan/kasan.h      |  8 ----
> > >  mm/kasan/kasan_test.c | 85 +++++++++++++++++++++++++++++++------------
> > >  mm/kasan/report.c     | 31 ----------------
> > >  4 files changed, 63 insertions(+), 63 deletions(-)
> > >
> > > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > > index ca09b1cf8ee9..ba5b27962c34 100644
> > > --- a/lib/Kconfig.kasan
> > > +++ b/lib/Kconfig.kasan
> > > @@ -181,7 +181,7 @@ config KASAN_VMALLOC
> > >
> > >  config KASAN_KUNIT_TEST
> > >         tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
> > > -       depends on KASAN && KUNIT
> > > +       depends on KASAN && KUNIT && TRACEPOINTS
> >
> > My build script for a KASAN-enabled kernel does something like:
> >
> > make defconfig
> > scripts/config -e CONFIG_KUNIT -e CONFIG_KASAN -e CONFIG_KASAN_HW_TAGS
> > -e CONFIG_KASAN_KUNIT_TEST
> > yes '' | make syncconfig
> >
> > and after this change, the unit tests are no longer built. Should this
> > use "select TRACING" instead?
>
> I think we shouldn't select TRACING, which should only be selected by
> tracers. You'd need CONFIG_FTRACE=y.

Doesn't CONFIG_FTRACE=y mean "function tracing", i.e. function
entry/exit tracing using compiler instrumentation? As far as I can
tell, the KASAN tests do not make use of this feature. They only use
the kernel tracepoint infrastructure to trace the "console" tracepoint
defined in include/trace/events/printk.h, which is not associated with
function entry/exit.

I have yet to find any evidence that TRACING ought to only be selected
by tracers. As far as I can tell, TRACING appears to be the minimal
config required in order for it to be possible to trace pre-defined
(i.e. defined with TRACE_EVENT) tracepoints, which is all that KASAN
needs. (I also tried selecting TRACEPOINTS, but this led to a number
of link failures.) If select TRACING is only used by tracers, it could
just mean that only tracers are making use of this functionality
inside the kernel. From that perspective the KASAN tests can
themselves be considered a "tracer" (albeit a very specialized one).

If I locally revert the change to lib/Kconfig.kasan and add the
TRACING select, the KASAN tests pass when using my kernel build
script, which suggests that TRACING is all that is needed.

> Since FTRACE is rather big, we probably also shouldn't implicitly
> select it. Instead, at least when using kunit.py tool, we could add a
> mm/kasan/.kunitconfig like:
>
> CONFIG_KUNIT=y
> CONFIG_KASAN=y
> CONFIG_KASAN_KUNIT_TEST=y
> # Additional dependencies.
> CONFIG_FTRACE=y
>
> Which mirrors the KFENCE mm/kfence/.kunitconfig. But that doesn't help
> if you want to run it with something other than KUnit tool.

In any case, I'm not sure I'm in favor of adding yet another config
that folks need to know to enable in order to avoid silently disabling
the unit tests. Many developers will maintain their own scripts for
kernel development if the existing ones do not meet their needs. It's
possible that kunit.py will work out for me now (when I looked at it
before, it was useless for me because it only supported UML, but it
looks like it supports QEMU now), but there's no guarantee that it
will, so I might stick with my scripts for a while.

Peter
