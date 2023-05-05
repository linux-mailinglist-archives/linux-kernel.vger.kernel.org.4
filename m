Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EF96F871B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjEEQzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjEEQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:55:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C0191FE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:55:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f19323259dso20553045e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683305727; x=1685897727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWd518ZVELbkPHYlOpmIJ7g/bmO3wYl7PpJavDJwK68=;
        b=c7fc4Z+RIAPUqsAFPp2G67pOYWK2PNIVlPcMURVWulSHwlGlmDQWWy0GUszI9vSQTf
         QhmlUVo9atPB+0/8hRcNFa+61TSG1KufgBpDfcRaQEwNBN13JRfCqcuhKWOliVO8wTMA
         nfaSDwNkKDXqGGCcI0qtz5ub3c7pGgudH2DAlirxI9mtkN81mD61o1IuiNzs1mvS9B2H
         l0E++3fyliRVDdn+P+ldd4IgGL6kGUYSry1U75OwRrCZiwTedjUdoe5DTME+tIIqJlEd
         n/RivTlWxyTDV3TFwQUalnUIA8lcqAylU2E2uAKhaBNGNelN80diIUsq3Drzcp4mXxiW
         Hwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305727; x=1685897727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWd518ZVELbkPHYlOpmIJ7g/bmO3wYl7PpJavDJwK68=;
        b=QVV2C3DYL/vQ83bcKc0hfRBO1+QlR7KyGshtuDkF4C9Xv+/1xXX+/XlUcDYM9TjMRS
         /VMu7VfPpSkIs/VCHPWCaFwmoZbQA7DLakfw6qaAfU9TzYo09ldNjNAeF51ULy14/0YT
         CTU5Dr3QyazGDs2nP914m53+RSQBF6SvkZVLEyK8m8WxZplGFfCNX3ry4hIpGEdfBD5N
         ixFzT4cq5DcLGt7ZREstFjEi3Kd75fa1Sr3XZlBAG5GAt98OjHjKeVFJH42myjNriq3t
         sauxA4o8W2xgR5wl/w4k9CVZzaqm1nvDkNMrAQ43LZLjm2wcqzt2yGFrQyZ72N/YjPav
         1wvg==
X-Gm-Message-State: AC+VfDwHv6tGpTwheWHv8HXeZwxxuUbrL6kRdfQYh8WvpufU5/Y4F4Yi
        USyy41VJzOHNBCDMnjPNprIMHQ==
X-Google-Smtp-Source: ACHHUZ4fK6zbNXMaQt+c/2yHsoyXsoSqwsYxy1PcYMyflrt5ETa+uP3MLXHfFWP0GrIrSYDQ3NK05A==
X-Received: by 2002:a05:600c:21cf:b0:3f1:6757:6245 with SMTP id x15-20020a05600c21cf00b003f167576245mr1688995wmj.7.1683305727569;
        Fri, 05 May 2023 09:55:27 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x7-20020adfffc7000000b002c7066a6f77sm2923551wrs.31.2023.05.05.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:55:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.com
Cc:     perex@perex.cz, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] ASoC: hdmi-codec: use snd_pcm_add_chmap_ctls_with_prefix to add controls
Date:   Fri,  5 May 2023 17:55:13 +0100
Message-Id: <20230505165514.4666-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230505165514.4666-1-srinivas.kandagatla@linaro.org>
References: <20230505165514.4666-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are multiple instances of this codec in a sound card
snd_pcm_add_chmap_ctls() will fail with below error because of
duplicate control names.

snd-sc8280xp sound: control 3:16:0:Playback Channel Map:0 is already present
hdmi-audio-codec hdmi-audio-codec.4.auto: ASoC: error at snd_soc_pcm_dai_new on i2s-hifi: -16

Fix this by using snd_pcm_add_chmap_ctls_with_prefix along wth component
name prefix.

This issue is noticed on x13s laptop which has multiple instances of Displayport.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/hdmi-codec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 6d980fbc4207..8c54cddf86b6 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -782,9 +782,10 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	unsigned int i;
 	int ret;
 
-	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
-				      NULL, drv->playback.channels_max, 0,
-				      &hcp->chmap_info);
+	ret =  snd_pcm_add_chmap_ctls_with_prefix(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
+						  NULL, drv->playback.channels_max, 0,
+						  &hcp->chmap_info,
+						  dai->component->name_prefix);
 	if (ret < 0)
 		return ret;
 
-- 
2.21.0

