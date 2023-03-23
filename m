Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62906C65DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCWK5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCWK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:56:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479962D54
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:56:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so84569389edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679568986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLNI73/fGTsgrr+TnsMtyvkfWieA5l/96brGiAGWXWU=;
        b=m+pKZSxsNLsBzApT/Z9BI1cWaQ0+UtAEmaa+WDnbcGYqLu3UA2qrEoSJNysG6zd0vs
         pZzpGjBSMIeTr0/ECJZpTRVWMhKDbCezAdTRbCYmYPo/S8jGsK6arh9UIhWon5bF6UWn
         bLxr9SpUWOUt6IvpNmDkVOnNtVICBDoXG/67P9v043HHMwCGMmtgROInN7mKTr8hfpCk
         08f/CpB9r46Dr9gkHlb0fEtXZAXZS3nRhLPYR3NxOHWcC1ou/ZGqY7RdYZsItDZuKFDl
         gsw7HbK9xuU+wRCQEAP5uP39xcmBb5Y1HRs8vA8lXmM5RSOBScRFPKXDi/IjKg0DiFCE
         Vktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679568986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLNI73/fGTsgrr+TnsMtyvkfWieA5l/96brGiAGWXWU=;
        b=1wJqWFFCdb19NnJ+pWHbO70+2fFynnOC5kp0mLsxBkSds4DbDV9hwktQinH9YQ3YyL
         +YOVYsH1uCXVyKHVD5ZtVD5CwCwXE1qbzM5KC714oQbL2ylx4d4jenquxqQRf2f1jclF
         Dhzlbv/RrG5bRH6UjuJs4+hjAiYNxEZMiNwqDMUO0fwBV84TaDDEcDpQjX15TyFz3ktN
         HkzwuctPQ4Gm8mw0zO6yz6vz995h/N5+/GvaAyprtPUCiWzFMPbxggXPdCm4mW9DecXm
         a9U30wahSQXktAcq+RVX9mj8mjrtZP5FmUhL2vv0HLN/3QjUWvu/sny9bt/EIDec37xq
         ymug==
X-Gm-Message-State: AO0yUKW5IB49LRKOfDHLqd0KyqoYzYsrsRGey1HHCbN50PtoOtlZ4Lrv
        EgoebP0dqXiY8KEtyzPyTBf9PQ==
X-Google-Smtp-Source: AK7set/vB6+hJy5CRde3bX5ov1VSiI423CINwK0ijuAujrYLRPYKFRGGKcez5vJ9zW2iNYkN6aXqFg==
X-Received: by 2002:a17:906:f8c2:b0:930:3916:df17 with SMTP id lh2-20020a170906f8c200b009303916df17mr11573547ejb.0.1679568985778;
        Thu, 23 Mar 2023 03:56:25 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090655c800b00930569e6910sm8647538ejp.16.2023.03.23.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:56:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH] ASoC: codecs: lpass: fix the order or clks turn off during suspend
Date:   Thu, 23 Mar 2023 10:56:19 +0000
Message-Id: <20230323105619.20996-1-srinivas.kandagatla@linaro.org>
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

