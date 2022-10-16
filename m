Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5305FFF96
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJPN15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJPN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:27:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EEF7654;
        Sun, 16 Oct 2022 06:27:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s30so12681075eds.1;
        Sun, 16 Oct 2022 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQsANxIEHACjEO789UfrDxMr8VcVkScq/x+QZ4UQMEA=;
        b=kJ4NshSVOAuSzJGz7Jj9SJ0xMOEi4H/WlYotPjjJejZwXBfKwe4D3mFeklshKLJi8L
         6lKCCypWJrFHTNrH127vr77kV0vifbz2zlgt2b37KKhI0PzdAGn5VLNDFaaTuqmbrX5e
         x+7riGpjdchVyrlR2P8JgHKB0T87pb/xCaiV4GPgAN5uxNwNs6njn9Rqhjo+We4mBKgv
         W2dof6GFySiw0JHaFysHlrhWFeVydnAUY5zHs+yAv9wvzIcc68Z4E5f3RXBPgf/jWPe2
         Sp3tXYuXlgzwm497Zx/EzipZu3TjEOLazm4vW3m24a6k6nQ3RUrR8WeLrThXidy9tvtJ
         nOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQsANxIEHACjEO789UfrDxMr8VcVkScq/x+QZ4UQMEA=;
        b=7OgaTrBQZ9LpHEdOMfDWsmiMajqh1S6WMylI1zI8y3BgCtF7990G8B7jLH9w2kBz5j
         SBQGJnR3cNQfHHPIYdNZ15J5X8IyrB2s8gvT5sYh+evXz9nvwOUywoFUoCR5zCC/SfNN
         zK6KlaUN+F8LThYokTFE3y4WO9zWbdNOZh54QkOwUVbQ5dilG6PsSntqmNlryZFsaJtw
         C3ekAWTCWXfBVePyDm8qIwmt4LPTQ+ySZXBP/Fo8pyUOHq48OFA22AmalNhP7OWhx7DT
         NHGzwywGmJa6cS7ewBTJFWhAfNfZqhTSQBTDTxAvmpHVZLI+COhfVb5YE6DdSvYMLVlk
         fgDA==
X-Gm-Message-State: ACrzQf00N76fVy3fxBx45v6ZQBPKMsXgo04lRoOvjhNifLI+XK2n+ddN
        /v08OD44xdoxyYGxmZPNhFQ=
X-Google-Smtp-Source: AMsMyM5GojADR3ig+RebZhArnx0qPJhabSJNCjSJnR1XJOqXg7ij25ZKfZGxwZkQ/3Rv0Iw6v5sMmg==
X-Received: by 2002:a05:6402:35c9:b0:45c:de2e:ae1c with SMTP id z9-20020a05640235c900b0045cde2eae1cmr6163562edc.393.1665926866448;
        Sun, 16 Oct 2022 06:27:46 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ce85000000b0045c72bba0bfsm5572057edv.4.2022.10.16.06.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 06:27:45 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] ASoC: codecs: jz4725b: fix reported volume for Master ctl
Date:   Sun, 16 Oct 2022 16:26:43 +0300
Message-Id: <20221016132648.3011729-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016132648.3011729-1-lis8215@gmail.com>
References: <20221016132648.3011729-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAC volume control is the Master Playback Volume at the moment
and it reports wrong levels in alsamixer and other alsa apps.

The patch fixes that, as stated in manual on the jz4725b SoC
(16.6.3.4 Programmable attenuation: GOD) the ctl range varies
from -22.5dB to 0dB with 1.5dB step.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index cc7a48c96..72549ee2e 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -142,8 +142,8 @@ struct jz_icdc {
 	struct clk *clk;
 };
 
-static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_dac_tlv, -2250, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_line_tlv, -1500, 600);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_dac_tlv, -2250, 150, 0);
 
 static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_DOUBLE_TLV("Master Playback Volume",
-- 
2.36.1

