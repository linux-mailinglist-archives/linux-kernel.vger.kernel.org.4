Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1B3743EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjF3P0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjF3P02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481BD3C10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDJvffpbrPgNmPKLqywH3LAm8S873ODrHn5dEekELQE=;
        b=an2KLj6Gnc9/MlRE7mlpFS6T7GryuLi0gIVwPN+8nTMLb2oH38Vg13wHknXiSnvxQfaWwX
        oAQiFy8bNkVxL/evs1VnTuMGO6OFcoeR+Hzc2z1IcTqdfdc6Lw+xESKBVfocgp2z0yeifM
        G1YLKK/AT9U++oKMwnseAZ0fVFQkoow=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-_scam52eM9erYnoM1SRttg-1; Fri, 30 Jun 2023 11:25:36 -0400
X-MC-Unique: _scam52eM9erYnoM1SRttg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb736a7746so2029981e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138735; x=1690730735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDJvffpbrPgNmPKLqywH3LAm8S873ODrHn5dEekELQE=;
        b=GR2BF9J13TTc5AfuP/+jsDDGIgr2GKJRH1fmGWyB+KVKmTvcRtN7GtvtwJqXx8AEC6
         BRMAjCCJZsrkb5gKsRvhSaP7OKwIpUWj9DD69VmVQj0iZJvigMwxGqexEToyiMFIKM2b
         fxT+bWVOrJv6VxeTlq3cQZ3ACVsLVzLyBPone2J2xOBW+u0xNejnik5IpSG+SqM+lnFF
         6HrLrJHcxL6SMSW1pblp9Cd0j3TqB+gSsSMsV6caVhBL5pQo3tqYQla9OKW7iD0/fIzq
         HhZy5C7UgJbi22Lh5nyHn2vphhZA+8Toa6a+vDXIdiI2WVxK4h3bRX2whjNr+a8uOVbR
         QI0w==
X-Gm-Message-State: ABy/qLYxrKwE+gubQDQ1Mrtc6vTmniKTbgBSzgWt5FhXwskxYWTAfWda
        xjz6N6aGhe4S++xxLAuq5Yu0YNxEWmo84kvappgObBGTmAh/YDhy1cABFZne8EZEmdiALpeO/v5
        mYN5OeSgqJ3KaFjxjljkOm7s=
X-Received: by 2002:a05:6512:312a:b0:4f8:587e:cbe0 with SMTP id p10-20020a056512312a00b004f8587ecbe0mr2451977lfd.52.1688138734744;
        Fri, 30 Jun 2023 08:25:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFGrlqJEk8VJbET2xLYZ7VCs1DOk8qkErqnhagVRJZHTM/u0xLat6MsvHazE9/4C5SpKsFqWg==
X-Received: by 2002:a05:6512:312a:b0:4f8:587e:cbe0 with SMTP id p10-20020a056512312a00b004f8587ecbe0mr2451970lfd.52.1688138734545;
        Fri, 30 Jun 2023 08:25:34 -0700 (PDT)
Received: from klayman.station (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0051def9be785sm813230edq.85.2023.06.30.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:25:34 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v8 2/4] fpga: add an initial KUnit suite for the FPGA Bridge
Date:   Fri, 30 Jun 2023 17:25:05 +0200
Message-ID: <20230630152507.30219-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630152507.30219-1-marpagan@redhat.com>
References: <20230630152507.30219-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suite tests the basic behaviors of the FPGA Bridge including
the functions that operate on a list of bridges.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/tests/fpga-bridge-test.c | 175 ++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c

diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
new file mode 100644
index 000000000000..c69d451fee88
--- /dev/null
+++ b/drivers/fpga/tests/fpga-bridge-test.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the FPGA Bridge
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/device.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+struct bridge_stats {
+	bool enable;
+};
+
+struct bridge_ctx {
+	struct fpga_bridge *bridge;
+	struct platform_device *pdev;
+	struct bridge_stats stats;
+};
+
+static int op_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct bridge_stats *stats = bridge->priv;
+
+	stats->enable = enable;
+
+	return 0;
+}
+
+/*
+ * Fake Bridge that implements only the enable_set op to track
+ * the state.
+ */
+static const struct fpga_bridge_ops fake_bridge_ops = {
+	.enable_set = op_enable_set,
+};
+
+/**
+ * register_test_bridge() - Register a fake Bridge for testing.
+ * @test: KUnit test context object.
+ *
+ * Return: Context of the newly registered Bridge.
+ */
+static struct bridge_ctx *register_test_bridge(struct kunit *test)
+{
+	struct bridge_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
+
+	ctx->bridge = fpga_bridge_register(&ctx->pdev->dev, "Fake FPGA Bridge", &fake_bridge_ops,
+					   &ctx->stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
+
+	return ctx;
+}
+
+static void unregister_test_bridge(struct bridge_ctx *ctx)
+{
+	fpga_bridge_unregister(ctx->bridge);
+	platform_device_unregister(ctx->pdev);
+}
+
+static void fpga_bridge_test_get(struct kunit *test)
+{
+	struct bridge_ctx *ctx = test->priv;
+	struct fpga_bridge *bridge;
+
+	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
+	KUNIT_EXPECT_PTR_EQ(test, bridge, ctx->bridge);
+
+	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
+	KUNIT_EXPECT_EQ(test, PTR_ERR(bridge), -EBUSY);
+
+	fpga_bridge_put(ctx->bridge);
+}
+
+static void fpga_bridge_test_toggle(struct kunit *test)
+{
+	struct bridge_ctx *ctx = test->priv;
+	int ret;
+
+	ret = fpga_bridge_disable(ctx->bridge);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, ctx->stats.enable);
+
+	ret = fpga_bridge_enable(ctx->bridge);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, ctx->stats.enable);
+}
+
+/* Test the functions for getting and controlling a list of bridges */
+static void fpga_bridge_test_get_put_list(struct kunit *test)
+{
+	struct list_head bridge_list;
+	struct bridge_ctx *ctx_0, *ctx_1;
+	int ret;
+
+	ctx_0 = test->priv;
+	ctx_1 = register_test_bridge(test);
+
+	INIT_LIST_HEAD(&bridge_list);
+
+	/* Get bridge 0 and add it to the list */
+	ret = fpga_bridge_get_to_list(&ctx_0->pdev->dev, NULL, &bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx_0->bridge,
+			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
+
+	/* Get bridge 1 and add it to the list */
+	ret = fpga_bridge_get_to_list(&ctx_1->pdev->dev, NULL, &bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx_1->bridge,
+			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
+
+	/* Disable an then enable both bridges from the list */
+	ret = fpga_bridges_disable(&bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, ctx_0->stats.enable);
+	KUNIT_EXPECT_FALSE(test, ctx_1->stats.enable);
+
+	ret = fpga_bridges_enable(&bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, ctx_0->stats.enable);
+	KUNIT_EXPECT_TRUE(test, ctx_1->stats.enable);
+
+	/* Put and remove both bridges from the list */
+	fpga_bridges_put(&bridge_list);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&bridge_list));
+
+	unregister_test_bridge(ctx_1);
+}
+
+static int fpga_bridge_test_init(struct kunit *test)
+{
+	test->priv = register_test_bridge(test);
+
+	return 0;
+}
+
+static void fpga_bridge_test_exit(struct kunit *test)
+{
+	unregister_test_bridge(test->priv);
+}
+
+static struct kunit_case fpga_bridge_test_cases[] = {
+	KUNIT_CASE(fpga_bridge_test_get),
+	KUNIT_CASE(fpga_bridge_test_toggle),
+	KUNIT_CASE(fpga_bridge_test_get_put_list),
+	{}
+};
+
+static struct kunit_suite fpga_bridge_suite = {
+	.name = "fpga_bridge",
+	.init = fpga_bridge_test_init,
+	.exit = fpga_bridge_test_exit,
+	.test_cases = fpga_bridge_test_cases,
+};
+
+kunit_test_suite(fpga_bridge_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.41.0

