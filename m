Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF75B5618
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiILIY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiILIYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:24:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A950303EE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:23:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y136so7901182pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CYZKTwkJqt/xmQ1S/2yshb1pzDHPMWMO6tW+glk5icQ=;
        b=ipbOD5/lU3TdsNEcVIu8wbFII35K/rkwPXlb8o2fSZZZR42I9Gs+FjgIbob/7Wvqoh
         jsGQXhcSwT+wxjU/JGmbuYQGIV/z+g6J26/kfzG/loBDj8+w14xO8fxweSzTIthByq8k
         KBviaq0tA5dLiLxkkCcNjWijEYB+T1KS3ueWCjHgnHlqZkMykjMOGG57mAHOGcFzGImy
         L0vEsvcneRgHUgcT7L9INa88bvCqir8XnWPTJJ+qYpiwBuAYBA32WbkJQU63BsHHrL5P
         Yad7QPxT3OP3FwBOTAwE/ypzjCFlpKFSy6PJdTiBW2nk8nU9k2U7ZJZGO7lMhb3hOvR1
         sm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CYZKTwkJqt/xmQ1S/2yshb1pzDHPMWMO6tW+glk5icQ=;
        b=jxjj5nmMd+ndZto72Y9chDKx88guSKwPtSFPMgEw276In2I9ZMjhZa8DCykdmUFEhv
         saWk5WRWLJqTQjWa+84lAvA41NRk63GmiWmZYj+Oj7F0YnWdTuz7Muq8gusqHua7QD45
         KGBeB2QgK0FSUjFmG2Vx+Ur6LTCiNo8QndAw6PCEKjZJjoKvTr6XWL6lMIybhwyZHxyx
         /Q5cgeyVVD4ewEHAd0Its81rkhe14TSsQe9nQdFa6m5AvvDa75+RqnAE3LnmpgUCF9Fs
         QlJU3eVtapMCp/pq3GLFnzUJJSu0KJQsdo9uVGEIfcZm1mqUlWzzluICj6qAmyWJQ/nt
         XqQQ==
X-Gm-Message-State: ACgBeo2p08epqrUYkD+MTgUbynTZ7FCbKsHR51U5flpwei7bYr+yCTi0
        Jrlk1z69Dzhj5zF8gB3rDgU=
X-Google-Smtp-Source: AA6agR5OKr7BYPEOnP35Wf2mdImB1iOLNb9iAB/QmCYRYJYOrB/ObagXLm06vH0ykCOvlcz3L/1EaA==
X-Received: by 2002:a63:475d:0:b0:430:120:18d0 with SMTP id w29-20020a63475d000000b00430012018d0mr22003947pgk.563.1662970989046;
        Mon, 12 Sep 2022 01:23:09 -0700 (PDT)
Received: from localhost ([106.118.72.87])
        by smtp.gmail.com with ESMTPSA id r1-20020aa79ec1000000b0053e42167a33sm4741079pfq.53.2022.09.12.01.23.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2022 01:23:08 -0700 (PDT)
From:   Mengchen Li <mengchenli64@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, steve@sk2.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mengchen Li <mengchenli64@gmail.com>
Subject: [PATCH] ASoC: wm8978: Support the recording function of codec
Date:   Mon, 12 Sep 2022 16:23:05 +0800
Message-Id: <1662970985-2909-1-git-send-email-mengchenli64@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we want to use the microphone function of the wm8978 codec,
we must enable the microphone bias circuit and power up the bias
circuit,otherwise the microphone can not vibrate for sound source
sampling.The bit that controls the output voltage of the bias circuit
is the fourth bit of the WM8978_POWER_MANAGEMENT_1 register,so this
bit must be set to 1.This patch can support the recording function of
the wm8978 codec.

Signed-off-by: Mengchen Li <mengchenli64@gmail.com>
---
 sound/soc/codecs/wm8978.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index a682f80..fdd5429 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -822,7 +822,9 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 
 	snd_soc_component_write(component, WM8978_AUDIO_INTERFACE, iface_ctl);
 	snd_soc_component_write(component, WM8978_ADDITIONAL_CONTROL, add_ctl);
-
+	/* Enable MICBEN */
+	snd_soc_component_write(component, WM8978_POWER_MANAGEMENT_1,
+		snd_soc_component_read(component, WM8978_POWER_MANAGEMENT_1) | 0x10);
 	if (wm8978->sysclk != current_clk_id) {
 		if (wm8978->sysclk == WM8978_PLL)
 			/* Run CODEC from PLL instead of MCLK */
-- 
2.7.4

