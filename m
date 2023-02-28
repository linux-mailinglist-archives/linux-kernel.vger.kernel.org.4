Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7396A6322
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjB1W7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjB1W66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:58:58 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF93CC674;
        Tue, 28 Feb 2023 14:58:52 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 16so6637311pge.11;
        Tue, 28 Feb 2023 14:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPSgblFxcMDwoNtdY8qW+0LuYLpgnFy45QQcEr2JcOw=;
        b=V1urbG5RuLnnO3VpMHdX0KG/G6gU5WFBPcaLIO0j/3+ro3asLgBZxzPDlmGLQLGWfY
         e1npBQxhdEGRFU27gZsGamZvqXfjGxkBzgs9jBR4/GulwzblxgQ3Q6HMAgg5602sWSXe
         UvJ7TjSeSlS12TW3snncvEDnKiwrwdWyJzrDKOpd+ZV44GjPF2+IThw12qS6zyzKbezc
         wD3N9vq19W3m09Onq+8ioeK5HFFsOCrkYESNlPR/LI/uiCcj/oiQoPZ+0w0sg8XCqlkr
         6ehVtL1cFcF+Pwx6XuAwYT67z061XHz0XA9KQ8wRhNrbCXO7Sp3k2WWlSbcRXTxvF919
         dW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPSgblFxcMDwoNtdY8qW+0LuYLpgnFy45QQcEr2JcOw=;
        b=drMn1Bqd7U5BcftodSROsE9IsKy8FcAQd+yNZvsFnXVwwSybAHhKezPB9lwCauYHGU
         Is0VUa0Vr9kSNLESaUYw9fl8ImSMibkHksurd/LjrCUnFiXme5mVLvlYxvhQoVP+Ko0I
         /XKKvCkbQqx8UjKDUv0C11typ5OhiurElhkXjOQ1XFqnNHqkUSXTmBOUgahcvNRe8zpx
         jX1xaFWJTt29h+23g6LST1Xf/bQg8nnsEXJS3u6X7MN/unDNlKI5fwlgRmNC4pkTg4Kd
         doGParsqU9DQX8OwNVg7jbVdHGTg0yDYZBEjFMERF5oh83ohiYLr5FBP3qRm3jTbdmR0
         CLaw==
X-Gm-Message-State: AO0yUKUdCB9kMtrzIRo9lR0KFrR9rpk+XbIxS8y/oq/uKtRWsVe/p787
        Nzzz3FpKxSyY5GQYlomCIxM=
X-Google-Smtp-Source: AK7set9D6bzyHSECO63x+rY5hYGmDXYfp4j6STSXtKZg5kfnZ3Wzzd0d0FRKKk5uiWMW7b1PfnYMZA==
X-Received: by 2002:aa7:99c8:0:b0:5a8:d97d:c346 with SMTP id v8-20020aa799c8000000b005a8d97dc346mr4142929pfi.12.1677625132210;
        Tue, 28 Feb 2023 14:58:52 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id k184-20020a633dc1000000b0049f5da82b12sm6121487pga.93.2023.02.28.14.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:58:51 -0800 (PST)
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
Subject: [PATCH v8 07/16] dma-buf/sync_file: Support (E)POLLPRI
Date:   Tue, 28 Feb 2023 14:58:11 -0800
Message-Id: <20230228225833.2920879-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230228225833.2920879-1-robdclark@gmail.com>
References: <20230228225833.2920879-1-robdclark@gmail.com>
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

