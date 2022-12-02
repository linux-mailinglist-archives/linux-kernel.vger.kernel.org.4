Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA4A640BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiLBRO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiLBROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:14:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E73E074B;
        Fri,  2 Dec 2022 09:14:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m14so8764889wrh.7;
        Fri, 02 Dec 2022 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8v9XTf3vXMWdEj7JPZSNyX2wl94/lt81sDZmVmnAZk=;
        b=REs7QLBqW5J5VrEbzEthHZE1wfZSrK3cW5zRoKBqN3bvl3pN/pCfDR+um1uJkzTC/4
         JP9Dm4H+19RXZnkU+om7Nn9lCfBSX27Iae2tITdSutf8C/usQe5SB7bN+p5H5mZePrz6
         xndHgU5Igr91sHK3NScswZ91dHpRQWOKaTVtWu0aVehvkf3z0jVrCHSTPeoDmyD1mXOg
         s5/jy3ze5ZJtuLi2dMj61QW6WtkG+PjeOLTtMjLv/dplZiuw7apog/3pgaruv+HnkuB5
         rJJJN7yYn/kiuaZsCf45/24G4dGrrZJpFF0sGgAGNUunAwBd4ZAEIwHyGUnNveDJTBoy
         k4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8v9XTf3vXMWdEj7JPZSNyX2wl94/lt81sDZmVmnAZk=;
        b=VFz5qyAVhmIDE+9vZZjOi4rzFB6fIB1KAQJimDIEkc2EMX5KsFup7AwIJoP2LPKRmP
         fXreVc6MkGKZFmjdCEkWRRptkLUcwsPVZfwvrWLKnCW3rtCEpZdXxAYmXA2amStk7f+G
         t6LZ/HvXiwZFS1Z2rAMs9xicmYwKpg2okm7MD0ZifGDe6mrPwFEcLLJBJ7hmZMf1yCTq
         S2RfodKcXVVHellT2e/CkEhEHkitXXIo/HoZzTLL2SkAAB1W+m3FQq6Y3raKQFyqvMux
         9460/QHqKIoHKtTPPoGeUe7Cj8GjNUUNzRT4gcQUUovadQ61nMlpsPxqfK34Pz+XtBLU
         BF8Q==
X-Gm-Message-State: ANoB5pmNj/NHf/UwELLXNV4NG2gwNOoEEn/V/ndibFngbKxXmDeF1Wwd
        V/kBwoz0ihSzEdH/9uPcXPA=
X-Google-Smtp-Source: AA0mqf7V00hqex6XhkoCKa3wTyxa3SNkDDr8CfdyWdN/p7w47wrcrprI66nTe6Gqv77wmWQs7pXSBA==
X-Received: by 2002:adf:f54d:0:b0:242:9e6:ea4d with SMTP id j13-20020adff54d000000b0024209e6ea4dmr20929160wrp.251.1670001292663;
        Fri, 02 Dec 2022 09:14:52 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k12-20020adfe8cc000000b00241b5af8697sm7651532wrn.85.2022.12.02.09.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:14:51 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: rt715: Make read-only arrays capture_reg_H and capture_reg_L static const
Date:   Fri,  2 Dec 2022 17:14:50 +0000
Message-Id: <20221202171450.1815346-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only arrays capture_reg_H and capture_reg_L
on the stack but instead make them static const. Also makes the
object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/rt715.c | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 917a04092da2..1a2036ccfbac 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -204,12 +204,12 @@ static int rt715_set_main_switch_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(component);
 	struct rt715_priv *rt715 = snd_soc_component_get_drvdata(component);
-	unsigned int capture_reg_H[] = {RT715_SET_GAIN_MIC_ADC_H,
-		RT715_SET_GAIN_LINE_ADC_H, RT715_SET_GAIN_MIX_ADC_H,
-		RT715_SET_GAIN_MIX_ADC2_H};
-	unsigned int capture_reg_L[] = {RT715_SET_GAIN_MIC_ADC_L,
-		RT715_SET_GAIN_LINE_ADC_L, RT715_SET_GAIN_MIX_ADC_L,
-		RT715_SET_GAIN_MIX_ADC2_L};
+	static const unsigned int capture_reg_H[] = {
+		RT715_SET_GAIN_MIC_ADC_H, RT715_SET_GAIN_LINE_ADC_H,
+		RT715_SET_GAIN_MIX_ADC_H, RT715_SET_GAIN_MIX_ADC2_H };
+	static const unsigned int capture_reg_L[] = {
+		RT715_SET_GAIN_MIC_ADC_L, RT715_SET_GAIN_LINE_ADC_L,
+		RT715_SET_GAIN_MIX_ADC_L, RT715_SET_GAIN_MIX_ADC2_L };
 	unsigned int addr_h, addr_l, val_h = 0x0, val_ll, val_lr;
 	unsigned int k_shift = RT715_DIR_IN_SFT, k_changed = 0;
 	unsigned int read_ll, read_rl, i, j, loop_cnt = 4;
