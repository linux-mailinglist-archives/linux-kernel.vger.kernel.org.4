Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C86EAEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjDUQM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjDUQMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:12:54 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770E9EF2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:12:44 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fe2e39156so21516047b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682093563; x=1684685563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQvRknvrozsjgOo+aHdUqHX5mEjM0UqwOQuOkiFPD1Q=;
        b=aY7hOgXg/OVMQhJpR+WdPXoXmESxOXa/4Z2E/3GbrCFz/DnAzBTOkLQvfUTDbakEKz
         B+fEz9sGY+bXYgokkV9JKIHIN1UX8lWCps3ls6u7xpOuI7x6gR4KZ0dDWtGd0r+PNKs3
         95eRD42ZB/Jd21qkUJZGCIvz3+lpllh9EkBag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682093563; x=1684685563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQvRknvrozsjgOo+aHdUqHX5mEjM0UqwOQuOkiFPD1Q=;
        b=Vbj6jov0xaiZEZxN3xs6u6kUCk3Nrh/OZBiSVV59mFcV3mNtcjbz+mr1si208MrZzg
         SnW2ERojQsSk9henCCxIvOVk3IQKQf6wqUXozPs54uAugpQBW97roS2O4ka0BFDKznDv
         b9slO1dlxUV2iim3Kix9VG3VBfm+dTxP6FsouZb6DZD7K0xeKWvC6qea0zD4p2xicFOD
         DFaEBZDjuuTUtULuzxOTdt0UQPWQhff2tMPJ3FppONzbBzB5CtU6uozEG0b1BnJQ73oo
         XCYMwZu7It2tY36FqDgtjiyuFsJ5rFC5Wr9gZGVBsdBsh0n5ta5utWXl1XvtYEwGr3Qd
         2+DQ==
X-Gm-Message-State: AAQBX9cdVS/AtffdjkfKDPJm+UJ40m9foTuK8vFokWHfiWFvJhW6rGS2
        NM6zq9h/k9vue09uVS8+UTxMJA==
X-Google-Smtp-Source: AKy350aEtduOjMIU3HUgeK4N5JZgtHBrAAVw0qeEDNNp/Pmvtp0bSXFirsCwHwiI8ng/WkSUfnqtnA==
X-Received: by 2002:a81:6245:0:b0:54c:2500:defa with SMTP id w66-20020a816245000000b0054c2500defamr2367114ywb.10.1682093563605;
        Fri, 21 Apr 2023 09:12:43 -0700 (PDT)
Received: from localhost ([2620:0:1035:15:25e5:2115:c97c:bf00])
        by smtp.gmail.com with UTF8SMTPSA id f67-20020a816a46000000b00552a648fd7bsm1020460ywc.83.2023.04.21.09.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:12:43 -0700 (PDT)
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
Subject: [PATCH v1 1/2] DRM: Create new Content Protection connector property
Date:   Fri, 21 Apr 2023 12:12:36 -0400
Message-ID: <20230421161237.357342-2-markyacoub@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230421161237.357342-1-markyacoub@google.com>
References: <20230421161237.357342-1-markyacoub@google.com>
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
To enable Protected Content, some drivers require a key to be injected
from user space to enable HDCP on the connector.

[How]
Create new "Content Protection Property" of type "Blob"

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 9 +++++++++
 include/drm/drm_connector.h       | 6 ++++++
 include/drm/drm_mode_config.h     | 6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index d867e7f9f2cd5..e20bc57cdb05c 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -749,6 +749,11 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->content_protection = val;
 	} else if (property == config->hdcp_content_type_property) {
 		state->hdcp_content_type = val;
+	} else if (property == config->content_protection_key_property) {
+		ret = drm_atomic_replace_property_blob_from_id(
+			dev, &state->content_protection_key, val, -1, -1,
+			&replaced);
+		return ret;
 	} else if (property == connector->colorspace_property) {
 		state->colorspace = val;
 	} else if (property == config->writeback_fb_id_property) {
@@ -843,6 +848,10 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->content_protection;
 	} else if (property == config->hdcp_content_type_property) {
 		*val = state->hdcp_content_type;
+	} else if (property == config->content_protection_key_property) {
+		*val = state->content_protection_key ?
+			       state->content_protection_key->base.id :
+			       0;
 	} else if (property == config->writeback_fb_id_property) {
 		/* Writeback framebuffer is one-shot, write and forget */
 		*val = 0;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 7b5048516185c..2fbe51272bfeb 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -896,6 +896,12 @@ struct drm_connector_state {
 	 */
 	unsigned int content_protection;
 
+	/**
+	 * @content_protection_key: DRM blob property for holding the Content
+	 * Protection Key injected from user space.
+	 */
+	struct drm_property_blob *content_protection_key;
+
 	/**
 	 * @colorspace: State variable for Connector property to request
 	 * colorspace change on Sink. This is most commonly used to switch
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index e5b053001d22e..615d1e5f57562 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -887,6 +887,12 @@ struct drm_mode_config {
 	 */
 	struct drm_property *hdcp_content_type_property;
 
+	/**
+	 * @content_protection_key_property: DRM blob property that receives the 
+	 * content protection key from user space to be injected into the kernel.
+	 */
+	struct drm_property *content_protection_key_property;
+
 	/* dumb ioctl parameters */
 	uint32_t preferred_depth, prefer_shadow;
 
-- 
2.40.0.634.g4ca3ef3211-goog

