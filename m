Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1593D6FF12E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbjEKMKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbjEKMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:10:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B03BA24E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9963a72fd9so18552749276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683806984; x=1686398984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFFdKRwDpDILumhyLuLJOTrk05DbXLc6wTGy62C/3Mw=;
        b=wS6sSkP9YPrEQci5WRw3K0xUtOK5+0/bwAebx2k91pqCIj0EfYjinxZrDO4ajIZjGM
         93t//KRpj0A5F6J4KjOlKV1y+Lm/ePEWG+KQn/cR4aakq3zES0kTJ5K9FNJ38y837AN0
         zBdhJGmHaQva80CE20d2I7pxXjrPjUcICIIMWKC+WwF8uB15gtNLv/4ImBvcL36KXmeB
         lqIS0virSRAaqSbuFnvycK3dKd0Kl7oqzEVb5PehKYMtdlLdGF42nsRcfsVhiU5qg+8j
         RWNR0gNjin97dZ3upG8fYJP+RPue2YJLbFd3/VCnCJqCjLsUh1T1O2t+pQCpgrkHV8vM
         z1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806984; x=1686398984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFFdKRwDpDILumhyLuLJOTrk05DbXLc6wTGy62C/3Mw=;
        b=h5QCytYEAxFbWn7MyMU3s2TIzhjedppvL4V0e+kVt+F1jmOE9HrIELFMxAVKnXcOxW
         C9WX16c7OyNbyJ+zDZdKqck78dzFqNh/E4x8zGDd3D15g0Sp16+VQG6L6fCY30jZiAOz
         efchWAPDlsi+nfRxSl9hHNP3Yrt9/7629Am0UuZ63O2LFTfZBeyAt8qcANy/hysAKEj9
         nPMxnK6J03BGHELdOoPodujjV0PNEGl7eW9dJv2D19K2bCM0VYDsxjguy8pj5fduwKsS
         pj9mfcquDESZw2Z9O2jgmKXT/K5BW8odjYpQX00xpmILBTT0iBQDWB+FvjOhHhbhFhck
         oB9Q==
X-Gm-Message-State: AC+VfDz3lffewHY0PhY0fyXcjMnJOsYGMQ9RQEnTUUGa6mE6YO5XbzjF
        WlOwdIFbWcfrZrrtDCvjUI/KGWpbyfuDE9hPgg==
X-Google-Smtp-Source: ACHHUZ6WNFGb++Bi1s3+Qljz7xPC8nDjrsTQIYeDWQxaajEyJ9TDJ4kJ1ngdN74pybDKr5utVuVJdeHDE4xVvgjKyw==
X-Received: from yixuanjiang.ntc.corp.google.com ([2401:fa00:fc:202:6c9a:64c9:7e44:6b1d])
 (user=yixuanjiang job=sendgmr) by 2002:a25:6648:0:b0:b68:7a4a:5258 with SMTP
 id z8-20020a256648000000b00b687a4a5258mr12799183ybm.3.1683806984600; Thu, 11
 May 2023 05:09:44 -0700 (PDT)
Date:   Thu, 11 May 2023 20:08:41 +0800
In-Reply-To: <20230511120841.2096524-1-yixuanjiang@google.com>
Mime-Version: 1.0
References: <20230511120841.2096524-1-yixuanjiang@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511120841.2096524-7-yixuanjiang@google.com>
Subject: [PATCH 6/6] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
From:   yixuanjiang <yixuanjiang@google.com>
To:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yixuan Jiang <yixuanjiang@google.com>, stable@vger.kernel.org
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 3aa1e96a2b95e2ece198f8dd01e96818971b84df ]

A BE connected to more than one FE, e.g. in a mixer case, can go
through the following transitions.

play FE1    -> BE state is START
pause FE1   -> BE state is PAUSED
play FE2    -> BE state is START
stop FE2    -> BE state is STOP (see note [1] below)
release FE1 -> BE state is START
stop FE1    -> BE state is STOP

play FE1    -> BE state is START
pause FE1   -> BE state is PAUSED
play FE2    -> BE state is START
release FE1 -> BE state is START
stop FE2    -> BE state is START
stop FE1    -> BE state is STOP

play FE1    -> BE state is START
play FE2    -> BE state is START (no change)
pause FE1   -> BE state is START (no change)
pause FE2   -> BE state is PAUSED
release FE1 -> BE state is START
release FE2 -> BE state is START (no change)
stop FE1    -> BE state is START (no change)
stop FE2    -> BE state is STOP

The existing code for PAUSE_RELEASE only allows for the case where the
BE is paused, which clearly would not work in the sequences above.

Extend the allowed states to restart the BE when PAUSE_RELEASE is
received, and increase the refcount if the BE is already in START.

[1] the existing logic does not move the BE state back to PAUSED when
the FE2 is stopped. This patch does not change the logic; it would be
painful to keep a history of changes on the FE side, the state machine
is already rather complicated with transitions based on the last BE
state and the trigger type.

Reported-by: Bard Liao <bard.liao@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20211207173745.15850-7-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Fixes: aa9ff6a4955f ("ASoC: soc-compress: Reposition and add pcm_mutex")
Signed-off-by: Yixuan Jiang <yixuanjiang@google.com>
Cc: stable@vger.kernel.org # 5.15+
---
 sound/soc/soc-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index b6099d36518f5..6e589708b9338 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2151,7 +2151,10 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			if (!be->dpcm[stream].be_start &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				goto next;
 
 			be->dpcm[stream].be_start++;
-- 
2.40.1.521.gf1e218fcd8-goog

