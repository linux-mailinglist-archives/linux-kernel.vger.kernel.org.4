Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1244A717C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjEaJzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjEaJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFBE8
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685526878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snh6cqXcNPSdXvXd+zNA/c6ecSqkCOtLESb6cXuhBo8=;
        b=TlHDi2flJdcqMeqkChfyjz1/qpRhJEGGq4mfucyyhTIDMixAhp8lm07XC83f1gXrg4Do6F
        G9qK9noMtaBniZk5VFIgtOG8jAK0itfs+UYrpfecqsQqSIffoOAK3ByHAmtUeIXVYgY2H2
        rsVqNkoZEkGa6FF+BzU0WSWfQMaK3/8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-O14z50KYPmek0xwB6wezMA-1; Wed, 31 May 2023 05:54:37 -0400
X-MC-Unique: O14z50KYPmek0xwB6wezMA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75b17aa340fso759051185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526876; x=1688118876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snh6cqXcNPSdXvXd+zNA/c6ecSqkCOtLESb6cXuhBo8=;
        b=T7dKe96REdY2nkWXjk0YGreS678lW8ZD1fh1MubBReMHZGyMQFxRqNJ51WsWfBokLA
         kXLYOUpGzlXZ2rZIYqvFL/3A6mbH1zCG/EEiQKrb0BKNHOW2WZWQEvW+6TskqabD0hIF
         l06jfnc3KHbbFN5r47q1QWlrHyk2t/vWQbs3Jnxp3rxyNKZXsxPjZbfkhFnqXJt5ria4
         yFQWmiONqi/zoBnhB0VkkzG+Ts7Vhf5t9IM0AeoGf0CgAXyfqEr5xf0W1VJ2Zb5QtbPC
         zKOisEkXBCtqV4Slto5z89nw8oS0plBXDUWzQ9RJ7hjCFwN/LxnbGb8SWwIeV3c5UJWI
         u3Kw==
X-Gm-Message-State: AC+VfDwMAHfKAjnDDon50oa/BGyJdJEvvegbZI9HA6vKDOoFWEWWJubY
        aEfxjXsn6butykBE0oqK9PTuRceQZBSeO4df6+GbICp3/Ey3N4hjKfU7DmK5mgn/s1tAqXeCEFV
        To1O/R8drSdgsVbD1/hzme2E=
X-Received: by 2002:a05:620a:6193:b0:75b:23a1:455 with SMTP id or19-20020a05620a619300b0075b23a10455mr5466438qkn.27.1685526876646;
        Wed, 31 May 2023 02:54:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6QKqThXy2mNH7El9Z4OvjaQg/p7yscRNKAU4UdJLk9VGerFr+QMws3OyBQvP/FWZtQDqfQGw==
X-Received: by 2002:a05:620a:6193:b0:75b:23a1:455 with SMTP id or19-20020a05620a619300b0075b23a10455mr5466422qkn.27.1685526876351;
        Wed, 31 May 2023 02:54:36 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id k25-20020a05620a139900b0074def53eca5sm4902404qki.53.2023.05.31.02.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:54:36 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v6 3/4] fpga: add an initial KUnit suite for the FPGA Region
Date:   Wed, 31 May 2023 11:54:04 +0200
Message-Id: <20230531095405.342080-4-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531095405.342080-1-marpagan@redhat.com>
References: <20230531095405.342080-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suite tests the programming of an FPGA Region with a Bridge
and the function for finding a particular Region.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-region-test.c | 186 ++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-region-test.c

diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
new file mode 100644
index 000000000000..81b271088240
--- /dev/null
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the FPGA Region
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <kunit/test.h>
+#include <linux/platform_device.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/fpga/fpga-region.h>
+
+struct mgr_stats {
+	u32 write_count;
+};
+
+struct bridge_stats {
+	u32 enable_count;
+};
+
+struct test_ctx {
+	struct fpga_manager *mgr;
+	struct platform_device *mgr_pdev;
+	struct fpga_bridge *bridge;
+	struct platform_device *bridge_pdev;
+	struct fpga_region *region;
+	struct platform_device *region_pdev;
+	struct bridge_stats bridge_stats;
+	struct mgr_stats mgr_stats;
+};
+
+static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	struct mgr_stats *stats = mgr->priv;
+
+	stats->write_count++;
+
+	return 0;
+}
+
+static const struct fpga_manager_ops fake_mgr_ops = {
+	.write = op_write,
+};
+
+static int op_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct bridge_stats *stats = bridge->priv;
+
+	if (enable)
+		stats->enable_count++;
+
+	return 0;
+}
+
+static const struct fpga_bridge_ops fake_bridge_ops = {
+	.enable_set = op_enable_set
+};
+
+static int fake_region_get_bridges(struct fpga_region *region)
+{
+	struct fpga_bridge *bridge = region->priv;
+
+	return fpga_bridge_get_to_list(bridge->dev.parent, region->info, &region->bridge_list);
+}
+
+static int fake_region_match(struct device *dev, const void *data)
+{
+	return dev->parent == data;
+}
+
+static void fpga_region_test_class_find(struct kunit *test)
+{
+	struct test_ctx *ctx = test->priv;
+	struct fpga_region *region;
+
+	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
+	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
+}
+
+static void fpga_region_test_program_fpga(struct kunit *test)
+{
+	struct test_ctx *ctx = test->priv;
+	struct fpga_image_info *img_info;
+	char img_buf[4];
+	int ret;
+
+	img_info = fpga_image_info_alloc(&ctx->mgr_pdev->dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
+
+	img_info->buf = img_buf;
+	img_info->count = sizeof(img_buf);
+
+	ctx->region->info = img_info;
+	ret = fpga_region_program_fpga(ctx->region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, 1, ctx->mgr_stats.write_count);
+	KUNIT_EXPECT_EQ(test, 1, ctx->bridge_stats.enable_count);
+
+	fpga_bridges_put(&ctx->region->bridge_list);
+
+	ret = fpga_region_program_fpga(ctx->region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, 2, ctx->mgr_stats.write_count);
+	KUNIT_EXPECT_EQ(test, 2, ctx->bridge_stats.enable_count);
+
+	fpga_bridges_put(&ctx->region->bridge_list);
+
+	fpga_image_info_free(img_info);
+}
+
+static int fpga_region_test_init(struct kunit *test)
+{
+	struct test_ctx *ctx;
+	struct fpga_region_info region_info = { 0 };
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
+
+	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
+					  &ctx->mgr_stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
+
+	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
+							   NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
+
+	ctx->bridge = fpga_bridge_register(&ctx->bridge_pdev->dev, "Fake FPGA Bridge",
+					   &fake_bridge_ops, &ctx->bridge_stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
+
+	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
+							   NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
+
+	region_info.mgr = ctx->mgr;
+	region_info.priv = ctx->bridge;
+	region_info.get_bridges = fake_region_get_bridges;
+
+	ctx->region = fpga_region_register_full(&ctx->region_pdev->dev, &region_info);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->region));
+
+	test->priv = ctx;
+
+	return 0;
+}
+
+static void fpga_region_test_exit(struct kunit *test)
+{
+	struct test_ctx *ctx = test->priv;
+
+	fpga_region_unregister(ctx->region);
+	platform_device_unregister(ctx->region_pdev);
+
+	fpga_bridge_unregister(ctx->bridge);
+	platform_device_unregister(ctx->bridge_pdev);
+
+	platform_device_unregister(ctx->mgr_pdev);
+}
+
+static struct kunit_case fpga_region_test_cases[] = {
+	KUNIT_CASE(fpga_region_test_class_find),
+	KUNIT_CASE(fpga_region_test_program_fpga),
+
+	{}
+};
+
+static struct kunit_suite fpga_region_suite = {
+	.name = "fpga_mgr",
+	.init = fpga_region_test_init,
+	.exit = fpga_region_test_exit,
+	.test_cases = fpga_region_test_cases,
+};
+
+kunit_test_suite(fpga_region_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.40.1

