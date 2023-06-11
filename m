Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ECE72B211
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjFKNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjFKNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B244122
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 06:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCEF0616A6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 13:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA1FC433EF;
        Sun, 11 Jun 2023 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686489918;
        bh=xPeJ6o7wutI/QhvigGbgtFZYPr0AiK21FcWdUhg4Dy8=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=mIndZqAjoUoRYZFild8wzfVnRFu7IlRjVHd99xlAS/FQW8w1/kQdh17ApLbbNuK/N
         Towsrub5mKAQ6eVXgskTbKJxxvIjjkyj/xHVQntFs2Vmr7KqSb7QUBZrRJ3lPCvawt
         SrMyxxTziZrTLnl9Z/2gxcMrQo5dmMQn/i7qv1NTX8PI5s8fZyWHvg/Oq/UcS1egUe
         a8zJlnWItnRGuB3T7KI+ahYQrBaeEWWa09YnW5eqnsIId/MckvlADwbVyBa3rZZLfr
         hbLCpzesf5lXk9EkWldj2n7aMDYkDHolIkO39/lB1Ft/8xZ+tK5HDRf71gWMxFqWi6
         G44cs+XxniXoA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 11 Jun 2023 14:25:03 +0100
Subject: [PATCH 2/2] regmap: Provide basic KUnit coverage for the raw
 register I/O
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230610-regcache-raw-kunit-v1-2-583112cd28ac@kernel.org>
References: <20230610-regcache-raw-kunit-v1-0-583112cd28ac@kernel.org>
In-Reply-To: <20230610-regcache-raw-kunit-v1-0-583112cd28ac@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=10475; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xPeJ6o7wutI/QhvigGbgtFZYPr0AiK21FcWdUhg4Dy8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhcs6Y3Ko/Zy4Hzv3txNA+JSXxP4J49gAEsF09GTl
 N3wQsAiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIXLOgAKCRAk1otyXVSH0LuQB/
 9mFBWWsM3SpNRrXhHaugTxtYIGn7SYOHHxLmyjaClQW3JqNFfM+wj5mqUZMcP+eV8hEYjvVplKBSPJ
 zY6OUmQ0GRVSMIQmvFwZ5wb25BmYPPikFIoEgGdYpFUgapK8k+EZpkWbcPjYIqG+1K4sBalJJa4kuB
 jMr0Jg+/cSMILdzb+zCRrncQdQ0qgG2A7L1qVKyYYo+gAQtIABDkBOListboNlZGsU1oa0cBXDZu1X
 kRbj8aueRilV6RFl5xxxahLMO3s/FyNARDfXsqBR+BC3z6QMV1or7iGRt0UUUUP3rVa1RWudMfk80a
 PI03yi0Ji/2AtwWc0F4YWou3t21gWb
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

Simple tests that cover basic raw I/O, plus basic coverage of cache sync
since the caches generate bulk I/O with raw register maps. This could be
more comprehensive but it is good for testing generic code.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 327 +++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index f76d41688134..4ec5cbfc0ca0 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -712,6 +712,327 @@ static void cache_drop(struct kunit *test)
 	regmap_exit(map);
 }
 
