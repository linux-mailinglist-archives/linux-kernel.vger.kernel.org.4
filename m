Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496AF6EAF03
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjDUQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDUQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:27:56 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FED5FE6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:27:55 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54fb9b1a421so9416107b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682094474; x=1684686474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McykokNzwWyCz9Y9TPtIev36ZR6e3+pIXruNzRoQkAY=;
        b=BUc1YxBC3awMTQscadlSIHFVnCRg4SyDmzMatWbAq+RrdhVVwAdHk38MECCoTxVyrE
         cMqkaUZQqVGdOI+Urt+ZUr6Yng1aC1kFZfbRxVjNIvLOrOgg7K7D21tr7IDpZyKMHbFR
         j/wo4ZRCFesby50BDSMqDksucccGTsyp0EMuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094474; x=1684686474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McykokNzwWyCz9Y9TPtIev36ZR6e3+pIXruNzRoQkAY=;
        b=NZCnnObKNRBJmMyxRFWwieZdlYCjJniybqodtXPPOKzQ5bagR0ttiuBBEh4TXYgksI
         y5c/WyCyRjK4fwg7Q0h6NQhs1a+wxXo1X1Oxzw10WQrFFu+GhyPDINwo15r7vwGaFtVU
         hRg43Hi0Fdf2VkxeKR1M+Nwiu2OQtXuwwXjlnA1mpEc3uBX7lBcam6lSITWdYmyPSrjF
         iCB9VGWvfiS2j2ZL46CSqGpctPZLcPvO9N91CU3e2eDxev8L3yBfyaJ/jJQEEOVGrBfk
         sefnNTBViKZAID/2dEYyLMw4p+ERjx6R2De2bnNHsd/ZcTAgAUbWlnIcQK/zfJ3leBRj
         hqSg==
X-Gm-Message-State: AAQBX9f1kx1LruDpsg/eq1CKQDxw5381BkbyUh2twY4ToaHrBWyP454w
        Bi0nn/ckLtKnR6iaCGfHLsA6wA==
X-Google-Smtp-Source: AKy350ZMUImoST1PPQEereoaPYWN/eiBO9JjQaNH8X/XxV88O/42bu9GQGxhm8cYP1K2g46uBi0tEQ==
X-Received: by 2002:a81:6207:0:b0:549:2623:6f65 with SMTP id w7-20020a816207000000b0054926236f65mr2430474ywb.33.1682094474289;
        Fri, 21 Apr 2023 09:27:54 -0700 (PDT)
Received: from localhost ([2620:0:1035:15:25e5:2115:c97c:bf00])
        by smtp.gmail.com with UTF8SMTPSA id b198-20020a0dd9cf000000b00545a0818487sm1036048ywe.23.2023.04.21.09.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:27:54 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
X-Google-Original-From: Mark Yacoub <markyacoub@google.com>
To:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     seanpaul@chromium.org, dianders@chromium.org,
        dmitry.baryshkov@linaro.org, Mark Yacoub <markyacoub@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm: Create support for Write-Only property blob
Date:   Fri, 21 Apr 2023 12:27:47 -0400
Message-ID: <20230421162749.360777-2-markyacoub@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230421162749.360777-1-markyacoub@google.com>
References: <20230421162749.360777-1-markyacoub@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@chromium.org>

[Why]
User space might need to inject data into the kernel without allowing it
to be read again by any user space.
An example of where this is particularly useful is secret keys fetched
by user space and injected into the kernel to enable content protection.

[How]
Create a DRM_MODE_CREATE_BLOB_WRITE_ONLY flag used by user space to
create a blob and mark the blob as write only.
On reading back the blob, data will be not be copied if it's a write
only blob

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/drm_property.c | 3 ++-
 include/drm/drm_property.h     | 2 ++
 include/uapi/drm/drm_mode.h    | 6 ++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index dfec479830e49..afedf7109d002 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -765,7 +765,7 @@ int drm_mode_getblob_ioctl(struct drm_device *dev,
 	if (!blob)
 		return -ENOENT;
 
-	if (out_resp->length == blob->length) {
+	if (out_resp->length == blob->length && !blob->is_write_only) {
 		if (copy_to_user(u64_to_user_ptr(out_resp->data),
 				 blob->data,
 				 blob->length)) {
@@ -800,6 +800,7 @@ int drm_mode_createblob_ioctl(struct drm_device *dev,
 		ret = -EFAULT;
 		goto out_blob;
 	}
+	blob->is_write_only = out_resp->flags & DRM_MODE_CREATE_BLOB_WRITE_ONLY;
 
 	/* Dropping the lock between create_blob and our access here is safe
 	 * as only the same file_priv can remove the blob; at this point, it is
diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
index 65bc9710a4702..700782f021b99 100644
--- a/include/drm/drm_property.h
+++ b/include/drm/drm_property.h
@@ -205,6 +205,7 @@ struct drm_property {
  * 	&drm_mode_config.property_blob_list.
  * @head_file: entry on the per-file blob list in &drm_file.blobs list.
  * @length: size of the blob in bytes, invariant over the lifetime of the object
+ * @is_write_only: user space can't read the blob data.
  * @data: actual data, embedded at the end of this structure
  *
  * Blobs are used to store bigger values than what fits directly into the 64
@@ -219,6 +220,7 @@ struct drm_property_blob {
 	struct list_head head_global;
 	struct list_head head_file;
 	size_t length;
+	bool is_write_only;
 	void *data;
 };
 
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 46becedf5b2fc..10403c9a73082 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -1168,6 +1168,9 @@ struct drm_format_modifier {
 	__u64 modifier;
 };
 
+#define DRM_MODE_CREATE_BLOB_WRITE_ONLY                                        \
+	(1 << 0) /* data of the blob can't be read by user space */
+
 /**
  * struct drm_mode_create_blob - Create New blob property
  *
@@ -1181,6 +1184,9 @@ struct drm_mode_create_blob {
 	__u32 length;
 	/** @blob_id: Return: new property ID. */
 	__u32 blob_id;
+	/** Flags for special handling. */
+	__u32 flags;
+	__u32 pad;
 };
 
 /**
-- 
2.40.0.634.g4ca3ef3211-goog

