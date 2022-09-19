Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA62B5BC36D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiISHQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiISHPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:15:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7589A13D72
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:15:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k9so46092502wri.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qfGjedfOfmqcmzpgBDloDio1P9ZSKZd/Kz8vAVqEXrA=;
        b=I/cZGAOmF7yLIHC6L1ZReI1Zr+la6gtckoj0oh31FXw7VNcw0Gbiov07i1Slmiq097
         rBlJ+EVXnKgTBHMR/5ASoB5Rio02rb6EzdfikO5QobiWNiU385CF8AbdHuqX+p46rBSK
         PCWzI6YN+409UnP5W2CqulmsOEX+Es4eIX+PxA0ezxskF7e9RAmi9kDS5CDClp0Mt7nx
         JCz6JHdHcsNbAHiFIeOMLFQzXG+rofrE8sqbybvhtoIjOrfW1TSlMMt9rCf/RPdiA8mR
         jJW0xrMuTbKHsPxUOYi+W5k09FQrdixs6R4zQf1xqUHvdNo0qNz45cyeqA5OnzCkYYYY
         t81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qfGjedfOfmqcmzpgBDloDio1P9ZSKZd/Kz8vAVqEXrA=;
        b=P/gFvJuBBOC9W4pPevP5Z0PD3QcQSnDsHL5UuSiuqEtVzusnji3AZxndQxhMOynmwA
         BndCk4s7x+mQlYWZg3mkragB8IVAzri4D+A4lXdGiQHmA+XwWPVPoqWleQp+vFaBPpUc
         0lx26OE5tFhrvDdvYLHQ1+HEDrFEhEa2IdTXEpBTY2OTpK55+X2pZ6hEvnmVJooGlCGy
         uDQbgwU4hdjs9gAZix4viYMo36W3+QuckgbeXLZu7NMwtPddQiClz3UBd175oFdeutae
         Rng/n0nYbeHqeqzs8z8GyiuvBkkY9AFTshPpbsROQ9e3po6dJ/+HSIWeCQgRtCuyF81n
         oIJg==
X-Gm-Message-State: ACrzQf3uhSPG1zkGj1lk/Xn5N3wBqhwqbUnuUpLZ2inQG+ODj1jVclGa
        jyrS2JBKLfNPbSiaBT2gT+M=
X-Google-Smtp-Source: AMsMyM6dBRYmU965RelyzKog9pKkRLMn4BxhBotd8j55/PpvNwhGT3YtQ0KoUvz9HEP8xrL990Allw==
X-Received: by 2002:adf:fb50:0:b0:22a:e4e9:a6b3 with SMTP id c16-20020adffb50000000b0022ae4e9a6b3mr6977062wrs.467.1663571744981;
        Mon, 19 Sep 2022 00:15:44 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4bc3000000b0022ac12fff29sm12864564wrt.65.2022.09.19.00.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 00:15:44 -0700 (PDT)
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
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v4 3/3] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()
Date:   Mon, 19 Sep 2022 09:15:31 +0200
Message-Id: <20220919071531.105124-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919071531.105124-1-jose.exposito89@gmail.com>
References: <20220919071531.105124-1-jose.exposito89@gmail.com>
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
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .../gpu/drm/tests/drm_format_helper_test.c    | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 09d358b54da0..71722e828abe 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -37,6 +37,11 @@ struct convert_to_xrgb2101010_result {
 	const u32 expected[TEST_BUF_SIZE];
 };
 
+struct convert_to_gray8_result {
+	unsigned int dst_pitch;
+	const u8 expected[TEST_BUF_SIZE];
+};
+
 struct convert_xrgb8888_case {
 	const char *name;
 	unsigned int pitch;
@@ -46,6 +51,7 @@ struct convert_xrgb8888_case {
 	struct convert_to_rgb565_result rgb565_result;
 	struct convert_to_rgb888_result rgb888_result;
 	struct convert_to_xrgb2101010_result xrgb2101010_result;
+	struct convert_to_gray8_result gray8_result;
 };
 
 static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
@@ -71,6 +77,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = 0,
 			.expected = { 0x3FF00000 },
 		},
+		.gray8_result = {
+			.dst_pitch = 0,
+			.expected = { 0x4C },
+		},
 	},
 	{
 		.name = "single_pixel_clip_rectangle",
@@ -97,6 +107,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = 0,
 			.expected = { 0x3FF00000 },
 		},
+		.gray8_result = {
+			.dst_pitch = 0,
+			.expected = { 0x4C },
+		},
 	},
 	{
 		/* Well known colors: White, black, red, green, blue, magenta,
@@ -155,6 +169,15 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0x3FFFFC00, 0x000FFFFF,
 			},
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
 	},
 	{
 		/* Randomly picked colors. Full buffer within the clip area. */
@@ -206,6 +229,14 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0x2A20300C, 0x1B1705CD, 0x03844672, 0x00000000, 0x00000000,
 			},
 		},
+		.gray8_result = {
+			.dst_pitch = 5,
+			.expected = {
+				0x3C, 0x33, 0x34, 0x00, 0x00,
+				0x6F, 0x3C, 0x33, 0x00, 0x00,
+				0x34, 0x6F, 0x3C, 0x00, 0x00,
+			},
+		},
 	},
 };
 
@@ -381,11 +412,42 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
 }
 
+static void drm_test_fb_xrgb8888_to_gray8_test(struct kunit *test)
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
 static struct kunit_case drm_format_helper_test_cases[] = {
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb332, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb565, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb888_test, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_xrgb2101010_test, convert_xrgb8888_gen_params),
+	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_gray8_test, convert_xrgb8888_gen_params),
 	{}
 };
 
-- 
2.25.1

