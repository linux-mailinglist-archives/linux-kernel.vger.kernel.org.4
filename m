Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C86FD81B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjEJH14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjEJH1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:27:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF677269E
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:27:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso174310866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683703666; x=1686295666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bNmaOH8hOKe+FXV9PlkqBsS7yyFGYnM5fSqJc6Zg8M=;
        b=DADDkOfmdzlakx1m9/PHB5TvV7043KRI3nQbryC6PTQO+agp0OMGan2sxKWoRt29vu
         E/Xa/4Hj/rVnvPfF9bS3QKXFviPrfbs0TO6xQvI36EuyqFXTmc1HciyIx3IorJKf81OM
         GSv2N4uIIJFh6yvia3vzuYeFragM1B4+L9arMEck3tDQarptAUItVA2PdQAo4B7zidx6
         EmrpGbz+QrUIdy30JtfQ0G3fME2WWqFmHo7ufr/TeGNQZdB0tgtBAH81ry574tF7qeoB
         5a/XFs1o779kDbLR7WI9CgJxCT5KaMeaT1hs9VoSWSd7AirLpX8kfWYm+TPlKcZ93snp
         Z9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683703666; x=1686295666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bNmaOH8hOKe+FXV9PlkqBsS7yyFGYnM5fSqJc6Zg8M=;
        b=j2YsUGZYWBvNm9BnuLt4Rv1N0IBKfN+xEZ4Ralg3EfkqPzujzwVw7OZifTjJLIXSas
         hObZh4pOoRNKYWLXGmvCb7aFjp3sOPqKHCM6ouXoVtyLBnEWN3Vv4aYkVPxMQtb3JfSo
         F1GjSIRaNoNIHpIFFsrNGjFSZ1PVfe3LKwxSGDPEQi0YJ3YL2uVOBR2HILb6LSby4xiJ
         Ue4FMa+9k5w+4cAdPwC5H682go8TOp6T+lqbzhhu+oxJf9GQFNIoVXAZT17b869cSeNV
         xVjkUMzv+eikueBeSaIH3ky8cfUCwB6OOyjn4hWlZZKpL5rNioT2wGS6GwHrXYEZzrFL
         QPJA==
X-Gm-Message-State: AC+VfDxE73QT/mzApHf6lLuQys/BznJXUAystBj8Hu009g8BFAyfZ3EX
        erjXmOdkx5jmzhjfMgFg7Do=
X-Google-Smtp-Source: ACHHUZ74x5zId9k1FmoJ6qedrP7LlwbyfJ1iMt9aHaEQxyIFsIu5WeFwJDOxoKGAsX4Uv+UvxO0jrw==
X-Received: by 2002:a17:906:2252:b0:965:bc62:fe38 with SMTP id 18-20020a170906225200b00965bc62fe38mr14117843ejr.7.1683703665665;
        Wed, 10 May 2023 00:27:45 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id y10-20020a170906914a00b009663cf5dc3bsm2280209ejw.53.2023.05.10.00.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 00:27:45 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, oswald.buddenhagen@gmx.de,
        axboe@kernel.dk, 42.hyeyoo@gmail.com, surenb@google.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] ALSA: PCM: Fix codestyle issues in pcm_native.c
Date:   Wed, 10 May 2023 11:27:26 +0400
Message-Id: <20230510072726.435247-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some obvious codestyle issues in the pcm_native.c file. Some of them
were found by checkpatch with --strict option, and the others by just
looking at the code. These issues include incorrect placement of brackets,
trailing and starting spaces, wrong alignment of function arguments,
incorrect multiline comments, using __attribute__((packed)) instead of just
"__packed", comparison with null instead of using "!". Also, today we have
100 columns per line available, and I tried to reformat the file
considering this.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/core/pcm_native.c | 696 +++++++++++++++++++---------------------
 1 file changed, 323 insertions(+), 373 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 39a65d1415ab..4a8d2e825b1d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -43,10 +43,9 @@
 
 struct snd_pcm_hw_params_old {
 	unsigned int flags;
-	unsigned int masks[SNDRV_PCM_HW_PARAM_SUBFORMAT -
-			   SNDRV_PCM_HW_PARAM_ACCESS + 1];
+	unsigned int masks[SNDRV_PCM_HW_PARAM_SUBFORMAT - SNDRV_PCM_HW_PARAM_ACCESS + 1];
 	struct snd_interval intervals[SNDRV_PCM_HW_PARAM_TICK_TIME -
-					SNDRV_PCM_HW_PARAM_SAMPLE_BITS + 1];
+				      SNDRV_PCM_HW_PARAM_SAMPLE_BITS + 1];
 	unsigned int rmask;
 	unsigned int cmask;
 	unsigned int info;
@@ -62,9 +61,9 @@ struct snd_pcm_hw_params_old {
 #define SNDRV_PCM_IOCTL_HW_PARAMS_OLD _IOWR('A', 0x11, struct snd_pcm_hw_params_old)
 
 static int snd_pcm_hw_refine_old_user(struct snd_pcm_substream *substream,
-				      struct snd_pcm_hw_params_old __user * _oparams);
+				      struct snd_pcm_hw_params_old __user *_oparams);
 static int snd_pcm_hw_params_old_user(struct snd_pcm_substream *substream,
-				      struct snd_pcm_hw_params_old __user * _oparams);
+				      struct snd_pcm_hw_params_old __user *_oparams);
 #endif
 static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream);
 
@@ -133,8 +132,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock);
  */
 void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 {
-	snd_pcm_group_lock_irq(&substream->self_group,
-			       substream->pcm->nonatomic);
+	snd_pcm_group_lock_irq(&substream->self_group, substream->pcm->nonatomic);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
 
@@ -164,6 +162,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irq);
 unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *substream)
 {
 	unsigned long flags = 0;
+
 	if (substream->pcm->nonatomic)
 		mutex_lock(&substream->self_group.mutex);
 	else
@@ -175,12 +174,11 @@ EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave);
 unsigned long _snd_pcm_stream_lock_irqsave_nested(struct snd_pcm_substream *substream)
 {
 	unsigned long flags = 0;
+
 	if (substream->pcm->nonatomic)
-		mutex_lock_nested(&substream->self_group.mutex,
-				  SINGLE_DEPTH_NESTING);
+		mutex_lock_nested(&substream->self_group.mutex, SINGLE_DEPTH_NESTING);
 	else
-		spin_lock_irqsave_nested(&substream->self_group.lock, flags,
-					 SINGLE_DEPTH_NESTING);
+		spin_lock_irqsave_nested(&substream->self_group.lock, flags, SINGLE_DEPTH_NESTING);
 	return flags;
 }
 EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave_nested);
@@ -192,8 +190,7 @@ EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave_nested);
  *
  * This is a counter-part of snd_pcm_stream_lock_irqsave().
  */
-void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
-				      unsigned long flags)
+void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream, unsigned long flags)
 {
 	if (substream->pcm->nonatomic)
 		mutex_unlock(&substream->self_group.mutex);
@@ -203,8 +200,7 @@ void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irqrestore);
 
 /* Run PCM ioctl ops */
-static int snd_pcm_ops_ioctl(struct snd_pcm_substream *substream,
-			     unsigned cmd, void *arg)
+static int snd_pcm_ops_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg)
 {
 	if (substream->ops->ioctl)
 		return substream->ops->ioctl(substream, cmd, arg);
@@ -233,14 +229,13 @@ int snd_pcm_info(struct snd_pcm_substream *substream, struct snd_pcm_info *info)
 	return 0;
 }
 
