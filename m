Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0B6026DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJRI2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiJRI14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:27:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494849C221
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:27:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h2so5786887plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JQMxkXv8mQ1Cge7g4D4yz8kxz9e6M1Q1dbsKZa3FJ8=;
        b=DmO0/d1FaXa15fY0eqVEvCoCZc0mb8i0//GzZGUK2c6JyZNioWLkj2m70HawoalhXa
         c4pZZOpbrOmQV0ftJ1jqiOZg8nS213MMPtPqsHND+TMd8szVH/PArflOMD460MCKNYpk
         FPPkPefJZ/o7KipOfsBRTR0WiG+ZiQn8VEBEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JQMxkXv8mQ1Cge7g4D4yz8kxz9e6M1Q1dbsKZa3FJ8=;
        b=jqZ7haaz1QkoKJMp31Gkm23EPxL/jjXGs+5qjmccYusYPCu70XE8JmaFEP1h1fueip
         fxCsMjs/Fwz1BzGzlIWdGY75ecbUpmjEsemBud2Q/kO0xUhy243uPp32dzp46U7VfLvC
         KxP+M7NYwOfuq++aCLPKbtp5CcE8P26/7IQwVKqNYR1b6MHO4n7xfRjFum2FEaGfJgRZ
         j8LNn+unvGF8bVDG1Q+Jdx5qNFcbtJA586HA4x63CGxbYAiI/6YqNZasTsi7XCUzftMM
         GzRnf1E+qouIlcgRho9AmRrI52Lz06lgzMyTl+xJm4ax4MN7fUrjeyTPRnXh6VRr7P15
         sfEg==
X-Gm-Message-State: ACrzQf3WpjWRPCsqCce0y0lSTEfR13EXts/OQmGbvchNNDFnjMJOjkfm
        YKGaYqtGNqwubC7xO74Dh6Qv+g==
X-Google-Smtp-Source: AMsMyM6pCqqmb1I5bzi98XAQmVznaqmBVGuzMs6GMGfK8QP3gDGY25J1ZLhOEIwi5cAJtRmx4HQptQ==
X-Received: by 2002:a17:90b:1c0a:b0:20a:7393:d8e9 with SMTP id oc10-20020a17090b1c0a00b0020a7393d8e9mr36753419pjb.188.1666081665083;
        Tue, 18 Oct 2022 01:27:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b001755e4278a6sm8101733plg.261.2022.10.18.01.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:27:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/fortify: Validate __alloc_size attribute results
Date:   Tue, 18 Oct 2022 01:27:41 -0700
Message-Id: <20221018082559.never.406-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4584; h=from:subject:message-id; bh=cqnD43HvNxjTrJeCb4jyi/kcbzUkumxTTwgCBYcw0BY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmN98gW0SnFSk2qn1CuOo+7cEzOifQl8lBoZx6SR rPQahgaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05jfQAKCRCJcvTf3G3AJv8eEA CUjOW1IXRuFdP9d/7g+yZv73vDBK8Q+ZnK6xQs5kvnSISGrZv+N1pzNmGreolYErvoHrjAmWfW9pw+ hElJDfq4Tq+7ZgdhErGmAmuZWHDvs23c4K+MX1AdAGKYuaUpgcMDAiIM/+O3WLYWrAP3RkSB9hiR71 yFBo/0UYslUl3XHgnDnlpU/vuky5j9yicO5wG1aAZzUgKh/2p2KVghJonf1bDDewoP/I+uzXVd0o/H sBYQMumJRJmtN21FHuXXAHw44FzbILRrDuoXAdCXFsoYYE39IbYcZ2splT5EWbXpOW1jrRgDsGDeHI OxPc5novssNJwzPxEtaOwTCsaqs/djNYXod79VYkjkoMiV8tYcHT5ke/3pDXsxb9UD2pL4wbjJIA/B DZUw1/7XWlURodBEFFKa14euT861B2HMPgsyHLAUAkny8awYPYznJC0p+Ib0vl2lLwPyQIy0pFoZZk 6Yu04dVOY2qZkjHO57iUJ6u7jVOnyc3zoiCFc5SWpIEpEkxDWu3pRsvWes28xEipcM2VaIWcEZ24T/ 2fWOfeS5WYh7+Jwzb0F0GNKDLAzUDR9SPVhc1L/8RDjycipBk5iFfGSRtIJe+8NtWG2eHnygSYOZ66 MtEDgS2VvLsdiYvQl3nrxOa+WzQ1eeH/CzL4EmHOpTJVEmsfNxsUNq6Cg8ng==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate the effect of the __alloc_size attribute on allocators. If the
compiler doesn't support __builtin_dynamic_object_size(), skip the test.

Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
To pass this depends on the following patches:
https://lore.kernel.org/lkml/20221018073430.never.551-kees@kernel.org/
https://lore.kernel.org/lkml/20221018082232.never.213-kees@kernel.org/
To not be skipped, either GCC 12 or Clang is needed.
---
 lib/fortify_kunit.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 409af07f340a..5076ba11adfd 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -16,7 +16,10 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <kunit/test.h>
