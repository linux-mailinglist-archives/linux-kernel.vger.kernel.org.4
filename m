Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEEA740CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjF1JbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjF1JYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:24:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159B610D8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:24:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa99f6a482so32651615e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687944269; x=1690536269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzKXpMccA6UrwHtXvOGSFvI/x46V/z1bpRu3rF0Fgs0=;
        b=fueU1DULpIywX2DaDQQk0rGXg3PtSBos/iW8JpD9Vgn8gH+xHWp/h0QRyukEI7O19n
         zm6aK/HjiOtVtDnYJOaFMUvOhdbBp42M8K0RL1WMTCaWgLu7TuX6X0HSUl8E5ohHg/cJ
         7hOyN1YGptCx7M2Kg9BpiVSukjKpVpaQeT/dqBlFAqG01ISxfbd1sS3ab+mmme8B95r/
         Fw7lYhPsitYBBrKLtJwiFm4MJV1MGMWOxKVo1KPOV6rKYvO0eq7GQgA1vRUPQ/3ZKX4I
         PGIgGxKgUefcJQV08RH9cHKNJP6V8+ERX2wOcQIQhtZjeSbSgLcDzuGTv91NBllPb1ss
         DWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687944269; x=1690536269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzKXpMccA6UrwHtXvOGSFvI/x46V/z1bpRu3rF0Fgs0=;
        b=CK5O3UtWGpDU7PU5GWQ/XIzwBANFyjT+ThyyxU8VPtRMIqjA3PzWGMqwqH5SFLDDfh
         AIKCJjQx6yIZnZIyhPL6vjCpEk9xNZuZ90QPoUQVBQinGDJTEzrrIaq+6+uDArwLfyV0
         h86NG9Go/dBTOTSTx5zfCmgprS3HL/YF8o1oS2I20/DuEQzcg2adA0lSem/aZ/gNua3O
         bejZgsGkAQ8uqN7SvjhWLlQn8CHKAdaCmVifcXqLKcIoGobc3SAUw+7mWZa3GIQK21mF
         Q2fdv3znDqetnghU5LPuzSmRy02nIawvDBGbgIxzkoxnpekd5l8Knka0ZfvvbY5SkNi0
         fzpg==
X-Gm-Message-State: AC+VfDxmzy489WuxM42IhjQ5L8vY1OrWjSpgS+8xUHSlQqaaDmdcweJH
        spm0MquRAC8P8c2oaGhJRwVfJQ==
X-Google-Smtp-Source: ACHHUZ54XNFWh70xItwrsXJjQNsNfbm1HM+SarGY7nLeMvIhA+uyrvqHtA6D65tWQXSWo7WG4YGACA==
X-Received: by 2002:a5d:4e50:0:b0:313:eb47:b7b3 with SMTP id r16-20020a5d4e50000000b00313eb47b7b3mr9446659wrt.66.1687944269482;
        Wed, 28 Jun 2023 02:24:29 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o18-20020a056000011200b00313f9085119sm5500091wrx.113.2023.06.28.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:24:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stable@vger.kernel.org
Subject: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device number
Date:   Wed, 28 Jun 2023 10:24:04 +0100
Message-Id: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason we ended up with a setup without this flag.
This resulted in inconsistent sound card devices numbers which
 are also not starting as expected at dai_link->id.
 (Ex: MultiMedia1 pcm ended up with device number 4 instead of 0)

With this patch patch now the MultiMedia1 PCM ends up with device number 0
as expected.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 5eb0b864c740..c90db6daabbd 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -840,6 +840,7 @@ static const struct snd_soc_component_driver q6apm_fe_dai_component = {
 	.pointer	= q6apm_dai_pointer,
 	.trigger	= q6apm_dai_trigger,
 	.compress_ops	= &q6apm_dai_compress_ops,
+	.use_dai_pcm_id = true,
 };
 
 static int q6apm_dai_probe(struct platform_device *pdev)
-- 
2.21.0

