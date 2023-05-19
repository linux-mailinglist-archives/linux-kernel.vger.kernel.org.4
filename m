Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35AC70A161
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjESVQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESVQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:16:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689C690
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:16:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d293746e0so2208619b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684531001; x=1687123001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5hMrPsXETXdUYGIPUMht35rFX/2A/wIEa9AD1NCqZE=;
        b=feoHRJajVXoGRyT1DlpVtAHKgDO2bRAUJNWq8xCnz05QMOevmCFEB9bWXjmtLfLX1G
         bwCv06j9XAzYtKywaraY1du3bcg/CNfYPPc5D0mqAxbnIpYnSK9mFmxuujnz1gh7pmbh
         GSpHd+P/cz4Vu0UY9cul2DtSIK8hFE3zevLiyHmi/e8dA01R2hgRM8+nS7xMoxTSRQca
         Ce3JnNyIapbbI1AKu7USnqJervS79llMPA3QenKCZVdfKCGv7prVeilEVZaFBTAKY1Ur
         TtA4A2Vjxb3cbMdjoZye7UGL0+5yuBxmqZOXAmrU3VMJdMdOFy94Ce1Y9/ZUjnxmXdWs
         19sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684531001; x=1687123001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5hMrPsXETXdUYGIPUMht35rFX/2A/wIEa9AD1NCqZE=;
        b=bLhTrEUuLrXFuaY3M1VNuIL1hkXnQG0uXdqtbPBmfoeR362YbApc4Vyh61dc5PrTNZ
         o2RPdjgr2ZOnCja4MZ4k92mN6APf+XgElIJOCxveV/B0445Lpdh/sPZohFmaGY2RWww3
         mEH/bwOAkyOoET8YP41EuyaTywQYH+3N/eMuQjIpVD7ZZDqGziE8C+cT+SPkmhvoppso
         kkAtE92ZY7k8oSDyvzqVpgGzqutIgSaKMDaW4jTWHdtsJSYUJxmS+4rZnnHct4QLLwBN
         r3Q07JAXuoef/YiPy5+XBqiqYNz2ymj66sW41Oy7VBJBr5t6O5TIe8jEmZtHJ9XJCxi0
         n84Q==
X-Gm-Message-State: AC+VfDyyCZK095vnHmICmbLHluW4JQr7twdhPOFOEk1gb52miefbcFVC
        FqXc00T1zaRBtp2LcCSGyFwk/upukebQIw==
X-Google-Smtp-Source: ACHHUZ445VWHeMjyyHhoM02szw1B7s5OGkgW9z17+MhAY5V98leMuZwdsDxZF09fT2aYyVu6pehJ4A==
X-Received: by 2002:a05:6a21:100a:b0:100:a636:6f22 with SMTP id nk10-20020a056a21100a00b00100a6366f22mr2546019pzb.19.1684531000853;
        Fri, 19 May 2023 14:16:40 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id z6-20020aa785c6000000b00643aa9436c9sm110457pfn.172.2023.05.19.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:16:40 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] SoC: ti: davinci-mcasp: Use pcm_for_each_format() macro
Date:   Sat, 20 May 2023 05:16:36 +0800
Message-Id: <20230519211636.3699-1-minhuadotchen@gmail.com>
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

Change since v1:
use clear subject format

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

