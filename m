Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B46FF123
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbjEKMJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbjEKMJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:09:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED2AD26
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-560def4d06dso34439347b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683806955; x=1686398955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7K8c0PbSb9/75eHA2UyPAuYfZp6gkS8+sNwMs4nkPsw=;
        b=aId7+0deecHGhvzHiCpQ99QDZYxs8sOskTVuQh+Id0foMa14spsgvuQ0XA0Z2ZEMuQ
         XuWIw22ug3J/BYgTc05q7rC0GG7biA1eiBtKmnUHCNLBLOoyslvxzJnEaU8TGLc/hRd0
         sGUQCfw0KuMjHnNhKyQGQPxbx5ylmXI1mHuScaYgtPCzlzYAgg2QA2K8IcTSnJbeYsHn
         zWZH0v/FMPmUTNE0s0iRHoD1v2dG094/NHJ2aH6MshBgjyUU9hs4oLsHhGpBd3ak/fT9
         YFhEv6DkZqGYwPRdsNwLA3e+/2qG2HrjBK7ytxtwTYYJjCXevj13Xfhl7vsPsiuoVNIR
         fELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806955; x=1686398955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7K8c0PbSb9/75eHA2UyPAuYfZp6gkS8+sNwMs4nkPsw=;
        b=ZJ+97mFx9pj8qoAflny5wg4CBMDdkWvmbi6E4A4UztUll5Z65HNwlC7Yc9+nSPUq/Y
         a5Gyb1y1kyvEcfr67zwWlYxA16AMJbDojAtThNltAFmyJB9x8f+BeHwXDjNVd9W4a5yG
         +F00agfOCyW8LGBK6mXYTU28X7Bro6Xd/8JLOAvACNLJvaHqaLAl/fb8wgxkViAy7G6y
         xTu25t0EXv08vlhcxkv7zuoeRFyGZejFFbBhVOq5VKMMMRGmgp+1QMIlNmpBh7er4azs
         4dSnnbKWezVzLfEbqW/UAe23UOhDKVJ0qr83nvTJWcdjBvLYHdpcltSMrK8zp+I3Nh/7
         V1Iw==
X-Gm-Message-State: AC+VfDzzbJnv+n2OTv7G8UXsXy+gIf2IxVH/OheCdVktSJBgvHd7oDWI
        bxIHgVYLEiB3kM2FGKMIBm5oWi3U4KBm2axr4Q==
X-Google-Smtp-Source: ACHHUZ649eEZOGu+69lcpa1h2QuufU2JwY+7I6E65DKzbwztYqdOFIXoAXFKOH6AJFiL/OCdeIEENenkhD6EYIzmYA==
X-Received: from yixuanjiang.ntc.corp.google.com ([2401:fa00:fc:202:6c9a:64c9:7e44:6b1d])
 (user=yixuanjiang job=sendgmr) by 2002:a81:b285:0:b0:559:f1b0:6eb with SMTP
 id q127-20020a81b285000000b00559f1b006ebmr12820158ywh.4.1683806955346; Thu,
 11 May 2023 05:09:15 -0700 (PDT)
Date:   Thu, 11 May 2023 20:08:36 +0800
In-Reply-To: <20230511120841.2096524-1-yixuanjiang@google.com>
Mime-Version: 1.0
References: <20230511120841.2096524-1-yixuanjiang@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511120841.2096524-2-yixuanjiang@google.com>
Subject: [PATCH 1/6] ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
From:   yixuanjiang <yixuanjiang@google.com>
To:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yixuan Jiang <yixuanjiang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit d8a9c6e1f6766a16cf02b4e99a629f3c5512c183 ]

We allocate a structure in dpcm_be_connect(), which may be called in
atomic context. Using GFP_KERNEL is not quite right, we have to use
GFP_ATOMIC to prevent the allocator from sleeping.

Suggested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20211207173745.15850-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Fixes: aa9ff6a4955f ("ASoC: soc-compress: Reposition and add pcm_mutex")
Signed-off-by: Yixuan Jiang <yixuanjiang@google.com>
Cc: stable@vger.kernel.org # 5.15+
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3b673477f6215..cffae9b7c2548 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1132,7 +1132,7 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			return 0;
 	}
 
-	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_KERNEL);
+	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_ATOMIC);
 	if (!dpcm)
 		return -ENOMEM;
 
-- 
2.40.1.521.gf1e218fcd8-goog

