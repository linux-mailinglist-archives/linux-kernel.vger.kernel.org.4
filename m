Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BD73201A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjFOSeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjFOSeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0386D270A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D01B61E22
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D96EC433C8;
        Thu, 15 Jun 2023 18:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686854009;
        bh=Dsjd+ZpmvL/6xXc3Y13JGILcWmi7U4GqyYJ6md9X1xY=;
        h=From:To:Cc:Subject:Date:From;
        b=fvmFV/WWm6mNcOwWDpoxuttJZLSXSm9ssx8ToCjmoc+cU34XimcYrjr40gM60l9Rq
         0fQINZ45Fqh+rXllOcuqIQLG8+Y8TzEUkIjXv8qPDZ3SlVa1XFkPQDIMG8ms5CWUsV
         cEqIsm/794h9b10+BGqxu3XPqzmmVMZoIBar/pOOdt58PU5zmG1LmJKjqvspCDTyoa
         y+ayOOLfq7RiJy36JsOR42b/eFiPNv2ekpW2Jsvt577E6C+o1wLaiQ0TB2bDzWL4Bs
         cX5VJnT4kI/pE7PF8agPnlLQN0H3rRum+cWkATm+AJTrWlTgqRMj+BKkkipUR87EEu
         1ph524/oH87Gw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, wangkefeng.wang@huawei.com,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/core-test: add a test for damon_set_attrs()
Date:   Thu, 15 Jun 2023 18:33:22 +0000
Message-Id: <20230615183323.87561-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5ff6e2fff88e ("mm/damon/core: fix divide error in
damon_nr_accesses_to_accesses_bp()") fixed a bug by adding arguments
validation in damon_set_attrs().  Add a unit test for the added
validation to ensure the bug cannot occur again.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index fae64d32b925..c11210124344 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -318,6 +318,29 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->age, 20);
 }
 
+static void damon_test_set_attrs(struct kunit *test)
+{
+	struct damon_ctx ctx;
+	struct damon_attrs valid_attrs = {
+		.min_nr_regions = 10, .max_nr_regions = 1000,
+		.sample_interval = 5000, .aggr_interval = 100000,};
+	struct damon_attrs invalid_attrs;
+
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &valid_attrs), 0);
+
+	invalid_attrs = valid_attrs;
+	invalid_attrs.min_nr_regions = 1;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
+
+	invalid_attrs = valid_attrs;
+	invalid_attrs.max_nr_regions = 9;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
+
+	invalid_attrs = valid_attrs;
+	invalid_attrs.aggr_interval = 4999;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -329,6 +352,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_update_monitoring_result),
+	KUNIT_CASE(damon_test_set_attrs),
 	{},
 };
 
-- 
2.25.1

