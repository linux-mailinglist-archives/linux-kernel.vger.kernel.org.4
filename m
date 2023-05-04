Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F86F6838
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjEDJXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjEDJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:22:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982814497
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:22:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7766d1f2so334775276.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683192174; x=1685784174;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jHuDeVQwq+SLO8mpsZeFy0esCdKvNG9damaRghoQ8Ck=;
        b=vG7euVawjosD+ZyeS8G4vdsF4OPhOHZaX+xr418g2cNcdeJaHcWPV2xvOm/7xyRvCO
         eMa5kcwhsjXhk5ESxJ6EgAougehijas2B/V8EXYI4mxIE7w/RCjc+jmB7SimGBV3aBQw
         veFkuVZwLHQAefRWxTrfAvinilX2MAHyDEBpn8f+jcHM9GA7rTI5+yUSnjtHir615YPY
         S919iC1y/YoFwLstMDfokQ36n2sZnJpEvyVqQS6OW2WsEhG24mcYYgdWN06MuH8sBHHq
         eqpyfisGHiDGC/ZTkSkqEhbB4FwAAqafZfxdW0K060jyuQqK59sGNqba4BP6iuVMn9Bc
         bFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683192174; x=1685784174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHuDeVQwq+SLO8mpsZeFy0esCdKvNG9damaRghoQ8Ck=;
        b=SnI8kOie4LoP5EDlBiyBByZHbcGW3OHFYdmu2ctOEfdhre4Z/BfInYciwtkXW3NuP4
         ftKGMMhMstTIXjoHiCsKRYDUGR6AeLFctBG2So4dHavwQ55RS8ZSpFGsD5cLSeZcq5gM
         O3yWGlbDG6u+2E06ajTw8rYLsTQVGfzlknzxdplHNjjTXBaO6Q4b9V0HH8f4a3ZWR+7O
         vLvVykNhskeyWV6Ot+dbD4icJWVPriAEUm6AG1ku/M97Buq7/ekqfHVsxTgTuKVvbxzb
         O4Bq7yaTdovZ34IOhauwzAJ753F2BXfps9Y2HnQO1PpqGzP5cDAhVDmHS1/wiSGkPbKJ
         VQ1Q==
X-Gm-Message-State: AC+VfDzhS33Lxs8IYD1QiGegs4GHiUnmzQ7m1Mshrr9QgV0GIjJiRHf8
        h8A4jv+Oqz/MuUY29OkhaH7KegAJV767Y/AViw==
X-Google-Smtp-Source: ACHHUZ7Fqp/fwWEnCS+k4jfVNnwOa0YF7vE1Rjl6gARL+j26U4NBwMCfLAPT9nj7v6raS5vxylAUP5LKU7TuSiKvLQ==
X-Received: from yixuanjiang.ntc.corp.google.com ([2401:fa00:fc:202:770:8186:365d:f82])
 (user=yixuanjiang job=sendgmr) by 2002:a05:6902:1003:b0:b8f:54f5:89ff with
 SMTP id w3-20020a056902100300b00b8f54f589ffmr15315973ybt.11.1683192173847;
 Thu, 04 May 2023 02:22:53 -0700 (PDT)
Date:   Thu,  4 May 2023 17:21:42 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504092142.4190069-1-yixuanjiang@google.com>
Subject: [PATCH] ASoC: soc-pcm: Fix and cleanup DPCM locking
From:   yixuanjiang <yixuanjiang@google.com>
To:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

The existing locking for DPCM has several issues
a) a confusing mix of card->mutex and card->pcm_mutex.
b) a dpcm_lock spinlock added inconsistently and on paths that could
be recursively taken. The use of irqsave/irqrestore was also overkill.

The suggested model is:

1) The pcm_mutex is the top-most protection of BE links in the FE. The
pcm_mutex is applied always on either the top PCM callbacks or the
external call from DAPM, not taken in the internal functions.

2) the FE stream lock is taken in higher levels before invoking
dpcm_be_dai_trigger()

