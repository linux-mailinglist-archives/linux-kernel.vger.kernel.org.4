Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2645B5561
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiILHad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiILHaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:30:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FFF21E27
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:30:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so7344106pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CK6XIpefy3/wH7x7ijKJf8zjoreJxucwMJjlvPQYCqM=;
        b=Hcmq27NHAy3z+4cG0SVQQd+fZ1/jc2GeejYyOfYCsFBqXYIbMXAR5thORHA1NDWlZO
         qnFRghwY11MQyO7syFahFHur08dpjCHZMDWn/ll+xTA2UPk2eQOh/NTRBUPZ4Z/+SlmA
         NLwf04AXksZltPBJtDg2BTZVfaMrnzcVuSq0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CK6XIpefy3/wH7x7ijKJf8zjoreJxucwMJjlvPQYCqM=;
        b=TWUvg6mXOczVKTMzmrscCUFbJ9trNlBCMryJevtjgFFpA/M+tpRHcQmL1pG81+dl8R
         hgRnwSDpItPcBN78+otIXYhTxI+NfGACJ2+GYFUCFyoqe1D3EM2mh3wXXqu6p0iM/05E
         9UU80TOb29xCsB38zQhlcj5mir5MPVlj/O62xmr8Uj5E1dwmjjZqZwHlbD/bw+c5cRpK
         o0YQEzO6ep9aZ2PHIM/7uMSB7sM6lQ/LoplbxIWRHUxpph//rSw15Dl6tVoZLS2CVN7C
         /YuAVvYLNPa9f7B3fvG01md/YmYDfz2zSBGMiwkxPtxzR8txqQJSJtODWRhSAMiEVEXq
         CxzQ==
X-Gm-Message-State: ACgBeo38/hECtKlnCGcu+ptkbi9ABH98FyHGZ3KaFjHwYpaWJsl6kZHo
        /1B6p0qpW0UaVZrsx++azR1ZliBuuYnu8g==
X-Google-Smtp-Source: AA6agR6vFVlg3Lae6dq+F8i18SG9dsYYmiCNbnuMk+cD9kBQUAPWJAESM62XMzfoJND/WN79EeYTtA==
X-Received: by 2002:a17:90a:1786:b0:202:856e:29bf with SMTP id q6-20020a17090a178600b00202856e29bfmr16907426pja.134.1662967822211;
        Mon, 12 Sep 2022 00:30:22 -0700 (PDT)
Received: from yjscloudtop.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id v4-20020a63f204000000b00438eaf65766sm1962955pgh.73.2022.09.12.00.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:30:20 -0700 (PDT)
From:   YJ Lee <yunjunlee@chromium.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        YJ Lee <yunjunlee@chromium.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, yuhsuan@chromium.org,
        whalechang@chromium.org
Subject: [PATCH v1] ALSA: dummy: Add customizable volume min/max.
Date:   Mon, 12 Sep 2022 15:29:45 +0800
Message-Id: <20220912072945.760949-1-yunjunlee@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add module parameters to support customized min/max volume leveling,
which will be useful to test devices with different volume granularity.

Signed-off-by: YJ Lee <yunjunlee@chromium.org>
---
 sound/drivers/dummy.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 2a7fc49c1a7c5..64fb2778f1e9a 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -42,6 +42,8 @@ MODULE_LICENSE("GPL");
 #define USE_CHANNELS_MAX 	2
 #define USE_PERIODS_MIN 	1
 #define USE_PERIODS_MAX 	1024
+#define USE_MIXER_VOLUME_LEVEL_MIN	-50
+#define USE_MIXER_VOLUME_LEVEL_MAX	100
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
@@ -50,6 +52,8 @@ static char *model[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = NULL};
 static int pcm_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
 static int pcm_substreams[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 8};
 //static int midi_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 2};
+static int mixer_volume_level_min = USE_MIXER_VOLUME_LEVEL_MIN;
+static int mixer_volume_level_max = USE_MIXER_VOLUME_LEVEL_MAX;
 #ifdef CONFIG_HIGH_RES_TIMERS
 static bool hrtimer = 1;
 #endif
@@ -69,6 +73,10 @@ module_param_array(pcm_substreams, int, NULL, 0444);
 MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-128) for dummy driver.");
 //module_param_array(midi_devs, int, NULL, 0444);
 //MODULE_PARM_DESC(midi_devs, "MIDI devices # (0-2) for dummy driver.");
+module_param(mixer_volume_level_min, int, 0444);
+MODULE_PARM_DESC(mixer_volume_level_min, "Minimum mixer volume level for dummy driver. Default: -50");
+module_param(mixer_volume_level_max, int, 0444);
+MODULE_PARM_DESC(mixer_volume_level_max, "Maximum mixer volume level for dummy driver. Default: 100");
 module_param(fake_buffer, bool, 0444);
 MODULE_PARM_DESC(fake_buffer, "Fake buffer allocations.");
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -713,8 +721,8 @@ static int snd_dummy_volume_info(struct snd_kcontrol *kcontrol,
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
-	uinfo->value.integer.min = -50;
-	uinfo->value.integer.max = 100;
+	uinfo->value.integer.min = mixer_volume_level_min;
+	uinfo->value.integer.max = mixer_volume_level_max;
 	return 0;
 }
  
@@ -739,15 +747,15 @@ static int snd_dummy_volume_put(struct snd_kcontrol *kcontrol,
 	int left, right;
 
 	left = ucontrol->value.integer.value[0];
-	if (left < -50)
-		left = -50;
-	if (left > 100)
-		left = 100;
+	if (left < mixer_volume_level_min)
+		left = mixer_volume_level_min;
+	if (left > mixer_volume_level_max)
+		left = mixer_volume_level_max;
 	right = ucontrol->value.integer.value[1];
-	if (right < -50)
-		right = -50;
-	if (right > 100)
-		right = 100;
+	if (right < mixer_volume_level_min)
+		right = mixer_volume_level_min;
+	if (right > mixer_volume_level_max)
+		right = mixer_volume_level_max;
 	spin_lock_irq(&dummy->mixer_lock);
 	change = dummy->mixer_volume[addr][0] != left ||
 	         dummy->mixer_volume[addr][1] != right;
@@ -1076,6 +1084,12 @@ static int snd_dummy_probe(struct platform_device *devptr)
 			dummy->pcm_hw.channels_max = m->channels_max;
 	}
 
+	if (mixer_volume_level_min > mixer_volume_level_max) {
+		pr_warn("snd-dummy: Invalid mixer volume level: min=%d, max=%d. Fall back to default value.\n",
+		mixer_volume_level_min, mixer_volume_level_max);
+		mixer_volume_level_min = USE_MIXER_VOLUME_LEVEL_MIN;
+		mixer_volume_level_max = USE_MIXER_VOLUME_LEVEL_MAX;
+	}
 	err = snd_card_dummy_new_mixer(dummy);
 	if (err < 0)
 		return err;
-- 
2.31.0

