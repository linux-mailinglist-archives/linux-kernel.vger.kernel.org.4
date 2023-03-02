Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6426B6A8D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCBXya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCBXyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:54:18 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC94FA81;
        Thu,  2 Mar 2023 15:54:12 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so4445746pjb.3;
        Thu, 02 Mar 2023 15:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677801252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETqCmTHSSqXnNZWKuQdc5aqtsOAoStUjUTTw9xnexgU=;
        b=Wg55OsvUwXVKaQjNDTz/HaotujJ91bf00LrX0Y2jNCT07MxMYSqkxfirm/mIkshtNr
         8tONL6g+r2yVJldmiMA1cqBIOanTPf9jJ/G9h8BHoC3qLzh8/FMuGFge2z1PDr4nM8OU
         +mJsenGKeB4rf27qQwYfeDsqBSzf+B83m2vRQrGNCvDkK4HGgJRy87cvWqJcTxkGMqjD
         qF8rEvrm9eAMcUUfQUkrN2W+xhZfQ7D1XVjGyhoQY49ujoynUK3relJ7EqTJSMNf6Xfg
         P9nRqP/xAxPECncv/2+hnxYoeyok4ZjO8yvgdx9KefDLkN5PUtCRTrEXQ0DsQ91nP0Si
         TOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETqCmTHSSqXnNZWKuQdc5aqtsOAoStUjUTTw9xnexgU=;
        b=HkKF9MLTQdUkco5Qp22XGQsJTUbkXhWp9ajwTIdJFqYem6p2QF4DYYbAFUezOlGDcJ
         Mmj/rPKgDfOLgoidHPkKpFtYWcJYXfVgO/bOWxwvKJ8mKRdoVnuXAuJtrmM//vmaEX+j
         dgNb5B0izxXlBfFQQAXKE8rphcfkVUGUcwzQhWmtTB7mjgIDV+QYYh+ycOgvD9OGCTTU
         cpP5xTbMVv08F30fB3/aBskWmeD2jh5akiKTeV/KE8jeWME/vaJcvn8GQ2Nv7p7zFSFQ
         Gd6dQ8MwZtsZBlXqTHoZBO47mTcLJNa50TFfv6ZW/UcAcOnu0Tz/hl3mD0guAQTC6iGk
         uhlA==
X-Gm-Message-State: AO0yUKX9JPzj6+uICwzNGsk73gJPWK4LW5kFZunqiaINa5/yOumlKduY
        QmcGSmi+nRTXUC+d/m/z2aE=
X-Google-Smtp-Source: AK7set+2NAy/RATNaAwh/ZUEbbMdlGMTUwyYU6TOy47ebkL3RE8iMUJiZwtUW9kAfHidx5nat7Hs9A==
X-Received: by 2002:a17:902:d511:b0:19c:e9c4:cc13 with SMTP id b17-20020a170902d51100b0019ce9c4cc13mr68168plg.25.1677801251933;
        Thu, 02 Mar 2023 15:54:11 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00198fb25d09bsm204948plp.237.2023.03.02.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:54:11 -0800 (PST)
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
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 06/15] dma-buf/sync_file: Add SET_DEADLINE ioctl
Date:   Thu,  2 Mar 2023 15:53:28 -0800
Message-Id: <20230302235356.3148279-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302235356.3148279-1-robdclark@gmail.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
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
2.39.1

