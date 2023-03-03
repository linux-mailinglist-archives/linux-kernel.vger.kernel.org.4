Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540EF6A9933
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCCOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjCCOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:14:51 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8DF16AF2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:14:50 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id ev6-20020a056402540600b004bc2358ac04so4178159edb.21
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677852889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rwOqGFiMpxVm/Yf2TCVg/tAOnz+fk0oI0q2ct+QMnRo=;
        b=XZGeQDWe4Pd5npHcAau0EzkvzHXKKNrGOH18yXzhEAmcYUZLbneOiYfhArq3rRCAZy
         GBbL3GsmlGQfzQ5SfxzKMgTFZEUEozH+Or/E60HwnODlceqj0C3HRmJbt7oN2LKCfPJB
         WhsQRvh03bRnXHE23IhTee0WmZOV7wI6BD1JQHMUVMgPFTpIWoulVpH3dQbdsiw8/T9J
         5TcP4NGjzxEa/ZJAP3crz6HfyNfIP1dIzC/ax7dquihg4zVwhhLGbI8jCGiV7Fd5VKtM
         dPhh1sc5W7VFazYm2ehiDohwqAS/RO0qdmBIFJm84GXSSdH9KLss/voUPFZtPSSBR+Ew
         t8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwOqGFiMpxVm/Yf2TCVg/tAOnz+fk0oI0q2ct+QMnRo=;
        b=buRr3hcwgiUSUfMdDhf1Uy4SlIHvVw/+3ofDDz41XwDhkom2w8ssjurCxtJhJ0XPkX
         v4iYVmYVMudD6m7Oelc+foVDyqK19OgLm64LbilKj55ejKVHrXGdKGQ6sOeojNKRScR1
         hgWMOcdVoVY+8kEzSadXiAFAZijej/rFqJtXAnF/rcGvGNSYehFQCCDxekt00ZTkeWH0
         vS7VV4tdPuBop1drr9XPt0efTw1vpzvodsMutaIL5ecHgtf83J2dIYCLm4B7kGvNmJac
         GEVfNcbKRqxzKPQIYvNP8JngbBnghQCCp7bDeMipvkInvADNCk6RGBZBsncIPl7XW0eM
         JBew==
X-Gm-Message-State: AO0yUKXaUQg/I6DOPGn33xCHxfYwjiA3bdToUDVc/uVLYlxMrViGLSNO
        Z5YMyKVnmGtYok08v3eDPn5Tz0Ce+LU=
X-Google-Smtp-Source: AK7set9r+yMP2FHj07wsqj7PjZE1ezap7iMthzxqlJBoACzjCEvFQP5Ey8Gv3jQTqbJVfvH5zLMGOYTOGuc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:f11e:2fac:5069:a04d])
 (user=glider job=sendgmr) by 2002:a50:cd81:0:b0:4af:6e08:30c with SMTP id
 p1-20020a50cd81000000b004af6e08030cmr962152edi.4.1677852889146; Fri, 03 Mar
 2023 06:14:49 -0800 (PST)
Date:   Fri,  3 Mar 2023 15:14:33 +0100
In-Reply-To: <20230303141433.3422671-1-glider@google.com>
Mime-Version: 1.0
References: <20230303141433.3422671-1-glider@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230303141433.3422671-4-glider@google.com>
Subject: [PATCH 4/4] kmsan: add memsetXX tests
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com
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

Add tests ensuring that memset16()/memset32()/memset64() are
instrumented by KMSAN and correctly initialize the memory.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 - drop a redundant parameter of DEFINE_TEST_MEMSETXX()
---
 mm/kmsan/kmsan_test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index aeddfdd4f679f..7095d3fbb23ac 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -504,6 +504,25 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/* Generate test cases for memset16(), memset32(), memset64(). */
+#define DEFINE_TEST_MEMSETXX(size)                                          \
+	static void test_memset##size(struct kunit *test)                   \
+	{                                                                   \
+		EXPECTATION_NO_REPORT(expect);                              \
+		volatile uint##size##_t uninit;                             \
+                                                                            \
+		kunit_info(test,                                            \
+			   "memset" #size "() should initialize memory\n"); \
+		DO_NOT_OPTIMIZE(uninit);                                    \
+		memset##size((uint##size##_t *)&uninit, 0, 1);              \
+		kmsan_check_memory((void *)&uninit, sizeof(uninit));        \
+		KUNIT_EXPECT_TRUE(test, report_matches(&expect));           \
+	}
+
+DEFINE_TEST_MEMSETXX(16)
+DEFINE_TEST_MEMSETXX(32)
+DEFINE_TEST_MEMSETXX(64)
+
 static noinline void fibonacci(int *array, int size, int start)
 {
 	if (start < 2 || (start == size))
@@ -550,6 +569,9 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memcpy_aligned_to_aligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
+	KUNIT_CASE(test_memset16),
+	KUNIT_CASE(test_memset32),
+	KUNIT_CASE(test_memset64),
 	KUNIT_CASE(test_long_origin_chain),
 	{},
 };
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

