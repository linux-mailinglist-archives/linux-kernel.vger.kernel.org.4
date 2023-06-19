Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77643734AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 05:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFSDbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 23:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFSDbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 23:31:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6236783
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 20:31:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57320c10635so21023777b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 20:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687145503; x=1689737503;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G10eF1L2n5B4Mwr5kacZKLWRTzWH55DNVZ3Rtlm7H5k=;
        b=lxtOJckE4YUvJj9N1FywwvKDMF0kL0qmMXCzWYZtlqsbP4VKvnRtOcC88yp+ai5905
         8WtttVVqWPhm6wCduDHkZZidMFxQU5ZgOVT3vP7gRczBDFAsUNfOF2YepyQVy8O6MgEO
         ORcEBPGWS62KHyngl3nasgPtEdnH/5B0wGROWu3eVCXnSuM5PF2p2fBD0FXwbIe6SNzN
         HiJH0A+FOXAghnI0Nnzo7UKrsRz+mLPzxOJUmnlq30gmLkFipiUOI83oNn5+JW1OHLUv
         7ogch49xBgMRndIZ9rvKL97TZk0FVCWTjgLfEbWB54PALXOVyBlLKYiq1bbu3zR3lQBU
         sCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687145503; x=1689737503;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G10eF1L2n5B4Mwr5kacZKLWRTzWH55DNVZ3Rtlm7H5k=;
        b=OB4JPosxnORxOIBBVLWcZdH7cc8vy78EvTk6aSN2xm1qznYyj1UmsRh1t1n17Jtb9Z
         Ewzahnki0Q1Pz77rTG+gssw3NkA58ekV9G7vVj+p4K/HIw3SKJ4yXHVIwgR7V7YWjAz8
         cAyUajP9V4kXKCSK+O2o5CJpCt/AJYCvROpSM3Md66sl/JMBHF5LGmmcMv83pNU4n+2j
         WL7hEAWGMrHddZQwK/aYgn5N1KxePguDjXvWPssgS34kcQRIX0wp5sHw+9hwPdWET3td
         uRAdSHMgxN+pFDIr/h6mpNsmD9KDpLNBlAFglycYz6osKyQPadjc/3yU7IQa2OavsHCt
         DcWw==
X-Gm-Message-State: AC+VfDxCO8TgUj7Dhq9Tev4I+oT7A0kv5cHg41gdOssgQz976MRx2xkb
        cytFw8xwd8z9aQHdlXQ3U4pF6eZt8E9cEv9Q+Q==
X-Google-Smtp-Source: ACHHUZ5Gm/dYiTDDMVyEOTutSI8nrCztJr4EgqlmkEjTqkZ1dWV/80rsN8Urd+WaQtK8tTcUDpCOH1q+ZSHDXeFmBg==
X-Received: from yixuanjiang.ntc.corp.google.com ([2401:fa00:fc:202:845a:7b17:7f6e:785b])
 (user=yixuanjiang job=sendgmr) by 2002:a05:6902:91:b0:ba8:6dc0:cacf with SMTP
 id h17-20020a056902009100b00ba86dc0cacfmr881612ybs.12.1687145503578; Sun, 18
 Jun 2023 20:31:43 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:31:27 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230619033127.2522477-1-yixuanjiang@google.com>
Subject: [PATCH] ASoC: soc-compress: Fix deadlock in soc_compr_open_fe
From:   yixuanjiang <yixuanjiang@google.com>
To:     vkoul@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        yixuanjiang <yixuanjiang@google.com>
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

Modify the error handling flow by release lock.
The require mutex will keep holding if open fail.

Fixes: aa9ff6a4955f ("ASoC: soc-compress: Reposition and add pcm_mutex")
Signed-off-by: yixuanjiang <yixuanjiang@google.com>
---
 sound/soc/soc-compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index d8715db5e415..2117fd61cf8f 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -194,6 +194,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	snd_soc_dai_compr_shutdown(cpu_dai, cstream, 1);
 out:
 	dpcm_path_put(&list);
+	snd_soc_dpcm_mutex_unlock(fe);
 be_err:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 	snd_soc_card_mutex_unlock(fe->card);
-- 
2.41.0.162.gfafddb0af9-goog

