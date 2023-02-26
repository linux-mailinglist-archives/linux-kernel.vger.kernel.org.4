Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E496A2F78
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBZMuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBZMuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51482C172
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1469B80B9B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 12:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB669C4339E;
        Sun, 26 Feb 2023 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677415816;
        bh=JEDiIUtaX6g3tzXr94u0tVLuH331wW8Kksrsq52VVaw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KJDl+HGre8yXeUx2qaDrDi2wZvNZ2dIYmMUG1rcPYUNvYuSzehbaEh/fOnI5/IWNt
         qd1XCLGO/mvCyeWMu1+YPB2h/n2SjS7KNu0prq0VQ2EGUQies2if/laQpoMK/VkfKL
         4als1i4T3HaS4Bea6b8FXV9R2FwynDxiowMh3L6MB3lPDDKvAAvuzCDb3nGvQg2wSj
         9GGiOKXHVtZs8jFhn9qG5MEyLb16B5OpWUmpd7vSCZBIIqzR/A/rraz2ujnZt2DyfU
         nVcL9+iBGAPKuELGEKic7vJlBeqQU2b1VqRtpsyU3xHkJwgyI8FGVG9n/xJiCtBtUp
         XY3gaYU+0A8TQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 26 Feb 2023 12:49:57 +0000
Subject: [PATCH 2/2] ASoC: mt8183: Fix event generation for I2S DAI
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-asoc-mt8183-quick-fixes-v1-2-041f29419ed5@kernel.org>
References: <20230224-asoc-mt8183-quick-fixes-v1-0-041f29419ed5@kernel.org>
In-Reply-To: <20230224-asoc-mt8183-quick-fixes-v1-0-041f29419ed5@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JEDiIUtaX6g3tzXr94u0tVLuH331wW8Kksrsq52VVaw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj+1WAnugavWTX+9Hg/IvfRmt51ua6j+yicn0pEbPH
 asQEgkeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/tVgAAKCRAk1otyXVSH0CYYB/
 0YSxCulCFXlrJOmzm6bM8diam+8P0CaA2QdRk+4WzbchuF3GPtZYVkpLATCYcFkge0COsUx4/f25Ng
 DEm6IaKvDx3uPBKT6F2o2utQBxHYPzaotQ0l6AzJ/CakQC+7h0FKRcwjK5yEWYGT0Y4LoVeZStSKfu
 rvLgBlDdRsXMEDGzXAhDzzpuU9y22LBshUeP/DQZnhpzYxFtUOlvCA+Xzavgn7FpA9Wxeut5Ztpq3f
 xsAVW6NAEr6b4xUwsgMfUazDH6Hh2dwnDuj9DzhaVKP+QLRrMZeKKBNHRjjCE/RTJRSODi+FkaI/nE
 4tr+kl9q1aYhrH7pGqFNzIEqt7tVnq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALSA control put() operations should return 0 if the value changed so that
events can be generated appropriately for userspace but the custom control
in the MT8183 I2S DAI driver doesn't do that, fix it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
index 38f7fa38ee95..8645ab686970 100644
--- a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
@@ -141,7 +141,7 @@ static int mt8183_i2s_hd_set(struct snd_kcontrol *kcontrol,
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
 	struct mtk_afe_i2s_priv *i2s_priv;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	int hd_en;
+	int hd_en, change;
 
 	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
@@ -155,9 +155,10 @@ static int mt8183_i2s_hd_set(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 	}
 
+	change = i2s_priv->low_jitter_en != hd_en;
 	i2s_priv->low_jitter_en = hd_en;
 
-	return 0;
+	return change;
 }
 
 static const struct snd_kcontrol_new mtk_dai_i2s_controls[] = {

-- 
2.30.2