+struct raw_test_types {
+	const char *name;
+
+	enum regcache_type cache_type;
+	enum regmap_endian val_endian;
+};
+
+static void raw_to_desc(const struct raw_test_types *t, char *desc)
+{
+	strcpy(desc, t->name);
+}
+
+static const struct raw_test_types raw_types_list[] = {
+	{ "none-little",   REGCACHE_NONE,   REGMAP_ENDIAN_LITTLE },
+	{ "none-big",      REGCACHE_NONE,   REGMAP_ENDIAN_BIG },
+	{ "flat-little",   REGCACHE_FLAT,   REGMAP_ENDIAN_LITTLE },
+	{ "flat-big",      REGCACHE_FLAT,   REGMAP_ENDIAN_BIG },
+	{ "rbtree-little", REGCACHE_RBTREE, REGMAP_ENDIAN_LITTLE },
+	{ "rbtree-big",    REGCACHE_RBTREE, REGMAP_ENDIAN_BIG },
+	{ "maple-little",  REGCACHE_MAPLE,  REGMAP_ENDIAN_LITTLE },
+	{ "maple-big",     REGCACHE_MAPLE,  REGMAP_ENDIAN_BIG },
+};
+
+KUNIT_ARRAY_PARAM(raw_test_types, raw_types_list, raw_to_desc);
+
+static const struct raw_test_types raw_cache_types_list[] = {
+	{ "flat-little",   REGCACHE_FLAT,   REGMAP_ENDIAN_LITTLE },
+	{ "flat-big",      REGCACHE_FLAT,   REGMAP_ENDIAN_BIG },
+	{ "rbtree-little", REGCACHE_RBTREE, REGMAP_ENDIAN_LITTLE },
+	{ "rbtree-big",    REGCACHE_RBTREE, REGMAP_ENDIAN_BIG },
+	{ "maple-little",  REGCACHE_MAPLE,  REGMAP_ENDIAN_LITTLE },
+	{ "maple-big",     REGCACHE_MAPLE,  REGMAP_ENDIAN_BIG },
+};
+
+KUNIT_ARRAY_PARAM(raw_test_cache_types, raw_cache_types_list, raw_to_desc);
+
+static const struct regmap_config raw_regmap_config = {
+	.max_register = BLOCK_TEST_SIZE,
+
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.reg_bits = 16,
+	.val_bits = 16,
+};
+
+static struct regmap *gen_raw_regmap(struct regmap_config *config,
+				     struct raw_test_types *test_type,
+				     struct regmap_ram_data **data)
+{
+	u16 *buf;
+	struct regmap *ret;
+	size_t size = (config->max_register + 1) * config->reg_bits / 8;
+	int i;
+	struct reg_default *defaults;
+
+	config->cache_type = test_type->cache_type;
+	config->val_format_endian = test_type->val_endian;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	get_random_bytes(buf, size);
+
+	*data = kzalloc(sizeof(**data), GFP_KERNEL);
+	if (!(*data))
+		return ERR_PTR(-ENOMEM);
+	(*data)->vals = (void *)buf;
+
+	config->num_reg_defaults = config->max_register + 1;
+	defaults = kcalloc(config->num_reg_defaults,
+			   sizeof(struct reg_default),
+			   GFP_KERNEL);
+	if (!defaults)
+		return ERR_PTR(-ENOMEM);
+	config->reg_defaults = defaults;
+
+	for (i = 0; i < config->num_reg_defaults; i++) {
+		defaults[i].reg = i;
+		switch (test_type->val_endian) {
+		case REGMAP_ENDIAN_LITTLE:
+			defaults[i].def = le16_to_cpu(buf[i]);
+			break;
+		case REGMAP_ENDIAN_BIG:
+			defaults[i].def = be16_to_cpu(buf[i]);
+			break;
+		default:
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	/*
+	 * We use the defaults in the tests but they don't make sense
+	 * to the core if there's no cache.
+	 */
+	if (config->cache_type == REGCACHE_NONE)
+		config->num_reg_defaults = 0;
+
+	ret = regmap_init_raw_ram(config, *data);
+	if (IS_ERR(ret)) {
+		kfree(buf);
+		kfree(*data);
+	}
+
+	return ret;
+}
+
+static void raw_read_defaults_single(struct kunit *test)
+{
+	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int rval;
+	int i;
+
+	config = raw_regmap_config;
+
+	map = gen_raw_regmap(&config, t, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Check that we can read the defaults via the API */
+	for (i = 0; i < config.max_register + 1; i++) {
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &rval));
+		KUNIT_EXPECT_EQ(test, config.reg_defaults[i].def, rval);
+	}
+
+	regmap_exit(map);
+}
+
+static void raw_read_defaults(struct kunit *test)
+{
+	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	u16 *rval;
+	u16 def;
+	size_t val_len;
+	int i;
+
+	config = raw_regmap_config;
+
+	map = gen_raw_regmap(&config, t, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	val_len = sizeof(*rval) * (config.max_register + 1);
+	rval = kmalloc(val_len, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, rval != NULL);
+	if (!rval)
+		return;
+	
+	/* Check that we can read the defaults via the API */
+	KUNIT_EXPECT_EQ(test, 0, regmap_raw_read(map, 0, rval, val_len));
+	for (i = 0; i < config.max_register + 1; i++) {
+		def = config.reg_defaults[i].def;
+		if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
+			KUNIT_EXPECT_EQ(test, def, be16_to_cpu(rval[i]));
+		} else {
+			KUNIT_EXPECT_EQ(test, def, le16_to_cpu(rval[i]));
+		}
+	}
+	
+	kfree(rval);
+	regmap_exit(map);
+}
+
+static void raw_write_read_single(struct kunit *test)
+{
+	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	u16 val;
+	unsigned int rval;
+
+	config = raw_regmap_config;
+
+	map = gen_raw_regmap(&config, t, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* If we write a value to a register we can read it back */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, val));
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
+	KUNIT_EXPECT_EQ(test, val, rval);
+
+	regmap_exit(map);
+}
+
+static void raw_write(struct kunit *test)
+{
+	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	u16 *hw_buf;
+	u16 val[2];
+	unsigned int rval;
+	int i;
+
+	config = raw_regmap_config;
+
+	map = gen_raw_regmap(&config, t, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	hw_buf = (u16 *)data->vals;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* Do a raw write */
+	KUNIT_EXPECT_EQ(test, 0, regmap_raw_write(map, 2, val, sizeof(val)));
+
+	/* We should read back the new values, and defaults for the rest */
+	for (i = 0; i < config.max_register + 1; i++) {
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &rval));
+
+		switch (i) {
+		case 2:
+		case 3:
+			if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
+				KUNIT_EXPECT_EQ(test, rval,
+						be16_to_cpu(val[i % 2]));
+			} else {
+				KUNIT_EXPECT_EQ(test, rval,
+						le16_to_cpu(val[i % 2]));
+			}
+			break;
+		default:
+			KUNIT_EXPECT_EQ(test, config.reg_defaults[i].def, rval);
+			break;
+		}
+	}
+
+	/* The values should appear in the "hardware" */
+	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], val, sizeof(val));
+
+	regmap_exit(map);
+}
+
+static void raw_sync(struct kunit *test)
+{
+	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	u16 val[2];
+	u16 *hw_buf;
+	unsigned int rval;
+	int i;
+
+	config = raw_regmap_config;
+
+	map = gen_raw_regmap(&config, t, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	hw_buf = (u16 *)data->vals;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* Do a regular write and a raw write in cache only mode */
+	regcache_cache_only(map, true);
+	KUNIT_EXPECT_EQ(test, 0, regmap_raw_write(map, 2, val, sizeof(val)));
+	if (config.val_format_endian == REGMAP_ENDIAN_BIG)
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 6,
+						      be16_to_cpu(val[0])));
+	else
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 6,
+						      le16_to_cpu(val[0])));
+
+	/* We should read back the new values, and defaults for the rest */
+	for (i = 0; i < config.max_register + 1; i++) {
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &rval));
+
+		switch (i) {
+		case 2:
+		case 3:
+		case 6:
+			if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
+				KUNIT_EXPECT_EQ(test, rval,
+						be16_to_cpu(val[i % 2]));
+			} else {
+				KUNIT_EXPECT_EQ(test, rval,
+						le16_to_cpu(val[i % 2]));
+			}
+			break;
+		default:
+			KUNIT_EXPECT_EQ(test, config.reg_defaults[i].def, rval);
+			break;
+		}
+	}
+	
+	/* The values should not appear in the "hardware" */
+	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], val, sizeof(val));
+	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[6], val, sizeof(u16));
+
+	for (i = 0; i < config.max_register + 1; i++)
+		data->written[i] = false;
+
+	/* Do the sync */
+	regcache_cache_only(map, false);
+	regcache_mark_dirty(map);
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+
+	/* The values should now appear in the "hardware" */
+	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], val, sizeof(val));
+	KUNIT_EXPECT_MEMEQ(test, &hw_buf[6], val, sizeof(u16));
+
+	regmap_exit(map);
+}
+
 static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(basic_read_write, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_write, regcache_types_gen_params),
@@ -727,6 +1048,12 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(cache_sync_defaults, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_sync_patch, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop, sparse_cache_types_gen_params),
+
+	KUNIT_CASE_PARAM(raw_read_defaults_single, raw_test_types_gen_params),
+	KUNIT_CASE_PARAM(raw_read_defaults, raw_test_types_gen_params),
+	KUNIT_CASE_PARAM(raw_write_read_single, raw_test_types_gen_params),
+	KUNIT_CASE_PARAM(raw_write, raw_test_types_gen_params),
+	KUNIT_CASE_PARAM(raw_sync, raw_test_cache_types_gen_params),
 	{}
 };
 

-- 
2.30.2

