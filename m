Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE572ECBF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbjFMUSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbjFMUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF61BC3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DE7863AAA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1359C433F0;
        Tue, 13 Jun 2023 20:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686687483;
        bh=HlCWEB0TkEMXgL7Np/AcOk7D/BltZYu6dtcLIzNuEH8=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=W2Wh8raVaRTIke7QaMgKW7bb/TlwBeupOGPXV/sst1O/Fjm0NsrY2ECkzyGFhVj3q
         aYy2xUjYidhYiH7CHSfsSpzygHfGwOPYU/X6RT0jdMFlJrrI6E26oh5Ts+THO2/Z8h
         icBIxMeG/dz5f6/1uvqzUCCnKmKcv8A18Bd0rZCBAKPHvDULTt125fB9hCsqVIurUj
         aDJ15UzDb2Y5gSkFVORxn7u2B64SaSKw/uFCnqsZL5Aa2/uqIbQL8f4kbEse5ODqsN
         JGcmSq+6zdvSdfGHzvPtEUz2XPjXijGxVCFQaKvYNdNfmZDxT2eyJNvj25hJ/lLqW0
         DtznZ1ZiWuNsQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 13 Jun 2023 21:17:44 +0100
Subject: [PATCH 3/3] regmap: Add test to make sure we don't sync to read
 only registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-regmap-kunit-read-write-v1-3-2db337c52827@kernel.org>
References: <20230613-regmap-kunit-read-write-v1-0-2db337c52827@kernel.org>
In-Reply-To: <20230613-regmap-kunit-read-write-v1-0-2db337c52827@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HlCWEB0TkEMXgL7Np/AcOk7D/BltZYu6dtcLIzNuEH8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkiM73rne9moWjQQWpOFaUabAmBps1dMoW4LJ/Aprh
 5A+gDZ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIjO9wAKCRAk1otyXVSH0EKaB/
 9AygOvQGpuQY6j90FmJVeAy7sfgIMqlOHvl/lg5R3X+gvmWiAuANDXJohhJxr1Gti8iuiBHHx9gvWW
 +2YDu2Hlgp/RVoFM/ER68PharDYmySsBnrfNDE1djHtM7iss9G6ShaqoV6+CXqVTOXfq4zTp/bHCWq
 YY+S2uhuKgIc8Y0JmUMynnjh4KRZHOTw+NSS8aX9e36kbNXMPwugQQs+rjShjJCdYKWH2pr+uQcYgv
 HrNaUN96HHcL1Qlb2OeCLe6vs85DbehaPSSrUj62eEkqcah3P+Wlbl2wwYwoA20hHQzWa1hiCzol1U
 cA2oL9t6tyGLOyUREW7z02g+CxwSTE
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

Ensure that a read only value in the register cache does not result in a
write during regcache_sync().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index a1a1a9ce2e13..6f444ac0ec49 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -680,6 +680,47 @@ static void cache_sync_defaults(struct kunit *test)
 	regmap_exit(map);
 }
 
+static void cache_sync_readonly(struct kunit *test)
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
+	config.writeable_reg = reg_5_false;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Read all registers to fill the cache */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &val));
+
+	/* Change the value of all registers, readonly should fail */
+	get_random_bytes(&val, sizeof(val));
+	regcache_cache_only(map, true);
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, i != 5, regmap_write(map, i, val) == 0);
+	regcache_cache_only(map, false);
+
+	/* Resync */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[i] = false;
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+
+	/* Did that match what we see on the device? */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, i != 5, data->written[i]);
+
+	regmap_exit(map);
+}
+
 static void cache_sync_patch(struct kunit *test)
 {
 	struct regcache_types *t = (struct regcache_types *)test->param_value;
@@ -1119,6 +1160,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(cache_bypass, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_sync, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_sync_defaults, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_sync_readonly, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_sync_patch, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop, sparse_cache_types_gen_params),
 

-- 
2.30.2