+#include <linux/device.h>
 #include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
 
 static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
@@ -60,9 +63,98 @@ static void control_flow_split_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, want_minus_one(pick), SIZE_MAX);
 }
 
+#define check_alloc(alloc, free)	do {				\
+	size_t expected = size;						\
+	void *p = alloc;						\
+	KUNIT_EXPECT_TRUE_MSG(test, p != NULL, #alloc " failed?!\n");	\
+	KUNIT_EXPECT_EQ_MSG(test, __builtin_dynamic_object_size(p, 1),	\
+		expected,						\
+		"__alloc_size() not working with " #alloc "\n");	\
+	free;								\
+} while (0)
+
+static volatile size_t unknown_size = 50;
+
+static void alloc_size_test(struct kunit *test)
+{
+#if !__has_builtin(__builtin_dynamic_object_size)
+	kunit_skip(test, "Compiler is missing __builtin_dynamic_object_size() support\n");
+#else
+	const char device_name[] = "fortify-test";
+	struct device *dev;
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
+	size_t size = unknown_size, prev_size;
+	void *orig;
+
+	/* kmalloc()-family */
+	check_alloc(kmalloc(size++, gfp),			kfree(p));
+	check_alloc(kmalloc_node(size++, gfp, NUMA_NO_NODE),	kfree(p));
+	check_alloc(kzalloc(size++, gfp),			kfree(p));
+	check_alloc(kzalloc_node(size++, gfp, NUMA_NO_NODE),	kfree(p));
+	check_alloc(kcalloc(1, size++, gfp),			kfree(p));
+	check_alloc(kcalloc_node(1, size++, gfp, NUMA_NO_NODE),	kfree(p));
+	check_alloc(kmalloc_array(1, size++, gfp),		kfree(p));
+	check_alloc(kmalloc_array_node(1, size++, gfp, NUMA_NO_NODE), kfree(p));
+	check_alloc(__kmalloc(size++, gfp),			kfree(p));
+	check_alloc(__kmalloc_node(size++, gfp, NUMA_NO_NODE),	kfree(p));
+
+	/* kmemdup() */
+	prev_size = size;
+	size = 11;
+	check_alloc(kmemdup("hello there", size, gfp),		kfree(p));
+	size = prev_size + 1;
+
+	/* krealloc()-family */
+	orig = kmalloc(size++, gfp);
+	check_alloc(krealloc(orig, size++, gfp),		kfree(p));
+	orig = kmalloc(size++, gfp);
+	check_alloc(krealloc_array(orig, 1, size++, gfp),	kfree(p));
+
+	/* vmalloc()-family */
+	check_alloc(vmalloc(size++),				vfree(p));
+	check_alloc(vzalloc(size++),				vfree(p));
+	check_alloc(__vmalloc(size++, gfp),			vfree(p));
+
+	/* kvalloc()-family */
+	check_alloc(kvmalloc(size++, gfp),			kvfree(p));
+	check_alloc(kvmalloc_node(size++, gfp, NUMA_NO_NODE),	kvfree(p));
+	check_alloc(kvzalloc(size++, gfp),			kvfree(p));
+	check_alloc(kvzalloc_node(size++, gfp, NUMA_NO_NODE),	kvfree(p));
+	check_alloc(kvcalloc(1, size++, gfp),			kvfree(p));
+	check_alloc(kvmalloc_array(1, size++, gfp),		kvfree(p));
+
+	/* kvrealloc() */
+	prev_size = size++;
+	orig = kvmalloc(prev_size, gfp);
+	check_alloc(kvrealloc(orig, prev_size, size++, gfp),	kfree(p));
+
+	/* Create dummy device for devm_kmalloc()-family tests. */
+	dev = root_device_register(device_name);
+	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
+			       "Cannot register test device\n");
+
+	/* devm_kmalloc()-family */
+	check_alloc(devm_kmalloc(dev, size++, gfp),		devm_kfree(dev, p));
+	check_alloc(devm_kzalloc(dev, size++, gfp),		devm_kfree(dev, p));
+
+	/* devm_kmemdup() */
+	prev_size = size;
+	size = 4;
+	check_alloc(devm_kmemdup(dev, "Ohai", size, gfp),	devm_kfree(dev, p));
+	size = prev_size + 1;
+
+	/* devm_kremalloc() */
+	orig = devm_kmalloc(dev, size++, gfp);
+	check_alloc(devm_krealloc(dev, orig, size++, gfp),	devm_kfree(dev, p));
+
+	device_unregister(dev);
+#endif
+}
+
 static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(known_sizes_test),
 	KUNIT_CASE(control_flow_split_test),
+	KUNIT_CASE(alloc_size_test),
 	{}
 };
 
-- 
2.34.1

