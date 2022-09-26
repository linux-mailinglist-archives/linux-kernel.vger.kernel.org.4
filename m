Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B735E9BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiIZIJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbiIZII4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:08:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26863EA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:08:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n10so8859129wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vrEtLoLXJ0iTEl/AGiFoQ93+y9nVNiEw3gldZxWD548=;
        b=XwJ/nd17lrK5HtYzpmPMlFKoPPzpoJAqnzR6WlZBiWnwK/24ANec4fDLbPd4eaCOh6
         tOssfynso6DYUeCUwaxCaD6zurRolYnkJxNaSTWLxJbm6J8FrZwL9rXlKuRJf1neDqiX
         sUE3TXl2zflQE+8r53ZDe+ny5BLYWUPTTKg/YpjL2bKdRa0XmKsRBclp9fqgMtWUb5Ox
         jVB106riCFKsH/LV0uioIVbu5iyXcKzq1zInWUmeUOR40VaobgistM847zq9I5g5Aq3m
         hN9htfjUNGHwgqgnzyu47maN6O2a/1LaapdsPJQgYpiBjP6XFvil7+sgqeSOGvv8YVXE
         eYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vrEtLoLXJ0iTEl/AGiFoQ93+y9nVNiEw3gldZxWD548=;
        b=RR6i1LCYrhXui+Ncud/+HSsW/s1xlI16KT2xJqCBqRXgGDViIwtYK50g1FoehcSWdf
         Om1zmCJjt7WQ9k1suv2ZBOyFilGSoBXlOhN3742ygrOdyYihlObxYuhxIMfsXnUKLxhx
         VueSYH+cneX4gthDWz5Xll2thvJ/LcMe/BD4uIPRsLxaEm6ssIBmca7UBuUIY0YJm5ZU
         Ns5HJ6kNBraK0VlMs/CXedI4OnYO7qNAAhg3bOuZvrSJqMvQjFANkY321bqwNjtc87RW
         uI0/oKgKz2dd4lImSed2CGKoinW3IHQeLweZrUHe3M216uw3WwtBaaS9hSsTAkrhfsH1
         YCXA==
X-Gm-Message-State: ACrzQf1K0B2EBOiTztORgznsUrBe7k5F7ngRqI9axS2heB353Esamg2A
        k4sSwu1dVe9stBre4sMy3pRs6AAf80IwSg==
X-Google-Smtp-Source: AMsMyM7doUvgczCN/zuxOmb+pZhS7rZWQ0TKivw2LEyV7K7JifUKdp1a3ZYMlnTdMi34BMVMpsGelA==
X-Received: by 2002:adf:f80b:0:b0:228:dbb9:5bdf with SMTP id s11-20020adff80b000000b00228dbb95bdfmr12549039wrp.327.1664179731590;
        Mon, 26 Sep 2022 01:08:51 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d6642000000b0022ac61ebb14sm13421078wrw.22.2022.09.26.01.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:08:51 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 3/3] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()
Date:   Mon, 26 Sep 2022 10:08:37 +0200
Message-Id: <20220926080837.65734-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926080837.65734-1-jose.exposito89@gmail.com>
References: <20220926080837.65734-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the existing test cases to test the conversion from XRGB8888 to
grayscale.

Tested-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 4a2f3c0de060..8d86c250c2ec 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -16,6 +16,11 @@
 
 #define TEST_BUF_SIZE 50
 
