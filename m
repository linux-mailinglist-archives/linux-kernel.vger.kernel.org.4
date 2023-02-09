Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DF6908C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjBIM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBIM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1A126D8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:28:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso3738032wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3ujPUkgM6w68JhuQ2OFyntLPvFx3aPpntFnJGR14xI=;
        b=Ijtf7zQNxQutfacxe7HkX1oZwBtdY0P9UgLSO8dhkP1U65kpJZJY7R1MMUyp6Ct4cD
         GLrKvMf4G8iPDCfLMR3KxkIlon3eS1Xk3zCwH/xrQT4V7rasfXSqO1W9FkT8JEwYG5nd
         vP7HU4m5aPIf3u7g0VK2aJyRsrCAVSO4I+7yaTvQlY0tkYTo78Ug18ERnMuYx1t6mXeu
         oZSmmi80y0kP5uJ/f6Ek8Y6oJvaacva8e/X8jBsI6J64GMqPq05H2DDCLPvWcgtqAy3k
         aFstUecHk+zX1c8eISshFvZUTetRV1WcNNIufuMsAsWp1bBovtK8eJZpyD4YQlqFQtJO
         IJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3ujPUkgM6w68JhuQ2OFyntLPvFx3aPpntFnJGR14xI=;
        b=iixzwsf0x1hnqIjn8/8Seeznw9/USez6cA8Oy8KQH1iHUaNNKRxx+lXGI0smuFU2Yf
         cwyI6kdCteVI/IixaZVvfdX6pcKlKHeSWfpufOOKKQeAD+nzQZuW2wV3aRAoXwpUoC6F
         CCqUNNpfbDvzLptK90yS5hQp+ysF+L+N0id21xKh+ENvQC+9li9Tgc+CtmcRsqkWYgWM
         SZMSdEQYJwRHLgiWr2R31YcTIT5sSQC8L5vRlZQB4RuXZWyNP2maYT0JFiYO0FPIKRZh
         Ivf2b6qcO2G+kb4ooGfXpg+fo/mHIoMRX73ybdYrpZbCgmFmBoXKSUfqces3YoaLnNOr
         VYZQ==
X-Gm-Message-State: AO0yUKW0Pc8zOuF8D/eZj/za3585lGajokK59YB59tzfLKHDONnodtvF
        zJ6pn2wb6NuPYkpX9Z3LZITswg==
X-Google-Smtp-Source: AK7set9AiscBQz9AMthG4OOWx2uMKBCI8kOz4peYLZo64rXsBho4JKZR0is3unV5v8eYp3JKFk2CzA==
X-Received: by 2002:a05:600c:511e:b0:3df:9858:c038 with SMTP id o30-20020a05600c511e00b003df9858c038mr5876254wms.13.1675945700377;
        Thu, 09 Feb 2023 04:28:20 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/8] ASoC: qcom: audioreach: fix ADSP ready check
Date:   Thu,  9 Feb 2023 12:28:02 +0000
Message-Id: <20230209122806.18923-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
References: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently q6apm_is_adsp_ready() will only return the cached value of
previous result. If we are unlucky and previous result is not-ready
then the caller will always get not-ready flag.

This is not correct, we should query the dsp of its current state in
irrespective of previous reported state.

Fixes: 47bc8cf60e92 ("ASoC: qdsp6: audioreach: Add ADSP ready check")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 8a7dfd27d3c5..994c9e823a88 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -145,14 +145,6 @@ static void q6apm_put_audioreach_graph(struct kref *ref)
 	kfree(graph);
 }
 
-bool q6apm_is_adsp_ready(void)
-{
-	if (g_apm && g_apm->state)
-		return true;
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(q6apm_is_adsp_ready);
 
 static int q6apm_get_apm_state(struct q6apm *apm)
 {
@@ -169,6 +161,15 @@ static int q6apm_get_apm_state(struct q6apm *apm)
 	return apm->state;
 }
 
+bool q6apm_is_adsp_ready(void)
+{
+	if (g_apm)
+		return q6apm_get_apm_state(g_apm);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(q6apm_is_adsp_ready);
+
 static struct audioreach_module *__q6apm_find_module_by_mid(struct q6apm *apm,
 						    struct audioreach_graph_info *info,
 						    uint32_t mid)
-- 
2.21.0