@@ -284,12 +284,12 @@ static int rt715_set_main_switch_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt715_priv *rt715 = snd_soc_component_get_drvdata(component);
-	unsigned int capture_reg_H[] = {RT715_SET_GAIN_MIC_ADC_H,
-		RT715_SET_GAIN_LINE_ADC_H, RT715_SET_GAIN_MIX_ADC_H,
-		RT715_SET_GAIN_MIX_ADC2_H};
-	unsigned int capture_reg_L[] = {RT715_SET_GAIN_MIC_ADC_L,
-		RT715_SET_GAIN_LINE_ADC_L, RT715_SET_GAIN_MIX_ADC_L,
-		RT715_SET_GAIN_MIX_ADC2_L};
+	static const unsigned int capture_reg_H[] = {
+		RT715_SET_GAIN_MIC_ADC_H, RT715_SET_GAIN_LINE_ADC_H,
+		RT715_SET_GAIN_MIX_ADC_H, RT715_SET_GAIN_MIX_ADC2_H };
+	static const unsigned int capture_reg_L[] = {
+		RT715_SET_GAIN_MIC_ADC_L, RT715_SET_GAIN_LINE_ADC_L,
+		RT715_SET_GAIN_MIX_ADC_L, RT715_SET_GAIN_MIX_ADC2_L };
 	unsigned int addr_h, addr_l, val_h = 0x0, i, loop_cnt = 4;
 	unsigned int read_ll, read_rl;
 
@@ -312,12 +312,12 @@ static int rt715_set_main_vol_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(component);
 	struct rt715_priv *rt715 = snd_soc_component_get_drvdata(component);
-	unsigned int capture_reg_H[] = {RT715_SET_GAIN_MIC_ADC_H,
-		RT715_SET_GAIN_LINE_ADC_H, RT715_SET_GAIN_MIX_ADC_H,
-		RT715_SET_GAIN_MIX_ADC2_H};
-	unsigned int capture_reg_L[] = {RT715_SET_GAIN_MIC_ADC_L,
-		RT715_SET_GAIN_LINE_ADC_L, RT715_SET_GAIN_MIX_ADC_L,
-		RT715_SET_GAIN_MIX_ADC2_L};
+	static const unsigned int capture_reg_H[] = {
+		RT715_SET_GAIN_MIC_ADC_H, RT715_SET_GAIN_LINE_ADC_H,
+		RT715_SET_GAIN_MIX_ADC_H, RT715_SET_GAIN_MIX_ADC2_H };
+	static const unsigned int capture_reg_L[] = {
+		RT715_SET_GAIN_MIC_ADC_L, RT715_SET_GAIN_LINE_ADC_L,
+		RT715_SET_GAIN_MIX_ADC_L, RT715_SET_GAIN_MIX_ADC2_L};
 	unsigned int addr_h, addr_l, val_h = 0x0, val_ll, val_lr;
 	unsigned int read_ll, read_rl, i, j, loop_cnt = 4, k_changed = 0;
 	unsigned int k_shift = RT715_DIR_IN_SFT, k_max = 0x3f;
@@ -393,12 +393,12 @@ static int rt715_set_main_vol_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt715_priv *rt715 = snd_soc_component_get_drvdata(component);
-	unsigned int capture_reg_H[] = {RT715_SET_GAIN_MIC_ADC_H,
-		RT715_SET_GAIN_LINE_ADC_H, RT715_SET_GAIN_MIX_ADC_H,
-		RT715_SET_GAIN_MIX_ADC2_H};
-	unsigned int capture_reg_L[] = {RT715_SET_GAIN_MIC_ADC_L,
-		RT715_SET_GAIN_LINE_ADC_L, RT715_SET_GAIN_MIX_ADC_L,
-		RT715_SET_GAIN_MIX_ADC2_L};
+	static const unsigned int capture_reg_H[] = {
+		RT715_SET_GAIN_MIC_ADC_H, RT715_SET_GAIN_LINE_ADC_H,
+		RT715_SET_GAIN_MIX_ADC_H, RT715_SET_GAIN_MIX_ADC2_H };
+	static const unsigned int capture_reg_L[] = {
+		RT715_SET_GAIN_MIC_ADC_L, RT715_SET_GAIN_LINE_ADC_L,
+		RT715_SET_GAIN_MIX_ADC_L, RT715_SET_GAIN_MIX_ADC2_L };
 	unsigned int addr_h, addr_l, val_h = 0x0, i, loop_cnt = 4;
 	unsigned int read_ll, read_rl;
 
-- 
2.38.1

