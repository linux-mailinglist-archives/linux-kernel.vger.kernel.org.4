Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A156A630F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjB1W7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjB1W6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:58:53 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF90F37714;
        Tue, 28 Feb 2023 14:58:48 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h8so8806967plf.10;
        Tue, 28 Feb 2023 14:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG7vKOCZs7RF7xaksAPYUQd1A2SxHbLuaH7Mq26I3gY=;
        b=EvydJjNFp+u1SVWCsmQl6hCES4FLObikUxdCaUzTp+mazMyN04WpakjfWOiWYZpQ9K
         +18Q+ZrVN6rXU535yHal4u0v9WlNj4fL83CX21cvR5kaAswoUkIIwPiP6yA7uSomZ2q4
         gOyL+8oS9/tESst5ORa9gq9/1quHZQT/awWoAwyGXR4G4xRhnGfJueSfJbFixQNDhsV+
         gSLgbCPMR+YRh9/psIjCBZ2zV70Lq/Am60VGukvTC352yjnZJCRJ6iQ47q9zdpYG+RW4
         JJ/Fs8OSN0EAlcLSodzwcWV0JQ/lIWcliG3tbJoDP5OA7yH1hUodS/10ILurYlxl3Z47
         xYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG7vKOCZs7RF7xaksAPYUQd1A2SxHbLuaH7Mq26I3gY=;
        b=sZZGhMts5leSrBhvtlX2iCQc0Z3MCHu6kLrsETnyN/FHyCAR8RpDrK5O2ThlqdvCeN
         sxn7uBJZ4IEWGkjZDKbiuJKvPM9k8cenwrOVY51Zw6ndeZCtFJ7sZXAR1m3fUnDWf98f
         RAuZTiCUjjDKF6Xm2w/O4F4EgZ4q6VpVYQlwl5felOJC3y338cKXzricG8pW50cBevl3
         bjhQUoCaehy0IaOmWXAyxTe+78Ft7+ioqrNh9Q5hCTQ9NFHQDzqoFXDvZFYA5lKxd4OQ
         PLrgRPQ9t9M8NAj3zOnKRjyQxL6fqqANwKqXU9h2eDzGDWQ0s+/3N1HpyLLUBSM/A34K
         HCSg==
X-Gm-Message-State: AO0yUKXsqe2QuJ/V8tBri5zbb7n7k3zmqfFsAILaRF3299P5cKkGGuau
        Tpqd5e+u+AINEus+wWDht+4=
X-Google-Smtp-Source: AK7set8lrAj3oH7C94OxUvYLU1Uk1OCd5R4A9eqbUFXEtWJ7E8gHvhvvliXhpZQfXk8gGBCizI2YJQ==
X-Received: by 2002:a17:902:cec5:b0:19a:6acc:1de2 with SMTP id d5-20020a170902cec500b0019a6acc1de2mr5095396plg.35.1677625128309;
        Tue, 28 Feb 2023 14:58:48 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902ed9300b0019949fd956bsm7038431plj.178.2023.02.28.14.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:58:47 -0800 (PST)
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
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 05/16] dma-buf/sync_file: Surface sync-file uABI
Date:   Tue, 28 Feb 2023 14:58:09 -0800
Message-Id: <20230228225833.2920879-6-robdclark@gmail.com>
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

We had all of the internal driver APIs, but not the all important
userspace uABI, in the dma-buf doc.  Fix that.  And re-arrange the
comments slightly as otherwise the comments for the ioctl nr defines
would not show up.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/driver-api/dma-buf.rst | 10 ++++++--
 include/uapi/linux/sync_file.h       | 35 +++++++++++-----------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index 183e480d8cea..ff3f8da296af 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -203,8 +203,8 @@ DMA Fence unwrap
 .. kernel-doc:: include/linux/dma-fence-unwrap.h
    :internal:
 