-int snd_pcm_info_user(struct snd_pcm_substream *substream,
-		      struct snd_pcm_info __user * _info)
+int snd_pcm_info_user(struct snd_pcm_substream *substream, struct snd_pcm_info __user *_info)
 {
 	struct snd_pcm_info *info;
 	int err;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (! info)
+	if (!info)
 		return -ENOMEM;
 	err = snd_pcm_info(substream, info);
 	if (err >= 0) {
@@ -284,8 +279,7 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 static int constrain_mask_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_hw_constraints *constrs =
-					&substream->runtime->hw_constraints;
+	struct snd_pcm_hw_constraints *constrs = &substream->runtime->hw_constraints;
 	struct snd_mask *m;
 	unsigned int k;
 	struct snd_mask old_mask __maybe_unused;
@@ -320,8 +314,7 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 static int constrain_interval_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_hw_constraints *constrs =
-					&substream->runtime->hw_constraints;
+	struct snd_pcm_hw_constraints *constrs = &substream->runtime->hw_constraints;
 	struct snd_interval *i;
 	unsigned int k;
 	struct snd_interval old_interval __maybe_unused;
@@ -356,8 +349,7 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_hw_constraints *constrs =
-					&substream->runtime->hw_constraints;
+	struct snd_pcm_hw_constraints *constrs = &substream->runtime->hw_constraints;
 	unsigned int k;
 	unsigned int *rstamps;
 	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
@@ -447,14 +439,12 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		 */
 		if (changed && r->var >= 0) {
 			if (hw_is_mask(r->var)) {
-				trace_hw_mask_param(substream, r->var,
-					k + 1, &old_mask,
-					hw_param_mask(params, r->var));
+				trace_hw_mask_param(substream, r->var, k + 1, &old_mask,
+						    hw_param_mask(params, r->var));
 			}
 			if (hw_is_interval(r->var)) {
-				trace_hw_interval_param(substream, r->var,
-					k + 1, &old_interval,
-					hw_param_interval(params, r->var));
+				trace_hw_interval_param(substream, r->var, k + 1, &old_interval,
+							hw_param_interval(params, r->var));
 			}
 
 			params->cmask |= PARAM_MASK_BIT(r->var);
@@ -509,18 +499,15 @@ static int fixup_unreferenced_params(struct snd_pcm_substream *substream,
 
 	if (!params->info) {
 		params->info = substream->runtime->hw.info;
-		params->info &= ~(SNDRV_PCM_INFO_FIFO_IN_FRAMES |
-				  SNDRV_PCM_INFO_DRAIN_TRIGGER);
+		params->info &= ~(SNDRV_PCM_INFO_FIFO_IN_FRAMES | SNDRV_PCM_INFO_DRAIN_TRIGGER);
 		if (!hw_support_mmap(substream))
-			params->info &= ~(SNDRV_PCM_INFO_MMAP |
-					  SNDRV_PCM_INFO_MMAP_VALID);
+			params->info &= ~(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID);
 	}
 
 	return 0;
 }
 
-int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
-		      struct snd_pcm_hw_params *params)
+int snd_pcm_hw_refine(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params)
 {
 	int err;
 
@@ -552,7 +539,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 EXPORT_SYMBOL(snd_pcm_hw_refine);
 
 static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params __user * _params)
+				  struct snd_pcm_hw_params __user *_params)
 {
 	struct snd_pcm_hw_params *params;
 	int err;
@@ -580,7 +567,7 @@ static int period_to_usecs(struct snd_pcm_runtime *runtime)
 {
 	int usecs;
 
-	if (! runtime->rate)
+	if (!runtime->rate)
 		return -1; /* invalid */
 
 	/* take 75% of period time as the deadline */
@@ -591,8 +578,7 @@ static int period_to_usecs(struct snd_pcm_runtime *runtime)
 	return usecs;
 }
 
-static void snd_pcm_set_state(struct snd_pcm_substream *substream,
-			      snd_pcm_state_t state)
+static void snd_pcm_set_state(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	snd_pcm_stream_lock_irq(substream);
 	if (substream->runtime->state != SNDRV_PCM_STATE_DISCONNECTED)
@@ -600,13 +586,11 @@ static void snd_pcm_set_state(struct snd_pcm_substream *substream,
 	snd_pcm_stream_unlock_irq(substream);
 }
 
-static inline void snd_pcm_timer_notify(struct snd_pcm_substream *substream,
-					int event)
+static inline void snd_pcm_timer_notify(struct snd_pcm_substream *substream, int event)
 {
 #ifdef CONFIG_SND_PCM_TIMER
 	if (substream->timer)
-		snd_timer_notify(substream->timer, event,
-					&substream->runtime->trigger_tstamp);
+		snd_timer_notify(substream->timer, event, &substream->runtime->trigger_tstamp);
 #endif
 }
 
@@ -672,10 +656,8 @@ static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
 			continue;
 
 		/* Trace the changed parameter. */
-		if (hw_is_mask(*v)) {
-			trace_hw_mask_param(pcm, *v, 0, &old_mask,
-					    hw_param_mask(params, *v));
-		}
+		if (hw_is_mask(*v))
+			trace_hw_mask_param(pcm, *v, 0, &old_mask, hw_param_mask(params, *v));
 		if (hw_is_interval(*v)) {
 			trace_hw_interval_param(pcm, *v, 0, &old_interval,
 						hw_param_interval(params, *v));
@@ -756,14 +738,13 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 		goto _error;
 
 	if (substream->managed_buffer_alloc) {
-		err = snd_pcm_lib_malloc_pages(substream,
-					       params_buffer_bytes(params));
+		err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
 		if (err < 0)
 			goto _error;
 		runtime->buffer_changed = err > 0;
 	}
 
-	if (substream->ops->hw_params != NULL) {
+	if (substream->ops->hw_params) {
 		err = substream->ops->hw_params(substream, params);
 		if (err < 0)
 			goto _error;
@@ -780,9 +761,8 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	runtime->info = params->info;
 	runtime->rate_num = params->rate_num;
 	runtime->rate_den = params->rate_den;
-	runtime->no_period_wakeup =
-			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
-			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
+	runtime->no_period_wakeup = (params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
+				    (params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
 
 	bits = snd_pcm_format_physical_width(runtime->format);
 	runtime->sample_bits = bits;
@@ -824,8 +804,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 		cpu_latency_qos_remove_request(&substream->latency_pm_qos_req);
 	usecs = period_to_usecs(runtime);
 	if (usecs >= 0)
-		cpu_latency_qos_add_request(&substream->latency_pm_qos_req,
-					    usecs);
+		cpu_latency_qos_add_request(&substream->latency_pm_qos_req, usecs);
 	err = 0;
  _error:
 	if (err) {
@@ -834,7 +813,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 		 * the correct hardware parameter settings
 		 */
 		snd_pcm_set_state(substream, SNDRV_PCM_STATE_OPEN);
-		if (substream->ops->hw_free != NULL)
+		if (substream->ops->hw_free)
 			substream->ops->hw_free(substream);
 		if (substream->managed_buffer_alloc)
 			snd_pcm_lib_free_pages(substream);
@@ -845,7 +824,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 }
 
 static int snd_pcm_hw_params_user(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params __user * _params)
+				  struct snd_pcm_hw_params __user *_params)
 {
 	struct snd_pcm_hw_params *params;
 	int err;
@@ -954,10 +933,9 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 	runtime->stop_threshold = params->stop_threshold;
 	runtime->silence_threshold = params->silence_threshold;
 	runtime->silence_size = params->silence_size;
-        params->boundary = runtime->boundary;
+	params->boundary = runtime->boundary;
 	if (snd_pcm_running(substream)) {
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-		    runtime->silence_size > 0)
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && runtime->silence_size > 0)
 			snd_pcm_playback_silence(substream, ULONG_MAX);
 		err = snd_pcm_update_state(substream, runtime);
 	}
@@ -966,10 +944,11 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 }
 
 static int snd_pcm_sw_params_user(struct snd_pcm_substream *substream,
-				  struct snd_pcm_sw_params __user * _params)
+				  struct snd_pcm_sw_params __user *_params)
 {
 	struct snd_pcm_sw_params params;
 	int err;
+
 	if (copy_from_user(&params, _params, sizeof(params)))
 		return -EFAULT;
 	err = snd_pcm_sw_params(substream, &params);
@@ -978,8 +957,7 @@ static int snd_pcm_sw_params_user(struct snd_pcm_substream *substream,
 	return err;
 }
 
-static inline snd_pcm_uframes_t
-snd_pcm_calc_delay(struct snd_pcm_substream *substream)
+static inline snd_pcm_uframes_t snd_pcm_calc_delay(struct snd_pcm_substream *substream)
 {
 	snd_pcm_uframes_t delay;
 
@@ -990,15 +968,14 @@ snd_pcm_calc_delay(struct snd_pcm_substream *substream)
 	return delay + substream->runtime->delay;
 }
 
-int snd_pcm_status64(struct snd_pcm_substream *substream,
-		     struct snd_pcm_status64 *status)
+int snd_pcm_status64(struct snd_pcm_substream *substream, struct snd_pcm_status64 *status)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	snd_pcm_stream_lock_irq(substream);
 
 	snd_pcm_unpack_audio_tstamp_config(status->audio_tstamp_data,
-					&runtime->audio_tstamp_config);
+					   &runtime->audio_tstamp_config);
 
 	/* backwards compatible behavior */
 	if (runtime->audio_tstamp_config.type_requested ==
@@ -1010,8 +987,9 @@ int snd_pcm_status64(struct snd_pcm_substream *substream,
 			runtime->audio_tstamp_config.type_requested =
 				SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT;
 		runtime->audio_tstamp_report.valid = 0;
-	} else
+	} else {
 		runtime->audio_tstamp_report.valid = 1;
+	}
 
 	status->state = runtime->state;
 	status->suspended_state = runtime->suspended_state;
@@ -1036,8 +1014,8 @@ int snd_pcm_status64(struct snd_pcm_substream *substream,
 			if (runtime->audio_tstamp_report.valid == 1)
 				/* backwards compatibility, no report provided in COMPAT mode */
 				snd_pcm_pack_audio_tstamp_report(&status->audio_tstamp_data,
-								&status->audio_tstamp_accuracy,
-								&runtime->audio_tstamp_report);
+								 &status->audio_tstamp_accuracy,
+								 &runtime->audio_tstamp_report);
 
 			goto _tstamp_end;
 		}
@@ -1055,19 +1033,18 @@ int snd_pcm_status64(struct snd_pcm_substream *substream,
 	status->appl_ptr = runtime->control->appl_ptr;
 	status->hw_ptr = runtime->status->hw_ptr;
 	status->avail = snd_pcm_avail(substream);
-	status->delay = snd_pcm_running(substream) ?
-		snd_pcm_calc_delay(substream) : 0;
+	status->delay = snd_pcm_running(substream) ? snd_pcm_calc_delay(substream) : 0;
 	status->avail_max = runtime->avail_max;
 	status->overrange = runtime->overrange;
 	runtime->avail_max = 0;
 	runtime->overrange = 0;
- _end:
- 	snd_pcm_stream_unlock_irq(substream);
+_end:
+	snd_pcm_stream_unlock_irq(substream);
 	return 0;
 }
 
 static int snd_pcm_status_user64(struct snd_pcm_substream *substream,
-				 struct snd_pcm_status64 __user * _status,
+				 struct snd_pcm_status64 __user *_status,
 				 bool ext)
 {
 	struct snd_pcm_status64 status;
@@ -1079,8 +1056,7 @@ static int snd_pcm_status_user64(struct snd_pcm_substream *substream,
 	 * get audio_tstamp_data from user,
 	 * ignore rest of status structure
 	 */
-	if (ext && get_user(status.audio_tstamp_data,
-				(u32 __user *)(&_status->audio_tstamp_data)))
+	if (ext && get_user(status.audio_tstamp_data, (u32 __user *)&_status->audio_tstamp_data))
 		return -EFAULT;
 	res = snd_pcm_status64(substream, &status);
 	if (res < 0)
@@ -1091,7 +1067,7 @@ static int snd_pcm_status_user64(struct snd_pcm_substream *substream,
 }
 
 static int snd_pcm_status_user32(struct snd_pcm_substream *substream,
-				 struct snd_pcm_status32 __user * _status,
+				 struct snd_pcm_status32 __user *_status,
 				 bool ext)
 {
 	struct snd_pcm_status64 status64;
@@ -1105,8 +1081,7 @@ static int snd_pcm_status_user32(struct snd_pcm_substream *substream,
 	 * get audio_tstamp_data from user,
 	 * ignore rest of status structure
 	 */
-	if (ext && get_user(status64.audio_tstamp_data,
-			    (u32 __user *)(&_status->audio_tstamp_data)))
+	if (ext && get_user(status64.audio_tstamp_data, (u32 __user *)&_status->audio_tstamp_data))
 		return -EFAULT;
 	res = snd_pcm_status64(substream, &status64);
 	if (res < 0)
@@ -1140,11 +1115,11 @@ static int snd_pcm_status_user32(struct snd_pcm_substream *substream,
 }
 
 static int snd_pcm_channel_info(struct snd_pcm_substream *substream,
-				struct snd_pcm_channel_info * info)
+				struct snd_pcm_channel_info *info)
 {
 	struct snd_pcm_runtime *runtime;
 	unsigned int channel;
-	
+
 	channel = info->channel;
 	runtime = substream->runtime;
 	snd_pcm_stream_lock_irq(substream);
@@ -1161,11 +1136,11 @@ static int snd_pcm_channel_info(struct snd_pcm_substream *substream,
 }
 
 static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
-				     struct snd_pcm_channel_info __user * _info)
+				     struct snd_pcm_channel_info __user *_info)
 {
 	struct snd_pcm_channel_info info;
 	int res;
-	
+
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
 	res = snd_pcm_channel_info(substream, &info);
@@ -1179,7 +1154,8 @@ static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
 static void snd_pcm_trigger_tstamp(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	if (runtime->trigger_master == NULL)
+
+	if (!runtime->trigger_master)
 		return;
 	if (runtime->trigger_master == substream) {
 		if (!runtime->trigger_tstamp_latched)
@@ -1191,17 +1167,13 @@ static void snd_pcm_trigger_tstamp(struct snd_pcm_substream *substream)
 	runtime->trigger_master = NULL;
 }
 
-#define ACTION_ARG_IGNORE	(__force snd_pcm_state_t)0
+#define ACTION_ARG_IGNORE ((__force snd_pcm_state_t)0)
 
 struct action_ops {
-	int (*pre_action)(struct snd_pcm_substream *substream,
-			  snd_pcm_state_t state);
-	int (*do_action)(struct snd_pcm_substream *substream,
-			 snd_pcm_state_t state);
-	void (*undo_action)(struct snd_pcm_substream *substream,
-			    snd_pcm_state_t state);
-	void (*post_action)(struct snd_pcm_substream *substream,
-			    snd_pcm_state_t state);
+	int (*pre_action)(struct snd_pcm_substream *substream, snd_pcm_state_t state);
+	int (*do_action)(struct snd_pcm_substream *substream, snd_pcm_state_t state);
+	void (*undo_action)(struct snd_pcm_substream *substream, snd_pcm_state_t state);
+	void (*post_action)(struct snd_pcm_substream *substream, snd_pcm_state_t state);
 };
 
 /*
@@ -1209,10 +1181,8 @@ struct action_ops {
  *  Note: the stream state might be changed also on failure
  *  Note2: call with calling stream lock + link lock
  */
-static int snd_pcm_action_group(const struct action_ops *ops,
-				struct snd_pcm_substream *substream,
-				snd_pcm_state_t state,
-				bool stream_lock)
+static int snd_pcm_action_group(const struct action_ops *ops, struct snd_pcm_substream *substream,
+				snd_pcm_state_t state, bool stream_lock)
 {
 	struct snd_pcm_substream *s = NULL;
 	struct snd_pcm_substream *s1;
@@ -1274,7 +1244,7 @@ static int snd_pcm_action_single(const struct action_ops *ops,
 				 snd_pcm_state_t state)
 {
 	int res;
-	
+
 	res = ops->pre_action(substream, state);
 	if (res < 0)
 		return res;
@@ -1297,8 +1267,7 @@ static void snd_pcm_group_assign(struct snd_pcm_substream *substream,
  * Unref and unlock the group, but keep the stream lock;
  * when the group becomes empty and no longer referred, destroy itself
  */
-static void snd_pcm_group_unref(struct snd_pcm_group *group,
-				struct snd_pcm_substream *substream)
+static void snd_pcm_group_unref(struct snd_pcm_group *group, struct snd_pcm_substream *substream)
 {
 	bool do_free;
 
@@ -1314,8 +1283,7 @@ static void snd_pcm_group_unref(struct snd_pcm_group *group,
  * Lock the group inside a stream lock and reference it;
  * return the locked group object, or NULL if not linked
  */
-static struct snd_pcm_group *
-snd_pcm_stream_group_ref(struct snd_pcm_substream *substream)
+static struct snd_pcm_group *snd_pcm_stream_group_ref(struct snd_pcm_substream *substream)
 {
 	bool nonatomic = substream->pcm->nonatomic;
 	struct snd_pcm_group *group;
@@ -1328,8 +1296,7 @@ snd_pcm_stream_group_ref(struct snd_pcm_substream *substream)
 		/* block freeing the group object */
 		refcount_inc(&group->refs);
 
-		trylock = nonatomic ? mutex_trylock(&group->mutex) :
-			spin_trylock(&group->lock);
+		trylock = nonatomic ? mutex_trylock(&group->mutex) : spin_trylock(&group->lock);
 		if (trylock)
 			break; /* OK */
 
@@ -1411,10 +1378,10 @@ static int snd_pcm_pre_start(struct snd_pcm_substream *substream,
 			     snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	if (runtime->state != SNDRV_PCM_STATE_PREPARED)
 		return -EBADFD;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    !snd_pcm_playback_data(substream))
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && !snd_pcm_playback_data(substream))
 		return -EPIPE;
 	runtime->trigger_tstamp_latched = false;
 	runtime->trigger_master = substream;
@@ -1448,13 +1415,12 @@ static void snd_pcm_post_start(struct snd_pcm_substream *substream,
 			       snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	snd_pcm_trigger_tstamp(substream);
 	runtime->hw_ptr_jiffies = jiffies;
-	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) / 
-							    runtime->rate;
+	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) / runtime->rate;
 	__snd_pcm_set_state(runtime, state);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    runtime->silence_size > 0)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && runtime->silence_size > 0)
 		snd_pcm_playback_silence(substream, ULONG_MAX);
 	snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MSTART);
 }
@@ -1475,15 +1441,13 @@ static const struct action_ops snd_pcm_action_start = {
  */
 int snd_pcm_start(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_action(&snd_pcm_action_start, substream,
-			      SNDRV_PCM_STATE_RUNNING);
+	return snd_pcm_action(&snd_pcm_action_start, substream, SNDRV_PCM_STATE_RUNNING);
 }
 
 /* take the stream lock and start the streams */
 static int snd_pcm_start_lock_irq(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_action_lock_irq(&snd_pcm_action_start, substream,
-				       SNDRV_PCM_STATE_RUNNING);
+	return snd_pcm_action_lock_irq(&snd_pcm_action_start, substream, SNDRV_PCM_STATE_RUNNING);
 }
 
 /*
@@ -1493,6 +1457,7 @@ static int snd_pcm_pre_stop(struct snd_pcm_substream *substream,
 			    snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	if (runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 	runtime->trigger_master = substream;
@@ -1502,8 +1467,7 @@ static int snd_pcm_pre_stop(struct snd_pcm_substream *substream,
 static int snd_pcm_do_stop(struct snd_pcm_substream *substream,
 			   snd_pcm_state_t state)
 {
-	if (substream->runtime->trigger_master == substream &&
-	    snd_pcm_running(substream)) {
+	if (substream->runtime->trigger_master == substream && snd_pcm_running(substream)) {
 		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
 		substream->runtime->stop_operating = true;
 	}
@@ -1514,6 +1478,7 @@ static void snd_pcm_post_stop(struct snd_pcm_substream *substream,
 			      snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	if (runtime->state != state) {
 		snd_pcm_trigger_tstamp(substream);
 		__snd_pcm_set_state(runtime, state);
@@ -1555,8 +1520,7 @@ EXPORT_SYMBOL(snd_pcm_stop);
  */
 int snd_pcm_drain_done(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_action_single(&snd_pcm_action_stop, substream,
-				     SNDRV_PCM_STATE_SETUP);
+	return snd_pcm_action_single(&snd_pcm_action_stop, substream, SNDRV_PCM_STATE_SETUP);
 }
 
 /**
@@ -1583,19 +1547,20 @@ EXPORT_SYMBOL_GPL(snd_pcm_stop_xrun);
 /*
  * pause callbacks: pass boolean (to start pause or resume) as state argument
  */
-#define pause_pushed(state)	(__force bool)(state)
+#define pause_pushed(state) ((__force bool)(state))
 
-static int snd_pcm_pre_pause(struct snd_pcm_substream *substream,
-			     snd_pcm_state_t state)
+static int snd_pcm_pre_pause(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	if (!(runtime->info & SNDRV_PCM_INFO_PAUSE))
 		return -ENOSYS;
 	if (pause_pushed(state)) {
 		if (runtime->state != SNDRV_PCM_STATE_RUNNING)
 			return -EBADFD;
-	} else if (runtime->state != SNDRV_PCM_STATE_PAUSED)
+	} else if (runtime->state != SNDRV_PCM_STATE_PAUSED) {
 		return -EBADFD;
+	}
 	runtime->trigger_master = substream;
 	return 0;
 }
@@ -1605,8 +1570,7 @@ static int snd_pcm_do_pause(struct snd_pcm_substream *substream,
 {
 	if (substream->runtime->trigger_master != substream)
 		return 0;
-	/* some drivers might use hw_ptr to recover from the pause -
-	   update the hw_ptr now */
+	// some drivers might use hw_ptr to recover from the pause - update the hw_ptr now
 	if (pause_pushed(state))
 		snd_pcm_update_hw_ptr(substream);
 	/* The jiffies check in snd_pcm_update_hw_ptr*() is done by
@@ -1614,26 +1578,23 @@ static int snd_pcm_do_pause(struct snd_pcm_substream *substream,
 	 * delta, effectively to skip the check once.
 	 */
 	substream->runtime->hw_ptr_jiffies = jiffies - HZ * 1000;
-	return substream->ops->trigger(substream,
-				       pause_pushed(state) ?
+	return substream->ops->trigger(substream, pause_pushed(state) ?
 				       SNDRV_PCM_TRIGGER_PAUSE_PUSH :
 				       SNDRV_PCM_TRIGGER_PAUSE_RELEASE);
 }
 
-static void snd_pcm_undo_pause(struct snd_pcm_substream *substream,
-			       snd_pcm_state_t state)
+static void snd_pcm_undo_pause(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	if (substream->runtime->trigger_master == substream)
-		substream->ops->trigger(substream,
-					pause_pushed(state) ?
+		substream->ops->trigger(substream, pause_pushed(state) ?
 					SNDRV_PCM_TRIGGER_PAUSE_RELEASE :
 					SNDRV_PCM_TRIGGER_PAUSE_PUSH);
 }
 
-static void snd_pcm_post_pause(struct snd_pcm_substream *substream,
-			       snd_pcm_state_t state)
+static void snd_pcm_post_pause(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	snd_pcm_trigger_tstamp(substream);
 	if (pause_pushed(state)) {
 		__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_PAUSED);
@@ -1658,24 +1619,23 @@ static const struct action_ops snd_pcm_action_pause = {
  */
 static int snd_pcm_pause(struct snd_pcm_substream *substream, bool push)
 {
-	return snd_pcm_action(&snd_pcm_action_pause, substream,
-			      (__force snd_pcm_state_t)push);
+	return snd_pcm_action(&snd_pcm_action_pause, substream, (__force snd_pcm_state_t)push);
 }
 
-static int snd_pcm_pause_lock_irq(struct snd_pcm_substream *substream,
-				  bool push)
+static int snd_pcm_pause_lock_irq(struct snd_pcm_substream *substream, bool push)
 {
 	return snd_pcm_action_lock_irq(&snd_pcm_action_pause, substream,
 				       (__force snd_pcm_state_t)push);
 }
 
 #ifdef CONFIG_PM
+
 /* suspend callback: state argument ignored */
 
-static int snd_pcm_pre_suspend(struct snd_pcm_substream *substream,
-			       snd_pcm_state_t state)
+static int snd_pcm_pre_suspend(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	switch (runtime->state) {
 	case SNDRV_PCM_STATE_SUSPENDED:
 		return -EBUSY;
@@ -1689,23 +1649,23 @@ static int snd_pcm_pre_suspend(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int snd_pcm_do_suspend(struct snd_pcm_substream *substream,
-			      snd_pcm_state_t state)
+static int snd_pcm_do_suspend(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	if (runtime->trigger_master != substream)
 		return 0;
-	if (! snd_pcm_running(substream))
+	if (!snd_pcm_running(substream))
 		return 0;
 	substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_SUSPEND);
 	runtime->stop_operating = true;
 	return 0; /* suspend unconditionally */
 }
 
-static void snd_pcm_post_suspend(struct snd_pcm_substream *substream,
-				 snd_pcm_state_t state)
+static void snd_pcm_post_suspend(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	snd_pcm_trigger_tstamp(substream);
 	runtime->suspended_state = runtime->state;
 	runtime->status->suspended_state = runtime->suspended_state;
@@ -1735,8 +1695,7 @@ static int snd_pcm_suspend(struct snd_pcm_substream *substream)
 	unsigned long flags;
 
 	snd_pcm_stream_lock_irqsave(substream, flags);
-	err = snd_pcm_action(&snd_pcm_action_suspend, substream,
-			     ACTION_ARG_IGNORE);
+	err = snd_pcm_action(&snd_pcm_action_suspend, substream, ACTION_ARG_IGNORE);
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
 	return err;
 }
@@ -1754,7 +1713,7 @@ int snd_pcm_suspend_all(struct snd_pcm *pcm)
 	struct snd_pcm_substream *substream;
 	int stream, err = 0;
 
-	if (! pcm)
+	if (!pcm)
 		return 0;
 
 	for_each_pcm_substream(pcm, stream, substream) {
@@ -1783,20 +1742,20 @@ EXPORT_SYMBOL(snd_pcm_suspend_all);
 
 /* resume callbacks: state argument ignored */
 
-static int snd_pcm_pre_resume(struct snd_pcm_substream *substream,
-			      snd_pcm_state_t state)
+static int snd_pcm_pre_resume(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	if (!(runtime->info & SNDRV_PCM_INFO_RESUME))
 		return -ENOSYS;
 	runtime->trigger_master = substream;
 	return 0;
 }
 
-static int snd_pcm_do_resume(struct snd_pcm_substream *substream,
-			     snd_pcm_state_t state)
+static int snd_pcm_do_resume(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	if (runtime->trigger_master != substream)
 		return 0;
 	/* DMA not running previously? */
@@ -1807,18 +1766,16 @@ static int snd_pcm_do_resume(struct snd_pcm_substream *substream,
 	return substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_RESUME);
 }
 
-static void snd_pcm_undo_resume(struct snd_pcm_substream *substream,
-				snd_pcm_state_t state)
+static void snd_pcm_undo_resume(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
-	if (substream->runtime->trigger_master == substream &&
-	    snd_pcm_running(substream))
+	if (substream->runtime->trigger_master == substream && snd_pcm_running(substream))
 		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_SUSPEND);
 }
 
-static void snd_pcm_post_resume(struct snd_pcm_substream *substream,
-				snd_pcm_state_t state)
+static void snd_pcm_post_resume(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	snd_pcm_trigger_tstamp(substream);
 	__snd_pcm_set_state(runtime, runtime->suspended_state);
 	snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MRESUME);
@@ -1833,8 +1790,7 @@ static const struct action_ops snd_pcm_action_resume = {
 
 static int snd_pcm_resume(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_action_lock_irq(&snd_pcm_action_resume, substream,
-				       ACTION_ARG_IGNORE);
+	return snd_pcm_action_lock_irq(&snd_pcm_action_resume, substream, ACTION_ARG_IGNORE);
 }
 
 #else
@@ -1876,10 +1832,10 @@ static int snd_pcm_xrun(struct snd_pcm_substream *substream)
  * reset ioctl
  */
 /* reset callbacks:  state argument ignored */
-static int snd_pcm_pre_reset(struct snd_pcm_substream *substream,
-			     snd_pcm_state_t state)
+static int snd_pcm_pre_reset(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	switch (runtime->state) {
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PREPARED:
@@ -1891,11 +1847,12 @@ static int snd_pcm_pre_reset(struct snd_pcm_substream *substream,
 	}
 }
 
-static int snd_pcm_do_reset(struct snd_pcm_substream *substream,
-			    snd_pcm_state_t state)
+static int snd_pcm_do_reset(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err = snd_pcm_ops_ioctl(substream, SNDRV_PCM_IOCTL1_RESET, NULL);
+	int err;
+
+	err = snd_pcm_ops_ioctl(substream, SNDRV_PCM_IOCTL1_RESET, NULL);
 	if (err < 0)
 		return err;
 	snd_pcm_stream_lock_irq(substream);
@@ -1908,14 +1865,13 @@ static int snd_pcm_do_reset(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void snd_pcm_post_reset(struct snd_pcm_substream *substream,
-			       snd_pcm_state_t state)
+static void snd_pcm_post_reset(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	snd_pcm_stream_lock_irq(substream);
 	runtime->control->appl_ptr = runtime->status->hw_ptr;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    runtime->silence_size > 0)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && runtime->silence_size > 0)
 		snd_pcm_playback_silence(substream, ULONG_MAX);
 	snd_pcm_stream_unlock_irq(substream);
 }
@@ -1928,16 +1884,14 @@ static const struct action_ops snd_pcm_action_reset = {
 
 static int snd_pcm_reset(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_action_nonatomic(&snd_pcm_action_reset, substream,
-					ACTION_ARG_IGNORE);
+	return snd_pcm_action_nonatomic(&snd_pcm_action_reset, substream, ACTION_ARG_IGNORE);
 }
 
 /*
  * prepare ioctl
  */
 /* pass f_flags as state argument */
-static int snd_pcm_pre_prepare(struct snd_pcm_substream *substream,
-			       snd_pcm_state_t state)
+static int snd_pcm_pre_prepare(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int f_flags = (__force int)state;
@@ -1951,10 +1905,10 @@ static int snd_pcm_pre_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int snd_pcm_do_prepare(struct snd_pcm_substream *substream,
-			      snd_pcm_state_t state)
+static int snd_pcm_do_prepare(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	int err;
+
 	snd_pcm_sync_stop(substream, true);
 	err = substream->ops->prepare(substream);
 	if (err < 0)
@@ -1962,10 +1916,10 @@ static int snd_pcm_do_prepare(struct snd_pcm_substream *substream,
 	return snd_pcm_do_reset(substream, state);
 }
 
-static void snd_pcm_post_prepare(struct snd_pcm_substream *substream,
-				 snd_pcm_state_t state)
+static void snd_pcm_post_prepare(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	runtime->control->appl_ptr = runtime->status->hw_ptr;
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_PREPARED);
 }
@@ -1983,8 +1937,7 @@ static const struct action_ops snd_pcm_action_prepare = {
  *
  * Return: Zero if successful, or a negative error code.
  */
-static int snd_pcm_prepare(struct snd_pcm_substream *substream,
-			   struct file *file)
+static int snd_pcm_prepare(struct snd_pcm_substream *substream, struct file *file)
 {
 	int f_flags;
 
@@ -2004,8 +1957,7 @@ static int snd_pcm_prepare(struct snd_pcm_substream *substream,
 	}
 	snd_pcm_stream_unlock_irq(substream);
 
-	return snd_pcm_action_nonatomic(&snd_pcm_action_prepare,
-					substream,
+	return snd_pcm_action_nonatomic(&snd_pcm_action_prepare, substream,
 					(__force snd_pcm_state_t)f_flags);
 }
 
@@ -2014,10 +1966,10 @@ static int snd_pcm_prepare(struct snd_pcm_substream *substream,
  */
 
 /* drain init callbacks: state argument ignored */
-static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream,
-				  snd_pcm_state_t state)
+static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	switch (runtime->state) {
 	case SNDRV_PCM_STATE_OPEN:
 	case SNDRV_PCM_STATE_DISCONNECTED:
@@ -2028,15 +1980,15 @@ static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream,
-				 snd_pcm_state_t state)
+static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		switch (runtime->state) {
 		case SNDRV_PCM_STATE_PREPARED:
 			/* start playback stream if possible */
-			if (! snd_pcm_playback_empty(substream)) {
+			if (!snd_pcm_playback_empty(substream)) {
 				snd_pcm_do_start(substream, SNDRV_PCM_STATE_DRAINING);
 				snd_pcm_post_start(substream, SNDRV_PCM_STATE_DRAINING);
 			} else {
@@ -2064,17 +2016,15 @@ static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (runtime->state == SNDRV_PCM_STATE_DRAINING &&
-	    runtime->trigger_master == substream &&
-	    (runtime->hw.info & SNDRV_PCM_INFO_DRAIN_TRIGGER))
+	if (runtime->state == SNDRV_PCM_STATE_DRAINING && runtime->trigger_master == substream &&
+	    runtime->hw.info & SNDRV_PCM_INFO_DRAIN_TRIGGER)
 		return substream->ops->trigger(substream,
 					       SNDRV_PCM_TRIGGER_DRAIN);
 
 	return 0;
 }
 
-static void snd_pcm_post_drain_init(struct snd_pcm_substream *substream,
-				    snd_pcm_state_t state)
+static void snd_pcm_post_drain_init(struct snd_pcm_substream *substream, snd_pcm_state_t state)
 {
 }
 
@@ -2091,8 +2041,7 @@ static const struct action_ops snd_pcm_action_drain_init = {
  * After this call, all streams are supposed to be either SETUP or DRAINING
  * (capture only) state.
  */
-static int snd_pcm_drain(struct snd_pcm_substream *substream,
-			 struct file *file)
+static int snd_pcm_drain(struct snd_pcm_substream *substream, struct file *file)
 {
 	struct snd_card *card;
 	struct snd_pcm_runtime *runtime;
@@ -2111,8 +2060,9 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 	if (file) {
 		if (file->f_flags & O_NONBLOCK)
 			nonblock = 1;
-	} else if (substream->f_flags & O_NONBLOCK)
+	} else if (substream->f_flags & O_NONBLOCK) {
 		nonblock = 1;
+	}
 
 	snd_pcm_stream_lock_irq(substream);
 	/* resume pause */
@@ -2120,8 +2070,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		snd_pcm_pause(substream, false);
 
 	/* pre-start/stop - all running streams are changed to DRAINING state */
-	result = snd_pcm_action(&snd_pcm_action_drain_init, substream,
-				ACTION_ARG_IGNORE);
+	result = snd_pcm_action(&snd_pcm_action_drain_init, substream, ACTION_ARG_IGNORE);
 	if (result < 0)
 		goto unlock;
 	/* in non-blocking, we don't wait in ioctl but let caller poll */
@@ -2131,8 +2080,9 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 	}
 
 	for (;;) {
-		long tout;
+		long tout, t;
 		struct snd_pcm_runtime *to_check;
+
 		if (signal_pending(current)) {
 			result = -ERESTARTSYS;
 			break;
@@ -2156,12 +2106,12 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&to_check->sleep, &wait);
 		snd_pcm_stream_unlock_irq(substream);
-		if (runtime->no_period_wakeup)
+		if (runtime->no_period_wakeup) {
 			tout = MAX_SCHEDULE_TIMEOUT;
-		else {
+		} else {
 			tout = 100;
 			if (runtime->rate) {
-				long t = runtime->buffer_size * 1100 / runtime->rate;
+				t = runtime->buffer_size * 1100 / runtime->rate;
 				tout = max(t, tout);
 			}
 			tout = msecs_to_jiffies(tout);
@@ -2183,9 +2133,9 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 			break;
 		}
 		if (tout == 0) {
-			if (substream->runtime->state == SNDRV_PCM_STATE_SUSPENDED)
+			if (substream->runtime->state == SNDRV_PCM_STATE_SUSPENDED) {
 				result = -ESTRPIPE;
-			else {
+			} else {
 				dev_dbg(substream->pcm->card->dev,
 					"playback drain timeout (DMA or IRQ trouble?)\n");
 				snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
@@ -2195,7 +2145,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		}
 	}
 
- unlock:
+unlock:
 	snd_pcm_stream_unlock_irq(substream);
 
 	return result;
@@ -2210,7 +2160,7 @@ static int snd_pcm_drop(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
 	int result = 0;
-	
+
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
@@ -2231,7 +2181,6 @@ static int snd_pcm_drop(struct snd_pcm_substream *substream)
 	return result;
 }
 
-
 static bool is_pcm_file(struct file *file)
 {
 	struct inode *inode = file_inode(file);
@@ -2347,8 +2296,7 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 
 	/* detach the last stream, too */
 	if (list_is_singular(&group->substreams)) {
-		relink_to_local(list_first_entry(&group->substreams,
-						 struct snd_pcm_substream,
+		relink_to_local(list_first_entry(&group->substreams, struct snd_pcm_substream,
 						 link_list));
 		do_free = refcount_dec_and_test(&group->refs);
 	}
@@ -2357,7 +2305,7 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 	if (do_free)
 		kfree(group);
 
-       _end:
+_end:
 	up_write(&snd_pcm_link_rwsem);
 	return res;
 }
@@ -2365,62 +2313,62 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 /*
  * hw configurator
  */
-static int snd_pcm_hw_rule_mul(struct snd_pcm_hw_params *params,
-			       struct snd_pcm_hw_rule *rule)
+static int snd_pcm_hw_rule_mul(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
+
 	snd_interval_mul(hw_param_interval_c(params, rule->deps[0]),
-		     hw_param_interval_c(params, rule->deps[1]), &t);
+			 hw_param_interval_c(params, rule->deps[1]), &t);
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
-static int snd_pcm_hw_rule_div(struct snd_pcm_hw_params *params,
-			       struct snd_pcm_hw_rule *rule)
+static int snd_pcm_hw_rule_div(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
+
 	snd_interval_div(hw_param_interval_c(params, rule->deps[0]),
-		     hw_param_interval_c(params, rule->deps[1]), &t);
+			 hw_param_interval_c(params, rule->deps[1]), &t);
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
-static int snd_pcm_hw_rule_muldivk(struct snd_pcm_hw_params *params,
-				   struct snd_pcm_hw_rule *rule)
+static int snd_pcm_hw_rule_muldivk(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
+
 	snd_interval_muldivk(hw_param_interval_c(params, rule->deps[0]),
-			 hw_param_interval_c(params, rule->deps[1]),
-			 (unsigned long) rule->private, &t);
+			     hw_param_interval_c(params, rule->deps[1]),
+			     (unsigned long)rule->private, &t);
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
-static int snd_pcm_hw_rule_mulkdiv(struct snd_pcm_hw_params *params,
-				   struct snd_pcm_hw_rule *rule)
+static int snd_pcm_hw_rule_mulkdiv(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
+
 	snd_interval_mulkdiv(hw_param_interval_c(params, rule->deps[0]),
-			 (unsigned long) rule->private,
-			 hw_param_interval_c(params, rule->deps[1]), &t);
+			     (unsigned long)rule->private,
+			     hw_param_interval_c(params, rule->deps[1]), &t);
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
-static int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params,
-				  struct snd_pcm_hw_rule *rule)
+static int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
 {
 	snd_pcm_format_t k;
-	const struct snd_interval *i =
-				hw_param_interval_c(params, rule->deps[0]);
+	const struct snd_interval *i = hw_param_interval_c(params, rule->deps[0]);
 	struct snd_mask m;
 	struct snd_mask *mask = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+
 	snd_mask_any(&m);
 	pcm_for_each_format(k) {
 		int bits;
+
 		if (!snd_mask_test_format(mask, k))
 			continue;
 		bits = snd_pcm_format_physical_width(k);
 		if (bits <= 0)
 			continue; /* ignore invalid formats */
-		if ((unsigned)bits < i->min || (unsigned)bits > i->max)
-			snd_mask_reset(&m, (__force unsigned)k);
+		if ((unsigned int)bits < i->min || (unsigned int)bits > i->max)
+			snd_mask_reset(&m, (__force unsigned int)k);
 	}
 	return snd_mask_refine(mask, &m);
 }
@@ -2437,14 +2385,15 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 	t.openmax = 0;
 	pcm_for_each_format(k) {
 		int bits;
+
 		if (!snd_mask_test_format(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT), k))
 			continue;
 		bits = snd_pcm_format_physical_width(k);
 		if (bits <= 0)
 			continue; /* ignore invalid formats */
-		if (t.min > (unsigned)bits)
+		if (t.min > (unsigned int)bits)
 			t.min = bits;
-		if (t.max < (unsigned)bits)
+		if (t.max < (unsigned int)bits)
 			t.max = bits;
 	}
 	t.integer = 1;
@@ -2465,27 +2414,28 @@ const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
 	.list = rates,
 };
 
-static int snd_pcm_hw_rule_rate(struct snd_pcm_hw_params *params,
-				struct snd_pcm_hw_rule *rule)
+static int snd_pcm_hw_rule_rate(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
 {
 	struct snd_pcm_hardware *hw = rule->private;
+
 	return snd_interval_list(hw_param_interval(params, rule->var),
 				 snd_pcm_known_rates.count,
 				 snd_pcm_known_rates.list, hw->rates);
-}		
+}
 
 static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 					    struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
 	struct snd_pcm_substream *substream = rule->private;
+
 	t.min = 0;
 	t.max = substream->buffer_bytes_max;
 	t.openmin = 0;
 	t.openmax = 0;
 	t.integer = 1;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
-}		
+}
 
 static int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 {
@@ -2493,13 +2443,11 @@ static int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 	struct snd_pcm_hw_constraints *constrs = &runtime->hw_constraints;
 	int k, err;
 
-	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK; k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++) {
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK; k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++)
 		snd_mask_any(constrs_mask(constrs, k));
-	}
 
-	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) {
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++)
 		snd_interval_any(constrs_interval(constrs, k));
-	}
 
 	snd_interval_setinteger(constrs_interval(constrs, SNDRV_PCM_HW_PARAM_CHANNELS));
 	snd_interval_setinteger(constrs_interval(constrs, SNDRV_PCM_HW_PARAM_BUFFER_SIZE));
@@ -2508,103 +2456,115 @@ static int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 	snd_interval_setinteger(constrs_interval(constrs, SNDRV_PCM_HW_PARAM_FRAME_BITS));
 
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
-				   snd_pcm_hw_rule_format, NULL,
+				  snd_pcm_hw_rule_format, NULL,
 				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				  snd_pcm_hw_rule_sample_bits, NULL,
-				  SNDRV_PCM_HW_PARAM_FORMAT, 
+				  SNDRV_PCM_HW_PARAM_FORMAT,
 				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				  snd_pcm_hw_rule_div, NULL,
-				  SNDRV_PCM_HW_PARAM_FRAME_BITS, SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+				  SNDRV_PCM_HW_PARAM_FRAME_BITS,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
 				  snd_pcm_hw_rule_mul, NULL,
-				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS, 
-				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
-				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
+				  snd_pcm_hw_rule_mulkdiv, (void *)8,
+				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS, 
-				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
-				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
+				  snd_pcm_hw_rule_mulkdiv, (void *)8,
+				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				  snd_pcm_hw_rule_div, NULL,
-				  SNDRV_PCM_HW_PARAM_FRAME_BITS, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
+				  SNDRV_PCM_HW_PARAM_FRAME_BITS,
+				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
-				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
-				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_PERIOD_TIME, -1);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  snd_pcm_hw_rule_mulkdiv, (void *)1000000,
+				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+				  SNDRV_PCM_HW_PARAM_PERIOD_TIME, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
-				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
-				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_BUFFER_TIME, -1);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  snd_pcm_hw_rule_mulkdiv, (void *)1000000,
+				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+				  SNDRV_PCM_HW_PARAM_BUFFER_TIME, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIODS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIODS,
 				  snd_pcm_hw_rule_div, NULL,
-				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
+				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				  snd_pcm_hw_rule_div, NULL,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_PERIODS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
-				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
-				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+				  snd_pcm_hw_rule_mulkdiv, (void *)8,
+				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				  SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
-				  snd_pcm_hw_rule_muldivk, (void*) 1000000,
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+				  snd_pcm_hw_rule_muldivk, (void *)1000000,
 				  SNDRV_PCM_HW_PARAM_PERIOD_TIME, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				  snd_pcm_hw_rule_mul, NULL,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_PERIODS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 
-				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
-				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+				  snd_pcm_hw_rule_mulkdiv, (void *)8,
+				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				  SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 
-				  snd_pcm_hw_rule_muldivk, (void*) 1000000,
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+				  snd_pcm_hw_rule_muldivk, (void *)1000000,
 				  SNDRV_PCM_HW_PARAM_BUFFER_TIME, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 
-				  snd_pcm_hw_rule_muldivk, (void*) 8,
-				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				  snd_pcm_hw_rule_muldivk, (void *)8,
+				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+				  SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 
-				  snd_pcm_hw_rule_muldivk, (void*) 8,
-				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				  snd_pcm_hw_rule_muldivk, (void *)8,
+				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+				  SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_TIME, 
-				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+				  snd_pcm_hw_rule_mulkdiv, (void *)1000000,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 
-				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_TIME,
+				  snd_pcm_hw_rule_mulkdiv, (void *)1000000,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
@@ -2618,9 +2578,9 @@ static int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	int err;
 	unsigned int mask = 0;
 
-        if (hw->info & SNDRV_PCM_INFO_INTERLEAVED)
+	if (hw->info & SNDRV_PCM_INFO_INTERLEAVED)
 		mask |= PARAM_MASK_BIT(SNDRV_PCM_ACCESS_RW_INTERLEAVED);
-        if (hw->info & SNDRV_PCM_INFO_NONINTERLEAVED)
+	if (hw->info & SNDRV_PCM_INFO_NONINTERLEAVED)
 		mask |= PARAM_MASK_BIT(SNDRV_PCM_ACCESS_RW_NONINTERLEAVED);
 	if (hw_support_mmap(substream)) {
 		if (hw->info & SNDRV_PCM_INFO_INTERLEAVED)
@@ -2668,7 +2628,7 @@ static int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				  snd_pcm_hw_rule_buffer_bytes_max, substream,
 				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, -1);
 	if (err < 0)
@@ -2676,13 +2636,14 @@ static int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 
 	/* FIXME: remove */
 	if (runtime->dma_bytes) {
-		err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 0, runtime->dma_bytes);
+		err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+						   0, runtime->dma_bytes);
 		if (err < 0)
 			return err;
 	}
 
 	if (!(hw->rates & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))) {
-		err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
+		err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 					  snd_pcm_hw_rule_rate, hw,
 					  SNDRV_PCM_HW_PARAM_RATE, -1);
 		if (err < 0)
@@ -2724,8 +2685,7 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL(snd_pcm_release_substream);
 
-int snd_pcm_open_substream(struct snd_pcm *pcm, int stream,
-			   struct file *file,
+int snd_pcm_open_substream(struct snd_pcm *pcm, int stream, struct file *file,
 			   struct snd_pcm_substream **rsubstream)
 {
 	struct snd_pcm_substream *substream;
@@ -2760,8 +2720,7 @@ int snd_pcm_open_substream(struct snd_pcm *pcm, int stream,
 	/* automatically set EXPLICIT_SYNC flag in the managed mode whenever
 	 * the DMA buffer requires it
 	 */
-	if (substream->managed_buffer_alloc &&
-	    substream->dma_buffer.dev.need_sync)
+	if (substream->managed_buffer_alloc && substream->dma_buffer.dev.need_sync)
 		substream->runtime->hw.info |= SNDRV_PCM_INFO_EXPLICIT_SYNC;
 
 	*rsubstream = substream;
@@ -2773,9 +2732,7 @@ int snd_pcm_open_substream(struct snd_pcm *pcm, int stream,
 }
 EXPORT_SYMBOL(snd_pcm_open_substream);
 
-static int snd_pcm_open_file(struct file *file,
-			     struct snd_pcm *pcm,
-			     int stream)
+static int snd_pcm_open_file(struct file *file, struct snd_pcm *pcm, int stream)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
@@ -2786,7 +2743,7 @@ static int snd_pcm_open_file(struct file *file,
 		return err;
 
 	pcm_file = kzalloc(sizeof(*pcm_file), GFP_KERNEL);
-	if (pcm_file == NULL) {
+	if (!pcm_file) {
 		snd_pcm_release_substream(substream);
 		return -ENOMEM;
 	}
@@ -2802,10 +2759,10 @@ static int snd_pcm_playback_open(struct inode *inode, struct file *file)
 {
 	struct snd_pcm *pcm;
 	int err = nonseekable_open(inode, file);
+
 	if (err < 0)
 		return err;
-	pcm = snd_lookup_minor_data(iminor(inode),
-				    SNDRV_DEVICE_TYPE_PCM_PLAYBACK);
+	pcm = snd_lookup_minor_data(iminor(inode), SNDRV_DEVICE_TYPE_PCM_PLAYBACK);
 	err = snd_pcm_open(file, pcm, SNDRV_PCM_STREAM_PLAYBACK);
 	if (pcm)
 		snd_card_unref(pcm->card);
@@ -2816,10 +2773,10 @@ static int snd_pcm_capture_open(struct inode *inode, struct file *file)
 {
 	struct snd_pcm *pcm;
 	int err = nonseekable_open(inode, file);
+
 	if (err < 0)
 		return err;
-	pcm = snd_lookup_minor_data(iminor(inode),
-				    SNDRV_DEVICE_TYPE_PCM_CAPTURE);
+	pcm = snd_lookup_minor_data(iminor(inode), SNDRV_DEVICE_TYPE_PCM_CAPTURE);
 	err = snd_pcm_open(file, pcm, SNDRV_PCM_STREAM_CAPTURE);
 	if (pcm)
 		snd_card_unref(pcm->card);
@@ -2831,7 +2788,7 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream)
 	int err;
 	wait_queue_entry_t wait;
 
-	if (pcm == NULL) {
+	if (!pcm) {
 		err = -ENODEV;
 		goto __error1;
 	}
@@ -2854,8 +2811,9 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream)
 				err = -EBUSY;
 				break;
 			}
-		} else
+		} else {
 			break;
+		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		mutex_unlock(&pcm->open_mutex);
 		schedule();
@@ -2875,12 +2833,12 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream)
 		goto __error;
 	return err;
 
-      __error:
+__error:
 	module_put(pcm->card->module);
-      __error2:
-      	snd_card_file_remove(pcm->card, file);
-      __error1:
-      	return err;
+__error2:
+	snd_card_file_remove(pcm->card, file);
+__error1:
+	return err;
 }
 
 static int snd_pcm_release(struct inode *inode, struct file *file)
@@ -2935,7 +2893,7 @@ static int do_pcm_hwsync(struct snd_pcm_substream *substream)
 /* increase the appl_ptr; returns the processed frames or a negative error */
 static snd_pcm_sframes_t forward_appl_ptr(struct snd_pcm_substream *substream,
 					  snd_pcm_uframes_t frames,
-					   snd_pcm_sframes_t avail)
+					  snd_pcm_sframes_t avail)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_sframes_t appl_ptr;
@@ -2988,8 +2946,7 @@ static snd_pcm_sframes_t snd_pcm_rewind(struct snd_pcm_substream *substream,
 	snd_pcm_stream_lock_irq(substream);
 	ret = do_pcm_hwsync(substream);
 	if (!ret)
-		ret = rewind_appl_ptr(substream, frames,
-				      snd_pcm_hw_avail(substream));
+		ret = rewind_appl_ptr(substream, frames, snd_pcm_hw_avail(substream));
 	snd_pcm_stream_unlock_irq(substream);
 	if (ret >= 0)
 		snd_pcm_dma_buffer_sync(substream, SNDRV_DMA_SYNC_DEVICE);
@@ -3007,16 +2964,14 @@ static snd_pcm_sframes_t snd_pcm_forward(struct snd_pcm_substream *substream,
 	snd_pcm_stream_lock_irq(substream);
 	ret = do_pcm_hwsync(substream);
 	if (!ret)
-		ret = forward_appl_ptr(substream, frames,
-				       snd_pcm_avail(substream));
+		ret = forward_appl_ptr(substream, frames, snd_pcm_avail(substream));
 	snd_pcm_stream_unlock_irq(substream);
 	if (ret >= 0)
 		snd_pcm_dma_buffer_sync(substream, SNDRV_DMA_SYNC_DEVICE);
 	return ret;
 }
 
-static int snd_pcm_delay(struct snd_pcm_substream *substream,
-			 snd_pcm_sframes_t *delay)
+static int snd_pcm_delay(struct snd_pcm_substream *substream, snd_pcm_sframes_t *delay)
 {
 	int err;
 
@@ -3029,7 +2984,7 @@ static int snd_pcm_delay(struct snd_pcm_substream *substream,
 
 	return err;
 }
-		
+
 static inline int snd_pcm_hwsync(struct snd_pcm_substream *substream)
 {
 	return snd_pcm_delay(substream, NULL);
@@ -3045,10 +3000,11 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	int err;
 
 	memset(&sync_ptr, 0, sizeof(sync_ptr));
-	if (get_user(sync_ptr.flags, (unsigned __user *)&(_sync_ptr->flags)))
+	if (get_user(sync_ptr.flags, (unsigned __user *)&_sync_ptr->flags))
+		return -EFAULT;
+	if (copy_from_user(&sync_ptr.c.control, &_sync_ptr->c.control,
+			   sizeof(struct snd_pcm_mmap_control)))
 		return -EFAULT;
-	if (copy_from_user(&sync_ptr.c.control, &(_sync_ptr->c.control), sizeof(struct snd_pcm_mmap_control)))
-		return -EFAULT;	
 	status = runtime->status;
 	control = runtime->control;
 	if (sync_ptr.flags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
@@ -3058,8 +3014,7 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	}
 	snd_pcm_stream_lock_irq(substream);
 	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
-		err = pcm_lib_apply_appl_ptr(substream,
-					     sync_ptr.c.control.appl_ptr);
+		err = pcm_lib_apply_appl_ptr(substream, sync_ptr.c.control.appl_ptr);
 		if (err < 0) {
 			snd_pcm_stream_unlock_irq(substream);
 			return err;
@@ -3093,7 +3048,7 @@ struct snd_pcm_mmap_status32 {
 	snd_pcm_state_t suspended_state;
 	s32 audio_tstamp_sec;
 	s32 audio_tstamp_nsec;
-} __attribute__((packed));
+} __packed;
 
 struct snd_pcm_mmap_control32 {
 	u32 appl_ptr;
@@ -3110,14 +3065,14 @@ struct snd_pcm_sync_ptr32 {
 		struct snd_pcm_mmap_control32 control;
 		unsigned char reserved[64];
 	} c;
-} __attribute__((packed));
+} __packed;
 
 /* recalcuate the boundary within 32bit */
 static snd_pcm_uframes_t recalculate_boundary(struct snd_pcm_runtime *runtime)
 {
 	snd_pcm_uframes_t boundary;
 
-	if (! runtime->buffer_size)
+	if (!runtime->buffer_size)
 		return 0;
 	boundary = runtime->buffer_size;
 	while (boundary * 2 <= 0x7fffffffUL - runtime->buffer_size)
@@ -3152,19 +3107,19 @@ static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
 	status = runtime->status;
 	control = runtime->control;
 	boundary = recalculate_boundary(runtime);
-	if (! boundary)
+	if (!boundary)
 		boundary = 0x7fffffff;
 	snd_pcm_stream_lock_irq(substream);
 	/* FIXME: we should consider the boundary for the sync from app */
 	if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL)) {
-		err = pcm_lib_apply_appl_ptr(substream,
-				scontrol.appl_ptr);
+		err = pcm_lib_apply_appl_ptr(substream, scontrol.appl_ptr);
 		if (err < 0) {
 			snd_pcm_stream_unlock_irq(substream);
 			return err;
 		}
-	} else
+	} else {
 		scontrol.appl_ptr = control->appl_ptr % boundary;
+	}
 	if (!(sflags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
 		control->avail_min = scontrol.avail_min;
 	else
@@ -3190,13 +3145,14 @@ static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
 
 	return 0;
 }
+
 #define __SNDRV_PCM_IOCTL_SYNC_PTR32 _IOWR('A', 0x23, struct snd_pcm_sync_ptr32)
 
 static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int arg;
-	
+
 	if (get_user(arg, _arg))
 		return -EFAULT;
 	if (arg < 0 || arg > SNDRV_PCM_TSTAMP_TYPE_LAST)
@@ -3290,8 +3246,8 @@ static int snd_pcm_forward_ioctl(struct snd_pcm_substream *substream,
 }
 
 static int snd_pcm_common_ioctl(struct file *file,
-				 struct snd_pcm_substream *substream,
-				 unsigned int cmd, void __user *arg)
+				struct snd_pcm_substream *substream,
+				unsigned int cmd, void __user *arg)
 {
 	struct snd_pcm_file *pcm_file = file->private_data;
 	int res;
@@ -3316,8 +3272,7 @@ static int snd_pcm_common_ioctl(struct file *file,
 	case SNDRV_PCM_IOCTL_TTSTAMP:
 		return snd_pcm_tstamp(substream, arg);
 	case SNDRV_PCM_IOCTL_USER_PVERSION:
-		if (get_user(pcm_file->user_pversion,
-			     (unsigned int __user *)arg))
+		if (get_user(pcm_file->user_pversion, (unsigned int __user *)arg))
 			return -EFAULT;
 		return 0;
 	case SNDRV_PCM_IOCTL_HW_REFINE:
@@ -3345,7 +3300,7 @@ static int snd_pcm_common_ioctl(struct file *file,
 	case SNDRV_PCM_IOCTL_START:
 		return snd_pcm_start_lock_irq(substream);
 	case SNDRV_PCM_IOCTL_LINK:
-		return snd_pcm_link(substream, (int)(unsigned long) arg);
+		return snd_pcm_link(substream, (int)(unsigned long)arg);
 	case SNDRV_PCM_IOCTL_UNLINK:
 		return snd_pcm_unlink(substream);
 	case SNDRV_PCM_IOCTL_RESUME:
@@ -3398,8 +3353,7 @@ static int snd_pcm_common_ioctl(struct file *file,
 	return -ENOTTY;
 }
 
-static long snd_pcm_ioctl(struct file *file, unsigned int cmd,
-			  unsigned long arg)
+static long snd_pcm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct snd_pcm_file *pcm_file;
 
@@ -3408,8 +3362,7 @@ static long snd_pcm_ioctl(struct file *file, unsigned int cmd,
 	if (((cmd >> 8) & 0xff) != 'A')
 		return -ENOTTY;
 
-	return snd_pcm_common_ioctl(file, pcm_file->substream, cmd,
-				     (void __user *)arg);
+	return snd_pcm_common_ioctl(file, pcm_file->substream, cmd, (void __user *)arg);
 }
 
 /**
@@ -3424,12 +3377,11 @@ static long snd_pcm_ioctl(struct file *file, unsigned int cmd,
  *
  * Return: zero if successful, or a negative error code
  */
-int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream,
-			 unsigned int cmd, void *arg)
+int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg)
 {
 	snd_pcm_uframes_t *frames = arg;
 	snd_pcm_sframes_t result;
-	
+
 	if (substream->runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 
@@ -3462,8 +3414,7 @@ int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL(snd_pcm_kernel_ioctl);
 
-static ssize_t snd_pcm_read(struct file *file, char __user *buf, size_t count,
-			    loff_t * offset)
+static ssize_t snd_pcm_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
@@ -3488,7 +3439,7 @@ static ssize_t snd_pcm_read(struct file *file, char __user *buf, size_t count,
 }
 
 static ssize_t snd_pcm_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t * offset)
+			     size_t count, loff_t *offset)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
@@ -3539,7 +3490,7 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 		return -EINVAL;
 	frames = bytes_to_samples(runtime, iov->iov_len);
 	bufs = kmalloc_array(to->nr_segs, sizeof(void *), GFP_KERNEL);
-	if (bufs == NULL)
+	if (!bufs)
 		return -ENOMEM;
 	for (i = 0; i < to->nr_segs; ++i) {
 		bufs[i] = iov->iov_base;
@@ -3578,7 +3529,7 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 		return -EINVAL;
 	frames = bytes_to_samples(runtime, iov->iov_len);
 	bufs = kmalloc_array(from->nr_segs, sizeof(void *), GFP_KERNEL);
-	if (bufs == NULL)
+	if (!bufs)
 		return -ENOMEM;
 	for (i = 0; i < from->nr_segs; ++i) {
 		bufs[i] = iov->iov_base;
@@ -3656,8 +3607,8 @@ static vm_fault_t snd_pcm_mmap_status_fault(struct vm_fault *vmf)
 {
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
-	
-	if (substream == NULL)
+
+	if (!substream)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
 	vmf->page = virt_to_page(runtime->status);
@@ -3665,8 +3616,7 @@ static vm_fault_t snd_pcm_mmap_status_fault(struct vm_fault *vmf)
 	return 0;
 }
 
-static const struct vm_operations_struct snd_pcm_vm_ops_status =
-{
+static const struct vm_operations_struct snd_pcm_vm_ops_status = {
 	.fault =	snd_pcm_mmap_status_fault,
 };
 
@@ -3674,6 +3624,7 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 			       struct vm_area_struct *area)
 {
 	long size;
+
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
@@ -3681,8 +3632,7 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 		return -EINVAL;
 	area->vm_ops = &snd_pcm_vm_ops_status;
 	area->vm_private_data = substream;
-	vm_flags_mod(area, VM_DONTEXPAND | VM_DONTDUMP,
-		     VM_WRITE | VM_MAYWRITE);
+	vm_flags_mod(area, VM_DONTEXPAND | VM_DONTDUMP, VM_WRITE | VM_MAYWRITE);
 
 	return 0;
 }
@@ -3694,8 +3644,8 @@ static vm_fault_t snd_pcm_mmap_control_fault(struct vm_fault *vmf)
 {
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
-	
-	if (substream == NULL)
+
+	if (!substream)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
 	vmf->page = virt_to_page(runtime->control);
@@ -3703,8 +3653,7 @@ static vm_fault_t snd_pcm_mmap_control_fault(struct vm_fault *vmf)
 	return 0;
 }
 
-static const struct vm_operations_struct snd_pcm_vm_ops_control =
-{
+static const struct vm_operations_struct snd_pcm_vm_ops_control = {
 	.fault =	snd_pcm_mmap_control_fault,
 };
 
@@ -3712,6 +3661,7 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 				struct vm_area_struct *area)
 {
 	long size;
+
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
@@ -3769,11 +3719,13 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 {
 	return -ENXIO;
 }
+
 static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file *file,
 				struct vm_area_struct *area)
 {
 	return -ENXIO;
 }
+
 #endif /* coherent mmap */
 
 /*
@@ -3784,10 +3736,10 @@ static vm_fault_t snd_pcm_mmap_data_fault(struct vm_fault *vmf)
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
 	unsigned long offset;
-	struct page * page;
+	struct page *page;
 	size_t dma_bytes;
-	
-	if (substream == NULL)
+
+	if (!substream)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
 	offset = vmf->pgoff << PAGE_SHIFT;
@@ -3884,7 +3836,7 @@ int snd_pcm_mmap_data(struct snd_pcm_substream *substream, struct file *file,
 	int err;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (!(area->vm_flags & (VM_WRITE|VM_READ)))
+		if (!(area->vm_flags & (VM_WRITE | VM_READ)))
 			return -EINVAL;
 	} else {
 		if (!(area->vm_flags & VM_READ))
@@ -3920,10 +3872,10 @@ EXPORT_SYMBOL(snd_pcm_mmap_data);
 
 static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 {
-	struct snd_pcm_file * pcm_file;
-	struct snd_pcm_substream *substream;	
+	struct snd_pcm_file *pcm_file;
+	struct snd_pcm_substream *substream;
 	unsigned long offset;
-	
+
 	pcm_file = file->private_data;
 	substream = pcm_file->substream;
 	if (PCM_RUNTIME_CHECK(substream))
@@ -3955,9 +3907,9 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 	return 0;
 }
 
-static int snd_pcm_fasync(int fd, struct file * file, int on)
+static int snd_pcm_fasync(int fd, struct file *file, int on)
 {
-	struct snd_pcm_file * pcm_file;
+	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
 
@@ -3985,8 +3937,8 @@ static int snd_pcm_fasync(int fd, struct file * file, int on)
  */
 
 #ifdef CONFIG_SND_SUPPORT_OLD_API
-#define __OLD_TO_NEW_MASK(x) ((x&7)|((x&0x07fffff8)<<5))
-#define __NEW_TO_OLD_MASK(x) ((x&7)|((x&0xffffff00)>>5))
+#define __OLD_TO_NEW_MASK(x) ((x & 7) | ((x & 0x07fffff8) << 5))
+#define __NEW_TO_OLD_MASK(x) ((x & 7) | ((x & 0xffffff00) >> 5))
 
 static void snd_pcm_hw_convert_from_old_params(struct snd_pcm_hw_params *params,
 					       struct snd_pcm_hw_params_old *oparams)
@@ -4027,7 +3979,7 @@ static void snd_pcm_hw_convert_to_old_params(struct snd_pcm_hw_params_old *opara
 }
 
 static int snd_pcm_hw_refine_old_user(struct snd_pcm_substream *substream,
-				      struct snd_pcm_hw_params_old __user * _oparams)
+				      struct snd_pcm_hw_params_old __user *_oparams)
 {
 	struct snd_pcm_hw_params *params;
 	struct snd_pcm_hw_params_old *oparams = NULL;
@@ -4062,7 +4014,7 @@ static int snd_pcm_hw_refine_old_user(struct snd_pcm_substream *substream,
 }
 
 static int snd_pcm_hw_params_old_user(struct snd_pcm_substream *substream,
-				      struct snd_pcm_hw_params_old __user * _oparams)
+				      struct snd_pcm_hw_params_old __user *_oparams)
 {
 	struct snd_pcm_hw_params *params;
 	struct snd_pcm_hw_params_old *oparams = NULL;
@@ -4095,10 +4047,8 @@ static int snd_pcm_hw_params_old_user(struct snd_pcm_substream *substream,
 #endif /* CONFIG_SND_SUPPORT_OLD_API */
 
 #ifndef CONFIG_MMU
-static unsigned long snd_pcm_get_unmapped_area(struct file *file,
-					       unsigned long addr,
-					       unsigned long len,
-					       unsigned long pgoff,
+static unsigned long snd_pcm_get_unmapped_area(struct file *file, unsigned long addr,
+					       unsigned long len, unsigned long pgoff,
 					       unsigned long flags)
 {
 	struct snd_pcm_file *pcm_file = file->private_data;
@@ -4133,7 +4083,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.llseek =		no_llseek,
 		.poll =			snd_pcm_poll,
 		.unlocked_ioctl =	snd_pcm_ioctl,
-		.compat_ioctl = 	snd_pcm_ioctl_compat,
+		.compat_ioctl =		snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
 		.fasync =		snd_pcm_fasync,
 		.get_unmapped_area =	snd_pcm_get_unmapped_area,
@@ -4147,7 +4097,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.llseek =		no_llseek,
 		.poll =			snd_pcm_poll,
 		.unlocked_ioctl =	snd_pcm_ioctl,
-		.compat_ioctl = 	snd_pcm_ioctl_compat,
+		.compat_ioctl =		snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
 		.fasync =		snd_pcm_fasync,
 		.get_unmapped_area =	snd_pcm_get_unmapped_area,
-- 
2.34.1