3) when adding and deleting a BE, both the pcm_mutex and FE stream
lock are taken.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[clarification of commit message by plbossart]
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bossart@linux.intel.com
Cc: stable@vger.kernel.org # 5.15.x
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |   2 -
 sound/soc/soc-core.c |   1 -
 sound/soc/soc-pcm.c  | 229 ++++++++++++++++++++++++++++---------------
 3 files changed, 152 insertions(+), 80 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8e6dd8a257c5..5872a8864f3b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -893,8 +893,6 @@ struct snd_soc_card {
 	struct mutex pcm_mutex;
 	enum snd_soc_pcm_subclass pcm_subclass;
 
-	spinlock_t dpcm_lock;
-
 	int (*probe)(struct snd_soc_card *card);
 	int (*late_probe)(struct snd_soc_card *card);
 	int (*remove)(struct snd_soc_card *card);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1b1749b920f4..a5b3ee69fb88 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2339,7 +2339,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
 	mutex_init(&card->pcm_mutex);
-	spin_lock_init(&card->dpcm_lock);
 
 	return snd_soc_bind_card(card);
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3b673477f621..07ad98934c7a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -27,6 +27,31 @@
 #include <sound/soc-link.h>
 #include <sound/initval.h>
 
+static inline void snd_soc_dpcm_mutex_lock(struct snd_soc_pcm_runtime *rtd)
+{
+	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+}
+
+static inline void snd_soc_dpcm_mutex_unlock(struct snd_soc_pcm_runtime *rtd)
+{
+	mutex_unlock(&rtd->card->pcm_mutex);
+}
+
+#define snd_soc_dpcm_mutex_assert_held(rtd) \
+	lockdep_assert_held(&(rtd)->card->pcm_mutex)
+
+static inline void snd_soc_dpcm_stream_lock_irq(struct snd_soc_pcm_runtime *rtd,
+						int stream)
+{
+	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
+}
+
+static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_runtime *rtd,
+						  int stream)
+{
+	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(rtd, stream));
+}
+
 #define DPCM_MAX_BE_USERS	8
 
 static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
@@ -73,7 +98,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_pcm_hw_params *params = &fe->dpcm[stream].hw_params;
 	struct snd_soc_dpcm *dpcm;
 	ssize_t offset = 0;
-	unsigned long flags;
 
 	/* FE state */
 	offset += scnprintf(buf + offset, size - offset,
@@ -101,7 +125,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 		goto out;
 	}
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		params = &dpcm->hw_params;
@@ -122,7 +145,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 					   params_channels(params),
 					   params_rate(params));
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 out:
 	return offset;
 }
@@ -145,11 +167,13 @@ static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
+	snd_soc_dpcm_mutex_lock(fe);
 	for_each_pcm_streams(stream)
 		if (snd_soc_dai_stream_valid(asoc_rtd_to_cpu(fe, 0), stream))
 			offset += dpcm_show_state(fe, stream,
 						  buf + offset,
 						  out_count - offset);
+	snd_soc_dpcm_mutex_unlock(fe);
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
 
@@ -221,14 +245,14 @@ static void dpcm_set_fe_update_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_pcm_substream *substream =
 		snd_soc_dpcm_get_substream(fe, stream);
 
-	snd_pcm_stream_lock_irq(substream);
+	snd_soc_dpcm_stream_lock_irq(fe, stream);
 	if (state == SND_SOC_DPCM_UPDATE_NO && fe->dpcm[stream].trigger_pending) {
 		dpcm_fe_dai_do_trigger(substream,
 				       fe->dpcm[stream].trigger_pending - 1);
 		fe->dpcm[stream].trigger_pending = 0;
 	}
 	fe->dpcm[stream].runtime_update = state;
