Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2407068CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjEQNBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQNBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:01:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DE130C1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:01:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52cb78647ecso474775a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684328491; x=1686920491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8eTr+kmtQOMistU8xT35doPKpqXFH7Y2/6qZfkliXQY=;
        b=seZjxxtmfTvReRahRdu8pf3VrMApAAYx3KRJlLrsfNCfVrBh3Ch/ftGO+CE6/3KLJp
         Bo+LVzN0mozW5ReZfrmPbMVxhZnaZCHKVoKA5wbnhZ5xxWJKLD4flaFyL7f6gIQaPi8o
         um5/OP1FIsg1tDn755f1ssscGWmiz9rkBrmNJ4B02SClqX+Bf9ASCj/BC4xLVFkdET61
         68STZpPXYoP4BLEfp9buTukZCcc++pU+vUPAviVNc7nteXmVSBKhfIgAficiCBRq0B3d
         gCjKU+8ZtpTD3vmREkn1iMaJed3iVbNRonpxLitDZ8Pfsw2XTNySnhlgsrpZOQYmJVt7
         mH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684328491; x=1686920491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eTr+kmtQOMistU8xT35doPKpqXFH7Y2/6qZfkliXQY=;
        b=dt3owqVnSywzeK2QihkqvcRqhmRdzC70HZZgyNvv9I/GCjQ81mUXWJblpY9Z5/gvUM
         AoRG+BaqxkGYNGBD9I0OMLXKuuF85bW6XBvIda4/VJGHuY3k9bgKUaE5r6R3h4CqO5B5
         3AnsktFG4RVdPsNC8c8ZfnS1Tv6WjmXP7vW8WOmntXeJ7afuALYr1K1o9FoYz9CyghgA
         +Ac2qRwysntmCuj9JPs548g1ID4hJA/XSFjbXtddDkw7ww6q1wQKeueCFsBgKbrE4euL
         jPo12k5a8G7oJYdUM8AqyfFRq/YcCytCoC7Btww2Gynw2MRH0DPsJfUjXZCGC0pPHJl/
         2N1w==
X-Gm-Message-State: AC+VfDyFAzvYGEbIWkQ18aDTI/8df5EQHopCcY3b0PCGkKHNN6Yo4lSZ
        myKBG6UItQDyy/GKYVrJYzg30dwRto4=
X-Google-Smtp-Source: ACHHUZ5CKkul94ZbhzG2mkSjbyrZSmL0AOKkrjBht/hCEzVCEhAObHX1vt6n10u0bWU1x65HrPd6Kw==
X-Received: by 2002:a17:902:b7cc:b0:1ac:3ddf:2299 with SMTP id v12-20020a170902b7cc00b001ac3ddf2299mr41063963plz.44.1684328489446;
        Wed, 17 May 2023 06:01:29 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001a1d41d1b8asm1725178plw.194.2023.05.17.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:01:29 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ti: Use pcm_for_each_format() macro for PCM format iteration
Date:   Wed, 17 May 2023 21:01:22 +0800
Message-Id: <20230517130124.26033-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pcm_for_each_format for the PCM format iteration and fix the
following sparse warnings.

sound/soc/ti/davinci-mcasp.c:1336:26: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/ti/davinci-mcasp.c:1358:26: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/ti/davinci-mcasp.c:1438:26: sparse: warning: restricted snd_pcm_format_t degrades to integer

No functional changes.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 sound/soc/ti/davinci-mcasp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index c0892be2992b..172fea764a31 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1328,15 +1328,16 @@ static int davinci_mcasp_hw_rule_slot_width(struct snd_pcm_hw_params *params,
 	struct davinci_mcasp_ruledata *rd = rule->private;
 	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	struct snd_mask nfmt;
-	int i, slot_width;
+	int slot_width;
+	snd_pcm_format_t i;
 
 	snd_mask_none(&nfmt);
 	slot_width = rd->mcasp->slot_width;
 
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-		if (snd_mask_test(fmt, i)) {
+	pcm_for_each_format(i) {
+		if (snd_mask_test_format(fmt, i)) {
 			if (snd_pcm_format_width(i) <= slot_width) {
-				snd_mask_set(&nfmt, i);
+				snd_mask_set_format(&nfmt, i);
 			}
 		}
 	}
@@ -1350,15 +1351,16 @@ static int davinci_mcasp_hw_rule_format_width(struct snd_pcm_hw_params *params,
 	struct davinci_mcasp_ruledata *rd = rule->private;
 	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	struct snd_mask nfmt;
-	int i, format_width;
+	int format_width;
+	snd_pcm_format_t i;
 
 	snd_mask_none(&nfmt);
 	format_width = rd->mcasp->max_format_width;
 
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-		if (snd_mask_test(fmt, i)) {
+	pcm_for_each_format(i) {
+		if (snd_mask_test_format(fmt, i)) {
 			if (snd_pcm_format_width(i) == format_width) {
-				snd_mask_set(&nfmt, i);
+				snd_mask_set_format(&nfmt, i);
 			}
 		}
 	}
@@ -1431,12 +1433,13 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 	struct snd_mask nfmt;
 	int rate = params_rate(params);
 	int slots = rd->mcasp->tdm_slots;
-	int i, count = 0;
+	int count = 0;
+	snd_pcm_format_t i;
 
 	snd_mask_none(&nfmt);
 
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-		if (snd_mask_test(fmt, i)) {
+	pcm_for_each_format(i) {
+		if (snd_mask_test_format(fmt, i)) {
 			uint sbits = snd_pcm_format_width(i);
 			unsigned int sysclk_freq;
 			int ppm;
@@ -1454,7 +1457,7 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 							 sbits * slots * rate,
 							 false);
 			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
-				snd_mask_set(&nfmt, i);
+				snd_mask_set_format(&nfmt, i);
 				count++;
 			}
 		}
-- 
2.34.1

