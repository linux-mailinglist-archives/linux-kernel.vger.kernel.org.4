Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396835FFF9F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJPN23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJPN2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:28:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70083D593;
        Sun, 16 Oct 2022 06:27:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l22so12652277edj.5;
        Sun, 16 Oct 2022 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R19Q50f+4lJZEQStb2xYnMd/U/8/rdyoHM9BaeMxvps=;
        b=gbkTAWWF6YY0ZHs9zxW1q9aUl6tCSvP9p4r8o3h1d5cTHJFV3BITvz6EgkHXD12VPF
         r45o4jjfXEVXaDE/HgXGhGzJtcVV2tdAG/hD8z35OgMVtzXvqc0uJhza7xWHJyBjphM5
         KN/0vaIoXgSILYv9JTWA/uVS6KYRY7P5dD5U9VIfjQ0RjJWD4XYLgl2+UftSL18DV1WT
         EHX+vVJpBDNvGUneUs+D1qh5G3Yam3mNSxnkhS8egoHtqPFC+yuNa9afL/DT2fBD/U4R
         vZlRwQPnZoOKFbfVmWMDHxNYmyY8P9UmCCc85qLYSYUpayfKCee0JP+vG0mhZYggG3AY
         uSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R19Q50f+4lJZEQStb2xYnMd/U/8/rdyoHM9BaeMxvps=;
        b=qx6LRE2ruSALtGJU+MH9CW0tIdp9+lRO7k1Vmg+pijtUbpFT7+Yb79LEvNHctXJa2d
         h5+VBZRK8zbjZY08P7XCBZCUOrCICWjUE+3fMc61aEsnLApz2qifhl8lVya8gPPRvinI
         zrGu13oRKVjuBTRbqg/nA27NgafKsTu2vJriLEH7p0WaWM7bL7NhD/pMJtj+3npLJA07
         GOEDKMU7iqVPVJTHAymTsJWCUrv9RyqMfP+bdRhnuvIHUIOr2jmREsAY+vQyKKx0lmaz
         UdTGiNrCJc80oM0v30C+OjnJWTRwnuSiGl3e9Bt5m+OtP5KlyJYjrFV7G4V4ZWDaJFMA
         33ig==
X-Gm-Message-State: ACrzQf3903FDiEBkBYKFoQS56kJJn5Amopti1MtYuw+7ejDHpQ/o4F7Y
        El2elJowjBBEfGu9SdEtf8g=
X-Google-Smtp-Source: AMsMyM4CLc3sbcJ+XcUb7r1QZ6mjeycYteXNf0YLcpCxBQ7DSnn0VWt1dxwJNrSay4i3SURbUIJ5SA==
X-Received: by 2002:a05:6402:5190:b0:45c:fca7:e07b with SMTP id q16-20020a056402519000b0045cfca7e07bmr6145825edd.327.1665926876937;
        Sun, 16 Oct 2022 06:27:56 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ce85000000b0045c72bba0bfsm5572057edv.4.2022.10.16.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 06:27:56 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] ASoC: codecs: jz4725b: add missed microphone widgets
Date:   Sun, 16 Oct 2022 16:26:48 +0300
Message-Id: <20221016132648.3011729-8-lis8215@gmail.com>
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

Microphone input can be single ended or differential, although
known SoCs with that codec expose MIC1P only.

Also there is 20dB mic boost in the Mic1 path.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 52b2bb95b..685ba1d3a 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -175,6 +175,15 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(jz4725b_out_tlv,
 	12, 23, TLV_DB_SCALE_ITEM(-1050, 100, 0),
 	24, 31, TLV_DB_SCALE_ITEM(  100,  50, 0),
 );
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_mic_boost_tlv, 0, 2000, 0);
+
+static const char * const jz4725b_mic_mode_texts[] = {
+	"Single Ended", "Differential",
+};
+
+static const struct soc_enum jz4725b_mic_mode_enum =
+	SOC_ENUM_SINGLE(JZ4725B_CODEC_REG_CR3, REG_CR3_MICDIFF_OFFSET,
+			2, jz4725b_mic_mode_texts);
 
 static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_DOUBLE_TLV("DAC Playback Volume",
@@ -219,6 +228,13 @@ static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_SINGLE("High-Pass Filter Capture Switch",
 		   JZ4725B_CODEC_REG_CR2,
 		   REG_CR2_ADC_HPF_OFFSET, 1, 0),
+
+	SOC_ENUM("Mic Mode Capture Switch", jz4725b_mic_mode_enum),
+
+	SOC_SINGLE_TLV("Mic1 Boost Capture Volume",
+		       JZ4725B_CODEC_REG_PMR2,
+		       REG_PMR2_GIM_OFFSET,
+		       1, 0, jz4725b_mic_boost_tlv),
 };
 
 static const char * const jz4725b_codec_adc_src_texts[] = {
-- 
2.36.1

