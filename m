Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC046FF126
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbjEKMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbjEKMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:09:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9A835A6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso16715115276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683806960; x=1686398960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2dsf61YMVY92FH7C3AkmJ5nwGxSUh4djoxlEJxPoZg=;
        b=Fm3IUSrIO6dioGkB92APGdJb1osx2Ot5x0wCO0UEqBQxCBUdYRoNP0KTWyt0fb70Z0
         0GZSXmqWDxptjteEYn/qpcdE3yJHtilD+khIiE1vi4zw/AqIe479LJ4+t3TRLfs0Hdrv
         qbcjIG5lSktyPDi9KHlTeqCOUH7pHWTNq5r4ShzUSGY7NaUgc2zZwhMJSkbgwMMxOJSC
         DqRXkK8qmW3F9pIsE4iFTRoojuExst1QgA6FCVanvZ9KBnCHcCJUbqqcmSE2bqSlddut
         hxMPdslmmdXESjFTPjiGZ4FC5RgqE65456Ln6uVnae+wXDl01twwgL5I6yU553ow6I9w
         eCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806960; x=1686398960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2dsf61YMVY92FH7C3AkmJ5nwGxSUh4djoxlEJxPoZg=;
        b=Fnekr0d3ngRLSWld1xdQ62uqJxcDZYs3RRm4aKBKkFvsh1GhMhPgSUgnSU5sBB3Ps4
         H+EQN9RI9GJdQ8HB1oqFuITstLGqIU3Lz97zuBIduHNl3lZxLszMX5X19gNHlBKzJH5g
         L7OA7YMrTqFG+/k3dU43frdZ29c0rgWnjkxtx2hvxxcsw3qjQqUhsrrTBHUi5hmjEjB5
         ieHK1iw329vkbYUGt87u+/Bpf0I9eFUxmx8RZohW4c6MJi19XrOKi8yzSK4PsSbMaQiQ
         0eddAYGo/Bc7S1kDBC5OXlKItBvoVCp6ZpzF4lTy7yiM9nDMTni5whYYWgBmyvjPzqzC
         R53w==
X-Gm-Message-State: AC+VfDyZzs1oYhQuy8TRiN6IU6EtE9RfvzHmTqH92JcaqEv92RskvT2D
        zjnlsx0CKyd3gkNkZbVhIovrErbLg0ohIJhaWw==
X-Google-Smtp-Source: ACHHUZ6MK+BdZXJuYQp0xdPqOukDcGy3FtdWiMye4msSsyxhUqmlwxjZSZ+VYlg2JzBOa89RPQhW3k2qNI+UA5zS7w==
X-Received: from yixuanjiang.ntc.corp.google.com ([2401:fa00:fc:202:6c9a:64c9:7e44:6b1d])
 (user=yixuanjiang job=sendgmr) by 2002:a05:6902:d2:b0:b9e:6fce:4f6d with SMTP
 id i18-20020a05690200d200b00b9e6fce4f6dmr13046837ybs.2.1683806960728; Thu, 11
 May 2023 05:09:20 -0700 (PDT)
Date:   Thu, 11 May 2023 20:08:37 +0800
In-Reply-To: <20230511120841.2096524-1-yixuanjiang@google.com>
Mime-Version: 1.0
References: <20230511120841.2096524-1-yixuanjiang@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511120841.2096524-3-yixuanjiang@google.com>
Subject: [PATCH 2/6] ASoC: soc-pcm: align BE 'atomicity' with that of the FE
From:   yixuanjiang <yixuanjiang@google.com>
To:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
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

[ Upstream commit bbf7d3b1c4f40eb02dd1dffb500ba00b0bff0303 ]

Since the flow for DPCM is based on taking a lock for the FE first, we
need to make sure during the connection between a BE and an FE that
they both use the same 'atomicity', otherwise we may sleep in atomic
context.

If the FE is nonatomic, this patch forces the BE to be nonatomic as
well. That should have no negative impact since the BE 'inherits' the
FE properties.

However, if the FE is atomic and the BE is not, then the configuration
is flagged as invalid.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
[ removed FE stream lock by tiwai ]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20211207173745.15850-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Fixes: aa9ff6a4955f ("ASoC: soc-compress: Reposition and add pcm_mutex")
Signed-off-by: Yixuan Jiang <yixuanjiang@google.com>
Cc: stable@vger.kernel.org # 5.15+
---
 sound/soc/soc-pcm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index cffae9b7c2548..373f20bd14301 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1123,6 +1123,8 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream)
 {
+	struct snd_pcm_substream *fe_substream;
+	struct snd_pcm_substream *be_substream;
 	struct snd_soc_dpcm *dpcm;
 	unsigned long flags;
 
@@ -1132,6 +1134,20 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			return 0;
 	}
 
+	fe_substream = snd_soc_dpcm_get_substream(fe, stream);
+	be_substream = snd_soc_dpcm_get_substream(be, stream);
+
+	if (!fe_substream->pcm->nonatomic && be_substream->pcm->nonatomic) {
+		dev_err(be->dev, "%s: FE is atomic but BE is nonatomic, invalid configuration\n",
+			__func__);
+		return -EINVAL;
+	}
+	if (fe_substream->pcm->nonatomic && !be_substream->pcm->nonatomic) {
+		dev_warn(be->dev, "%s: FE is nonatomic but BE is not, forcing BE as nonatomic\n",
+			 __func__);
+		be_substream->pcm->nonatomic = 1;
+	}
+
 	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_ATOMIC);
 	if (!dpcm)
 		return -ENOMEM;
-- 
2.40.1.521.gf1e218fcd8-goog

