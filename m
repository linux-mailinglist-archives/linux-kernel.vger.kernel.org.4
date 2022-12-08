Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01938646ACE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLHImy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLHImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:42:38 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB666C86
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:42:18 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 142so673324pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGJUqYentDxpsZIqZganWe5s05yc50g5y506pVr616s=;
        b=c9xG9GI1V8aQgWpo7G11WVbtiKLGwJBz5kacyFpUq+OtYMc52xXwIEzThqSwV9pNxC
         mQBMXyrUJeoNWya3unYBMIO2jv7vZPvvT/enpF5UTF/jRaBpFDrNkLNt5D5UxWJPRwMy
         833lLMjlZeR0jwGgk/mIGGI5LDM7B3O3AIBTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGJUqYentDxpsZIqZganWe5s05yc50g5y506pVr616s=;
        b=tRx9Qc+TjQRePeR1lg8NFIYD0h5Zf0n+dSDN2NXunm5urOMzcMjOU6Y0nTYs7qRN1z
         aLNQs/0DETMlCeYIWAPFJT8dx7mDMbSjF7iM7cCkaNv4Vlbcl3cpFW8ZATSr3XsEI2YS
         tOxenKsKOWhMRiHSpecgW6oywoX3ujF1CVo/kHof+P9yPUqP7PaFC+jxXHDNP39DLfH+
         atVUdhZGJUybBlCouFAllYk3ZP9FvJwcPqKYyAk82Skwaz06OtH0Wqh4xeUJRNNalXTQ
         qmr8/tmWuRoJG0w50sB3YldFR6aj+hSgULsnLcnVgdaD12VfSAQ3eYWtG95dGkKIafgX
         WhZw==
X-Gm-Message-State: ANoB5pnwAdYpBcelt6sr8ZZyEBfv+3aERYQ/KWQ/s6RY75zx7LBmEMEx
        q8H8B/lhj8N65W4YuEmAWVoqOg==
X-Google-Smtp-Source: AA0mqf5NZIwK4wg0NcMqZI3Pqz/HTbk75LiStHqDkGpllqpRWle6crJdD45l2KSB5di/zLufBJA+2g==
X-Received: by 2002:a62:de04:0:b0:577:3885:9d43 with SMTP id h4-20020a62de04000000b0057738859d43mr1501097pfg.18.1670488937909;
        Thu, 08 Dec 2022 00:42:17 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79849000000b005769ccca18csm9215193pfq.85.2022.12.08.00.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 00:42:17 -0800 (PST)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v1] ASoC: qcom: lpass-platform: Use SNDRV_DMA_TYPE_NONCOHERENT page allocation
Date:   Thu,  8 Dec 2022 08:42:00 +0000
Message-Id: <20221208084200.2136311-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace SNDRV_DMA_TYPE_DEV by SNDRV_DMA_TYPE_NONCOHERENT for pcm
buffer allocation. We measured about 18x performance improvement
when accessing the snd_pcm_mmap() buffer from userspace.

Eg: aarch64 with internal speaker
==
SNDRV_DMA_TYPE_DEV
    frames_per_second=66.4557M/s
    max_time_per_4096_frames=106.094u
    time_per_4096_frames=61.6351us

SNDRV_DMA_TYPE_NONCOHERENT
    frames_per_second=1028.58M/s
    max_time_per_4096_frames=20.312u
    time_per_4096_frames=3.98221us

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

---

 sound/soc/qcom/lpass-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index b41ab7a321ae..ef5cb40b2d9b 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -1181,7 +1181,7 @@ static int lpass_platform_pcm_new(struct snd_soc_component *component,
 	if (is_cdc_dma_port(dai_id))
 		return lpass_platform_prealloc_cdc_dma_buffer(component, pcm, dai_id);
 
-	return snd_pcm_set_fixed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+	return snd_pcm_set_fixed_buffer_all(pcm, SNDRV_DMA_TYPE_NONCOHERENT,
 					    component->dev, size);
 }
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

