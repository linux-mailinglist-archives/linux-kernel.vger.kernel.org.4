Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111A86115CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJ1P1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJ1P0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:26:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3181CF56A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:26:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n12so13666210eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWOXtZdeE7MXcWYkV9UqH7xJWnsDsrChaSh5X+0ymME=;
        b=A9tM9pd5l2CdvVGQhJ9hSPryXHIi3u3k5PvNLdLItJWafLR3Mz9QQCXpsQJHcYDxY1
         1GpOIJEHJpegytu5MENt44AgAUdDFP+h7HObOzqEd1gASFiK7tCocoQnyDsnYYlX4uUG
         0G/JXcIRm9pLLVRiDrN+bICu8NFfvCqar3Ifkqm8Pin7Ezm39JktPAuTD6B+5uvn8pET
         pqcQN46LVvX5NJMDwHLGbHxgibD3+cYVR98HaGPcImq5eSXXYxYwBZPlu+HiMEXvgVoH
         3Q9/NV7S7yXI+M9b5X5rmf6CiBDS9VxDApVoIjzcGmz8AB+c1NsPov04khEdmo5u5J/s
         Zu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWOXtZdeE7MXcWYkV9UqH7xJWnsDsrChaSh5X+0ymME=;
        b=Uv6sr2xjq846TwppFc/TCQBi/SpeDF+l1nca7OPc+yamX2+EJH6/sKTuE6OmAuS3hr
         //mdSYVjt6+GqfZQyZokLfGrRx4CRqPQxJgYmch2anYtThXAXkLUjhHHYN2iscrxoUF+
         IpuOgTQYBT5kYboQXl0C0L0Ie34rRkrdeQ8Z0U8r044IStiHk5gRdXLjrcx8F6xf04n9
         oP9E9YA+6CeTtOjk3eDUic8OeA9Nu/K2ERrrTxRVp7Md5XZ85rl/hI+/k7zuhNEOneH3
         8lGvztBiQOnwLeK02VPaKvaMEDoq2WRqDvQl338FlUdpOsf3PXyBHyAUZfcynonrRxLJ
         xqVw==
X-Gm-Message-State: ACrzQf0ChOvw0kKcNMosdtR3DfDtZZ7bKU/Gc8jQk8pB7ZJhy5YRMKhH
        SbcHHAHivITGixASnoVTxSUIUg==
X-Google-Smtp-Source: AMsMyM7s4zQhZSZe0Gwp4o8LLInXxkJAz9VOMp7gKPhy4+xNy/Geo2aAiMWI5r+csh+Y04c6Ix2YwQ==
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id mp31-20020a1709071b1f00b0072f56dbcce9mr46674745ejc.605.1666970812645;
        Fri, 28 Oct 2022 08:26:52 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906319100b00730df07629fsm2349839ejy.174.2022.10.28.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:26:52 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: adau1372: add support for S24_LE mode
Date:   Fri, 28 Oct 2022 17:26:24 +0200
Message-Id: <20221028152626.109603-3-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028152626.109603-1-maarten.zanders@mind.be>
References: <20221028152626.109603-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADAU1372 contains 24bit ADCs and DACs. Allow the driver to use
its native mode which uses the same settings as the current 32 bit
mode.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 sound/soc/codecs/adau1372.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1372.c b/sound/soc/codecs/adau1372.c
index 00d0825e193b..6b35981c8777 100644
--- a/sound/soc/codecs/adau1372.c
+++ b/sound/soc/codecs/adau1372.c
@@ -662,6 +662,7 @@ static int adau1372_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		sai1 = ADAU1372_SAI1_BCLKRATE;
 		break;
+	case 24:
 	case 32:
 		sai1 = 0;
 		break;
@@ -699,6 +700,7 @@ static int adau1372_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	case 16:
 		sai1 = ADAU1372_SAI1_BCLK_TDMC;
 		break;
+	case 24:
 	case 32:
 		sai1 = 0;
 		break;
@@ -869,7 +871,9 @@ static const struct snd_soc_dai_ops adau1372_dai_ops = {
 	.startup = adau1372_startup,
 };
 
-#define ADAU1372_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |	SNDRV_PCM_FMTBIT_S32_LE)
+#define ADAU1372_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			  SNDRV_PCM_FMTBIT_S24_LE | \
+			  SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_driver adau1372_dai_driver = {
 	.name = "adau1372",
-- 
2.37.3

