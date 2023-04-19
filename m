Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713C46E8168
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDSSpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDSSpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:45:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C05940C6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A79D64002
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3575BC433EF;
        Wed, 19 Apr 2023 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681929941;
        bh=U44OvH5Ba58JqAqXvvAptgXEcVgFiFaDJocylAIsjEw=;
        h=From:Date:Subject:To:Cc:From;
        b=rrqPiMPa0m8jDWIt+4EzPhmtaJyahMqr3j0Z9eNMh6wKuHNgtZPhgrtmpvAcTxgZv
         b4AcGEgypFNRi9nLtCXRjRwWijS785hZZeZ9yyisgOzZ/n3Q6grlS8DVQ8Q5jyFftP
         N23UBew9w4rEGqiuCfljKP919DboANEGsw2L5ZKVyyGVpvSZJsJ1S6+jZreN66ls4K
         Wr+RTv4dErGt6yJ8IcNHpoczk/yX2vGW4U2xMi1UZm5Cp00/OiR7FeciyRL+y4YMYx
         aZvc1eGnqKOIPAh/qKiAG2y1jtQXdZRTSeGLKRuFFaxI7zLeJXfC8oebQA23I1dEVu
         BKVMj2MeOdKpw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 19 Apr 2023 19:45:06 +0100
Subject: [PATCH] ASoC: es8316: Don't use ranges based register lookup for a
 single register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-asoc-es8316-volatile-v1-1-2074ec93d8f1@kernel.org>
X-B4-Tracking: v=1; b=H4sIALE2QGQC/x2NywrCMBAAf6Xs2YU8tEZ/pXjYpqtdLIlkpS2U/
 rupxxkYZgPlIqxwbzYoPItKThXsqYE4UnoxylAZnHHenO0NSXNE1uBti3Oe6CsT48UEH0Mwrbs
 OUNOelLEvlOJ4xEsu70N/Cj9l/d+6x77/AM269It9AAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00e42
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=broonie@kernel.org;
 h=from:subject:message-id; bh=U44OvH5Ba58JqAqXvvAptgXEcVgFiFaDJocylAIsjEw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkQDbTBrzfPW8GLzUpQVLW+r1bLaSED4/APH3/R7KL
 Cd+7hCWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZEA20wAKCRAk1otyXVSH0L4RB/
 9RLomTJLcuU96AbE8AES8DrrDVdPC6WIdLv5PabHOI2Bl+nSmiKUCuHshMOkxWMck42uSoU/xKcTIo
 Mnz++ONSpPjkkyDpo5/4UG0pLdymyQPXSclEbWuyNTlzoNCv32uoh1ZQygUSurGpD7NnupqxNQ1Kt7
 2O7K+fQYzkumFb1IOf4aSHTwTlNNbJR86x7ma2qo2vyRTiI0G4KPCu8rdzpzppDryUY9laRvgx0arg
 4rXh5CpopOjuX8aG9Abv3cVKqOxHgtPjgJNh0tQ2CfyQ/ElCZUaCFMGFi3Q0RButADRM/wZKka8Qmy
 Jm5/GH+PXH9PCt1aUlC5TpqBiSY+19
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

The es8316 driver uses a register range to specify the single volatile
register it has. While the cost will be in the noise this is a bunch of
overhead compared to just having a volatile_reg() callback so switch to
the callback.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8316.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 056c3082fe02..1736a905abdb 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -803,14 +803,15 @@ static const struct snd_soc_component_driver soc_component_dev_es8316 = {
 	.endianness		= 1,
 };
 
-static const struct regmap_range es8316_volatile_ranges[] = {
-	regmap_reg_range(ES8316_GPIO_FLAG, ES8316_GPIO_FLAG),
-};
-
-static const struct regmap_access_table es8316_volatile_table = {
-	.yes_ranges	= es8316_volatile_ranges,
-	.n_yes_ranges	= ARRAY_SIZE(es8316_volatile_ranges),
-};
+static bool es8316_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ES8316_GPIO_FLAG:
+		return true;
+	default:
+		return false;
+	}
+}
 
 static const struct regmap_config es8316_regmap = {
 	.reg_bits = 8,
@@ -818,7 +819,7 @@ static const struct regmap_config es8316_regmap = {
 	.use_single_read = true,
 	.use_single_write = true,
 	.max_register = 0x53,
-	.volatile_table	= &es8316_volatile_table,
+	.volatile_reg = es8316_volatile_reg,
 	.cache_type = REGCACHE_RBTREE,
 };
 

---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230419-asoc-es8316-volatile-5083c880627d

Best regards,
-- 
Mark Brown <broonie@kernel.org>

