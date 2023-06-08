Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F87276A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjFHF1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFHF1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:27:32 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FACF26B5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 22:27:29 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 78BAqQV8E5y9n78BAqmbdj; Thu, 08 Jun 2023 07:27:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686202046;
        bh=NC7exZWD31sFeAwipTt4OgnGAif/dXKMSn2/zIDOEiQ=;
        h=From:To:Cc:Subject:Date;
        b=Lg2L8LSFWbJeuTvjlyjI7VHKdR4+wJ2HclIeWo3/25PD6YibOWY2yYSUShhHI1oWf
         sa8/rcyF2vvXwO7SzG8DxnsSyf6H/GhxIN2SA10AsHw5b8W517fKLASoy0REEGghXt
         NqBs3z5eXSIsEnKjA3O7cGa9Eg4wT5a/FW8b1P6qF87R7dTPE6EmCf1E/xEvjEFglQ
         wCUwwY8oP6iBpl4s8SCWBRfW5f3jIo72jTdCW5ToXjY7tun/qA8co4TvDA8eYRvYsD
         vilvFZG9NqFNXK2ijn8QKcUsmFogds4Lc3VXEIfvhq+6lBYJMU50Y2QRHmrrZVngqX
         O8hBytCNDkVHg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Jun 2023 07:27:26 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
Subject: [PATCH] ASoC: tegra: Simplify code around clk_get_rate() handling
Date:   Thu,  8 Jun 2023 07:27:22 +0200
Message-Id: <53f928290f08f50ff43031e17fe1d88443c2c441.1686202022.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_get_rate() returns an unsigned long, so there is no point in storing it
in a long, and test for negative values.

So, turn 'parent_rate' into an unsigned long, simplify the sanity check,
the error message and the return value, in case of error (i.e. 0).

Doing so also turns 'i' and 'valid_rates' into unsigned long, but it is
fine and harmless.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/tegra/tegra20_i2s.c   | 9 ++++-----
 sound/soc/tegra/tegra20_spdif.c | 9 ++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index e1a0f50969c1..d38b58305c6b 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -273,13 +273,12 @@ static int tegra20_i2s_filter_rates(struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai = rule->private;
 	struct tegra20_i2s *i2s = dev_get_drvdata(dai->dev);
 	struct clk *parent = clk_get_parent(i2s->clk_i2s);
-	long i, parent_rate, valid_rates = 0;
+	unsigned long i, parent_rate, valid_rates = 0;
 
 	parent_rate = clk_get_rate(parent);
-	if (parent_rate <= 0) {
-		dev_err(dai->dev, "Can't get parent clock rate: %ld\n",
-			parent_rate);
-		return parent_rate ?: -EINVAL;
+	if (!parent_rate) {
+		dev_err(dai->dev, "Can't get parent clock rate\n");
+		return -EINVAL;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tegra20_i2s_rates); i++) {
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 86bef54dfdf2..d034803695a0 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -187,13 +187,12 @@ static int tegra20_spdif_filter_rates(struct snd_pcm_hw_params *params,
 	struct tegra20_spdif *spdif = dev_get_drvdata(dai->dev);
 	struct clk *parent = clk_get_parent(spdif->clk_spdif_out);
 	static const unsigned int rates[] = { 32000, 44100, 48000 };
-	long i, parent_rate, valid_rates = 0;
+	unsigned long i, parent_rate, valid_rates = 0;
 
 	parent_rate = clk_get_rate(parent);
-	if (parent_rate <= 0) {
-		dev_err(dai->dev, "Can't get parent clock rate: %ld\n",
-			parent_rate);
-		return parent_rate ?: -EINVAL;
+	if (!parent_rate) {
+		dev_err(dai->dev, "Can't get parent clock rate\n");
+		return -EINVAL;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(rates); i++) {
-- 
2.34.1

