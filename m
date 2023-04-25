Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8636EE68C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjDYRXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjDYRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72177D303
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E87616CC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8FAC433D2;
        Tue, 25 Apr 2023 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682443372;
        bh=VKteOqI+tR4jwGiz0s3/Zl8oDW+YNdx9hzGF1XdHEMo=;
        h=From:Date:Subject:To:Cc:From;
        b=CIeHLNXwrtuZP1fk/mP2JVFX8QiAzb9EH8/FBc5VSnL0x3alVZ26UH1jmp+vrrYd7
         BHl60ppi3SsDTAL4oaRPenV6JvwC7N6ypwijCcmDRnPHGufj4N7i+5YSfqfKzOIRPb
         a6xH1zGfQoXSymyg940vzVk3Rn18gp0HKZLtRVqoTuNAzPh8kQ/buhwfiB8bCCEtjg
         ju6qyVAv1bdlc1f3Q6bUn6Qb6r0JoOceNMNZpqqPAD/Z8Qglq/mG/YkvjF3kYCq/7B
         PnTTLtz2m0Ez5snW6A9Sjnf4Nk/bgoZdwubJIw/vZvsUzWSbQFLT2V4x81bg83+G2A
         72VYxsKeJPoLw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 25 Apr 2023 18:22:46 +0100
Subject: [PATCH] ASoC: rt5682: Use a maple tree based register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-asoc-rt5682-maple-v1-1-ed40369c9099@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGUMSGQC/x2N0QrCMAwAf2Xk2UBb57T+yvAh66ILajsSUWHs3
 +18vIPjFjBWYYNzs4DyW0xKruB3DaSJ8o1RxsoQXNi71kckKwn1dehOAZ80PxiPI7nOxegTtVC
 7gYxxUMpp2spP0fumZ+WrfP+r/rKuP/A3VeB6AAAA
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00e42
X-Developer-Signature: v=1; a=openpgp-sha256; l=2318; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VKteOqI+tR4jwGiz0s3/Zl8oDW+YNdx9hzGF1XdHEMo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkSAxp2sZLL3hFa9KQamIgB5LVBhsaT19TwxKWmCMD
 E8FCPLiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZEgMaQAKCRAk1otyXVSH0EvYB/
 9/ZvgAOmb7RxPtTXmPAUyzGqnIhe1YiWSDe9ry8PqS9V7VZiMLecrPa8CkpyTNoZtR7CVaPtYytWDb
 vx/9GJhs4Ua9/zOHn7EnT6Kikg9H8TE7n1rnVU34v2JfiErArIEmS8533sHpSBjIZmIb2h/b4+EJyK
 UhEiCEeSPeVKzm63FP3iYRt/JP4rEmVkpaFyLwC5zLjKlAxq+LUa5LhAOWJzSAJaP7iTLNFu8lOwI/
 t7R3yMY8nu7nPiq1R8wdGqGy3N6tLvc2iV4E2j0cxhTEb2haqkddl9pVgBMqo8X3BTg9p+2soikPdk
 Emn+XqqCZlUNtGQBKUbpcniduOQO8V
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap has introduced a maple tree based register cache which makes use of
this more advanced data structure which has been added to the kernel
recently. Maple trees are much flatter than rbtrees, meaning that they do
not grow to such depths when the register map is sparse which makes access
a bit more efficient. The maple tree cache type is still a bit of a work
in progress but should be effective for some devices already.

RT5682 seems like a good candidate for maple tree. It only supports single
register read/write operations so will gain minimal benefit from storing
the register data in device native format like rbtree does (none for
SoundWire) and has some sparsity in the register map which is a good fit
for maple tree.

Convert to use maple tree. There should be little if any visible difference
at runtime.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682-sdw.c | 2 +-
 sound/soc/codecs/rt5682s.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 5f80a5d59b65..fb7951f11c92 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -79,7 +79,7 @@ static const struct regmap_config rt5682_sdw_indirect_regmap = {
 	.max_register = RT5682_I2C_MODE,
 	.volatile_reg = rt5682_volatile_register,
 	.readable_reg = rt5682_readable_register,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = rt5682_reg,
 	.num_reg_defaults = RT5682_REG_NUM,
 	.use_single_read = true,
diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 9c34dca58f54..36102fa2b806 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -3046,7 +3046,7 @@ static const struct regmap_config rt5682s_regmap = {
 	.max_register = RT5682S_MAX_REG,
 	.volatile_reg = rt5682s_volatile_register,
 	.readable_reg = rt5682s_readable_register,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = rt5682s_reg,
 	.num_reg_defaults = ARRAY_SIZE(rt5682s_reg),
 	.use_single_read = true,

---
base-commit: 4a670ac3e75e517c96cbd01ef870dbd598c3ce71
change-id: 20230419-asoc-rt5682-maple-7da060991ca4

Best regards,
-- 
Mark Brown <broonie@kernel.org>

