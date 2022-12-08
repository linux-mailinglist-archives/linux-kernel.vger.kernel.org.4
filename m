Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB33646902
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLHGSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLHGSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:18:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED719B7B7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 22:18:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f11-20020a5b01cb000000b0070374b66537so459666ybp.14
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 22:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aq+igaQActZoeLPo+P37AxsZ6LyFtCj6997AnfPKCGo=;
        b=b8yxAQyQnKnqP9TK8IjQI4SpJ0M6l/etWSjXnA8uTuRIhvddvbLg+vxni3QMzIUASB
         oh5/OaSrCGAy4+HLH8GNZC7vTUpcKKpZ2iBJ36KOeF/+Te4vy7/MAVYIzfJY0vREC7ap
         BJ5LcGwYfoSMCU7MMVr/TgWPIsQa5zTY5FqNqaIjV5sJxA/dWnuR+rySWt6RL3gP0YPE
         NxON0CCPT0e/OHA5LohxVfMYzcot8724NhwtqAe5iAaU8UeI9jecdEZ2lA2rrKSm+DIh
         pooBobPcxO2R+OoIEVDVqb60RVIOP9ZlHRQ04ZBbKWecQ8kdrKab6NIG9J6Pnok0lD2h
         6HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq+igaQActZoeLPo+P37AxsZ6LyFtCj6997AnfPKCGo=;
        b=wdBcPlbk6gP2YwLJfcmBXz1/tZQBHD8jqFw//NRWa32AkgEpSofagEpa3oawCCZb1m
         cItpd4v7Vi93opltfalK1fgV8BZSuV8ZM07AHXbvx6146Fmenrk7zHo0IYK7O6SpIBUX
         856cdrQw1kJhdsi5fQG1wpla/uKJqamWSpCn99twGzGgHT7rXj8n5rP0ebJYNKuajeWb
         uuVWiMjbpwO3yZBUBxoUqkG+QgqaLP8l9RopjP5BWhRtCK/QFw2ASqjiCSTlvWBFbuK+
         hIe1PRPqlevHEXRas7PB3uJP34mTShIGP21I1TVa8ZF2ekAgW+rd530hwlaRbQCxqaR1
         aw2Q==
X-Gm-Message-State: ANoB5pmk7xEIOHmEePwLH3qW4MV/eJs/HYAVJbRGeMUIQ3Q8enpdvRwo
        /GpmK0Z/QewE8QV90fMHOwi93RTpdatHvg==
X-Google-Smtp-Source: AA0mqf4yDR9D5Q2JsEiI6RkOFIuh4GnpzFIuS8zAeq7GKq0p65tzzrure46cqvsCAxEeiPPoiMJH207Kl4uCIQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:d949:0:b0:3e8:5c02:56d6 with SMTP id
 b70-20020a0dd949000000b003e85c0256d6mr19000406ywe.413.1670480327874; Wed, 07
 Dec 2022 22:18:47 -0800 (PST)
Date:   Thu,  8 Dec 2022 14:18:39 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221208061841.2186447-1-davidgow@google.com>
Subject: [PATCH 0/2] kunit: Function Redirection ("static stub") support
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing tests, it'd often be very useful to be able to intercept
calls to a function in the code being tested and replace it with a
test-specific stub. This has always been an obviously missing piece of
KUnit, and the solutions always involve some tradeoffs with cleanliness,
performance, or impact on non-test code. See the folowing document for
some of the challenges:
https://kunit.dev/mocking.html

This series introduces a new "static_stub" feature add support for this
sort of redirection to KUnit tests.

Any function which might want to be intercepted adds a
call to a macro which checks if a test has redirected calls to it, and
calls the corresponding replacement.

Note that at alternate implementation (based on ftrace) was also
proposed in an earlier RFC:
https://lore.kernel.org/linux-kselftest/20220910212804.670622-3-davidgow@google.com/

This series only implements "static" stubbing, as it is more compatible
across different architectures, and more flexible w/r/t inlined code,
but we don't rule out offering the ftrace-based solution as well if the
demand is there in the future.

This feature was presented at LPC 2022, see:
- https://lpc.events/event/16/contributions/1308/
- https://www.youtube.com/watch?v=0Nm06EdXWsE

The KUnit 'example' test suite now includes an example of static stubs
being used, and the new 'Function Redirection' API documentation
provides a step-by-step walkthrough for using the new feature.

In addition, an (in-progress) test for the atkbd driver, which provides
an example of static stubs being used, can be found here:
https://kunit-review.googlesource.com/c/linux/+/5631

Cheers,
-- David

---
David Gow (1):
  kunit: Expose 'static stub' API to redirect functions

Sadiya Kazi (1):
  Documentation: Add Function Redirection API docs

 .../kunit/api/functionredirection.rst         | 162 ++++++++++++++++++
 Documentation/dev-tools/kunit/api/index.rst   |  13 +-
 include/kunit/static_stub.h                   | 117 +++++++++++++
 lib/kunit/Makefile                            |   1 +
 lib/kunit/kunit-example-test.c                |  38 ++++
 lib/kunit/static_stub.c                       | 123 +++++++++++++
 6 files changed, 451 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/api/functionredirection.rst
 create mode 100644 include/kunit/static_stub.h
 create mode 100644 lib/kunit/static_stub.c

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

