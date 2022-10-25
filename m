Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFA60C4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiJYHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiJYHTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:19:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C012BE09
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:19:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-360a7ff46c3so111050707b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KA5AmQjfCAbtpdHkGDjwVts9T7CuDkkry+0zPgKF0lM=;
        b=ho9NvHEqLfDplAjRx3uXKJiU3DoSROQtKqQ8jRhFd0Ck3bp2UOpw8N9lYdxjatKuYv
         co/P5Nk6CLcK/+U9EK4lL66rumOXMbWTwndY1+zqeBCGNIjWtMZexvP1r8fzZLGhIbkU
         URsp7CuLP4czyMYdx7nshdoj5wFvyKDgBctnpRho0U/7PipKMJWU+msjlZHwvoClSw6O
         EvgkK+rfUfDrf/fynysJgKuFNt/SnjNJ/7x0wc8t7u3GvmcbGHIzDOGamTDQO4RMxpdU
         hh8nQ1fXv3LVNN0nD4AItp5Or8XNWSODER0ITRmk2Az9YLODBHDSLXNZo3mhj/LYKCQs
         eyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KA5AmQjfCAbtpdHkGDjwVts9T7CuDkkry+0zPgKF0lM=;
        b=MvJTt1GvyBc5fnPmee/coaae5ECv1CxyLCHGaon7dYwcNa4srNE93k44RQZ+lfkGSF
         1GrC7R/P0r/OZCZY4GJcA1rkmRIL6RhEACTqgjyDzcyv5jnDjsZxLHJSjoERXRQ1BMz9
         5gxMgSwEjgQscOOOmaSFTCDdPC8k4pLN5rilj4d+kRAkm2fa34evef3kap+neePdy9tJ
         2WbX5pUz3dHP65bjztPTV56gpSGxFyUXzMClJqr3KdBpKvlc77ZQ7GRGgxikWZz635Ei
         4l9D3ABJvwSExaHiL8zfuLQ0t904LOab3DgKoDlPSD78eLHA9Su7PVZ3ZeS74sAPIRMN
         BN0A==
X-Gm-Message-State: ACrzQf26em5UTwTXzrdPnN2rWEmcFC9BpdkZfDcc6IGIadvBV5x4VmYW
        6ZUCeI2r5yF3o7sBrRL2bUEmOBvZlU2J4g==
X-Google-Smtp-Source: AMsMyM6F8n0cf6ZN6EOjJAyPYC15rg0ifDjy+Yi3k90H65/ao6P/DBifaGO+L8XRdtun64inb2rPoXzES3FOCQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:6907:0:b0:34a:51ce:3b38 with SMTP id
 e7-20020a816907000000b0034a51ce3b38mr32787158ywc.151.1666682369948; Tue, 25
 Oct 2022 00:19:29 -0700 (PDT)
Date:   Tue, 25 Oct 2022 15:19:07 +0800
In-Reply-To: <20221025071907.1251820-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221025071907.1251820-1-davidgow@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025071907.1251820-3-davidgow@google.com>
Subject: [PATCH v2 3/3] mm: slub: test: Use the kunit_get_current_test() function
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
---

This is intended as an example use of the new function. Other users
(such as KASAN) will be updated separately, as there would otherwise be
conflicts.

Assuming there are no objections, we'll take this whole series via the
kselftest/kunit tree.

There was no v1 of this patch. v1 of the series can be found here:
https://lore.kernel.org/linux-kselftest/20221021072854.333010-1-davidgow@google.com/T/#u

---
 lib/slub_kunit.c | 1 +
 mm/slub.c        | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index 157527d7101b..15d10d250ef2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -39,6 +39,7 @@
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/sort.h>
 
 #include <linux/debugfs.h>
@@ -603,10 +604,10 @@ static bool slab_add_kunit_errors(void)
 {
 	struct kunit_resource *resource;
 
-	if (likely(!current->kunit_test))
+	if (likely(!kunit_get_current_test()))
 		return false;
 
-	resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
+	resource = kunit_find_named_resource(kunit_get_current_test(), "slab_errors");
 	if (!resource)
 		return false;
 
-- 
2.38.0.135.g90850a2211-goog

