Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F82610E98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiJ1Ke5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJ1Keg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:34:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019E10551;
        Fri, 28 Oct 2022 03:34:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v1so6025898wrt.11;
        Fri, 28 Oct 2022 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTLqcHpLknCfW4rU/oVOZ72CKaRxSFT1z0XfsYLerY4=;
        b=imzO8c9InqFWAAe6UDl0tJeylGXAQfRifIWLxkEBBPkDDUoq2OeAehXep3L+AUcFV4
         LhTomTHllwI5F8+VOPZznHFHmr51Nxp3RPNNaANnkgxfPQD2t443F1HLxZykztKpM1De
         HwfNABEBPfu3PtyydWY7snwBdKmHigdexxAbytchL1D+7bbKKCaTOrHDuLhbPSuR9JX6
         F0iC2zRQ63X4kROMVyd0e1o165TC1h8n9CuneBAEtgSEoBa8TV3/v0Njypss0+tnB1VI
         b/q/x63MDmFqBYBPv3d6FFH/iPDs5+XRVdavLRqWqPaZIL+yEo4tkYBJIuPg6rwQLfQT
         CiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTLqcHpLknCfW4rU/oVOZ72CKaRxSFT1z0XfsYLerY4=;
        b=57jJ9AiOKfa0NR9r/KuSERYCm2yPjKQH5lz32icaCw2vRy8ZN/gGsRRZM8sjGtWyua
         wfOWR+n3m0Bs9SX/bjWfo/mDXvQt/y8p6xnk5WCVoe+fV/yCpRzQGOYYr2n6BZrdCJey
         baknIeHj/MjivAybbZ6gSysp6bFd1PY5lz0ZEIIvCr+Z+WMAtRRetzF0oQ+zxyOB1EY6
         6n9+1TthnUDIAaFiGyw7QpPruqqAEECGYrgBJJ7dt5f4y/bErcbJQyAo3SpbgRCXupQB
         86OjiofRt17LKWPh5zzDFUxgWD9JCeLHCTZlUbwLduS3tu39FXC7djCR2RMzfHDQAK6B
         WkRQ==
X-Gm-Message-State: ACrzQf2sb/ZRWVoxNcCTDKQhA9qP0zae1xtCAYJdrk7yt+R2HNL4b0+N
        tJPtXJSs75cyWqB51JxqfUw=
X-Google-Smtp-Source: AMsMyM7xKnVs7p0u7RjUBpS/H+wM1foxGyZ7zOdVy4011K+n1YCXJ6oaIUI+vH0bMmnXElFL5TCO6g==
X-Received: by 2002:adf:e510:0:b0:235:de50:72ff with SMTP id j16-20020adfe510000000b00235de5072ffmr27142953wrm.100.1666953269251;
        Fri, 28 Oct 2022 03:34:29 -0700 (PDT)
Received: from localhost (94.197.40.204.threembb.co.uk. [94.197.40.204])
        by smtp.gmail.com with ESMTPSA id d13-20020adff84d000000b0023682011c1dsm3277496wrq.104.2022.10.28.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:34:28 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tsbogend@alpha.franken.de, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] ASoC: jz4740-i2s: Remove .set_sysclk()
Date:   Fri, 28 Oct 2022 11:34:18 +0100
Message-Id: <20221028103418.17578-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
References: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.set_sysclk() is effectively unused here. No machine drivers use
jz4740-i2s; and JZ4740_I2S_CLKSRC_EXT is the only selectable clock
source with simple-card, but that is also the default source and
has a fixed frequency, so configuring it would be redundant.

simple-card ignores -ENOTSUPP error codes when setting the sysclock,
so any device trees that do set the sysclock for some reason should
still work.

It's still possible to configure the clock parent manually in the
device tree and control frequency using other simple-card options,
so at the end of the day there's no real loss in functionality.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
Meant to be applied on top of jz4740-i2s cleanups series already
in linux-next.
Link: https://lore.kernel.org/alsa-devel/20221023143328.160866-1-aidanmacdonald.0x0@gmail.com/

 sound/soc/jz4740/jz4740-i2s.c | 32 --------------------------------
 sound/soc/jz4740/jz4740-i2s.h | 10 ----------
 2 files changed, 42 deletions(-)
 delete mode 100644 sound/soc/jz4740/jz4740-i2s.h

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index b620d4462d90..6d9cfe0a5041 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -23,8 +23,6 @@
 #include <sound/initval.h>
 #include <sound/dmaengine_pcm.h>
 
-#include "jz4740-i2s.h"
-
 #define JZ_REG_AIC_CONF		0x00
 #define JZ_REG_AIC_CTRL		0x04
 #define JZ_REG_AIC_I2S_FMT	0x10
@@ -273,35 +271,6 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
-	unsigned int freq, int dir)
-{
-	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	struct clk *parent;
-	int ret = 0;
-
-	switch (clk_id) {
-	case JZ4740_I2S_CLKSRC_EXT:
-		parent = clk_get(NULL, "ext");
-		if (IS_ERR(parent))
-			return PTR_ERR(parent);
-		clk_set_parent(i2s->clk_i2s, parent);
-		break;
-	case JZ4740_I2S_CLKSRC_PLL:
-		parent = clk_get(NULL, "pll half");
-		if (IS_ERR(parent))
-			return PTR_ERR(parent);
-		clk_set_parent(i2s->clk_i2s, parent);
-		ret = clk_set_rate(i2s->clk_i2s, freq);
-		break;
-	default:
-		return -EINVAL;
-	}
-	clk_put(parent);
-
-	return ret;
-}
-
 static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -318,7 +287,6 @@ static const struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
 	.trigger = jz4740_i2s_trigger,
 	.hw_params = jz4740_i2s_hw_params,
 	.set_fmt = jz4740_i2s_set_fmt,
-	.set_sysclk = jz4740_i2s_set_sysclk,
 };
 
 #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
diff --git a/sound/soc/jz4740/jz4740-i2s.h b/sound/soc/jz4740/jz4740-i2s.h
deleted file mode 100644
index 4da14eac1145..000000000000
--- a/sound/soc/jz4740/jz4740-i2s.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#ifndef _JZ4740_I2S_H
-#define _JZ4740_I2S_H
-
-/* I2S clock source */
-#define JZ4740_I2S_CLKSRC_EXT 0
-#define JZ4740_I2S_CLKSRC_PLL 1
-
-#endif
-- 
2.38.1

