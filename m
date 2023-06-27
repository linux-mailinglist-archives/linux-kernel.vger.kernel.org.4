Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4388273F969
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjF0J7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjF0J6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:58:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A76E4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:56:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e64e97e2so2348727b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687859805; x=1690451805;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hujbIY55doI6O8/m1tW9FFQi85pBz1jV9D3SM708Vs=;
        b=bEG9tJct1KZYbxGfh6jyAnWppOW23cMFzLGB5sG2GQNmu6r7At8oEhJwqnRYr851yy
         CMEW2CHrDQXQSNdGEp9ars9suyXU/cThKu9wAZTea2wC9XnQEXG6eSG69nh1PsCrIRiW
         o00BtxyFrdbLvUMRigztbulqgbpT1cueYd9RagF8/Dtpmw7Xf3rWQejf4SjED00WkE5Z
         jZMTtr8CekIiGcR9Y5ZNvHMMCugF5JE/cjODwoZNcT8Y0paVbVZryENeqwPT36OTQ1SA
         dthBkallc57ZnAKuu5RVlm6B3CgnSRgp1nntffl7PLpStW8SbS+hhuzVLSXEutJweM9S
         eDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687859805; x=1690451805;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hujbIY55doI6O8/m1tW9FFQi85pBz1jV9D3SM708Vs=;
        b=PAT3qIC9tWgA5R+UOsvN2rEVhbHgOO/+DbZIYxwbbXujTvfObHRSuWM7fGoNOq8ay8
         mhgO+fca7sOwQuoFyDSMEqSsf05s3jTWyDEPLqZAHPzuAFeIxDS7NPwZPuMeD1byZI9B
         Pe5G9M5cFXacEcgqDH8FmILkbrnWZ45L2d1sRLtFClVVqDva21jQvqz8aKlk9hRW485M
         8Oj37eGchPZTec3db+zZ32dmqgdFtaGL8OrDMbDt9BbM640zeQUNngJ11+wDquEzO5oY
         g1/wSrZ0urZCoVPjIv1+mKPJ8l2jB/lrzvGi3V9xDjFOn/9jASwT+1aLlcfVzvSMwdhZ
         2jfQ==
X-Gm-Message-State: AC+VfDxxw2ESw231HnwrdzUuDqKSK7AuxLjTg0nBql5oalPWRlHDVeaM
        aBGxWTNs+OcZKa9T8XW0lKk=
X-Google-Smtp-Source: ACHHUZ5WVISo1YP3SNQ/0ZKGrBjNBIgGIOloCf7piWhXiZOmE1VgfLdLEHzcn0U5sFfGlK99QkR6Sw==
X-Received: by 2002:a05:6a20:3d94:b0:126:926:26b8 with SMTP id s20-20020a056a203d9400b00126092626b8mr9111685pzi.62.1687859804608;
        Tue, 27 Jun 2023 02:56:44 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id v1-20020aa78501000000b0067db7c32419sm812085pfn.15.2023.06.27.02.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:56:44 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] ALSA: sb: fix potential deadlock on &chip->mixer_lock
Date:   Tue, 27 Jun 2023 09:56:16 +0000
Message-Id: <20230627095616.5333-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &chip->mixer_lock is also acquired by the irq snd_sb8dsp_interrupt()
which executes under hard-irq context, code executing under process
context should disable irq before acquiring the lock, otherwise
deadlock could happen if the process context hold the lock then
preempt by the interruption.

As the ALSA Driver document described, PCM prepare callbacks are not
executed with irq disabled by default, thus the acquiring of
&chip->mixer_lock should be irq disabled.

Possible deadlock scenario:
snd_sb8_playback_prepare
    -> spin_lock(&chip->mixer_lock);
        <irq interrupt>
        -> snd_sb8dsp_interrupt()
        -> snd_sb8_capture_trigger()
        -> spin_lock(&chip->mixer_lock); (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 sound/isa/sb/sb8_main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 2ed176a5a574..81af8dcddcd2 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -148,10 +148,12 @@ static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 		snd_sbdsp_command(chip, format);
 	else if (stereo) {
 		/* set playback stereo mode */
-		spin_lock(&chip->mixer_lock);
+		unsigned long flags;
+
+		spin_lock_irqsave(&chip->mixer_lock, flags);
 		mixreg = snd_sbmixer_read(chip, SB_DSP_STEREO_SW);
 		snd_sbmixer_write(chip, SB_DSP_STEREO_SW, mixreg | 0x02);
-		spin_unlock(&chip->mixer_lock);
+		spin_unlock_irqrestore(&chip->mixer_lock, flags);
 
 		/* Soundblaster hardware programming reference guide, 3-23 */
 		snd_sbdsp_command(chip, SB_DSP_DMA8_EXIT);
@@ -164,12 +166,13 @@ static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 	}
 	snd_sbdsp_command(chip, SB_DSP_SAMPLE_RATE);
 	if (stereo) {
+		unsigned long flags;
 		snd_sbdsp_command(chip, 256 - runtime->rate_den / 2);
-		spin_lock(&chip->mixer_lock);
+		spin_lock_irqsave(&chip->mixer_lock, flags);
 		/* save output filter status and turn it off */
 		mixreg = snd_sbmixer_read(chip, SB_DSP_PLAYBACK_FILT);
 		snd_sbmixer_write(chip, SB_DSP_PLAYBACK_FILT, mixreg | 0x20);
-		spin_unlock(&chip->mixer_lock);
+		spin_unlock_irqrestore(&chip->mixer_lock, flags);
 		/* just use force_mode16 for temporary storate... */
 		chip->force_mode16 = mixreg;
 	} else {
@@ -289,12 +292,13 @@ static int snd_sb8_capture_prepare(struct snd_pcm_substream *substream)
 		snd_sbdsp_command(chip, SB_DSP_STEREO_8BIT);
 	snd_sbdsp_command(chip, SB_DSP_SAMPLE_RATE);
 	if (stereo) {
+		unsigned long flags;
 		snd_sbdsp_command(chip, 256 - runtime->rate_den / 2);
-		spin_lock(&chip->mixer_lock);
+		spin_lock_irqsave(&chip->mixer_lock, flags);
 		/* save input filter status and turn it off */
 		mixreg = snd_sbmixer_read(chip, SB_DSP_CAPTURE_FILT);
 		snd_sbmixer_write(chip, SB_DSP_CAPTURE_FILT, mixreg | 0x20);
-		spin_unlock(&chip->mixer_lock);
+		spin_lock_irqsave(&chip->mixer_lock, flags);
 		/* just use force_mode16 for temporary storate... */
 		chip->force_mode16 = mixreg;
 	} else {
-- 
2.17.1

