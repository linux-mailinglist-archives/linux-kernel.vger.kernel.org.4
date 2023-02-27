Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576156A4B22
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjB0Tg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjB0TgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:36:11 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE02799B;
        Mon, 27 Feb 2023 11:36:02 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l1so7352471pjt.2;
        Mon, 27 Feb 2023 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPSgblFxcMDwoNtdY8qW+0LuYLpgnFy45QQcEr2JcOw=;
        b=QZZ1q6r0sTzHPL7VdFvT0DoM/oGJCvYAXWVG2Sq60pT1O4tLHJp+sjl/Ykf9EjPMDE
         rnP7Qjro7d87sOtDeaAwf/tVHLI/8H4R/xSS85I61TGHpSt1lk9Ci+/tTi+snY+1eLxA
         jNwotBYTEY9umpsoTbC8ooXUZBOorHN/PGCHCfx6uT+revidH/IRH7LWIxzDxyUtK79z
         5z89DVB3rViku7Li6muVd4Aa38la2/eYoBeQVzW5fkObbJTSrCx6gVFG/yhpqIpqSCN6
         oFQcFh4rW5VbwINPaEj/shHDVZFmciEuf9nBscjy/upst6ovmm+6vWSyZXoFO7+FgI5V
         CUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPSgblFxcMDwoNtdY8qW+0LuYLpgnFy45QQcEr2JcOw=;
        b=f2wc8bm1rPK5jpqATcQMK0DXuplpvRFcf1MUixSdYG7ALguBTA8r8gdcAz2ixR2Nmv
         9DOykIbIxRNCBXWSuIOh08M+mMdnt+sYNjbmfD8KVWR12hzUQ3GxXeKzVTPcEzgDl4Sb
         c2G7NjUDOjrNAEoUtxy55ORccOgwVb5iH/2cgYKgyWAzVjAwOB8LqEaLKxE1R2Lck5FT
         y6yIDHnWZREHevD+sY7vD87/REYrnjAPLSBu4bIn6XAUWgY4JddFV94h9ahMWDlRVibK
         xwX1NO45JX4iLfCi3txeD06irT7OWcNaaJRGgYIpBJRf5M+iBW8plRFB4XMllpSdy4OZ
         oV/w==
X-Gm-Message-State: AO0yUKX0jLxGgKYwMYXq2N3RTh3KG2O/y6VHaXEqpNSt+e7JH5Nvsb/j
        gI1FmtknvomlfQHiJqGdwoA=
X-Google-Smtp-Source: AK7set9qlYKiBuxZSBv407fTxhQUDFX37IZbk5poFBbtPNGwefM6+yp8XFL+jFG1XsSowJqpxO6wXA==
X-Received: by 2002:a17:90b:1d0e:b0:232:edb6:9710 with SMTP id on14-20020a17090b1d0e00b00232edb69710mr439552pjb.17.1677526562243;
        Mon, 27 Feb 2023 11:36:02 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id fw8-20020a17090b128800b00219752c8ea5sm4729897pjb.37.2023.02.27.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:36:01 -0800 (PST)
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
Subject: [PATCH v7 06/15] dma-buf/sync_file: Support (E)POLLPRI
Date:   Mon, 27 Feb 2023 11:35:12 -0800
Message-Id: <20230227193535.2822389-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227193535.2822389-1-robdclark@gmail.com>
References: <20230227193535.2822389-1-robdclark@gmail.com>
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

