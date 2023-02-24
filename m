Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034E36A22D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjBXUCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBXUCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:13 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7D231D0;
        Fri, 24 Feb 2023 12:02:09 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e9so657726plh.2;
        Fri, 24 Feb 2023 12:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH1XEc3KAn/sRh8mdEO2wIJdXWsQGUDBi0nWZu5f5AE=;
        b=AnuBiC9Q4HD/sUWdq/Fuox9rJMcPyz4IEFy99CvJwm+0yDoqm0sl10VKkn1V3As0Ld
         9yqP3MwbEmbBESPJ2yGFVRTdlVnuJqF+AuF2vAhae4BwxKo3JQScL1eo6txft8D6QwBt
         vIc1xJOiAYUB0T5bgVooBq49NYzQ4fTcadKTiFn8Z/Cnfrg7bJv4yAJfwMsHhKPdcuTk
         ZthqbRNX5Fpr//AI78+tvzjI4FbtX3VHZUEfPrHafz0ILLrmWTCtMqw1c/zMBrnSxrco
         QV4RIXFTkiyPFdfNIoz02GUekJvDjQ14Ct8TRJ+unbKgdDmLXuWjfoWqd0PIt05Usl30
         zOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH1XEc3KAn/sRh8mdEO2wIJdXWsQGUDBi0nWZu5f5AE=;
        b=YydUNBnUZwdEO8C+fb765ZwnIbtVI2w14ddnt5PiukQKrsteAECCy1Fgs56rE1o7TM
         +MBWwiD/Khrol6sxpBfvvViLwWbZFyo4/M2PlDC7XqK0lHf61I4dYYAk8LuskiPhW/Fx
         sPs2JvL86MP5K2Oq1t4FZkJYo4G4u85AMKJMf5jujzHGvM7GnqtNyhjSXJlOhLHkS9CR
         ImByIn5du75epTfmm2Ds+nbu2Zcacw63qL8qUH5EPFMdZ6nHY03BgWKsvqr90mgNjim3
         ZtmY4Yv2PC6ocURXq+ZLrcIpi5FDYL+685oQqUMvPka1M7lusX/R+ZLjK+sSvcRwvdeY
         vt7w==
X-Gm-Message-State: AO0yUKViN1t81UDOmRYFMxJB0YXaJU2QC39q+baFdkYlLZPvGc+88kOs
        NUrmdVVajjzzBLNo1j8r2a0=
X-Google-Smtp-Source: AK7set8qFCH+2CqKbLueNDCo7fIj4c1IevDrQc9lQ5xht0OLqjJeM8PM0g3X2XTYAZJ3UwnNvMgevA==
X-Received: by 2002:a17:90b:1d84:b0:230:c96e:fc4a with SMTP id pf4-20020a17090b1d8400b00230c96efc4amr877500pjb.1.1677268929188;
        Fri, 24 Feb 2023 12:02:09 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090ac00600b002366c766ef4sm1889017pjt.33.2023.02.24.12.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:08 -0800 (PST)
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
Subject: [PATCH v6 05/15] dma-buf/sync_file: Add SET_DEADLINE ioctl
Date:   Fri, 24 Feb 2023 12:01:33 -0800
Message-Id: <20230224200155.2510320-6-robdclark@gmail.com>
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

The initial purpose is for igt tests, but this would also be useful for
compositors that wait until close to vblank deadline to make decisions
about which frame to show.

The igt tests can be found at:

https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/fence-deadline

v2: Clarify the timebase, add link to igt tests
v3: Use u64 value in ns to express deadline.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/dma-buf/sync_file.c    | 19 +++++++++++++++++++
 include/uapi/linux/sync_file.h | 22 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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
index ee2dcfb3d660..49325cf6749b 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -67,6 +67,21 @@ struct sync_file_info {
 	__u64	sync_fence_info;
 };
 
+/**
+ * struct sync_set_deadline - set a deadline hint on a fence
+ * @deadline_ns: absolute time of the deadline
+ * @pad:	must be zero
+ *
+ * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank)
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
 
 /**
@@ -95,4 +110,11 @@ struct sync_file_info {
  */
 #define SYNC_IOC_FILE_INFO	_IOWR(SYNC_IOC_MAGIC, 4, struct sync_file_info)
 
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

