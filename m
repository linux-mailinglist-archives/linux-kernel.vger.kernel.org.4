Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76BA69BC3B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBRVQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBRVQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:16:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D715CB2;
        Sat, 18 Feb 2023 13:15:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n1so1451380plc.11;
        Sat, 18 Feb 2023 13:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hI9qNsZmZouFqjT4Q7iKBhJP6Ch7PWCt+bcIXmzWxTA=;
        b=n8m0ik/8SEVtlt4tLy+1xKXcajLNDaoTcnObCr8qoX1kosoaMIoPX31NBzsj7seG30
         TaPhmBInQnPnfd0sbBYcu2Sjd2IA6FxDGaZmCXZoXtGjZW6hFd+e9Xciqw/mNaEUFrq1
         hjgq42bMdkekPwZy8PzTS6/Xq4JcoVNW50YdZjMsh/w+8uyRIy6w/+AWEK3pPnMvauwT
         wNnyWecM/dDofyumtFxiSCy6DM51SXQm97P8nGKVnoB2XUwupExO/xZ5cnsTPvxIDZIP
         qmCKeD3CtfUoaR56Ve0CFhe2vvZV/cLqVUjPQ858IZhTD5rfzOW9nQ9q1HUMtmg9/Zl0
         ZfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hI9qNsZmZouFqjT4Q7iKBhJP6Ch7PWCt+bcIXmzWxTA=;
        b=nWsKbyyIwWelqOmz6eJmexRq1iL+8On4/01gAZdYQq8td1ZoZB0FfzuekGR7JLMHVn
         e6iToVPLJpwEUvJrRNy01gsZQIJ9VNlz4YxHaEoyuCt0Jljc8W29JNQAsmM0l24/KnPU
         2QPAyx0s6Jw6E3pEvbWbBjbN1x31tjGbhoF7FyD0R5rovH7VJXjM861CM+HLiQ6Um5yb
         wmGqWBSzhK1ZBGvvIuOKvSuQoBImayQNGvmAyc6YHn+UIXhAJ+PI+flcEmUabDp42tPr
         X6zXjMyTcW1T0+Mjb0vZ8frfNc2naeWdco8IHQsixs/ju5bRsypRxQ0v/ZFSrKoamLcl
         fJsQ==
X-Gm-Message-State: AO0yUKVOi1Mcn11nXan6Toa06tEeupEueVOIYZvHBLHq+uU+4AR1TkF1
        iOy4firbpNGxgtoEBXTgs8g=
X-Google-Smtp-Source: AK7set9yuqIqkhJME2lpIvPyHaEjKyBB3ZOLwsVnLF62v/VV509uPfIKWgQ2ORuaU7W+EZTtXhgZJQ==
X-Received: by 2002:a17:902:f98d:b0:19a:a647:1881 with SMTP id ky13-20020a170902f98d00b0019aa6471881mr3492159plb.62.1676754955043;
        Sat, 18 Feb 2023 13:15:55 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b0019934030f46sm5057523plh.132.2023.02.18.13.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:15:54 -0800 (PST)
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
Subject: [PATCH v4 05/14] dma-buf/sync_file: Add SET_DEADLINE ioctl
Date:   Sat, 18 Feb 2023 13:15:48 -0800
Message-Id: <20230218211608.1630586-6-robdclark@gmail.com>
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

The initial purpose is for igt tests, but this would also be useful for
compositors that wait until close to vblank deadline to make decisions
about which frame to show.

The igt tests can be found at:

https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/fence-deadline

v2: Clarify the timebase, add link to igt tests

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/dma-buf/sync_file.c    | 19 +++++++++++++++++++
 include/uapi/linux/sync_file.h | 22 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index af57799c86ce..fb6ca1032885 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -350,6 +350,22 @@ static long sync_file_ioctl_fence_info(struct sync_file *sync_file,
 	return ret;
 }
 
+static int sync_file_ioctl_set_deadline(struct sync_file *sync_file,
+					unsigned long arg)
+{
+	struct sync_set_deadline ts;
+
+	if (copy_from_user(&ts, (void __user *)arg, sizeof(ts)))
+		return -EFAULT;
+
+	if (ts.pad)
+		return -EINVAL;
+
+	dma_fence_set_deadline(sync_file->fence, ktime_set(ts.tv_sec, ts.tv_nsec));
+
+	return 0;
+}
+
 static long sync_file_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -362,6 +378,9 @@ static long sync_file_ioctl(struct file *file, unsigned int cmd,
 	case SYNC_IOC_FILE_INFO:
 		return sync_file_ioctl_fence_info(sync_file, arg);
 
+	case SYNC_IOC_SET_DEADLINE:
+		return sync_file_ioctl_set_deadline(sync_file, arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index ee2dcfb3d660..c8666580816f 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -67,6 +67,20 @@ struct sync_file_info {
 	__u64	sync_fence_info;
 };
 
+/**
+ * struct sync_set_deadline - set a deadline on a fence
+ * @tv_sec:	seconds elapsed since epoch
+ * @tv_nsec:	nanoseconds elapsed since the time given by the tv_sec
+ * @pad:	must be zero
+ *
+ * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank)
+ */
+struct sync_set_deadline {
+	__s64	tv_sec;
+	__s32	tv_nsec;
+	__u32	pad;
+};
+
 #define SYNC_IOC_MAGIC		'>'
 
 /**
@@ -95,4 +109,12 @@ struct sync_file_info {
  */
 #define SYNC_IOC_FILE_INFO	_IOWR(SYNC_IOC_MAGIC, 4, struct sync_file_info)
 
+
+/**
+ * DOC: SYNC_IOC_SET_DEADLINE - set a deadline on a fence
+ *
+ * Allows userspace to set a deadline on a fence, see dma_fence_set_deadline()
+ */
+#define SYNC_IOC_SET_DEADLINE	_IOW(SYNC_IOC_MAGIC, 5, struct sync_set_deadline)
+
 #endif /* _UAPI_LINUX_SYNC_H */
-- 
2.39.1

