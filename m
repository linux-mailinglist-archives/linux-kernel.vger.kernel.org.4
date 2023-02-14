Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659986955D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBNBVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBNBVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:21:38 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AEA8A56
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:21:37 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id i4so2556109vkn.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VTf6y2rsNM1eSIJ6oZJRGFI8N75zoVA8XUUEZKJwwzs=;
        b=mOYk+wlLkHpYxTRCpTfD+LZwmqSmgfaBTCfSrPLRk7Fv/QOzkNbYinmE+VCVBdlEAB
         Q4KwtFwl8rPSZjdTI59Dn9a5ZmHGOZSdFi9g7pGFJS9IvUEnUq1kzIHFRxp0b7FKxeiB
         AQz4UP7NkbLQdzq0+ayPWfqlyZKDelT7607dH0nEKibSfIKGqcK4O7QXGIL+vdi09GTj
         Rbzr3rPwuPBhA7SmgXfops4n6fpipbqJmiKHkQ/4oktU0ATi+nx6lywVWqW8ho7aXq7O
         VyNtFA+QRwW41WERLxoUMis95vBlZT3PHajZHhAxKCV82rTxICRc8RPQZ34Ch6LFNp06
         AevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTf6y2rsNM1eSIJ6oZJRGFI8N75zoVA8XUUEZKJwwzs=;
        b=uR4BAtxNLR8qEeQrvRZQ8TqloqWAanWZ3UhJEYVzD9taYaBKTy4O72+y7RAFxnvRt8
         JFc6W6098tLEemz27gdy3NwciXwkUK7b+kEIvxPtu3FIRB+Ef7LcuwYqVJLywk3vh2b9
         oco0hW2fa3RyEtb1zO+j4AFn5fIX2RYLBvHGtHaemxu9e0gIAiH7pXUzFsDin5gksuI3
         xY8xx486hTn1rE9RJclDhXiiMrebNPp2LVT9xdU+Vq2hZzxT9loRNNPk/BkDsy44+vOE
         BhZ4t6ZT4JrUw3lO2K1YpNDhDX4LPmxpMy20PDhNLtx1g+kBYJizbuj60TmQ3ZDM0ID4
         4fRg==
X-Gm-Message-State: AO0yUKViuVtgh5pzI6CU668g060GYTt9H6wUS0kIR5wcLCyw3Qw4DXvI
        6sxAfSkDODLPHmEV9G0Su4+P7AggLqLxWiOIiv6INA==
X-Google-Smtp-Source: AK7set/R3fPq4pUkj1B3UOjrKbLZD9BDcC+1bDC2TQ1VSwoDXP2OGdbLShCU/MnRwqudZ3huUie64T3/2dnpfmXzWtE=
X-Received: by 2002:a1f:32c9:0:b0:3ea:4912:8be7 with SMTP id
 y192-20020a1f32c9000000b003ea49128be7mr68149vky.41.1676337696352; Mon, 13 Feb
 2023 17:21:36 -0800 (PST)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
In-Reply-To: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 13 Feb 2023 17:21:25 -0800
Message-ID: <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
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

On Tue, Oct 18, 2022 at 10:17 AM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Switch KUnit-compatible KASAN tests from using per-task KUnit resources
> to console tracepoints.
>
> This allows for two things:
>
> 1. Migrating tests that trigger a KASAN report in the context of a task
>    other than current to KUnit framework.
>    This is implemented in the patches that follow.
>
> 2. Parsing and matching the contents of KASAN reports.
>    This is not yet implemented.
>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Changed v2->v3:
> - Rebased onto 6.1-rc1
>
> Changes v1->v2:
> - Remove kunit_kasan_status struct definition.
> ---
>  lib/Kconfig.kasan     |  2 +-
>  mm/kasan/kasan.h      |  8 ----
>  mm/kasan/kasan_test.c | 85 +++++++++++++++++++++++++++++++------------
>  mm/kasan/report.c     | 31 ----------------
>  4 files changed, 63 insertions(+), 63 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index ca09b1cf8ee9..ba5b27962c34 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -181,7 +181,7 @@ config KASAN_VMALLOC
>
>  config KASAN_KUNIT_TEST
>         tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
> -       depends on KASAN && KUNIT
> +       depends on KASAN && KUNIT && TRACEPOINTS

My build script for a KASAN-enabled kernel does something like:

make defconfig
scripts/config -e CONFIG_KUNIT -e CONFIG_KASAN -e CONFIG_KASAN_HW_TAGS
-e CONFIG_KASAN_KUNIT_TEST
yes '' | make syncconfig

and after this change, the unit tests are no longer built. Should this
use "select TRACING" instead?

Peter
