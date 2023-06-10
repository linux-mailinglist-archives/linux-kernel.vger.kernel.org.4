Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED56372AC1B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjFJOGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjFJOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B83A96
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D33F612F3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766B0C433D2;
        Sat, 10 Jun 2023 14:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405960;
        bh=BCytfjaMmeBCddEcB7GoSbhAurC86JhfZMbj7EJid+E=;
        h=From:Date:Subject:To:Cc:From;
        b=E0vbBEBOGKeTGX09NfEhuqPCJ28K4Egcgdh1Qn5Ro+OX5i+nIbui0oXomQ8oesZIU
         w+fyJjw1T3DYmphlujf4Pk7vVkFYpp6N/052/zsYQQjEWObtPUEjh0f5c8BOJfi9QM
         QhCes3h0/dPbDK9dvAbFMePlqrPcvwy7JGLvf3OrPGN0zTBrbFeyuwqDrAeU/VZt/1
         P5QqDw9jc37D98ZkXpjptIe3mpYb4XvLFMApp9f5Wnsp4kbPTV+wSOSe3cZv0JUGPo
         yeN7+TdSkitmJOyWFQve1e8DrrU7Kc77VvUFj22gHqNGvuSmWx5ShS/Ag6V20KR+qx
         z/mxM3QX6mHCA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 15:05:54 +0100
Subject: [PATCH] regmap: Don't check for changes in regcache_set_val()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-regcache-set-val-no-ret-v1-1-9a6932760cf8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEKDhGQC/x2N0QrCMAwAf2Xk2UC3iqi/Ij5kMV2D0koypjD27
 3Y+3sFxK7iYisO1W8FkUddaGvSHDjhTmQT10RiGMMRwChc0mZg4C7rMuNALS21uxsh8jKmPZ0o
 ErR7JBUejwnnvP9Weu36bJP3+h7f7tv0AEkOOaIAAAAA=
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BCytfjaMmeBCddEcB7GoSbhAurC86JhfZMbj7EJid+E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhINGGU14EQGDpDnXk0qHOsvwLc0aIo1B8lchdyad
 yaaYmc2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISDRgAKCRAk1otyXVSH0OKsB/
 9hdc7wHKaEL0Btp60/8LLGhWcXUbX/xPLiRE2bLGjbvJllys/gZ6+OGLEkzpH0C0GP6qq3MTUNWRov
 zB5GL6Qe4KqA5k7mzm4zduJp2j9pXR/WlgVAK1osqBoDesDWM0uuql24Yjt9qySM/hpHAP84vR9Yqi
 F0VOwqW5ygNEe8rYHJYr4gcEmhbSflrv43BEZI6fx3luOoBXTnNfl4krW40/wGbvR4XR5GMZxur5Wg
 +28BViDI7M1CugrzEfikMm069Qf/qkdr9MmvyOHnmqtk6ZN2nCQnrgKxVK4QY/LjxEOnPBbaVWtkGV
 YK96pQZBBp0Wl+wgdgG0me4hgLcsJ3
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

The only user of regcache_set_val() ignores the return value so we may as
well not bother checking if the value we are trying to set is the same as
the value already stored.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/internal.h | 2 +-
 drivers/base/regmap/regcache.c | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 9bd0dfd1e259..8a0a5adbfb5e 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -267,7 +267,7 @@ static inline const void *regcache_get_val_addr(struct regmap *map,
 
 unsigned int regcache_get_val(struct regmap *map, const void *base,
 			      unsigned int idx);
-bool regcache_set_val(struct regmap *map, void *base, unsigned int idx,
+void regcache_set_val(struct regmap *map, void *base, unsigned int idx,
 		      unsigned int val);
 int regcache_lookup_reg(struct regmap *map, unsigned int reg);
 int regcache_sync_val(struct regmap *map, unsigned int reg, unsigned int val);
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 029564695dbb..3219ca4bd8d0 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -558,17 +558,14 @@ void regcache_cache_bypass(struct regmap *map, bool enable)
 }
 EXPORT_SYMBOL_GPL(regcache_cache_bypass);
 
-bool regcache_set_val(struct regmap *map, void *base, unsigned int idx,
+void regcache_set_val(struct regmap *map, void *base, unsigned int idx,
 		      unsigned int val)
 {
-	if (regcache_get_val(map, base, idx) == val)
-		return true;
-
 	/* Use device native format if possible */
 	if (map->format.format_val) {
 		map->format.format_val(base + (map->cache_word_size * idx),
 				       val, 0);
-		return false;
+		return;
 	}
 
 	switch (map->cache_word_size) {
@@ -601,7 +598,6 @@ bool regcache_set_val(struct regmap *map, void *base, unsigned int idx,
 	default:
 		BUG();
 	}
-	return false;
 }
 
 unsigned int regcache_get_val(struct regmap *map, const void *base,

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-regcache-set-val-no-ret-3cc43f138afa

Best regards,
-- 
Mark Brown <broonie@kernel.org>

