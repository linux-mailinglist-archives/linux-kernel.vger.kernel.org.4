Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3D69BC34
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBRVQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBRVQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:16:06 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A713D7C;
        Sat, 18 Feb 2023 13:15:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id o9so1553787plk.12;
        Sat, 18 Feb 2023 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYIkCiW1P3MTuGNaXnYInZXOL6oL98BTswmIrYI3+hc=;
        b=eQ/2i4WtARuumdk6wu3UFqAW69ZW8h3tfauASKVW6UiPkF3AV+YCLi3IsnRxxMwg0g
         CUIDHLV4BZqXknqttTtk+bXdQ6ljF08ejS9/UaWYQhGdaghr+KWH/71gNpnwDfzQ/UH5
         nBW8tWukaXtSxhoyOsYUBlBageDHZMcz+vUTvBGG9/D5e4fM1azL9Vg9cP2p+UYvndt2
         AHl5A36OpTJ8bpk7MfIg49zDicp0C2GaVHxplb2BU6oIc7LsUP5oMXTq3g1kIWHJce+H
         XGKorRr6oiJXunUlrDyMsUxILj9/VBJnJZI1d9zF9ycS3uV11lNRCp0g7026hwsHpCwE
         JhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYIkCiW1P3MTuGNaXnYInZXOL6oL98BTswmIrYI3+hc=;
        b=Cbf+1pS36nIWOhUBT7qVafeLUocqxkZ9ouS2pgEfesUdYU62aisMY47ys/j+crWR8x
         GJxGn9ZOkU0nfNaKgR8syXXLTerszhGSeiGFeaO6hoKRDxAUvuX+hj18GDoSAPybcZFK
         kpLPXGCJKLY/cHMRqc5yyebUs2GzSbyzK0gHANE5N3640yBjU1hjVHGoZW0dlzOyO3nl
         qGfNHq/jEqrCPolq3nr4NPWs8NofJyYyxgklM8W6siaCFFjO9LffAZ1I5w9NavcrVuxE
         1XY5GO9RZbcid8fa6QeM+t47ShEKlBTdZg7/BOsuEfNfIkCne3jMaKT3DLz3qXLEwXMy
         iFiQ==
X-Gm-Message-State: AO0yUKXQyYey09Q8aGcYvqgnaq+vWWbE9q90iGv7qv5U0V8niwXHaago
        Z9sEHK1Ag+YDFJpQqH+kAyk=
X-Google-Smtp-Source: AK7set+6yJ/VIDgvzJ07sbwRoyqtX5Z4gVUluKE0+5jQloSvZWFq8eCN7xusPVn+H7cDq6VHJfZzWQ==
X-Received: by 2002:a17:902:8504:b0:199:30a6:376c with SMTP id bj4-20020a170902850400b0019930a6376cmr3106041plb.68.1676754956327;
        Sat, 18 Feb 2023 13:15:56 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b0019a96871e09sm5072653plb.211.2023.02.18.13.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:15:55 -0800 (PST)
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
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
Date:   Sat, 18 Feb 2023 13:15:49 -0800
Message-Id: <20230218211608.1630586-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218211608.1630586-1-robdclark@gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
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
index fb6ca1032885..c30b2085ee0a 100644
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

