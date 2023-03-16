Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45B6BDBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCPWrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCPWrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:47:18 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE1E6D8C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:47:16 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so4905951edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679006835;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mIMhApGgO8tdqBq7ln4mUoYAtVQfctnuG47znmR3Hdk=;
        b=dG1Fj3EX4sgJuQwgp2UhU7BloxdGqfpKCXNsSUwcImn0Gtitsw4nucQeqec/zudYiq
         79+GE640VKDtERe9UcudVnI3IJwjavox42UEIyWrax04lelN9sgHSInSVI7K9aXmCBdX
         3bKG/P5pP+f95mS62WQEBleu1VD+z6Kc4FO3l8Au9P2St2CD7Y3WMAUG8ktwBnw1rHT9
         s47xHUyBGN4xrFp7/wYWe3AHWZPTgCwyHNiYQrSSD6TBpgb67ltgdkb09LDw/PNSJBNO
         EJx4qe+cc5vCmCJcoRSeeT5kns/WNboi6XPBBAxi2836S2HBaG/P9Uwa9R6xiUbh5qNl
         Eyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006835;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIMhApGgO8tdqBq7ln4mUoYAtVQfctnuG47znmR3Hdk=;
        b=eWRaTzNkHs/9a6C9BHqrqQ/t+dYA0A7MBRBlXkh3INh9/pKiyFID8dbYnC0K/P+n8a
         NM6bxDBNVQGc3SyQu9rAGegbfSHI7CealtbfFTVAhplVkU7oSrIJjADz1mO9aFhY3Sgp
         9HBbrLMQ8rpOXHxHNxyG+TlKmdaW1TE1uFiBr3ed/GVtgQrMYudrMkfn8y7I1zSnRvvL
         ORoMjWsQU/GUU9pU2fdV1XHfC2LHPBrE/27BONdUvS40rX+FNuwQEh/wCp1u48IriDv5
         70FpOHjq5GI5ZFyUmqAfkgN8ggLYuEHxaZWapVq9lwc4Py6HZgv4fz4lSum2l2XWgHyi
         qAEg==
X-Gm-Message-State: AO0yUKU1pGHl0R5yxQKUbRoZfVBSqADiUiZta7hMGKv92/3ZXC9P26Nu
        J3iPVILKJN8H+DF6g0IJ6UQAyuo+KQ==
X-Google-Smtp-Source: AK7set//hzRaf3817JCLhSDQAGvQzyZ1e2uHq6BrFdQ9Xuirr5ufy7yRaiJimwcfj+RKh9yiWLlx9PIgpQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:f359:6b95:96e:1317])
 (user=elver job=sendgmr) by 2002:a17:907:8a01:b0:92f:b8f1:7239 with SMTP id
 sc1-20020a1709078a0100b0092fb8f17239mr3202420ejc.4.1679006835449; Thu, 16 Mar
 2023 15:47:15 -0700 (PDT)
Date:   Thu, 16 Mar 2023 23:47:04 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316224705.709984-1-elver@google.com>
Subject: [PATCH 1/2] kfence: avoid passing -g for test
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

All the test wants is that stack traces print valid function names, and
debug info is not required for that. (I currently cannot recall why I
added the explicit `-g`.)

Fixes: bc8fbc5f305a ("kfence: add test suite")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