-	snd_pcm_stream_unlock_irq(substream);
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 }
 
 static void dpcm_set_be_update_state(struct snd_soc_pcm_runtime *be,
@@ -256,7 +280,7 @@ void snd_soc_runtime_action(struct snd_soc_pcm_runtime *rtd,
 	struct snd_soc_dai *dai;
 	int i;
 
-	lockdep_assert_held(&rtd->card->pcm_mutex);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	for_each_rtd_dais(rtd, i, dai)
 		snd_soc_dai_action(dai, stream, action);
@@ -309,6 +333,8 @@ int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 {
 	struct snd_soc_dpcm *dpcm;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
 	for_each_dpcm_be(fe, dir, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
@@ -646,14 +672,14 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
+static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
+			 struct snd_pcm_substream *substream, int rollback)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 	int i;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	if (!rollback)
 		snd_soc_runtime_deactivate(rtd, substream->stream);
@@ -665,9 +691,6 @@ static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
 
 	soc_pcm_components_close(substream, rollback);
 
-
-	mutex_unlock(&rtd->card->pcm_mutex);
-
 	snd_soc_pcm_component_pm_runtime_put(rtd, substream, rollback);
 
 	for_each_rtd_components(rtd, i, component)
@@ -682,9 +705,21 @@ static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
  * freed here. The cpu DAI, codec DAI, machine and components are also
  * shutdown.
  */
+static int __soc_pcm_close(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_pcm_substream *substream)
+{
+	return soc_pcm_clean(rtd, substream, 0);
+}
+
+/* PCM close ops for non-DPCM streams */
 static int soc_pcm_close(struct snd_pcm_substream *substream)
 {
-	return soc_pcm_clean(substream, 0);
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	soc_pcm_clean(rtd, substream, 0);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return 0;
 }
 
 static int soc_hw_sanity_check(struct snd_pcm_substream *substream)
@@ -730,21 +765,21 @@ static int soc_hw_sanity_check(struct snd_pcm_substream *substream)
  * then initialized and any private data can be allocated. This also calls
  * startup for the cpu DAI, component, machine and codec DAI.
  */
-static int soc_pcm_open(struct snd_pcm_substream *substream)
+static int __soc_pcm_open(struct snd_soc_pcm_runtime *rtd,
+			  struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 	int i, ret = 0;
 
+	snd_soc_dpcm_mutex_assert_held(rtd);
+
 	for_each_rtd_components(rtd, i, component)
 		pinctrl_pm_select_default_state(component->dev);
 
 	ret = snd_soc_pcm_component_pm_runtime_get(rtd, substream);
 	if (ret < 0)
-		goto pm_err;
-
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+		goto err;
 
 	ret = soc_pcm_components_open(substream);
 	if (ret < 0)
@@ -786,16 +821,26 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	snd_soc_runtime_activate(rtd, substream->stream);
 	ret = 0;
 err:
-	mutex_unlock(&rtd->card->pcm_mutex);
-pm_err:
 	if (ret < 0) {
-		soc_pcm_clean(substream, 1);
+		soc_pcm_clean(rtd, substream, 1);
 		dev_err(rtd->dev, "%s() failed (%d)", __func__, ret);
 	}
 
 	return ret;
 }
 
+/* PCM open ops for non-DPCM streams */
+static int soc_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_open(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
+}
+
 static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
 {
 	/*
@@ -811,13 +856,13 @@ static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
  * rate, etc.  This function is non atomic and can be called multiple times,
  * it can refer to the runtime info.
  */
-static int soc_pcm_prepare(struct snd_pcm_substream *substream)
+static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *dai;
 	int i, ret = 0;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	ret = snd_soc_link_prepare(substream);
 	if (ret < 0)
@@ -845,14 +890,24 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		snd_soc_dai_digital_mute(dai, 0, substream->stream);
 
 out:
-	mutex_unlock(&rtd->card->pcm_mutex);
-
 	if (ret < 0)
 		dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
 
 	return ret;
 }
 
+/* PCM prepare ops for non-DPCM streams */
+static int soc_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_prepare(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
+}
+
 static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
 				       unsigned int mask)
 {
@@ -864,13 +919,13 @@ static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
 	interval->max = channels;
 }
 
-static int soc_pcm_hw_clean(struct snd_pcm_substream *substream, int rollback)
+static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_substream *substream, int rollback)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *dai;
 	int i;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	/* clear the corresponding DAIs parameters when going to be inactive */
 	for_each_rtd_dais(rtd, i, dai) {
@@ -900,16 +955,28 @@ static int soc_pcm_hw_clean(struct snd_pcm_substream *substream, int rollback)
 		snd_soc_dai_hw_free(dai, substream, rollback);
 	}
 
-	mutex_unlock(&rtd->card->pcm_mutex);
 	return 0;
 }
 
 /*
  * Frees resources allocated by hw_params, can be called multiple times
  */
+static int __soc_pcm_hw_free(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_pcm_substream *substream)
+{
+	return soc_pcm_hw_clean(rtd, substream, 0);
+}
+
+/* hw_free PCM ops for non-DPCM streams */
 static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	return soc_pcm_hw_clean(substream, 0);
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_hw_free(rtd, substream);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
 }
 
 /*
@@ -917,15 +984,15 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
  * function can also be called multiple times and can allocate buffers
  * (using snd_pcm_lib_* ). It's non-atomic.
  */
-static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
+			       struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i, ret = 0;
 
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+	snd_soc_dpcm_mutex_assert_held(rtd);
 
 	ret = soc_pcm_params_symmetry(substream, params);
 	if (ret)
