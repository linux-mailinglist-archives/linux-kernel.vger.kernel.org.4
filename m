Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326C372ECBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbjFMUSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjFMUSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7681980
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C63D63AA4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06020C433D9;
        Tue, 13 Jun 2023 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686687482;
        bh=WhDf+kiOS5aGuKfQUW/eJ+QBuABHGrCyRWVCjRn2dDA=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=WEpeg+qLFzsDtXVmweut5W1DguWjehSf3IVBlfEEC5VI5yCC+12DC1OIMLJpvzugu
         zQ+QOjBvRt/sL5P0xUXmAfCficmth4XFEJIAc1yTakGgc/VlndgTtyHrZMPxwrFOGx
         ch268kG7bRClsE+yKzXGKOIvz9NEvo2XD6wYAzr5/Pj/a5HVo7egDKLgjpsLuiCuU+
         a3NLWdZQ+13qk3LkpNzbWXn7W7Vqha1lMp1b3ODLIynZtC685EtQ9pJuvYQPXchTWQ
         OoJCZONoESW4VeXShMOPGzJJdyFYL6nxpe1OMw+7soeW56HdkXZk1Q6/MLweeJvVPA
         uKuZmZF2kV9xA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 13 Jun 2023 21:17:43 +0100
Subject: [PATCH 2/3] regmap: Add a test case for write only registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-regmap-kunit-read-write-v1-2-2db337c52827@kernel.org>
References: <20230613-regmap-kunit-read-write-v1-0-2db337c52827@kernel.org>
In-Reply-To: <20230613-regmap-kunit-read-write-v1-0-2db337c52827@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WhDf+kiOS5aGuKfQUW/eJ+QBuABHGrCyRWVCjRn2dDA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkiM72N5yZTsPaXZCipx/1IPP5jFg2fekvhIb4EhIi
 TUR/LEqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIjO9gAKCRAk1otyXVSH0P9WB/
 93dMF8vQ5978ILOWs6dF215F8uwWjXb1gympEWm8GVV7VLqkzHMMZ+gJqcyWLKvCOkBLTEH9+oLSYV
 8ANTje7h6yLATbj7puUUSFpSX+wTb4Qr29lW+EbDUBjZlglV6LeyhjJpS0JqU367KQtuMCOmKjzeUG
 GhR8eVyfVGRVnd3L8T6gqWoS8usrjqd+fAMlUlTE404zEp9kAxXp7zKJ+rPE8b3ivuO77w7rKAwNb+
 WXf8oWy0d5EgBvOVvONVP2ZED5Hl9CQJ5JTUgAOStgZzrQByCFuZo++lcQrmnVuoP13ii76zuqSgPE
 YQtBkGy6TOOzZHRVZNegc7EguYulL/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate that attempts to read from write only registers fail and don't
somehow trigger spurious hardware accesses.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index f5c175022a47..a1a1a9ce2e13 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -231,6 +231,37 @@ static void write_readonly(struct kunit *test)
 	regmap_exit(map);
 }
 
+static void read_writeonly(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val;
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+	config.readable_reg = reg_5_false;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->read[i] = false;
+
+	/* Try to read all the registers, the writeonly one should fail */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, i != 5, regmap_read(map, i, &val) == 0);
+
+	/* Did we trigger a hardware access? */
+	KUNIT_EXPECT_FALSE(test, data->read[5]);
+
+	regmap_exit(map);
+}
+
 static void reg_defaults(struct kunit *test)
 {
 	struct regcache_types *t = (struct regcache_types *)test->param_value;
@@ -1078,6 +1109,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(bulk_write, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_read, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(write_readonly, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(read_writeonly, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(reg_defaults, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(reg_defaults_read_dev, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(register_patch, regcache_types_gen_params),

-- 
2.30.2

