Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3554A69D4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjBTUTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjBTUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:19:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2113D48;
        Mon, 20 Feb 2023 12:19:27 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b14-20020a17090a8c8e00b002349579949aso2475375pjo.5;
        Mon, 20 Feb 2023 12:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPSgblFxcMDwoNtdY8qW+0LuYLpgnFy45QQcEr2JcOw=;
        b=b6XsnDqK1olt5qz2T9u3YiOy1VT5RRxz/VMoCYps3Pgrs+exn0Ya8JX+enLUoYcNBj
         buWfCT4iJPWfewaDPWp/5MvY+8QNicRVOvpZHbzyieCeadRJB6D+ELIdtWQA4vrudB0C
         Ic8gs+sFUfMRmdGe8U8V9mlHakR00nNgiPRSLRz2wdN0NwK0cO/ZTEM+Dk85lDjnxFGH
         4H69GyzuGQ4Yzbn85CZMH0ujDoR4wVYNjPMbCZHKi7GaRLaFXdb2OrikJlOFpEQdeOqM
         rY/t4VFouvqsEETK+GCENjhhtY9tFNbH5CV48cJKLSsRL+uhx50XjKjLgz+GY+R0oaqk
         Wy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPSgblFxcMDwoNtdY8qW+0LuYLpgnFy45QQcEr2JcOw=;
        b=M+EbSZe1g0EiAt6i4BGTDr416db8RR+EyW4N2S7whytxiSWHkjYoeORh4mNGumbljT
         Xa4+ix0OBLalAHEwffKwxqeAaRE9fu38n3kUcuLdPLCmvnReIKZl0m7jhFhETtgJnf2T
         LkXfeauU36du/fc+BGnWOcocz9kZS4VfUDAWRRNqfsvOxFBl2jlDgQ4LHhrT9U4mUh3q
         8QtVvNcVoXfYb0O03V3I7ZKQeiWHWN7/JabrOLxddWgTSQokv9nLU8EcPUCqVbUPJF93
         fSG9ICChadUTs8sfs0VOZARx/yiTyHFUrF3dESozOcoQetVvAs/1t4OjVe5u2zmaT2I8
         w6IA==
X-Gm-Message-State: AO0yUKWMwDk59K1ge9jTrPAaG6ks9/h8n3NXXzdOOlMpwxYCFT2a8SBR
        aZ3AG2Cr/Fayny2qfU6RLRk=
X-Google-Smtp-Source: AK7set/kLRp8IZ3rKb3WEqYptlfgjeKBGtJDw+/6Vpa1D7As5QAyc9t819GAtY4AWeHTvgf1dPYb+A==
X-Received: by 2002:a17:902:ea07:b0:19a:f9b5:2f2f with SMTP id s7-20020a170902ea0700b0019af9b52f2fmr2362963plg.55.1676924367448;
        Mon, 20 Feb 2023 12:19:27 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709028f9200b00198f2407ea1sm2033972plo.241.2023.02.20.12.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:19:27 -0800 (PST)
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
Subject: [PATCH v5 06/14] dma-buf/sync_file: Support (E)POLLPRI
Date:   Mon, 20 Feb 2023 12:18:53 -0800
Message-Id: <20230220201916.1822214-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220201916.1822214-1-robdclark@gmail.com>
References: <20230220201916.1822214-1-robdclark@gmail.com>
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

