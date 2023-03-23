Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624DA6C6606
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCWLBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCWLBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:01:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F982884C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:01:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b20so51689867edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679569293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ahu8cJkhHnhzUOlpxuAtr0xDCT/S8rOYab9pN6g8aow=;
        b=QuK7pVzcIN1kxnSgkMaJd1q1aZ/0cNK/3nrFNc7eXQ8fUBlIAlZIe9nJ4UZPfrBgCP
         NJD13PXxGHT+CcouoFJLdjzhXO4s+ogC7g8qE4bGZAvQ60eqDbmcY9eB0KdJkwSp6Ujw
         f5TteRs0xrHf1KPJFT1HdxxNcCbXJIWChpoW7ZR1DQAQ5RcV2xyuHUXOx8WWjDnUwvxq
         FBuS88qeSTOZ1uLPA105JEK7F4vs9zMGjvOMpe8eOS2Jdorrsby+MV7VLKLoQp22DyFI
         ihF0194SQ2ChEs4FwrbryvXk6Hp8lbJHtQ+NTuoBQCMIk/bKXMaE3KKkKUBudoLlZ/Sp
         PREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679569293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ahu8cJkhHnhzUOlpxuAtr0xDCT/S8rOYab9pN6g8aow=;
        b=BYnE//4YnDwT5ENtB++owbJ1N/4Yjss2/QWYZxO+qxYUovQUOb3eQGY2Wrhv5Q5Ph+
         dRAxgiCSlHTf1klLxEF+TvHPfg/GTVbCoEekJsMctpTo0dibIJzPVJ3gahbUUQn8FWvL
         9bc1+GF0ZZtBKo6/YBGoo1EbOR7s/hiOsHEnN6Iq06Ghh/K0iNMgpRDM2vv8SwVSy7YS
         xCItqXgU1T2mTtNejKcwAbQM0T65Ey9NpcA0N+yKMyES6MWcnyDa0tDhl7B6nSnwPTUm
         sT69OPZS9ymeIPVwLyAQ/LUVrqTh6R/xIQkvAtETxawEZPpXTSJpstymHVeYRdLHmF+q
         6JsQ==
X-Gm-Message-State: AO0yUKW32b4aKp0DGqzQRfuKihstOCp5nVkKk3B3wFdH4NbDghMLXsCS
        I3MRrNXyrTjryw1TUT4C6lxUWhHAgFBjaOmFYlE=
X-Google-Smtp-Source: AK7set+VkIEJFUs3BcCNTxgxlbqPZF4opEfOOks6fNYPBLX0E2pUV8JwSmNwHYOpN53HDRb9qr81+g==
X-Received: by 2002:a05:6402:1619:b0:4fc:3777:f630 with SMTP id f25-20020a056402161900b004fc3777f630mr10171556edv.0.1679569292850;
        Thu, 23 Mar 2023 04:01:32 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x23-20020a50d617000000b004fa268da13esm9129009edi.56.2023.03.23.04.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 04:01:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [RESEND PATCH] ASoC: codecs: lpass: fix the order or clks turn off during suspend
Date:   Thu, 23 Mar 2023 11:01:25 +0000
Message-Id: <20230323110125.23790-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order in which clocks are stopped matters as some of the clock
like NPL are derived from MCLK.

Without this patch, Dragonboard RB5 DSP would crash with below error:
 qcom_q6v5_pas 17300000.remoteproc: fatal error received:
 ABT_dal.c:278:ABTimeout: AHB Bus hang is detected,
 Number of bus hang detected := 2 , addr0 = 0x3370000 , addr1 = 0x0!!!

Turn off  fsgen first, followed by npl and then finally mclk, which is exactly
the opposite order of enable sequence.

Fixes: 1dc3459009c3 ("ASoC: codecs: lpass: register mclk after runtime pm")
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Sorry for noise, resending this one, as I missed the asoc mailing list in my previous send.


 sound/soc/codecs/lpass-rx-macro.c  | 4 ++--
 sound/soc/codecs/lpass-tx-macro.c  | 4 ++--
 sound/soc/codecs/lpass-wsa-macro.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 9e0a4e8a46c3..372bea8b3525 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3668,9 +3668,9 @@ static int __maybe_unused rx_macro_runtime_suspend(struct device *dev)
 	regcache_cache_only(rx->regmap, true);
 	regcache_mark_dirty(rx->regmap);
 
-	clk_disable_unprepare(rx->mclk);
-	clk_disable_unprepare(rx->npl);
 	clk_disable_unprepare(rx->fsgen);
+	clk_disable_unprepare(rx->npl);
+	clk_disable_unprepare(rx->mclk);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index b044c9c6f89b..d9318799f6b7 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2096,9 +2096,9 @@ static int __maybe_unused tx_macro_runtime_suspend(struct device *dev)
 	regcache_cache_only(tx->regmap, true);
 	regcache_mark_dirty(tx->regmap);
 
-	clk_disable_unprepare(tx->mclk);
-	clk_disable_unprepare(tx->npl);
 	clk_disable_unprepare(tx->fsgen);
+	clk_disable_unprepare(tx->npl);
+	clk_disable_unprepare(tx->mclk);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 728f26d12ab0..6484c335bd5d 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2504,9 +2504,9 @@ static int __maybe_unused wsa_macro_runtime_suspend(struct device *dev)
 	regcache_cache_only(wsa->regmap, true);
 	regcache_mark_dirty(wsa->regmap);
 
-	clk_disable_unprepare(wsa->mclk);
-	clk_disable_unprepare(wsa->npl);
 	clk_disable_unprepare(wsa->fsgen);
+	clk_disable_unprepare(wsa->npl);
+	clk_disable_unprepare(wsa->mclk);
 
 	return 0;
 }
-- 
2.21.0

