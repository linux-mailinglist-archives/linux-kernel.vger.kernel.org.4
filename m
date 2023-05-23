Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E96070E0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbjEWPqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjEWPq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:46:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51134DD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:46:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso202475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684856785; x=1687448785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY78bpvovATO4WTiWWCs/PyinwWE+HdEDWAOWfiu7IY=;
        b=qzXoE7KKxl8W7e9Ja/36EZNThJM8rZx06KxNTz3pu/jWCjkNW83xPrSo87iAGb5eod
         tYOi1jkZbAiEFgKV594n50+88hyF1C9ftpmv8HxaiYgOAr0mRStKnWG+cwq6WqGzPBy+
         OG0Fj1AxfEX3J2sgJB/WYBzgD3A3lm+Iauu5wrSl7fbwLIGt/Y8q202YcqU71xBs7rg8
         exjOndDRf3smAaxgYEkP67pAQ2MP+1JSlYAj4IJkNJWH3Fms6lP5Ntt7CNXklyrsFbPz
         x70ZRlAc4zhIbWw7zEW6a+yRuEpQJ3pvYuXGBsuieV5suQ5IyViTHuX6eTk44TSxkqVG
         vE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684856785; x=1687448785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY78bpvovATO4WTiWWCs/PyinwWE+HdEDWAOWfiu7IY=;
        b=froFlziAqHrnBfmhxZbVPsub1Qmuv7eTCRe2l8o+lui4qgWQe3+yJE6Qm/TCRcq/vJ
         NVe9sjA/h0XuKIizFi2vvc7FCLxL9nme5SWrrTURx0x4fRKwHzGqTa3GtBsN8sxcP6MQ
         vLYRPXMs8pY2Gppr2IrLwfO1oamqSHlCj1AP1On1zfxxwahlRQqFLzTkS/g8PdiXSjeg
         RMEaTZTtxmCJCa8M1TRBpAs8Ve5ZsfdGmrdp8xiqxL3NQMzyxb3Dr2mL45aESWfiL1B1
         6Bmc+GpPCYdAjwngFyx3vCwJA6UGR+DWlltnvyqGP+ouFWiaG++ORXJPNdaGfUOi5mLM
         zq1w==
X-Gm-Message-State: AC+VfDyr2eZabcMT+agtSNT8O2MPKKC9PDv0zlaxseqkWfg6HGo6vTqA
        bN0Qs/N7sOImwBjMxYZh4RtWdQ==
X-Google-Smtp-Source: ACHHUZ5UPojsYEPmPMD6YBrtM2ogvSu7gGXAEL3nSBCW0XABVz487ZQkY16kEyIPnERnW6fC5GGhGQ==
X-Received: by 2002:a05:600c:3549:b0:3f5:a54:9f97 with SMTP id i9-20020a05600c354900b003f50a549f97mr11115515wmq.0.1684856784731;
        Tue, 23 May 2023 08:46:24 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f4-20020a1c6a04000000b003f1978bbcd6sm3374063wmc.3.2023.05.23.08.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:46:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: wsa881x: do not set can_multi_write flag
Date:   Tue, 23 May 2023 16:46:05 +0100
Message-Id: <20230523154605.4284-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap-sdw does not support multi register writes, so there is
no point in setting this flag. This also leads to incorrect
programming of WSA codecs with regmap_multi_reg_write() call.

This invalid configuration should have been rejected by regmap-sdw.

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 4ce72a7f01b6..211b154bc514 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -645,7 +645,6 @@ static struct regmap_config wsa881x_regmap_config = {
 	.readable_reg = wsa881x_readable_register,
 	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.can_multi_write = true,
 };
 
 enum {
-- 
2.21.0

