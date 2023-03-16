Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01E96BDBEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCPWr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCPWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:47:23 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B452E6FE0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:47:19 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id k12-20020a50c8cc000000b004accf30f6d3so4986367edh.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679006838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKOoaD6Ra29v+G2EYQelA/9U1zSfLrdqKtsejRDWzBc=;
        b=poi8gC8t1L69qGbvV3ks4+AtYYPqxKPowF0x6sr1KaWiMUjsX4yJbWzHEuFQwMGTCC
         a7vDGOPF9ZmWUYAEKqcXuGg3TH0I0ByS3it3T8iCMelyOoIoUHvnsD37tuy/eN/f8fgZ
         MOhWLEZtd3O1iIO5liKIZl+rOd00DGKRWzqCFt9cb4FP0WauXq3RGlanbszWSkS7PIsn
         3nqOmi6gnlGBIz02VEBhfzUlvZI0++Z2V19sIEMasWeBhM3fLZntPYAgfU5woXjA+hM0
         rBDgBHTT1bwY8Y8QQDo0Lj2HKJM539d9cPt6XQANsVd4KS01FOSCOJtESH1ZAHER6eb1
         CyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKOoaD6Ra29v+G2EYQelA/9U1zSfLrdqKtsejRDWzBc=;
        b=4hhEMepwyXTmGDl5BscUVEh3TZgKTlpAyo5DuVNRGrj5bL63T42C2Dk6sB2ldyH6yh
         SzATUwmqugyA3R3M8dvJg8WG9OTcUbaAaduWyJwvx4yOg7NZdFbXCs1wBXvCJwFKdb3f
         jO9ga46f3Eqsw5tlZubQEMSBTPLnUyWavee/HJEApIZd94U73CghvzK0ttQhViV1Q0Nk
         QpGlqQOUNuWRMsjI6seVuyBf0u/NaAhaEzx4yHvxg0uMx6gDrB6bNXiBak+JYWnksg2p
         sPmLp6clrkgbeUU52OnmLqZr7XC6YiW6AVI2/4FjYyVw5MhKZgkA4O8mx+IxqtapnVAG
         zLUw==
X-Gm-Message-State: AO0yUKU/izNPNttNH033GjxQsIfhvVt2SxMN8+nuoxPDGy/r+yNLw5jl
        uyZv6CPf2hUB4o3yRYQ/sFtnFwEVqQ==
X-Google-Smtp-Source: AK7set84vqzxuBmj5AgtGtjOmC56rRG8HcHnwMoT5tOHT4ppEJRc4UKAS6topCc1otARidzMsc5TwGO2Fg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:f359:6b95:96e:1317])
 (user=elver job=sendgmr) by 2002:a17:907:7284:b0:931:6f5b:d27d with SMTP id
 dt4-20020a170907728400b009316f5bd27dmr669131ejc.0.1679006838228; Thu, 16 Mar
 2023 15:47:18 -0700 (PDT)
Date:   Thu, 16 Mar 2023 23:47:05 +0100
In-Reply-To: <20230316224705.709984-1-elver@google.com>
Mime-Version: 1.0
References: <20230316224705.709984-1-elver@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316224705.709984-2-elver@google.com>
Subject: [PATCH 2/2] kcsan: avoid passing -g for test
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan reported that when building with GNU as and a version of clang
that defaults to DWARF5, the assembler will complain with:

  Error: non-constant .uleb128 is not supported

This is because `-g` defaults to the compiler debug info default. If the
assembler does not support some of the directives used, the above errors
occur. To fix, remove the explicit passing of `-g`.

All the test wants is that stack traces print valid function names, and
debug info is not required for that. (I currently cannot recall why I
added the explicit `-g`.)

Fixes: 1fe84fd4a402 ("kcsan: Add test suite")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index 8cf70f068d92..a45f3dfc8d14 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -16,6 +16,6 @@ obj-y := core.o debugfs.o report.o
 KCSAN_INSTRUMENT_BARRIERS_selftest.o := y
 obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
 
-CFLAGS_kcsan_test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
+CFLAGS_kcsan_test.o := $(CFLAGS_KCSAN) -fno-omit-frame-pointer
 CFLAGS_kcsan_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_KCSAN_KUNIT_TEST) += kcsan_test.o
-- 
2.40.0.rc1.284.g88254d51c5-goog

