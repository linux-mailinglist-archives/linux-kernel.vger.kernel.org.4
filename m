Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4394C630D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 09:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiKSINY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 03:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiKSINK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 03:13:10 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF327EBDC
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 00:13:09 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id h16-20020a170902f55000b001871b770a83so5419673plf.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 00:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZT09dwWD5fIaFMw5MiqU60lisIB0ejJz2T/HMt9VF4=;
        b=SHtU6YYNKAEepXdm5HbRFnuAyJFQdgO+1wedLhMpRsszD6ADUFWgk+3Dk2eyg23L4C
         zABv2VQZoq1xk7m9WvhdFXtEOjqkkRv7G5nWIow9W96ux/+b98E53LvWytC2S4a6h04r
         zB4vTdApfRXZH7pB+ZryafnleYvVDTkZGvhF74jyYCJAm2CuHpmFMED7k0JsoYO/yiTs
         ad0L59iP04zGlyxAB7bv/LMHHuEgs7zBVIQDhZWBX89Lj4G42i/ICeB0VmRucNP1g2An
         1t2Tfm6nmhgKRrF4oWPqvjeR2y4x9QOOTpjql3bpcBMpiyRGomB6M2x+txB9lOy5kc1+
         MRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZT09dwWD5fIaFMw5MiqU60lisIB0ejJz2T/HMt9VF4=;
        b=hR3FCuvDHaZ/1Nmw2QUsr1MKhlGQTGiYM+gFtKaiIqq0cwLeOQgGj6q1s+uElxsj9J
         /yekw3gccQNGoyPUhuBdiNKikcIOhZPh2sfXCM5wQNqZSPoWtPFpOhsoFTujIej6xTK7
         wtqgNsJxmV50ANLNq/DdDzMJ8wC907rubcVB8KvPNI5RNUergX4nxtAWlQMyDYCluO6I
         fFdqVp8Ht7++yTc4Ru/LgFge4g3VnJi1dZqIV3Hk8q17mFAmGagz1e+p/YUwMaRmuowB
         kXOvjsckdWmUr4orbrVt7Tl1Z9yKezsOcClUNWOs3y+2QOQSD9xQxHrZwpfYG5aneW7c
         Xwlw==
X-Gm-Message-State: ANoB5pmAWcJ64MXw5Zp++5n5FU74o0mBCe5ahuW95Jw8Xas1qVSgQX9p
        cqef0LPf5NQ5QV8CcQFv52tcxIV9eS7+zg==
X-Google-Smtp-Source: AA0mqf6d0TFeFJe2lky/Uxlh+yxajwOJpZKYlUcAsY4hA8k+GJ+0dKXuSI5wzfJrQ5yVpEF7+GNMYaRxd/NUbA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:aa7:9f9c:0:b0:53e:81ab:9419 with SMTP id
 z28-20020aa79f9c000000b0053e81ab9419mr11494527pfr.15.1668845588834; Sat, 19
 Nov 2022 00:13:08 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:12:52 +0800
In-Reply-To: <20221119081252.3864249-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221119081252.3864249-3-davidgow@google.com>
Subject: [PATCH v3 3/3] mm: slub: test: Use the kunit_get_current_test() function
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, Oliver Glitta <glittao@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

Use the newly-added function kunit_get_current_test() instead of
accessing current->kunit_test directly. This function uses a static key
to return more quickly when KUnit is enabled, but no tests are actively
running. There should therefore be a negligible performance impact to
enabling the slub KUnit tests.

Other than the performance improvement, this should be a no-op.

Cc: Oliver Glitta <glittao@gmail.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Gow <davidgow@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---

This is intended as an example use of the new function. Other users
(such as KASAN) will be updated separately, as there would otherwise be
conflicts.

We'll take this whole series via the kselftest/kunit tree.

Changes since v2:
https://lore.kernel.org/all/20221025071907.1251820-3-davidgow@google.com/
- Get rid of a redundant 'likely' (Thanks Vlastimil Babka)
- Use current->kunit_test directly when we already know a test is
  running. (Thanks Vlastimil Babka)
- Add Vlastimil's Acked-by.

There was no v1 of this patch. v1 of the series can be found here:
https://lore.kernel.org/linux-kselftest/20221021072854.333010-1-davidgow@google.com/T/#u

Cheers,
-- David

---
 lib/slub_kunit.c | 1 +
 mm/slub.c        | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 7a0564d7cb7a..8fd19c8301ad 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/module.h>
diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..1887996cb703 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -39,6 +39,7 @@
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/sort.h>
 
 #include <linux/debugfs.h>
@@ -603,7 +604,7 @@ static bool slab_add_kunit_errors(void)
 {
 	struct kunit_resource *resource;
 
-	if (likely(!current->kunit_test))
+	if (!kunit_get_current_test())
 		return false;
 
 	resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
-- 
2.38.1.584.g0f3c55d4c2-goog

