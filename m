Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7588B72EC7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbjFMUH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjFMUHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEC61BE8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67BE761554
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1F0C433D9;
        Tue, 13 Jun 2023 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686686839;
        bh=cBzrkpEp4ssa1s3NzFCpArV7nF8Fv4V6npfoOqtTpFQ=;
        h=From:Date:Subject:To:Cc:From;
        b=jxX8Y/XuuLmoPqETf6kyvWegHhkrd9oKxJAY0IB33ftDOjcQkif8z8H7YsKIaIuGG
         rtL3eWjKloJpg/64Zl2n+V92gOlvbGxc/nSFZull1sypZ09yj/0kfz4hawSv6kk8Ef
         o0Ca9hLeLPr9zWboEAJhK+29nZUUm8PcrugYjpoy9BsqDhiJarXpJROrhZlXZ8ZRWD
         JdE3vwIbe4KtgUI0g4yV4uMIePgc2U+Rc3Tw/yTZshbmyicbX7BvHNWQdPTCbD7z0j
         OU1lyp6yINaHxjW8dON3LLpPrhJxgFdGPOFXdHH6Nf/GF8hznjRsmHtMdFLOa3stYR
         eR1KkA5ZNXKag==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 13 Jun 2023 21:07:16 +0100
Subject: [PATCH] regmap: Check for register readability before checking
 cache during read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-b4-regmap-check-readability-before-cache-v1-1-b144c0b01ed9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHPMiGQC/x2OywqDMBBFf0Wy7oAxVWx/pbiYjBMz2EaZlD4Q/
 72xy3MuHO5mMqtwNtdqM8ovybKkAvZUGYqYJgYZC5umblzdWQf+DMrTA1egyDQXwBG93OX5Bc9
 hUQbCMsEldG3vXI8tWVNyHjODV0wUj+B70fnQq3KQz//Bbdj3H4meuSiRAAAA
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cBzrkpEp4ssa1s3NzFCpArV7nF8Fv4V6npfoOqtTpFQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkiMx2Q1ZDGinfDW7oL7OUbC8y3p4UH2gOvcLAult3
 6nq+NsaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIjMdgAKCRAk1otyXVSH0GSyB/
 4iAasEhoHy5gno6PFoPqaH1wwZlDHzctTNDPwNuGWE6MkKYtf3WMh2xPgEvsPX159CJDD6YrFusacT
 umaipFoS/CKQJSm5RfLoowk9UA288y6px9MT5KTlENS1CIywkhg/N0qRz3N7qXb1f943NDfiH+iun4
 UdlQ8ztw47jI61/6zsIUvqsBSY3pAPg2Qar5/eKkeA2QE7lvcakNadyMuHUGy43MS+Lzv39BJvxDN8
 nR3uBITpNQ6iDXmr5M+hrTteJdUj0RP31iMeMS4EDdyv/hhdX9fRPLQQ4S7PU5nmQZqLX0L0vEGYG1
 TDT/j/K1PCLSY5AvTvvGdgMITTQVDV
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

Ensure that we don't return a spurious cache hit for unreadable registers
(eg, with the flat cache which doesn't understand sparseness) by checking
for readability before we do a cache lookup.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fa2d3fba6ac9..3efbe59ca1a7 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2897,6 +2897,9 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
 	int ret;
 	void *context = _regmap_map_get_context(map);
 
+	if (!regmap_readable(map, reg))
+		return -EIO;
+
 	if (!map->cache_bypass) {
 		ret = regcache_read(map, reg, val);
 		if (ret == 0)
@@ -2906,9 +2909,6 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
 	if (map->cache_only)
 		return -EBUSY;
 
-	if (!regmap_readable(map, reg))
-		return -EIO;
-
 	ret = map->reg_read(context, reg, val);
 	if (ret == 0) {
 		if (regmap_should_log(map))

---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230613-b4-regmap-check-readability-before-cache-9f658338a5c1

Best regards,
-- 
Mark Brown <broonie@kernel.org>

