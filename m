Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD55D6C6E04
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjCWQpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCWQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:45:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787D2BDD7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg48so89398381edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679589855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9hR2ta52bACZknOtBgzAtIQixsM2cnIaeXyomXOX0M=;
        b=hsU07gcm4byF9ZYlXK1WlYHz20he7E5os8F7BoiRYFqBoQ2LrF2tAJIR9eVB89B8Uy
         HJA8JeTi7FwzRJ9QxYCsEuIBXYiMTMb1rDVSxF4Q/n0XMr/M4RFU6tkGTphQfVx4uG71
         l5UlNqW7RwV16UokCSfFHyRmu8oAgTKWjS8tWQtIe5h/PGz52NnEbauFdC0hY47EMOgS
         SOTX0YK+AtNfFB4fQyOEqxMCyZHkHGoA+mSLPFbuU4KUzJ7iT2zGM9o8cDWy0W066NRI
         FquE+gLVNO9wbeZ7aJh0yrRbmLCExY1uQ7JeyDp7ZrXtcJ+GS4EGqeX6jb6AUxU2ZUqV
         I1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9hR2ta52bACZknOtBgzAtIQixsM2cnIaeXyomXOX0M=;
        b=nx/5fLIpVGGYbaYvz61zzhZwtBN+uvNV9i6aRqL5yk7J6jvs6WAYkKy6gDsiaR7JOW
         0f/hrXPEMczjAz0qiflCstkcmgLjdH9RNre1Gu7/0yTxo9Byw1a96qVlvLbbY5UgmIxr
         4bIKYRbUbvyXW8wdWzqZI7gFyqWepTuIQBOcTwdxYI1ZG6oaERTegNcKrl89YWSlcRxG
         0ZVdzI+rXzciJMjIC7Nj28Un72zxEPMXrNizfegnAA9FxBd2/v4gxvdj+U+OZrZb/MLn
         aBa5FZNczfMUPdTs4EsdxS8e/YA8maMv8dbxttyHxOwLZc9yvabdiNOGRIBH3y4PIrIr
         53VQ==
X-Gm-Message-State: AO0yUKVn33iGaHOPOKrAsDqp0ZYOlVu8eTWsJQzCsW/uqd+Kun6yGbC3
        EFcAtu/lnGCm9lgNLXXypOsxsQ==
X-Google-Smtp-Source: AK7set9SrJMpkEy99egze/q3burIKmKgQxPwfncKKS5udbZI/dH1Vt0lijTuLG5/wJEWwSEzEDNPxw==
X-Received: by 2002:a50:e619:0:b0:4fd:298a:62cb with SMTP id y25-20020a50e619000000b004fd298a62cbmr6183375edm.21.1679589854783;
        Thu, 23 Mar 2023 09:44:14 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m10-20020a50998a000000b004e48f8df7e2sm9542187edb.72.2023.03.23.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:44:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] ASoC: qcom: q6apm-lpass-dai: close graphs before opening a new one
Date:   Thu, 23 Mar 2023 16:44:00 +0000
Message-Id: <20230323164403.6654-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
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

On multiple prepare calls, its possible that the playback graphs are
not unloaded from the DSP, which can have some wierd side-effects,
one of them is that the data not consumed without any errors.

Fixes: c2ac3aec474d("ASoC: qcom: q6apm-lpass-dai: unprepare stream if its already prepared")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 23d23bc6fbaa..420e8aa11f42 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -130,6 +130,9 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 	if (dai_data->is_port_started[dai->id]) {
 		q6apm_graph_stop(dai_data->graph[dai->id]);
 		dai_data->is_port_started[dai->id] = false;
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			q6apm_graph_close(dai_data->graph[dai->id]);
 	}
 
 	/**
-- 
2.21.0

