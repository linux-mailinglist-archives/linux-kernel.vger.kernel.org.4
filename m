Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9171218D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbjEZHyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbjEZHyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:54:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8854AB6
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:54:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacfa4eefd3so709391276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685087641; x=1687679641;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9bgtUJTrUPIWbcjE2YrRDnp+lMcC0D7ZWyXbYBrXuSE=;
        b=h1pP42iyvlOB7PXc1d4O9+YDxu94Br5uZo6P1cNH3ds5S4dVjkvqv666GHsU2XnWNc
         BKU6U3EKC39ri14gHTtxayPzPH7zeDs1FSRNTXw0qG8Y95K0jYVhODrw16EXjaMnOXN2
         8VDkWg0ZCzGJI4BA5kx8VBZimihQKyKEEwBvBMoODoHlICnpGzPL2WYtYEN5qvpjuCMo
         39IXxvMNHQYov2AEv+Yor1fr68hO1jhtMWIrtKAsJHOKCm7QWjw5LHMEAEjZs2V915om
         cE77hXJmthrXbCEmNzrxHXvH1W9XGqNrrM9fCm25iGWls/sYKEuS2X2OQlGpJo5C0ct6
         VfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685087641; x=1687679641;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bgtUJTrUPIWbcjE2YrRDnp+lMcC0D7ZWyXbYBrXuSE=;
        b=TCvuEP50UsRjVEQlVWStSb37iH199bbdzKQU14H8uBR4eYaGoKIByKAHsD8kdwxrO0
         bD0Cx9853U54dJlbIFXTgsQyZexM4LbiPKiAFp2t8qc5o5WjametspJXi3gaTmTMCbCc
         KtAGvjv+pUphmQ18HNqbQYXvMQl8uy1H6Q0gG4k9XdcuBRpr2kHwZQB1nfeCZpN9NECw
         +WeD/ktXEPZaSb6+nMYWPY5jNL2ByO2ZTCBg7BRPBFcIYgTZH+ZKD/bts297JQVqYSsK
         vskrmbROETGRQqFeF3yWascpX4KIsMAAP6JE6Qr6G6hECAbPe1iXFA6cX0sBKyYPSFbk
         J3iQ==
X-Gm-Message-State: AC+VfDxful2qUHTYfVKTVEjOiZq/568eRFKWtNFs09hv5MXUUOwRpdeY
        e1la5bmvyS+0D9aN/37F/w/1Aet0KLfWHw==
X-Google-Smtp-Source: ACHHUZ5J/dcsqYhlQaPA0ex1GxAxZze4W6DSSDGH0LeBuat3DIA1OjJPZ9PuzQX+zpk79CLo6+n3+iFEP7bVPg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:3d2:0:b0:bac:a1d4:dbf6 with SMTP id
 201-20020a2503d2000000b00baca1d4dbf6mr492750ybd.6.1685087641289; Fri, 26 May
 2023 00:54:01 -0700 (PDT)
Date:   Fri, 26 May 2023 15:53:54 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526075355.586335-1-davidgow@google.com>
Subject: [RFC PATCH] kunit: Move kunit_abort() call out of kunit_do_failed_assertion()
From:   David Gow <davidgow@google.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit aborts the current thread when an assertion fails. Currently, this
is done conditionally as part of the kunit_do_failed_assertion()
function, but this hides the kunit_abort() call from the compiler
(particularly if it's in another module). This, in turn, can lead to
both suboptimal code generation (the compiler can't know if
kunit_do_failed_assertion() will return), and to static analysis tools
like smatch giving false positives.

Moving the kunit_abort() call into the macro should give the compiler
and tools a better chance at understanding what's going on. Doing so
requires exporting kunit_abort(), though it's recommended to continue to
use assertions in lieu of aborting directly.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 4 ++++
 lib/kunit/test.c     | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 2f23d6efa505..6a35e3e2a1e5 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -481,6 +481,8 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
  */
 #define KUNIT_SUCCEED(test) do {} while (0)
 
+void __noreturn kunit_abort(struct kunit *test);
+
 void kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
@@ -498,6 +500,8 @@ void kunit_do_failed_assertion(struct kunit *test,
 				  assert_format,			       \
 				  fmt,					       \
 				  ##__VA_ARGS__);			       \
+	if (assert_type == KUNIT_ASSERTION)				       \
+		kunit_abort(test);					       \
 } while (0)
 
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d3fb93a23ccc..3b350e50cab9 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -310,7 +310,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 	string_stream_destroy(stream);
 }
 
-static void __noreturn kunit_abort(struct kunit *test)
+void __noreturn kunit_abort(struct kunit *test)
 {
 	kunit_try_catch_throw(&test->try_catch); /* Does not return. */
 
@@ -340,9 +340,6 @@ void kunit_do_failed_assertion(struct kunit *test,
 	kunit_fail(test, loc, type, assert, assert_format, &message);
 
 	va_end(args);
-
-	if (type == KUNIT_ASSERTION)
-		kunit_abort(test);
 }
 EXPORT_SYMBOL_GPL(kunit_do_failed_assertion);
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

