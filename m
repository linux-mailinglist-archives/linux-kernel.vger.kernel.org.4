Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B96ABDF2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCFLON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCFLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:13:58 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D333233F5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:13:31 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id h11-20020a0564020e8b00b004e59d4722a3so3197322eda.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678101209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1L+pZCwrwV8WFeqR7MKglAsPEnoOPqo6PmA3RfPAYI=;
        b=P5DhRm6lyoKz3NoNdsdxwrRj/MfjpheohwuDiF7EpSFlNNXCKBaoHIBOiHLSs4Yzre
         6zEPjyPu0V4FkWh1Jtnal2exA5k4WwW8AbTrCkoXx4RjCcJewqsOrcNgnaLuTBJEze/l
         VGuQ7KdXumG/1Oc8kkYYtbRiCbr1ZMr0hDisTKb/hBPLVRcl7r3dM9ZwyLhLY7bgcvph
         KiQP1/tCcC74t9C7yVQwSeKAFhacYwFs5vhzrqyMo5OOr6N+uRAZB0CYJdq9/1YDnZhg
         tYmjh5t8WjxwwB84qFIiW9FlQDDLzJjnFU3PfE7CAheT6nZrosN+8/etsfpD+UY+qiot
         Q12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678101209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1L+pZCwrwV8WFeqR7MKglAsPEnoOPqo6PmA3RfPAYI=;
        b=fviWn4VTIR/9QFTgHiDBFDMFTQEZrHqax/iuSM8gNSQHLObnTsisK4brM8X8dfV87x
         T0wm2URyF/U+fFNLDHkAFfdALEX+6WyroqBPdAJE5mB/3puNIhsufzjenN0/waZ+xBRd
         SgIdAVp7kzRr1sc35pcYXT4GaEwYPJpNK0iYOr6HBAH6bNVkOJ24kLphChC5iF263bUN
         u7sZVzvIDJd0ICwPQNIdhXkSmDruXxQXhJ2hmj77vw/3K4TbOMP7HUX8iFoyawkKVfXw
         TCH8U2oRtjB8/rKRzPoQfkXqyFJNa11M7bZqydoynQFUv6BZBc4Y2EAflcHUHwkdMLyZ
         XOoA==
X-Gm-Message-State: AO0yUKXrFahvJwvXF0JOtJotMZpthNEp2YFn283xb1Gm6jTZDzpnCNpZ
        NnpFHrgzSn+t0KYsHC9//2ewKhF2jV4=
X-Google-Smtp-Source: AK7set8HRrR3WYNCNKrhw5eYGbtiDR8z1X0sw4OF9TB+cqX5mY5fOft5pn76XHBrFTvkLNhtM87td2wBZZA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b93a:5d85:6f2c:517d])
 (user=glider job=sendgmr) by 2002:a17:906:4f94:b0:8b1:7de9:b39b with SMTP id
 o20-20020a1709064f9400b008b17de9b39bmr5034537eju.1.1678101209226; Mon, 06 Mar
 2023 03:13:29 -0800 (PST)
Date:   Mon,  6 Mar 2023 12:13:22 +0100
In-Reply-To: <20230306111322.205724-1-glider@google.com>
Mime-Version: 1.0
References: <20230306111322.205724-1-glider@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306111322.205724-2-glider@google.com>
Subject: [PATCH 2/2] kmsan: add test_stackdepot_roundtrip
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
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

Ensure that KMSAN does not report false positives in instrumented callers
of stack_depot_save(), stack_depot_print(), and stack_depot_fetch().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/kmsan_test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 7095d3fbb23ac..d9eb141c27aa4 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -551,6 +551,36 @@ static void test_long_origin_chain(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/*
+ * Test case: ensure that saving/restoring/printing stacks to/from stackdepot
+ * does not trigger errors.
+ *
+ * KMSAN uses stackdepot to store origin stack traces, that's why we do not
+ * instrument lib/stackdepot.c. Yet it must properly mark its outputs as
+ * initialized because other kernel features (e.g. netdev tracker) may also
+ * access stackdepot from instrumented code.
+ */
+static void test_stackdepot_roundtrip(struct kunit *test)
+{
+	unsigned long src_entries[16], *dst_entries;
+	unsigned int src_nentries, dst_nentries;
+	EXPECTATION_NO_REPORT(expect);
+	depot_stack_handle_t handle;
+
+	kunit_info(test, "testing stackdepot roundtrip (no reports)\n");
+
+	src_nentries =
+		stack_trace_save(src_entries, ARRAY_SIZE(src_entries), 1);
+	handle = stack_depot_save(src_entries, src_nentries, GFP_KERNEL);
+	stack_depot_print(handle);
+	dst_nentries = stack_depot_fetch(handle, &dst_entries);
+	KUNIT_EXPECT_TRUE(test, src_nentries == dst_nentries);
+
+	kmsan_check_memory((void *)dst_entries,
+			   sizeof(*dst_entries) * dst_nentries);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
 static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_uninit_kmalloc),
 	KUNIT_CASE(test_init_kmalloc),
@@ -573,6 +603,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memset32),
 	KUNIT_CASE(test_memset64),
 	KUNIT_CASE(test_long_origin_chain),
+	KUNIT_CASE(test_stackdepot_roundtrip),
 	{},
 };
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