+struct convert_to_gray8_result {
+	unsigned int dst_pitch;
+	const u8 expected[TEST_BUF_SIZE];
+};
+
 struct convert_to_rgb332_result {
 	unsigned int dst_pitch;
 	const u8 expected[TEST_BUF_SIZE];
@@ -42,6 +47,7 @@ struct convert_xrgb8888_case {
 	unsigned int pitch;
 	struct drm_rect clip;
 	const u32 xrgb8888[TEST_BUF_SIZE];
+	struct convert_to_gray8_result gray8_result;
 	struct convert_to_rgb332_result rgb332_result;
 	struct convert_to_rgb565_result rgb565_result;
 	struct convert_to_rgb888_result rgb888_result;
@@ -54,6 +60,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 		.pitch = 1 * 4,
 		.clip = DRM_RECT_INIT(0, 0, 1, 1),
 		.xrgb8888 = { 0x01FF0000 },
+		.gray8_result = {
+			.dst_pitch = 0,
+			.expected = { 0x4C },
+		},
 		.rgb332_result = {
 			.dst_pitch = 0,
 			.expected = { 0xE0 },
@@ -80,6 +90,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			0x00000000, 0x00000000,
 			0x00000000, 0x10FF0000,
 		},
+		.gray8_result = {
+			.dst_pitch = 0,
+			.expected = { 0x4C },
+		},
 		.rgb332_result = {
 			.dst_pitch = 0,
 			.expected = { 0xE0 },
@@ -113,6 +127,15 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			0x00000000, 0x550000FF, 0x66FF00FF, 0x00000000,
 			0x00000000, 0x77FFFF00, 0x8800FFFF, 0x00000000,
 		},
+		.gray8_result = {
+			.dst_pitch = 0,
+			.expected = {
+				0xFF, 0x00,
+				0x4C, 0x99,
+				0x19, 0x66,
+				0xE5, 0xB2,
+			},
+		},
 		.rgb332_result = {
 			.dst_pitch = 0,
 			.expected = {
@@ -166,6 +189,14 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			0xD16C7073, 0xA20E449C, 0xB2114D05,
 			0xC2A80303, 0xD26C7073, 0xA30E449C,
 		},
+		.gray8_result = {
+			.dst_pitch = 5,
+			.expected = {
+				0x3C, 0x33, 0x34, 0x00, 0x00,
+				0x6F, 0x3C, 0x33, 0x00, 0x00,
+				0x34, 0x6F, 0x3C, 0x00, 0x00,
+			},
+		},
 		.rgb332_result = {
 			.dst_pitch = 5,
 			.expected = {
@@ -257,6 +288,36 @@ static void convert_xrgb8888_case_desc(struct convert_xrgb8888_case *t,
 KUNIT_ARRAY_PARAM(convert_xrgb8888, convert_xrgb8888_cases,
 		  convert_xrgb8888_case_desc);
 
+static void drm_test_fb_xrgb8888_to_gray8(struct kunit *test)
+{
+	const struct convert_xrgb8888_case *params = test->param_value;
+	const struct convert_to_gray8_result *result = &params->gray8_result;
+	size_t dst_size;
+	__u8 *buf = NULL;
+	__u32 *xrgb8888 = NULL;
+	struct iosys_map dst, src;
+
+	struct drm_framebuffer fb = {
+		.format = drm_format_info(DRM_FORMAT_XRGB8888),
+		.pitches = { params->pitch, 0, 0 },
+	};
+
+	dst_size = conversion_buf_size(DRM_FORMAT_R8, result->dst_pitch,
+				       &params->clip);
+	KUNIT_ASSERT_GT(test, dst_size, 0);
+
+	buf = kunit_kzalloc(test, dst_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	iosys_map_set_vaddr(&dst, buf);
+
+	xrgb8888 = le32buf_to_cpu(test, params->xrgb8888, TEST_BUF_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xrgb8888);
+	iosys_map_set_vaddr(&src, xrgb8888);
+
+	drm_fb_xrgb8888_to_gray8(&dst, &result->dst_pitch, &src, &fb, &params->clip);
+	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+}
+
 static void drm_test_fb_xrgb8888_to_rgb332(struct kunit *test)
 {
 	const struct convert_xrgb8888_case *params = test->param_value;
@@ -382,6 +443,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
 }
 
 static struct kunit_case drm_format_helper_test_cases[] = {
+	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_gray8, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb332, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb565, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb888, convert_xrgb8888_gen_params),
-- 
2.25.1