@@ -997,16 +1064,27 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_pcm_component_hw_params(substream, params);
 out:
-	mutex_unlock(&rtd->card->pcm_mutex);
-
 	if (ret < 0) {
-		soc_pcm_hw_clean(substream, 1);
+		soc_pcm_hw_clean(rtd, substream, 1);
 		dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
 	}
 
 	return ret;
 }
 
+/* hw_params PCM ops for non-DPCM streams */
+static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	int ret;
+
+	snd_soc_dpcm_mutex_lock(rtd);
+	ret = __soc_pcm_hw_params(rtd, substream, params);
+	snd_soc_dpcm_mutex_unlock(rtd);
+	return ret;
+}
+
 static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
@@ -1124,7 +1202,8 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
-	unsigned long flags;
+
+	snd_soc_dpcm_mutex_assert_held(fe);
 
 	/* only add new dpcms */
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -1140,10 +1219,10 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	dpcm->fe = fe;
 	be->dpcm[stream].runtime = fe->dpcm[stream].runtime;
 	dpcm->state = SND_SOC_DPCM_LINK_STATE_NEW;
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+	snd_soc_dpcm_stream_lock_irq(fe, stream);
 	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
 	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 
 	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
 			stream ? "capture" : "playback",  fe->dai_link->name,
@@ -1188,8 +1267,10 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
 void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm, *d;
-	unsigned long flags;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
+	snd_soc_dpcm_stream_lock_irq(fe, stream);
 	for_each_dpcm_be_safe(fe, stream, dpcm, d) {
 		dev_dbg(fe->dev, "ASoC: BE %s disconnect check for %s\n",
 				stream ? "capture" : "playback",
@@ -1207,12 +1288,11 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 
 		dpcm_remove_debugfs_state(dpcm);
 
-		spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 		list_del(&dpcm->list_be);
 		list_del(&dpcm->list_fe);
-		spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 		kfree(dpcm);
 	}
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 }
 
 /* get BE for DAI widget and stream */
@@ -1426,12 +1506,9 @@ int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
 void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm_set_be_update_state(dpcm->be, stream, SND_SOC_DPCM_UPDATE_NO);
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 }
 
 void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
@@ -1467,12 +1544,12 @@ void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
 				continue;
 
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) {
-				soc_pcm_hw_free(be_substream);
+				__soc_pcm_hw_free(be, be_substream);
 				be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 			}
 		}
 
-		soc_pcm_close(be_substream);
+		__soc_pcm_close(be, be_substream);
 		be_substream->runtime = NULL;
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 	}
@@ -1520,7 +1597,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			stream ? "capture" : "playback", be->dai_link->name);
 
 		be_substream->runtime = be->dpcm[stream].runtime;
-		err = soc_pcm_open(be_substream);
+		err = __soc_pcm_open(be, be_substream);
 		if (err < 0) {
 			be->dpcm[stream].users--;
 			if (be->dpcm[stream].users < 0)
@@ -1764,7 +1841,7 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 	dev_dbg(fe->dev, "ASoC: open FE %s\n", fe->dai_link->name);
 
 	/* start the DAI frontend */
-	ret = soc_pcm_open(fe_substream);
+	ret = __soc_pcm_open(fe, fe_substream);
 	if (ret < 0)
 		goto unwind;
 
@@ -1795,6 +1872,8 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int stream = substream->stream;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
 	/* shutdown the BEs */
@@ -1803,7 +1882,7 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	dev_dbg(fe->dev, "ASoC: close FE %s\n", fe->dai_link->name);
 
 	/* now shutdown the frontend */
-	soc_pcm_close(substream);
+	__soc_pcm_close(fe, substream);
 
 	/* run the stream stop event */
 	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
@@ -1848,7 +1927,7 @@ void dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
 			be->dai_link->name);
 
-		soc_pcm_hw_free(be_substream);
+		__soc_pcm_hw_free(be, be_substream);
 
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 	}
@@ -1859,13 +1938,13 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int stream = substream->stream;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
 	dev_dbg(fe->dev, "ASoC: hw_free FE %s\n", fe->dai_link->name);
 
 	/* call hw_free on the frontend */
-	soc_pcm_hw_free(substream);
+	soc_pcm_hw_clean(fe, substream, 0);
 
 	/* only hw_params backends that are either sinks or sources
 	 * to this frontend DAI */
@@ -1874,7 +1953,7 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
 
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 	return 0;
 }
 
