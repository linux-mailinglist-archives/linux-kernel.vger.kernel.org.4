Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B760E565
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiJZQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiJZQWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:22:00 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B0510EA3B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:21:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r3so19559608yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dyd6cIxqMoiV31eHklrQhs9akoYIl7JR8zcy+9Yf9Ek=;
        b=MBEkyQ/uyWiwu/66kX0ye1vCdV2WVAqC0KC4h/5JzVBpJECVcleXeWcAF4SY6gHA6E
         sZMr5TNKsl25CGoqofAWdfi2k9QwqCOTf665XxKRkKT1kAk74fmR6KqoTesUOL9sA7+p
         zOr/zNk9efUmsgUqGb3MbKH4qLYzzGnd6PqKIJt12cMo5NmuB6BMoelVvZzM5MaUQVNf
         wJ3UR5Z0CMq9O5lq0Hdo6TZ8jfN6P+t3UNSbpBwPtOzmSsDR2qHc7lnBeQG1MXEiQ/gt
         UiKSQHclevB+86rHW+L7tIendd4JtU4jVk2rd4PA2O5bqosHCxBfxytKsV34VmjH4Dis
         obPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyd6cIxqMoiV31eHklrQhs9akoYIl7JR8zcy+9Yf9Ek=;
        b=KZz+DWWY7DgfRIqrVBSybzfIfECJtTmsV49npB4hHRcVShzW4GhiDcbB8DnPXgl9Lu
         PysFFpvxR0IY3EdQndQJcpFLwHCjduPT8DnIXzmYknZBc0JI1O3/I8LrfwRxhjDkwG2q
         xuDD5a8G2evQw5U9k8h4oKC2Pg8hMe0hwVj2GlaOWMLiSHQ50xC0DQ2A3bVCV7W19wbn
         3KZuRTce2428tNl8Xl4DqFLtjRKThaEK7k37o8Vw7CJxzLbnIQKKPTVNxVfyHWFOZEwp
         VFNw8Dw7Bl/KXdEtvMJ4sgYP8uLthbuG2FF+4dESDQxDkHHApTw8aBaJGsx9Fr5C/ITh
         97Eg==
X-Gm-Message-State: ACrzQf2t6cF4OWfWhdOoNUPsZ5UFBZqFSyTwiANqJXCgavR8952l4JyY
        B7y1+YdNaVBaeXEqi5eAJSJkzdmVWhk1APCIOnok6Q==
X-Google-Smtp-Source: AMsMyM4Ghir/aZcnPIPwDCiFDhAkrglmo8h6kwMd9/ZLmLkRq6xzIV3AhzmkeBd/MJxhyucE59YHgxL45g1eTQ0OkvQ=
X-Received: by 2002:a25:c102:0:b0:6c4:c94:2842 with SMTP id
 r2-20020a25c102000000b006c40c942842mr41389384ybf.611.1666801318874; Wed, 26
 Oct 2022 09:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221026141040.1609203-1-davidgow@google.com>
In-Reply-To: <20221026141040.1609203-1-davidgow@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 26 Oct 2022 09:21:22 -0700
Message-ID: <CANpmjNMLuep71fz2P=9ZrYSaD_GwE6XDf69+auf=2G7FYqu4sw@mail.gmail.com>
Subject: Re: [PATCH] perf/hw_breakpoint: test: Skip the test if dependencies unmet
To:     David Gow <davidgow@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 at 07:10, David Gow <davidgow@google.com> wrote:
>
> Running the test currently fails on non-SMP systems, despite being
> enabled by default. This means that running the test with:
>
>  ./tools/testing/kunit/kunit.py run --arch x86_64 hw_breakpoint
>
> results in every hw_breakpoint test failing with:
>
>  # test_one_cpu: failed to initialize: -22
>  not ok 1 - test_one_cpu
>
> Instead, use kunit_skip(), which will mark the test as skipped, and give
> a more comprehensible message:
>
>  ok 1 - test_one_cpu # SKIP not enough cpus
>
> This makes it more obvious that the test is not suited to the test
> environment, and so wasn't run, rather than having run and failed.
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Marco Elver <elver@google.com>

Although I still get confused by the fact that skipped tests say "ok"
and then need to double check the log that tests weren't skipped.

> ---
>  kernel/events/hw_breakpoint_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
> index 5ced822df788..c57610f52bb4 100644
> --- a/kernel/events/hw_breakpoint_test.c
> +++ b/kernel/events/hw_breakpoint_test.c
> @@ -295,11 +295,11 @@ static int test_init(struct kunit *test)
>  {
>         /* Most test cases want 2 distinct CPUs. */
>         if (num_online_cpus() < 2)
> -               return -EINVAL;
> +               kunit_skip(test, "not enough cpus");
>
>         /* Want the system to not use breakpoints elsewhere. */
>         if (hw_breakpoint_is_used())
> -               return -EBUSY;
> +               kunit_skip(test, "hw breakpoint already in use");
>
>         return 0;
>  }
> --
> 2.38.0.135.g90850a2211-goog
>
