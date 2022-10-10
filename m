Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D45FA3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJJSzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJJSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:54:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0510F1EED1;
        Mon, 10 Oct 2022 11:54:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b4so18341638wrs.1;
        Mon, 10 Oct 2022 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KOQIYlbblLHHRIPNNVIX9zOac26R/P9cPlWZ+KbLOU=;
        b=onG0G8qPaIbhvuYeakoEpmZHsfPvkKuL9BZEMMFTdcP43O1NME8Fsb3POluz3fZAhy
         Lwbs300R2iesaLWumkxsJL5uE8kBY4xjuHhl0V3S2yq7Nr1b2moiF+asMXIv+hS04InD
         F3a9I8ivWJfHcsXqo3J6HupLIFSYlylCcyMRFSKBDtOwSIPJLwNPOMYPz6ugQawWaQWh
         uVZmOXHlLlh6itxn33mXSbIRkKosG9Ntei/KKh3JsTi2u4vV1wF3BdkwWGCL8jfiLn1u
         NRGJ2HPMKGAKLaQwOt9T015Ea71JKf5GGsoHF5K3sAetsg8Z44agAM/OFdD1qeXrSrqF
         AAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KOQIYlbblLHHRIPNNVIX9zOac26R/P9cPlWZ+KbLOU=;
        b=aql14PYMblA/b0/ANMp2F14+mtR27x7sHtJwP0CoeHYOYejv10ntfmaURgTaTe5Z0t
         M5LQcpOY/+fez3dSH7bYRKD97NgXv29hVnrqvjKBxG4PHGwpOxoXlGskVxBrbCcTYNX/
         SLhHGgZJKAYAbGLcpZwwIxVMoZINOfezH9zGcBNyzUrWLtWnJ41O20mz/XuV7FdAOBYg
         hN1wMrRb9NvW7ZGE6jcEnAvLuPSkgJBpkn8Ahpf9VmUl3NfkfCLoDP/uP27ZmaJsQ0m6
         3ZDYR6ChguzAFiwaCl3YW232eJYbMrzci7nEjM1kCgU8ELg9HVuMI+dFKcyaOuGbifyg
         i4xA==
X-Gm-Message-State: ACrzQf12WtGP1WOtw/hA+02JCxkDOIYUEB0CVQ07h9PU5oONkXgiq7OW
        sl2Zux8AxSEkR+3uQhvWZbmsjS25ppdbNw==
X-Google-Smtp-Source: AMsMyM5//7B1JOa0HJE0sfOI/B5b30P3bn4Cwu1SQ317PoD6E8TMN+PaK3ZV1wOCrhSvOLjVjRmz+Q==
X-Received: by 2002:adf:f883:0:b0:22e:5610:79fe with SMTP id u3-20020adff883000000b0022e561079femr12637080wrp.351.1665428096495;
        Mon, 10 Oct 2022 11:54:56 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-126-34-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.34.126])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6142000000b00230c9d427f9sm2082272wrt.53.2022.10.10.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:54:55 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] ASoC: codecs: jz4725b: fix capture selector naming
Date:   Mon, 10 Oct 2022 21:54:21 +0300
Message-Id: <20221010185423.3167208-5-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221010185423.3167208-1-lis8215@gmail.com>
References: <Y0P/u4pJT8rup8Za@sirena.org.uk>
 <20221010185423.3167208-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment Capture source selector appears on Playback
tab in the alsamixer and has a senseless name.

Let's fix that.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 4363d898a..3f9bbd79d 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -183,7 +183,7 @@ static SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
 				  jz4725b_codec_adc_src_texts,
 				  jz4725b_codec_adc_src_values);
 static const struct snd_kcontrol_new jz4725b_codec_adc_src_ctrl =
-			SOC_DAPM_ENUM("Route", jz4725b_codec_adc_src_enum);
+	SOC_DAPM_ENUM("ADC Source Capture Route", jz4725b_codec_adc_src_enum);
 
 static const struct snd_kcontrol_new jz4725b_codec_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Line In Bypass", JZ4725B_CODEC_REG_CR1,
-- 
2.36.1

