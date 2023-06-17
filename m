Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A401734372
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346231AbjFQULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjFQULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A2199
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63D9B60F35
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 20:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11E6C433C8;
        Sat, 17 Jun 2023 20:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687032674;
        bh=KeCDSnau7JN7yi2nxNFuESkrgba7CPG9SkuWocLpywE=;
        h=From:Date:Subject:To:Cc:From;
        b=givozWZ6jfMDklbBNHoqOLaEGSKqw4NJnWxCKSG3GMs0n9Pjt6xnV3U1F38uvVABm
         1sFD+sANNXgTZmb77u6jE1Jl2DmROT+mVIoVhQXskUaYPGjUSa8GuYtQvVxkS2G4Qe
         +o5sw44sOgLycTqqXIP7oM4iIeI/C8bXN+K1SJjpr9rUTtP8UbNw1ZlSf/DdrxjpBN
         wkag/J9Hj/Li6v2rHvfiV4ma23SbcOHH5CHWV+dF+eYHFvfTKT/GHPTsPX2hnnTfEm
         gLMY5OREZoeJc/ERWTAv9MWsmmSYhh/vk74iKNpgJnTuJtj1GG2dss4rdY5KmKhWjN
         85PISu78tJVeQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 17 Jun 2023 21:11:07 +0100
Subject: [PATCH] regmap: Allow reads from write only registers with the
 flat cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230617-regmap-kunit-read-writeonly-flat-v1-1-efd3ed66dec6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFoTjmQC/y2Nyw6CMBBFf4XM2jGlIKK/YlwMdICJWMi0vkL4d
 4txeXJyz10gsAoHOGcLKD8lyOQT5LsM2oF8zyguMVhjC1PlR1Tu7zTj7eElJiCHL5XIkx8/2I0
 U0RWlZXMqa64tpExDgbFR8u2whf77an/Y5Kzcyfv3f7mu6xf/0KLsjwAAAA==
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KeCDSnau7JN7yi2nxNFuESkrgba7CPG9SkuWocLpywE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkjhNf3lKjjCbgeP2mnU6XtPhAMWrk/9ts8OBvn
 SBEfIMemc+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZI4TXwAKCRAk1otyXVSH
 0MNcB/9fk5Yt2sj94uQhfJQLfuzH4mwM5LPGCmOnoae9Gvip0KuQz6iXkZEdd9VVQtO8RunqlFS
 l2VlhmVRMNVc5gahELjXtn142MalOBM3GWUi9jlaA8XhHGVRtcxB73+CVVjq3cf9auIhDSZ3tab
 9bBwpepXK3Eka3jfYidsYyYk7g4Np/rBLRxOpnCsYjh7jLFQ8KhTftoBxIc+p0MO5bfy0/FPjDu
 50cvtgTG3Gimf8frI15VBHmN9Pbf1tcKTfcsfP8+7h+7TmfVa1ehtzqYEm/pYCNrFYgtzSXiCMa
 L/7e+OGVwGBkZoBHdBwsrwMCXt6VyTD8ftURx4sVaJ/YGgPs
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

The flat cache is intended for devices that need the lowest overhead so
doesn't track any sparseness.

Signed-off-by: Mark Brown <broonie@kernel.org>
---


Signed-off-by: Mark Brown,,, <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 6f444ac0ec49..24257aa9004d 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -252,9 +252,18 @@ static void read_writeonly(struct kunit *test)
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		data->read[i] = false;
 
-	/* Try to read all the registers, the writeonly one should fail */
-	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, i != 5, regmap_read(map, i, &val) == 0);
+	/*
+	 * Try to read all the registers, the writeonly one should
+	 * fail if we aren't using the flat cache.
+	 */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
+		if (t->type != REGCACHE_FLAT) {
+			KUNIT_EXPECT_EQ(test, i != 5,
+					regmap_read(map, i, &val) == 0);
+		} else {
+			KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &val));
+		}
+	}
 
 	/* Did we trigger a hardware access? */
 	KUNIT_EXPECT_FALSE(test, data->read[5]);

---
base-commit: 3e47b8877d6c0f60943b00f3112756ca3b572cd6
change-id: 20230617-regmap-kunit-read-writeonly-flat-d342e0948e82

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>

