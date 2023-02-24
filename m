Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4116A22D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBXUC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjBXUCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:13 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7864AFE2;
        Fri, 24 Feb 2023 12:02:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id c23so201292pjo.4;
        Fri, 24 Feb 2023 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPSgblFxcMDwoNtdY8qW+0LuYLpgnFy45QQcEr2JcOw=;
        b=YjrzSGmSAO24NAy7pV99H76mHnO/ob0DJd+KgHuXHgTONteT6eB8WKwKvzxTAV8OFc
         ozODGa8na8UY6YME2rJSC+RUVjI+c0l9Zr9nmjTVoIq+dYqU50lqNhMb6B01hqnG7mMj
         S94REDyVMh5NWQHFZF56abZ0uJNxUpO2pG4bdx0klAg7rZDI5Re4eaBmwMj8v//CcpE1
         RtofOghuwLRSl9tPiOQ1TWX4fP326emGj/xi1A2eZFVxerP3uJll6xEQhXhLzvLjzFc9
         ZGZq/hzvp/teFofSmQtORvyU2110tn2XdxVYxH1WPlaBH7/nMEsrJFl/TsVRy5vryYa7
         8d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPSgblFxcMDwoNtdY8qW+0LuYLpgnFy45QQcEr2JcOw=;
        b=P82uYS9taHioWX6em14/ozAcFMacsYKSlkwlpPsGfrTwYGC8QIh6Q9MgbxfJbC+irF
         /i+LcfAIIR6L6R2AEngU2O/5S874b6u9fdUV1ZF06SAs/b8QgL1JhHcaL8ncPEE6PmpI
         ZmBw/wfaRCm2Ab1t+2dyvjsj9RuslO/vsCOcJPN6dg5pnaszLmVJk5OWDVHLNMLPDl53
         7UjuVtVZerdGqXPwQMlHaMj4upkba4ektVbIPcX2VHrFhC4+ySeqd0oZj69o5d2/qIVS
         1o7bq8/mNazmcJnIyTVGUooE5BhUWegMrgc6jc0YKn7kTNrxj59V5EO2kHy1eUK/EzIT
         HrXA==
X-Gm-Message-State: AO0yUKU4g1arvndzp2DZ3UGCfu+39fm9JK96MXhApReUEa+iaVM2SdwO
        rlbuTGKajfp7sDeIGfdK3TQ=
X-Google-Smtp-Source: AK7set/0So7/yjbHxG+9IFq3Vyn2w/a/SkcQTRiHJyKEh5wCWaBbLoFxjxFUp2shIAdMi1mUsKQDAg==
X-Received: by 2002:a17:90a:351:b0:236:73d5:82cf with SMTP id 17-20020a17090a035100b0023673d582cfmr17766333pjf.9.1677268930955;
        Fri, 24 Feb 2023 12:02:10 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709029f9700b0019cbe436b87sm3610113plq.81.2023.02.24.12.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:10 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 06/15] dma-buf/sync_file: Support (E)POLLPRI
Date:   Fri, 24 Feb 2023 12:01:34 -0800
Message-Id: <20230224200155.2510320-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224200155.2510320-1-robdclark@gmail.com>
References: <20230224200155.2510320-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Allow userspace to use the EPOLLPRI/POLLPRI flag to indicate an urgent
wait (as opposed to a "housekeeping" wait to know when to cleanup after
some work has completed).  Usermode components of GPU driver stacks
often poll() on fence fd's to know when it is safe to do things like
free or reuse a buffer, but they can also poll() on a fence fd when
waiting to read back results from the GPU.  The EPOLLPRI/POLLPRI flag
lets the kernel differentiate these two cases.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/dma-buf/sync_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 418021cfb87c..cbe96295373b 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -192,6 +192,14 @@ static __poll_t sync_file_poll(struct file *file, poll_table *wait)
 {
 	struct sync_file *sync_file = file->private_data;
 
+	/*
+	 * The POLLPRI/EPOLLPRI flag can be used to signal that
+	 * userspace wants the fence to signal ASAP, express this
+	 * as an immediate deadline.
+	 */
+	if (poll_requested_events(wait) & EPOLLPRI)
+		dma_fence_set_deadline(sync_file->fence, ktime_get());
+
 	poll_wait(file, &sync_file->wq, wait);
 
 	if (list_empty(&sync_file->cb.node) &&
-- 
2.39.1

