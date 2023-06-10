Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607A672A723
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 02:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjFJAwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 20:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjFJAwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 20:52:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770501FDF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 17:52:16 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-3f9d3ad6fd5so15272021cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 17:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686358335; x=1688950335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3zbnVqAY087jc6zf5zGMbDLx4xURbX3P9p7/Tuiobs=;
        b=et/MOGBK43VQyQvYIB7WrQSc2K4IoXPVkm0UVfNUNy96HPcVZba6zLNT5urtOdGcBs
         P5jt2t2alfdalvP+MXwOg5CshT5nrkNH4RWZjKB7EdlIykKTWXG/akynbg/MxRcvIali
         cR6E0dGflT2FGLplmwq9iV7KLl5YiqcNNNeJqrHLkpgbofZ845oFq7BFKXlpp3VAZhyB
         0anqrIvE8hlk1cks2OHMBgZmMdPUQYGvDXR5uzuiNXd1k6vEEfIPVZWzwFBkXVAFjir+
         T7UvI1CHBZDi+GBLKQfZrLguMJw+Mcmyrl5IDqx5fM6Oa4UHrYFHXc04eE87IVZpjdve
         mT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358335; x=1688950335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3zbnVqAY087jc6zf5zGMbDLx4xURbX3P9p7/Tuiobs=;
        b=Dh17fVd4gWjgGvp+/8Lz71y7YyiasTcl48Tblqc26etjU2ecP6C1rdIHTjPAaZcpmC
         EaOaNxV0nJ+rnTLpAJDp1wdaDJcWuR2cUNVgbF271V1fLwdrxDotyppYn5tQru1/A57/
         8IzFmWtPuOUut9SkOiOdfwcEcLvfAnSFkP4TXQFP9WJCxxtXxN2ohw3RUBDobyPLJbUa
         qlwPPlJGCeXpZqJfQjWuJFda+2oV+IjmLRW8ZBvI5z82QITR8zsMbO0c182rUGv97Bjv
         5KRCGFDoy6pe2m4dNoc9DK67TzanoANlr1KONLL2MrapVyqXzKw9F2LIZ1bqeAVJswrj
         CT7Q==
X-Gm-Message-State: AC+VfDwhamSWDIAMgwfe0ZzUZTbDUzEEWlTHKzWHR/KQzUYIFltvoK2d
        6Ei3nog5Pk9bA0STjjrefGIbJ7kQMg==
X-Google-Smtp-Source: ACHHUZ6dnvhynsP+qbvMSlLVpDX2UXxgBwmpdFpa0jMBlxgs6rhuAeeLQxvZlPYg2eocE1JYwxLuOIy3Sg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:622a:1485:b0:3f7:469b:91a with SMTP id
 t5-20020a05622a148500b003f7469b091amr1337196qtx.6.1686358335447; Fri, 09 Jun
 2023 17:52:15 -0700 (PDT)
Date:   Sat, 10 Jun 2023 00:51:48 +0000
In-Reply-To: <20230610005149.1145665-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230610005149.1145665-6-rmoar@google.com>
Subject: [RFC v1 5/6] kunit: memcpy: Mark tests as slow using test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark slow memcpy KUnit tests using test attributes.

Tests marked as slow are as follows: memcpy_large_test, memmove_test,
memmove_large_test, and memmove_overlap_test.

These tests were the slowest of the memcpy tests and relatively slower to
most other KUnit tests. Most of these tests are already skipped when
CONFIG_MEMCPY_SLOW_KUNIT_TEST is not enabled.

These tests can now be filtered on using the KUnit test attribute filtering
feature. Example: --filter "speed>slow". This will run only the tests that
have speeds faster than slow. The slow attribute will also be outputted in
KTAP.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/memcpy_kunit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 887926f04731..440aee705ccc 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -551,10 +551,10 @@ static void strtomem_test(struct kunit *test)
 static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(memset_test),
 	KUNIT_CASE(memcpy_test),
-	KUNIT_CASE(memcpy_large_test),
-	KUNIT_CASE(memmove_test),
-	KUNIT_CASE(memmove_large_test),
-	KUNIT_CASE(memmove_overlap_test),
+	KUNIT_CASE_SLOW(memcpy_large_test),
+	KUNIT_CASE_SLOW(memmove_test),
+	KUNIT_CASE_SLOW(memmove_large_test),
+	KUNIT_CASE_SLOW(memmove_overlap_test),
 	KUNIT_CASE(strtomem_test),
 	{}
 };
-- 
2.41.0.162.gfafddb0af9-goog

