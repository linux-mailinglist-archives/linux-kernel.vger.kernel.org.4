Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE7A603AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJSHdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJSHdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:33:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FE61121
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:33:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id u12-20020a17090a410c00b0020b7d65a875so8009826pjf.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OFBlhkYS8e4Y++xggTk7x762ubjdCZQL5LyxpmWeUCA=;
        b=Ozsq01M1gRGtGtoH/cesMFHrQcZgb+x4tyXdANAkVr2929UYFp/CQCJNXnoeFXDiNU
         BZzmFTWGkBpJuzxNNTEUt8mg3kaO/D4gk78C8xiYyqpZN5wlBBvwHPrU/+3GTP7Q3aVF
         GUn+1EEzrZprmxQZAO7uIhpSmiGFbxtWtGzAb3ReiY4nqkAzN09e1ovJBDEs/q4o5knY
         3Y54xYIdGEZXD/yShY+i5YkBn74VennWUUnxZEZN1CDFNTvNUGzk4Aqu3wN6j3pmmeRq
         MIa8VNaNxL+7+TQnDMEKpKDjXF7BmcCe8b84+M2DjcOL7+la4vlYESzSQBniYQYrWIg0
         3OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFBlhkYS8e4Y++xggTk7x762ubjdCZQL5LyxpmWeUCA=;
        b=wQqgG2r1guTPLp8SKJ81J156gHi73LOVL9K7p71iQLfdaSPnClFRXI+NwLG7laxDTo
         aicqooRz4mdsk2TMxB0140ZnBHnwqQCHH2QhjO7/9PmUINE/dQsZFlzlVSiKs/iKByCq
         Gfx9g+7nvOuV8iB0k4vhRNsVoUgqjGx1kzY2Te70NpUMZ/iYXjY2K+mWm0+yRepBkTb+
         1V5ejFldMnRp6Igde0E3MACu9b1gPjvoS/M6NjCxV9L+wA2JGqhvTzD3X+JfBQwGZ20b
         pUhoEO5szdKZo46cw3Z2YsnEk96rH2jP49fPEeHD/jon9EI0PWKpwp1nEg5nnIR+AUk4
         NAuQ==
X-Gm-Message-State: ACrzQf24ufewIpCKgRzdo01gKh7nvlvAhe1J98Ywa6UufPBiOrPkpOx5
        37p4xOsTnFahQb6stb+PQ9Ie9BXiQfa5jw==
X-Google-Smtp-Source: AMsMyM4sOm/YKLPaiW4toZ1Q1K+zqroG9h4PkVBmHim0IP5UnC6FuUX/WvPm+qCKMpmkixjA3plQjM513FTWEA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP
 id w6-20020a17090ac98600b00205f08ca82bmr2707194pjt.1.1666164781481; Wed, 19
 Oct 2022 00:33:01 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:32:40 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221019073239.3779180-1-davidgow@google.com>
Subject: [PATCH] drm: tests: Fix a buffer overflow in format_helper_test
From:   David Gow <davidgow@google.com>
To:     "=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     David Gow <davidgow@google.com>,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Functional Testing <lkft@linaro.org>
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

The xrgb2101010 format conversion test (unlike for other formats) does
an endianness conversion on the results. However, it always converts
TEST_BUF_SIZE 32-bit integers, which results in reading from (and
writing to) more memory than in present in the result buffer. Instead,
use the buffer size, divided by sizeof(u32).

The issue could be reproduced with KASAN:
./tools/testing/kunit/kunit.py run --kunitconfig drivers/gpu/drm/tests \
	--kconfig_add CONFIG_KASAN=y --kconfig_add CONFIG_KASAN_VMALLOC=y \
	--kconfig_add CONFIG_KASAN_KUNIT_TEST=y \
	drm_format_helper_test.*xrgb2101010

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: 453114319699 ("drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_xrgb2101010()")
Signed-off-by: David Gow <davidgow@google.com>
---

This is a fix for the issue reported here:
https://lore.kernel.org/dri-devel/CA+G9fYsuc9G+RO81E=vHMqxYStsmLURLdOB0NF26kJ1=K8pRZA@mail.gmail.com/

Note that it may conflict with the KUNIT_EXPECT_MEMEQ() series here:
https://lore.kernel.org/linux-kselftest/20221018190541.189780-1-mairacanal@riseup.net/

Cheers,
-- David

---
 drivers/gpu/drm/tests/drm_format_helper_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 8d86c250c2ec..2191e57f2297 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -438,7 +438,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
 	iosys_map_set_vaddr(&src, xrgb8888);
 
 	drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &fb, &params->clip);
-	buf = le32buf_to_cpu(test, buf, TEST_BUF_SIZE);
+	buf = le32buf_to_cpu(test, buf, dst_size / sizeof(u32));
 	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
 }
 
-- 
2.38.0.413.g74048e4d9e-goog

