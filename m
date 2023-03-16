Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50876BD45A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCPPvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCPPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:51:20 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8D1E5F1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:51:16 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id y24-20020aa7ccd8000000b004be3955a42eso3673693edt.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678981874;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ExLMwJzNgwWRHjnTjtALJSPVKx9BbSWtrYmWXQLM/Bk=;
        b=BaozqFKkD3sCcThM3kJ0CJeU1oKVvG2IZTEZYRhcVPVNMkZ1lFzWF9as+MMZ8hsld7
         tZ3GmrajONdoZqutkUpFP17bnuQ/1GSMT+4xd5Z0upJdJchDmE5BiRfjKY7kKS4mrZem
         NJsUJendQeheVIikqG7slo7ctosxTk0J/IANNs9/xvgYw2BbqggYZTXPLMQDq7WxBvS4
         NdWvxaHOdqZ5eUoP9yCwMRgeFncikGyhyqzUJ1IoIlLYH5H2hJCWGH+xjlVSQnVjDARK
         xstaHNw72Eu5bUEcZiJfIVBSYiXVOPFhGNIZ5RMPCG2zaog+4lxteu0Hqpd31h/TmoOx
         nZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678981874;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExLMwJzNgwWRHjnTjtALJSPVKx9BbSWtrYmWXQLM/Bk=;
        b=TrjVvs3k3lW6653gQ9qmHnE1ciyBSg6HvZrWrjOkOG5BJWp+nLen9Doy6rTq7kaA3s
         NF4dVwM7ZWfudSaEh3rv9EtlyMRtROaTKQugo+lq48DAXt5HTv5/lrQOmMB+CSIs4DrT
         X76fG4Uq+Dcctl4vEF3SmsXTwdgksu0Bn8nwqWj3aCNTsMSwYvsjJpAS8sYb13PxBFfj
         vSre13aT+rPSmJCVdD1PIDf8KhckEHto3SW1m0aXsF43uvALHbvardyfUz81gng9ae9k
         eWf0RJ587Zb/Gsu2ZO9xYmQ7f5GjgDZApz0g8NOG7Z9bljtLdpJSwRVIEiXMVtJikzJV
         rEYA==
X-Gm-Message-State: AO0yUKWmehzJeUNxWKErFqQAJnSZNmXeSi91XIOMc1IpxTICZyYbloF5
        fJciD4kKoo1Bqkdk8Yng9/ytEKnRvw==
X-Google-Smtp-Source: AK7set/LJ2SDmH3RPj1qgIEPYl3gP+fJLKcu8qRdtwUXHzgL+9elI1ulbLS4ORh4eNFQaUU+1RVlcmM3pA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:f359:6b95:96e:1317])
 (user=elver job=sendgmr) by 2002:a50:ce1a:0:b0:4bb:e549:a2ad with SMTP id
 y26-20020a50ce1a000000b004bbe549a2admr43911edi.4.1678981874737; Thu, 16 Mar
 2023 08:51:14 -0700 (PDT)
Date:   Thu, 16 Mar 2023 16:51:04 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316155104.594662-1-elver@google.com>
Subject: [PATCH] kfence, kcsan: avoid passing -g for tests
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
that defaults to DWARF5:

  $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
			LLVM=1 LLVM_IAS=0 O=build \
			mrproper allmodconfig mm/kfence/kfence_test.o
  /tmp/kfence_test-08a0a0.s: Assembler messages:
  /tmp/kfence_test-08a0a0.s:14627: Error: non-constant .uleb128 is not supported
  /tmp/kfence_test-08a0a0.s:14628: Error: non-constant .uleb128 is not supported
  /tmp/kfence_test-08a0a0.s:14632: Error: non-constant .uleb128 is not supported
  /tmp/kfence_test-08a0a0.s:14633: Error: non-constant .uleb128 is not supported
  /tmp/kfence_test-08a0a0.s:14639: Error: non-constant .uleb128 is not supported
  ...

This is because `-g` defaults to the compiler debug info default. If the
assembler does not support some of the directives used, the above errors
occur. To fix, remove the explicit passing of `-g`.

All these tests want is that stack traces print valid function names,
and debug info is not required for that. I currently cannot recall why I
added the explicit `-g`.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/Makefile | 2 +-
 mm/kfence/Makefile    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/mm/kfence/Makefile b/mm/kfence/Makefile
index 0bb95728a784..2de2a58d11a1 100644
--- a/mm/kfence/Makefile
+++ b/mm/kfence/Makefile
@@ -2,5 +2,5 @@
 
 obj-y := core.o report.o
 
-CFLAGS_kfence_test.o := -g -fno-omit-frame-pointer -fno-optimize-sibling-calls
+CFLAGS_kfence_test.o := -fno-omit-frame-pointer -fno-optimize-sibling-calls
 obj-$(CONFIG_KFENCE_KUNIT_TEST) += kfence_test.o
-- 
2.40.0.rc1.284.g88254d51c5-goog