@@ -1918,7 +1997,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
 			be->dai_link->name);
 
-		ret = soc_pcm_hw_params(be_substream, &dpcm->hw_params);
+		ret = __soc_pcm_hw_params(be, be_substream, &dpcm->hw_params);
 		if (ret < 0)
 			goto unwind;
 
@@ -1948,7 +2027,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
 			continue;
 
-		soc_pcm_hw_free(be_substream);
+		__soc_pcm_hw_free(be, be_substream);
 	}
 
 	return ret;
@@ -1960,7 +2039,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int ret, stream = substream->stream;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
 
 	memcpy(&fe->dpcm[stream].hw_params, params,
@@ -1974,7 +2053,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 			params_channels(params), params_format(params));
 
 	/* call hw_params on the frontend */
-	ret = soc_pcm_hw_params(substream, params);
+	ret = __soc_pcm_hw_params(fe, substream, params);
 	if (ret < 0)
 		dpcm_be_dai_hw_free(fe, stream);
 	else
@@ -1982,7 +2061,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 
 out:
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s failed (%d)\n", __func__, ret);
@@ -2253,7 +2332,7 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
 			be->dai_link->name);
 
-		ret = soc_pcm_prepare(be_substream);
+		ret = __soc_pcm_prepare(be, be_substream);
 		if (ret < 0)
 			break;
 
@@ -2271,7 +2350,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
 	int stream = substream->stream, ret = 0;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 
 	dev_dbg(fe->dev, "ASoC: prepare FE %s\n", fe->dai_link->name);
 
@@ -2290,7 +2369,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 		goto out;
 
 	/* call prepare on the frontend */
-	ret = soc_pcm_prepare(substream);
+	ret = __soc_pcm_prepare(fe, substream);
 	if (ret < 0)
 		goto out;
 
@@ -2298,7 +2377,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 
 out:
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
@@ -2349,7 +2428,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	struct snd_soc_dpcm *dpcm;
 	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
 	int ret = 0;
-	unsigned long flags;
 
 	dev_dbg(fe->dev, "ASoC: runtime %s open on FE %s\n",
 			stream ? "capture" : "playback", fe->dai_link->name);
@@ -2418,7 +2496,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	dpcm_be_dai_shutdown(fe, stream);
 disconnect:
 	/* disconnect any pending BEs */
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 
@@ -2430,7 +2507,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			be->dpcm[stream].state == SND_SOC_DPCM_STATE_NEW)
 				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
@@ -2505,7 +2581,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card *card)
 	struct snd_soc_pcm_runtime *fe;
 	int ret = 0;
 
-	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	mutex_lock_nested(&card->pcm_mutex, card->pcm_subclass);
 	/* shutdown all old paths first */
 	for_each_card_rtds(card, fe) {
 		ret = soc_dpcm_fe_runtime_update(fe, 0);
@@ -2521,7 +2597,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card *card)
 	}
 
 out:
-	mutex_unlock(&card->mutex);
+	mutex_unlock(&card->pcm_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_runtime_update);
@@ -2532,6 +2608,8 @@ static void dpcm_fe_dai_cleanup(struct snd_pcm_substream *fe_substream)
 	struct snd_soc_dpcm *dpcm;
 	int stream = fe_substream->stream;
 
+	snd_soc_dpcm_mutex_assert_held(fe);
+
 	/* mark FE's links ready to prune */
 	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
@@ -2546,12 +2624,12 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(fe_substream);
 	int ret;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	ret = dpcm_fe_dai_shutdown(fe_substream);
 
 	dpcm_fe_dai_cleanup(fe_substream);
 
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 	return ret;
 }
 
@@ -2562,7 +2640,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	int ret;
 	int stream = fe_substream->stream;
 
-	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	snd_soc_dpcm_mutex_lock(fe);
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
 	ret = dpcm_path_get(fe, stream, &list);
@@ -2579,7 +2657,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	dpcm_clear_pending_state(fe, stream);
 	dpcm_path_put(&list);
 open_end:
-	mutex_unlock(&fe->card->mutex);
+	snd_soc_dpcm_mutex_unlock(fe);
 	return ret;
 }
 
@@ -2840,10 +2918,8 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 	int state;
 	int ret = 1;
-	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -2857,7 +2933,6 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 			}
 		}
 	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 	/* it's safe to do this BE DAI */
 	return ret;
-- 
2.40.1.495.gc816e09b53d-goog

