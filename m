Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454F86B0DB1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjCHPyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjCHPyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:54:02 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF393E0A;
        Wed,  8 Mar 2023 07:53:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a9so18036531plh.11;
        Wed, 08 Mar 2023 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678290822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y5b+VjWsIZ7/aQ28FJAoXhXCRI/6ay8CYDf5UDrIsQ=;
        b=Qgty6JemmqndPzrOvTFjpdZYq4HTDRC1Nb/6xQ9mwOXXVtHYWblss0rZOXOun+0brb
         Vn0VmVgiIHeYoANUhgQneDplGRLe/AEM8ojrFvDAhScrvRUu2RNv1ewj/sRzCcWDeKCS
         LXeDrQzld7Y3CdcYFPQv6Dg02+FAgWqYzNO/JlsBqPvAQGP1eiMDM5kWekKp+ikzSBlJ
         RrpAMk86oSm9njXvxu4e4i58S06IwH+lg5lWOovDQRj/dLi+Hq6NGWki5mO3eDwlLD1z
         e0J19KOhAleiZWrrGMWpUk62X8VmJj21NldYbcCgixQ/aXm5mKLM/9tKWEDZugaqhZ1G
         Fagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y5b+VjWsIZ7/aQ28FJAoXhXCRI/6ay8CYDf5UDrIsQ=;
        b=eu4luRo/CGYddCQVi3KJN7tOxWxfuzsRPKiRESbo3LhgcNC0guqpITQlprXJDXy6VT
         9mWuYBdIXIlLimjo9bxqa3MSnxdfv7+0T8vNVsg3qp/fn2YXEZVuPO9p66xwz+4gsJzT
         5TpZkvzl/s4jfYmzb6HYIqSbLFxFPbKbcNriISwHEHVlGY2PSwpETdzJ1t+QqEVxnZhU
         FmcBzuSiHFu/RLL4LCoBkqLl9glr3JrQ0scnlprpUviAT+Fp5wIbIcjMcVyy93FuRlRE
         1yiO7KwCRMNWvfEhZrIbw2i1jGXB3jH01ybHU8SVBcJXlm204KxNZ4YwqcDTD1TE/6lg
         b6xQ==
X-Gm-Message-State: AO0yUKWhhLotu0MJ+seNkRdE/yHdFZXfbIcVpsYmQwP6U7B6Droe6n9N
        4ffnhdJwv/7609YuOV9MY8c=
X-Google-Smtp-Source: AK7set+slEwuyhiM7J+t4oZEWiZ6d/QJzILZsLHwV9a8j3akEhhWZmIVSvWagsgajmw3hvccg7AyNQ==
X-Received: by 2002:a17:90b:3a82:b0:237:c5cc:15bf with SMTP id om2-20020a17090b3a8200b00237c5cc15bfmr18947277pjb.13.1678290821736;
        Wed, 08 Mar 2023 07:53:41 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090acf0900b00219752c8ea5sm8987481pju.37.2023.03.08.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:53:41 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Rob Clark <robdclark@chromium.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 06/15] dma-buf/sync_file: Add SET_DEADLINE ioctl
Date:   Wed,  8 Mar 2023 07:52:57 -0800
Message-Id: <20230308155322.344664-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308155322.344664-1-robdclark@gmail.com>
References: <20230308155322.344664-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
v3: Use u64 value in ns to express deadline.
v4: More doc

Signed-off-by: Rob Clark <robdclark@chromium.org>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---
 drivers/dma-buf/dma-fence.c    |  3 ++-
 drivers/dma-buf/sync_file.c    | 19 +++++++++++++++++++
 include/uapi/linux/sync_file.h | 22 ++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index f177c56269bb..74e36f6d05b0 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -933,7 +933,8 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
  *   the GPU's devfreq to reduce frequency, when in fact the opposite is what is
  *   needed.
  *
- * To this end, deadline hint(s) can be set on a &dma_fence via &dma_fence_set_deadline.
+ * To this end, deadline hint(s) can be set on a &dma_fence via &dma_fence_set_deadline
+ * (or indirectly via userspace facing ioctls like &sync_set_deadline).
  * The deadline hint provides a way for the waiting driver, or userspace, to
  * convey an appropriate sense of urgency to the signaling driver.
  *
diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index af57799c86ce..418021cfb87c 100644
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
+	dma_fence_set_deadline(sync_file->fence, ns_to_ktime(ts.deadline_ns));
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
index 7e42a5b7558b..d61752dca4c6 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -76,6 +76,27 @@ struct sync_file_info {
 	__u64	sync_fence_info;
 };
 
+/**
+ * struct sync_set_deadline - SYNC_IOC_SET_DEADLINE - set a deadline hint on a fence
+ * @deadline_ns: absolute time of the deadline
+ * @pad:	must be zero
+ *
+ * Allows userspace to set a deadline on a fence, see &dma_fence_set_deadline
+ *
+ * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank).  For
+ * example
+ *
+ *     clock_gettime(CLOCK_MONOTONIC, &t);
+ *     deadline_ns = (t.tv_sec * 1000000000L) + t.tv_nsec + ns_until_deadline
+ */
+struct sync_set_deadline {
+	__u64	deadline_ns;
+	/* Not strictly needed for alignment but gives some possibility
+	 * for future extension:
+	 */
+	__u64	pad;
+};
+
 #define SYNC_IOC_MAGIC		'>'
 
 /*
@@ -87,5 +108,6 @@ struct sync_file_info {
 
 #define SYNC_IOC_MERGE		_IOWR(SYNC_IOC_MAGIC, 3, struct sync_merge_data)
 #define SYNC_IOC_FILE_INFO	_IOWR(SYNC_IOC_MAGIC, 4, struct sync_file_info)
+#define SYNC_IOC_SET_DEADLINE	_IOW(SYNC_IOC_MAGIC, 5, struct sync_set_deadline)
 
 #endif /* _UAPI_LINUX_SYNC_H */
-- 
2.39.2

