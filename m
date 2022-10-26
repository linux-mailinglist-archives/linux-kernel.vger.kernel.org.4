Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9205660E2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiJZOKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiJZOKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:10:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A24B8BB86
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:10:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h7-20020a252107000000b006cbb0e24adaso871965ybh.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oVCnLyxMsU2FaLl3D+PS+uuU9HLGod0PTLLsMzXQBPI=;
        b=MpZihCZI6V0d3vjHzoWFyZNUGKtaDmyQeeQjONz5yCsLwixNRtRYH8kVbw4IAj071I
         RtI5ylTTr0HmD103lHtW8GBjStpSSNk7D2IdMVsYQ4YozdkznqH/iHzaYWETb+Gb4s5A
         clqSzqiPC21fxU4gz1CciKwcJqKxXl6U66oOiuk6W/D6fsilKWyi7v/PxHeAQjRdQ0Yl
         4f194yEaUt9VdJlHvDFcDgIl2/GU9prcdlsKivsUZaYe/wLHWO3865s7Q2e79/zhVqKq
         42x/T7UNAP0Etik7BBFtJ8htlIYmUX4A55kRJXFgloxuG60P3M+tySMy5GQjuqin4mzn
         Y+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVCnLyxMsU2FaLl3D+PS+uuU9HLGod0PTLLsMzXQBPI=;
        b=mNMLiYCWGCH2wIA4CD4fn5KMzJKHB/OWx9XYrWyUf5+rvZMOVPm4k4KX+9bCqoC9IS
         +1nUzL0eQ5zPFfTrJnWqHDSPfYmZBYLcDvSxL3AMjiliMv+/9JVu6Xq2s3m80v2YckIM
         lxhtKawMmOj1toDeL03LXPMkZW8F0EGuXD7gK1jBlmLEWPB9f4Z35rz9A67XHo55/EdK
         9SXpiHw4dTl5YgZn6L7eSCjuL8A7CyRK3qpi3X+yIcjHDTLpiHOgIfJFC43oUv3c9gnk
         0EtD+nFtjRYO79PEmlzYDK044KW8JgnjvJP059ghbV2YvYrUHjgTB0edAAw6TUt/OCwn
         4Dwg==
X-Gm-Message-State: ACrzQf0zPQ6fZpbPsXqCijT7PCZcSMoWiMQGX5orLqphqOPrPbiW/ET1
        mnNQfMAR8WcjApxcrA718MUCrzxzIXeNbQ==
X-Google-Smtp-Source: AMsMyM5filAM/Pnh+qhZG7fTAorWRnmibQoVWzKGwKCoBdzpgJyDwpDWGy9Rm7JLRaju1rk5h1H22IP+svXzdg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:d857:0:b0:36f:c0f7:f0ec with SMTP id
 a84-20020a0dd857000000b0036fc0f7f0ecmr7838435ywe.82.1666793446446; Wed, 26
 Oct 2022 07:10:46 -0700 (PDT)
Date:   Wed, 26 Oct 2022 22:10:40 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221026141040.1609203-1-davidgow@google.com>
Subject: [PATCH] perf/hw_breakpoint: test: Skip the test if dependencies unmet
From:   David Gow <davidgow@google.com>
To:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     David Gow <davidgow@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the test currently fails on non-SMP systems, despite being
enabled by default. This means that running the test with:

 ./tools/testing/kunit/kunit.py run --arch x86_64 hw_breakpoint

results in every hw_breakpoint test failing with:

 # test_one_cpu: failed to initialize: -22
 not ok 1 - test_one_cpu

Instead, use kunit_skip(), which will mark the test as skipped, and give
a more comprehensible message:

 ok 1 - test_one_cpu # SKIP not enough cpus

This makes it more obvious that the test is not suited to the test
environment, and so wasn't run, rather than having run and failed.

Signed-off-by: David Gow <davidgow@google.com>
---
 kernel/events/hw_breakpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
index 5ced822df788..c57610f52bb4 100644
--- a/kernel/events/hw_breakpoint_test.c
+++ b/kernel/events/hw_breakpoint_test.c
@@ -295,11 +295,11 @@ static int test_init(struct kunit *test)
 {
 	/* Most test cases want 2 distinct CPUs. */
 	if (num_online_cpus() < 2)
-		return -EINVAL;
+		kunit_skip(test, "not enough cpus");
 
 	/* Want the system to not use breakpoints elsewhere. */
 	if (hw_breakpoint_is_used())
-		return -EBUSY;
+		kunit_skip(test, "hw breakpoint already in use");
 
 	return 0;
 }
-- 
2.38.0.135.g90850a2211-goog

