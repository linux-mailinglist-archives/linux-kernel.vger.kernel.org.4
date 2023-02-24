Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8331B6A1D39
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBXOIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjBXOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:07:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C769AEC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:07:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 853EA61844
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2061C4339C;
        Fri, 24 Feb 2023 14:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677247665;
        bh=tJW69WWMKlprOa5Xp3MSQu9gJosO9MCtIHdxPOTSeTM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=exI1HPiqonADtQ3JbWxYrA0MvmrGUJ5sDDyhhgai0FWcxboCZRDuUIN9TGWCn8104
         qHhSyUlgIZ5Oj3w6WRbc0L7gbUXFwRUemlpsSKCMj+W/i0+/Xew9NlBvV2FhT32G7G
         bVSBawb2n7XVXx01Pnun+OBBDIFvTcYq+Y4DyHwDDTh651L6T6s3FjaFUWvxHGAyZm
         QZXSbIcms4hzEkVPkuYb3Fk7EJoeNHlql3GBQCK7CnwVOjMR6dL6s6ZOb3hsKvG426
         dPuzGVEYhgx+fVPBl00LjM7RGxPcjNwRVNeRZUS5IrE8uckiZrDjYMpXfd0JxgUtI7
         oBdQkL2SN6uiw==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 24 Feb 2023 14:03:58 +0000
Subject: [PATCH 4/4] ASoC: mt8192: Fix range for sidetone positive gain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-asoc-mt8192-quick-fixes-v1-4-9a85f90368e1@kernel.org>
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tJW69WWMKlprOa5Xp3MSQu9gJosO9MCtIHdxPOTSeTM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj+MSj76AsGbh8BaFvHgyLdCRoaexzbW9BgLDoOgOC
 J6TdUxqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/jEowAKCRAk1otyXVSH0EaCB/
 9Hy8hUSJ7pct+oUw+uwv5aFtd39IiXzilcaerZgNl786hX0BWJ6gN4wMCsKSctPepdVVMzytQkF9cu
 gs5Rw3oo8vWL3QcSNuF/4kP/E1edK/fCedSR80cTmL9cxDyXXO+P8pbNcRMVeKsflgIUCNky5hlNzH
 vxcEJeKM3g9AP7axDa0k+dQGySwQZkE6SK6dFfoh0Bt2X9PgXB9HO6yul6rgkqC1sz8LmD/jAi1Rik
 ymG5hWRm1oOZ1/jcZT90v2D8WH7+5LeH+yhqlEjVKEOXE5Zs2M6bZs+6RuVOiX+q5gN9Mz+L+3+pCn
 1t2qHuh3soPr5qc6RDZ9JcSi6cwmvQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sidetone_Positive_Gain_dB control reports a range of 0..100 as valid
but the put() function rejects anything larger than 24. Fix this.

There are numerous other problems with this control, the name is very non
idiomatic and it should be a TLV, but it's ABI so probably we should leave
those alone.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
index a02a297c0450..4919535e2759 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
@@ -670,7 +670,7 @@ static int mt8192_adda6_only_set(struct snd_kcontrol *kcontrol,
 static const struct snd_kcontrol_new mtk_adda_controls[] = {
 	SOC_SINGLE("Sidetone_Gain", AFE_SIDETONE_GAIN,
 		   SIDE_TONE_GAIN_SFT, SIDE_TONE_GAIN_MASK, 0),
-	SOC_SINGLE_EXT("Sidetone_Positive_Gain_dB", SND_SOC_NOPM, 0, 100, 0,
+	SOC_SINGLE_EXT("Sidetone_Positive_Gain_dB", SND_SOC_NOPM, 0, 24, 0,
 		       stf_positive_gain_get, stf_positive_gain_set),
 	SOC_SINGLE("ADDA_DL_GAIN", AFE_ADDA_DL_SRC2_CON1,
 		   DL_2_GAIN_CTL_PRE_SFT, DL_2_GAIN_CTL_PRE_MASK, 0),

-- 
2.30.2