-DMA Fence uABI/Sync File
-~~~~~~~~~~~~~~~~~~~~~~~~
+DMA Fence Sync File
+~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/dma-buf/sync_file.c
    :export:
@@ -212,6 +212,12 @@ DMA Fence uABI/Sync File
 .. kernel-doc:: include/linux/sync_file.h
    :internal:
 
+DMA Fence Sync File uABI
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/uapi/linux/sync_file.h
+   :internal:
+
 Indefinite DMA Fences
 ~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index ee2dcfb3d660..eced40c204d7 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -16,12 +16,16 @@
 #include <linux/types.h>
 
 /**
- * struct sync_merge_data - data passed to merge ioctl
+ * struct sync_merge_data - SYNC_IOC_MERGE: merge two fences
  * @name:	name of new fence
  * @fd2:	file descriptor of second fence
  * @fence:	returns the fd of the new fence to userspace
  * @flags:	merge_data flags
  * @pad:	padding for 64-bit alignment, should always be zero
+ *
+ * Creates a new fence containing copies of the sync_pts in both
+ * the calling fd and sync_merge_data.fd2.  Returns the new fence's
+ * fd in sync_merge_data.fence
  */
 struct sync_merge_data {
 	char	name[32];
@@ -34,8 +38,8 @@ struct sync_merge_data {
 /**
  * struct sync_fence_info - detailed fence information
  * @obj_name:		name of parent sync_timeline
-* @driver_name:	name of driver implementing the parent
-* @status:		status of the fence 0:active 1:signaled <0:error
+ * @driver_name:	name of driver implementing the parent
+ * @status:		status of the fence 0:active 1:signaled <0:error
  * @flags:		fence_info flags
  * @timestamp_ns:	timestamp of status change in nanoseconds
  */
@@ -48,14 +52,19 @@ struct sync_fence_info {
 };
 
 /**
- * struct sync_file_info - data returned from fence info ioctl
+ * struct sync_file_info - SYNC_IOC_FILE_INFO: get detailed information on a sync_file
  * @name:	name of fence
  * @status:	status of fence. 1: signaled 0:active <0:error
  * @flags:	sync_file_info flags
  * @num_fences	number of fences in the sync_file
  * @pad:	padding for 64-bit alignment, should always be zero
- * @sync_fence_info: pointer to array of structs sync_fence_info with all
+ * @sync_fence_info: pointer to array of struct &sync_fence_info with all
  *		 fences in the sync_file
+ *
+ * Takes a struct sync_file_info. If num_fences is 0, the field is updated
+ * with the actual number of fences. If num_fences is > 0, the system will
+ * use the pointer provided on sync_fence_info to return up to num_fences of
+ * struct sync_fence_info, with detailed fence information.
  */
 struct sync_file_info {
 	char	name[32];
@@ -76,23 +85,7 @@ struct sync_file_info {
  * no upstream users available.
  */
 
-/**
- * DOC: SYNC_IOC_MERGE - merge two fences
- *
- * Takes a struct sync_merge_data.  Creates a new fence containing copies of
- * the sync_pts in both the calling fd and sync_merge_data.fd2.  Returns the
- * new fence's fd in sync_merge_data.fence
- */
 #define SYNC_IOC_MERGE		_IOWR(SYNC_IOC_MAGIC, 3, struct sync_merge_data)
-
-/**
- * DOC: SYNC_IOC_FILE_INFO - get detailed information on a sync_file
- *
- * Takes a struct sync_file_info. If num_fences is 0, the field is updated
- * with the actual number of fences. If num_fences is > 0, the system will
- * use the pointer provided on sync_fence_info to return up to num_fences of
- * struct sync_fence_info, with detailed fence information.
- */
 #define SYNC_IOC_FILE_INFO	_IOWR(SYNC_IOC_MAGIC, 4, struct sync_file_info)
 
 #endif /* _UAPI_LINUX_SYNC_H */
-- 
2.39.1

