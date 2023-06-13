Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4572ECBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbjFMUSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbjFMUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB34A7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225C463AA3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFBBC433F2;
        Tue, 13 Jun 2023 20:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686687481;
        bh=VbxQM5rd9J1wfcJAjyGtGXRhnFYFWNB67/3Yu6cd5n0=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=O3RaT0cBLGNEsghEbmdNOiPflmBHxVUup3aXF12DDoUdgFMsai6zWeZMsOmE8Ygua
         hW6rEjUzwjkZCwn3dqj4DOUZ1XowH7wYEBAVg/jlk1OCI+fiA8W+N2Lntk1Dob6FzM
         ty5/DoSsVoGVEouMqiul5oDfou3Q4ibY1SyJdyA359U9rHBQ6fPa6qOrPgf43PJwfU
         AF00iBMLZLY5xnPNq0rnVKsy0WK55JBPWwhgrkVeghGvCD7P6Ga7eXytGmPg9sfNrZ
         sibc+lkLv7CYTrKzrxQPf5cXOezXLoVHSq5d4T2+bVPcY7YeuTv7XFq7/OO1UzT0IQ
         Iat18DOBcsoUA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 13 Jun 2023 21:17:42 +0100
Subject: [PATCH 1/3] regmap: Add test that writes to write only registers
 are prevented
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-regmap-kunit-read-write-v1-1-2db337c52827@kernel.org>
References: <20230613-regmap-kunit-read-write-v1-0-2db337c52827@kernel.org>
In-Reply-To: <20230613-regmap-kunit-read-write-v1-0-2db337c52827@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=2588; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VbxQM5rd9J1wfcJAjyGtGXRhnFYFWNB67/3Yu6cd5n0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkiM71k5/z/PsKtne40l8ZSIrWf0Kq1vEaCQAKb1ak
 xfu3J6uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIjO9QAKCRAk1otyXVSH0LFSB/
 4iu0f4qqsIhrOuvGt6DUhUAKTmra/A+1DL+Fit6e8ZD1P/ceTBCnh1U8juy5erurEdLtR61Rs3RzPT
 yvULzzyZmYQRs1zaNLSYuXgkWVIdQr7TZXbB1BeDKSap9iMy93r5NR3YCGpVnf8oWon3alB8gdvCRl
 d/RT6VCW+fI8U0U4NKAELKknuUFN+nPhy19JUwW9xCZP9q1CuhWTABcaUg3Scm7KBNUeglL8W2BHuZ
 aBUtjo+AFat/rNCpeTVZivTJSLNooJvHypK+DcvH4rOPZGIari6v+henpikkr2U+mcjaTV4We3TTUc
 s6NI4AGr4qOaW1Tsw4SY5OqVpsZXHU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should have error checking that verifies that writes to write only
registers are suppressed, verify that this happens as it should.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 4ec5cbfc0ca0..f5c175022a47 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -92,6 +92,11 @@ static struct regmap *gen_regmap(struct regmap_config *config,
 	return ret;
 }
 
+static bool reg_5_false(struct device *context, unsigned int reg)
+{
+	return reg != 5;
+}
+
 static void basic_read_write(struct kunit *test)
 {
 	struct regcache_types *t = (struct regcache_types *)test->param_value;
@@ -191,6 +196,41 @@ static void bulk_read(struct kunit *test)
 	regmap_exit(map);
 }
 
+static void write_readonly(struct kunit *test)
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
+	config.num_reg_defaults = BLOCK_TEST_SIZE;
+	config.writeable_reg = reg_5_false;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[i] = false;
+
+	/* Change the value of all registers, readonly should fail */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, i != 5, regmap_write(map, i, val) == 0);
+
+	/* Did that match what we see on the device? */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, i != 5, data->written[i]);
+
+	regmap_exit(map);
+}
+
 static void reg_defaults(struct kunit *test)
 {
 	struct regcache_types *t = (struct regcache_types *)test->param_value;
@@ -1037,6 +1077,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(basic_read_write, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_write, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_read, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(write_readonly, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(reg_defaults, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(reg_defaults_read_dev, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(register_patch, regcache_types_gen_params),

-- 
2.30.2

