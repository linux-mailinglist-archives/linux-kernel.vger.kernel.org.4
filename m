Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535D55E9BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiIZIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiIZIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:08:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9E1C27
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:08:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso3262708wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WcgXDoMd0CVdxOWuR/GM8D94WcALUjLEc5ia9kSiHqU=;
        b=hbiv/D7EdlkW6+bV0VRFWklX+6adfuzsk5mTQSXjW3YzTnbyGABTuEYseP/vxVrv2a
         P3Q+V711IBp9I+LsJGFZJV5MIFTBnm/fTq280RSsLgy9L/CuVw4Pj+PZcvNW1UgmdJ6J
         XQrpkGNdpTEEgEqA5AS8lswbDpHapmZufycc6sB0WdoUyCEtgM+fytxZpZHgUwdHru9j
         LBrzJLLtU6bhL9ImhwSTcMfaW4H/dSEiPaiBqZP7vY5RU26obRsgt8nw81KZcMqwGv7X
         VrOLrlMZVFmqC2NF4cBysBYnYlzHCpiZuRkboYCN51RHxeXj9Q3Q9A8B8jx0/JZFYQe3
         hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WcgXDoMd0CVdxOWuR/GM8D94WcALUjLEc5ia9kSiHqU=;
        b=x2F+/FYfcwTwPmsPWzSpPZoQSuWj9IrUNInfC/SPHZ9hsquhEGnrg64i44SxRWGCaj
         Cn9i28r+AA4c0Tgiy0joklIY/Dj/7UAHK/fO3yBaOX9QEhjoDIO7DHvAKE84oIYfRVmE
         SPOb3jpgTQwZyR8CRVxIJ1f5Ko2IIXdfuPLfG577x/jo7xK6nGxhWtk3RqQjc0fMBGeP
         zJcayViIpxloIUXEhPh/Q4At+MNCAIF2d6SSMHLcIaeSzHkMwdIJy9jdvC80Vid4f3ZN
         0qs8kiSjY1eT28G30CyfAMOehByTjXDVPfFGLEdltlHOVCqoEJTxdozJR/2MSoJCtw/v
         NfRg==
X-Gm-Message-State: ACrzQf07eanEOvyCJdDEKKFlSL1Cf18z9Asfo+NOCQ6kEFGFhAYIGiBq
        ZkphieoOEtSs0AkNujsZS6s=
X-Google-Smtp-Source: AMsMyM5xF6KiDr6ZUij9bip2Wrijf6oe5EIypAhSp3xgij8ghz42DLUWJp7pUcgBPd5U1F0VWZx63w==
X-Received: by 2002:a7b:ce0d:0:b0:3b4:8728:3e7e with SMTP id m13-20020a7bce0d000000b003b487283e7emr13478059wmc.182.1664179727918;
        Mon, 26 Sep 2022 01:08:47 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d6642000000b0022ac61ebb14sm13421078wrw.22.2022.09.26.01.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:08:47 -0700 (PDT)
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
Subject: [PATCH v5 1/3] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb888()
Date:   Mon, 26 Sep 2022 10:08:35 +0200
Message-Id: <20220926080837.65734-2-jose.exposito89@gmail.com>
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
RGB888.

Tested-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index ab49f5e8796c..bc830601e7a2 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -27,6 +27,11 @@ struct convert_to_rgb565_result {
 	const u16 expected_swab[TEST_BUF_SIZE];
 };
 
+struct convert_to_rgb888_result {
+	unsigned int dst_pitch;
+	const u8 expected[TEST_BUF_SIZE];
+};
+
 struct convert_xrgb8888_case {
 	const char *name;
 	unsigned int pitch;
@@ -34,6 +39,7 @@ struct convert_xrgb8888_case {
 	const u32 xrgb8888[TEST_BUF_SIZE];
 	struct convert_to_rgb332_result rgb332_result;
 	struct convert_to_rgb565_result rgb565_result;
+	struct convert_to_rgb888_result rgb888_result;
 };
 
 static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
@@ -51,6 +57,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.expected = { 0xF800 },
 			.expected_swab = { 0x00F8 },
 		},
+		.rgb888_result = {
+			.dst_pitch = 0,
+			.expected = { 0x00, 0x00, 0xFF },
+		},
 	},
 	{
 		.name = "single_pixel_clip_rectangle",
@@ -69,6 +79,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.expected = { 0xF800 },
 			.expected_swab = { 0x00F8 },
 		},
+		.rgb888_result = {
+			.dst_pitch = 0,
+			.expected = { 0x00, 0x00, 0xFF },
+		},
 	},
 	{
 		/* Well known colors: White, black, red, green, blue, magenta,
@@ -109,6 +123,15 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0xE0FF, 0xFF07,
 			},
 		},
+		.rgb888_result = {
+			.dst_pitch = 0,
+			.expected = {
+				0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0xFF, 0x00, 0xFF, 0x00,
+				0xFF, 0x00, 0x00, 0xFF, 0x00, 0xFF,
+				0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
+			},
+		},
 	},
 	{
 		/* Randomly picked colors. Full buffer within the clip area. */
@@ -141,6 +164,17 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0x00A8, 0x8E6B, 0x330A, 0x0000, 0x0000,
 			},
 		},
+		.rgb888_result = {
+			.dst_pitch = 15,
+			.expected = {
+				0x9C, 0x44, 0x0E, 0x05, 0x4D, 0x11, 0x03, 0x03, 0xA8,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				0x73, 0x70, 0x6C, 0x9C, 0x44, 0x0E, 0x05, 0x4D, 0x11,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				0x03, 0x03, 0xA8, 0x73, 0x70, 0x6C, 0x9C, 0x44, 0x0E,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			},
+		},
 	},
 };
 
@@ -255,9 +289,40 @@ static void drm_test_fb_xrgb8888_to_rgb565(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected_swab, dst_size), 0);
 }
 
+static void drm_test_fb_xrgb8888_to_rgb888(struct kunit *test)
+{
+	const struct convert_xrgb8888_case *params = test->param_value;
+	const struct convert_to_rgb888_result *result = &params->rgb888_result;
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
+	dst_size = conversion_buf_size(DRM_FORMAT_RGB888, result->dst_pitch,
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
+	drm_fb_xrgb8888_to_rgb888(&dst, &result->dst_pitch, &src, &fb, &params->clip);
+	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+}
+
 static struct kunit_case drm_format_helper_test_cases[] = {
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb332, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb565, convert_xrgb8888_gen_params),
+	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb888, convert_xrgb8888_gen_params),
 	{}
 };
 
-- 
2.25.1

