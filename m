Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335BA60711B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJUHba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJUHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:31:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EDD2475EC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:31:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i16-20020a056902069000b006c3ef07d22eso2365968ybt.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYRI4YM/O3HPavk8M56cMbkj+MwZGK3MSk39K+2fBzs=;
        b=jbSx66ETI+A32fKzKRjx5OquaUQL8nMNegJ5xcIQN/qDilciMPGigwaH0+Zc07EiKX
         vSt4omPWR1sWbZsL2+Jbm91k4cOhgnEndNJ4H69cflKemIXd6lPrpY/Pjpl1Mxu4Wt3n
         X4PBCIK2jEgZJ1gOlO6NCeZsnY0RlvaZeykZbwYvhpJYFWPM0IhI/nWiMDD+Vl2X0cay
         56gP5+65jhmTYTzgC7jF0WhkFSwDzXQQp2gPZIHL1iFYBBPGGr2yPllgTZEU63g98MIf
         G5fkmIXxWhW4nf+dadIq1oRCMUQKZGlFkRE6gpPhJkomEXnY+zNpM/fuof6ZeqpZj90M
         hj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYRI4YM/O3HPavk8M56cMbkj+MwZGK3MSk39K+2fBzs=;
        b=W/4lVAZAiLtjjqTXeZsn3SuGnPwNmkHGH2hdu55zlbxZ5RAsA+7D5lg20hXkHlskfl
         OehMKvS7lNPZ8q0RmhxgMjYRwqqi9Qia0LkebQwB0xRlkQF61Zxu2zeJ37IaCXZKYJDZ
         EnLoaS+X2zSjbtbBRanh831833JpaMM8YzqfsqW3C7E+qNLOej/RFZf6+7On+ELO2HIh
         d+uVJ0gel9OTtf6zZGyj6fSTeOiNcicHG9lQBpIgK+BdmzO0kNBNapCwPuedB1hlmNP4
         zYXkr7DfemXNKnNs4aD9fjiv3TDftCXb4vR6Wp7imsoO/rGYzgo3C5DY6dcVRbGuuBlk
         mYJA==
X-Gm-Message-State: ACrzQf1wcbTdUXodZiC+Zns/HYu3BMAmM9TuinLEWX5+QmQDhuWi2KTJ
        ruhtOoyexofm+Pgl6QxYNv4jlcyTux0d1w==
X-Google-Smtp-Source: AMsMyM76iIWNmGWl5azzgQ/kUxazHQFVQEwuFrEmhRfU3we+Qyko7o5kcAkKNyco/dfhd8d2fOk1nyM9rBERtg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:34b:b0:691:4b82:7624 with SMTP
 id e11-20020a056902034b00b006914b827624mr16182648ybs.614.1666337470120; Fri,
 21 Oct 2022 00:31:10 -0700 (PDT)
Date:   Fri, 21 Oct 2022 15:28:54 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021072854.333010-1-davidgow@google.com>
Subject: [PATCH 1/2] kunit: Provide a static key to check if KUnit is actively
 running tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
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

KUnit does a few expensive things when enabled. This hasn't been a
problem because KUnit was only enabled on test kernels, but with a few
people enabling (but not _using_) KUnit on production systems, we need a
runtime way of handling this.

Provide a 'kunit_running' static key (defaulting to false), which allows
us to hide any KUnit code behind a static branch. This should reduce the
performance impact (on other code) of having KUnit enabled to a single
NOP when no tests are running.

Note that, while it looks unintuitive, tests always run entirely within
__kunit_test_suites_init(), so it's safe to decrement the static key at
the end of this function, rather than in __kunit_test_suites_exit(),
which is only there to clean up results in debugfs.

Signed-off-by: David Gow <davidgow@google.com>
---

This should be a no-op (other than a possible performance improvement)
functionality-wise, and lays the groundwork for a more optimised static
stub implementation.

---
 include/kunit/test.h | 4 ++++
 lib/kunit/test.c     | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b1ab6b32216d..450a778a039e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -16,6 +16,7 @@
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/jump_label.h>
 #include <linux/kconfig.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -27,6 +28,9 @@
 
 #include <asm/rwonce.h>
 
+/* Static key: true if any KUnit tests are currently running */
+extern struct static_key_false kunit_running;
+
 struct kunit;
 
 /* Size of log associated with test. */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 90640a43cf62..314717b63080 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -20,6 +20,8 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+DEFINE_STATIC_KEY_FALSE(kunit_running);
+
 #if IS_BUILTIN(CONFIG_KUNIT)
 /*
  * Fail the current test and print an error message to the log.
@@ -612,10 +614,14 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 		return 0;
 	}
 
+	static_branch_inc(&kunit_running);
+
 	for (i = 0; i < num_suites; i++) {
 		kunit_init_suite(suites[i]);
 		kunit_run_tests(suites[i]);
 	}
+
+	static_branch_dec(&kunit_running);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
-- 
2.38.0.135.g90850a2211-goog

