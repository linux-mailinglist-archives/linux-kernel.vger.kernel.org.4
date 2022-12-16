Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5164F51E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLPXd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLPXd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:33:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693D32BF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:33:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 17so3838426pll.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfjZR0CL1te6hYjGQ5Dgru9uZsEh0pXQEs7OK+nQBYw=;
        b=MEAPdrhZCgMx9z1Z6Jn2EYHyIXxjfM1YSxkXyqhSTc2jPmkC1c0uWfXBTsUYHE4PtP
         h8rVGbHesBKlT+CU8fc6gdoh+eOabsO2dVBJGr+mVHhCuUmi6DwypQm/9vV1MI1fcg1D
         5/Yf8XKQKp8JDF1kx0kdS89aVofVbDMcDrnd3M+E0O8FW5mqg3NBwMpmq92xGyZeL7yA
         dYhh8ayAcrmYr90vQ5arscaU13bsjieP09SmQliZrPvFAVWLqFwfXbCVU6Fl1I09FxNL
         01/YSveCtv21TrKwk4tV+8bE8YqKj4uQoT9ueZf8XPZpLeFHtkswnov/hR++CjriaVDq
         WNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfjZR0CL1te6hYjGQ5Dgru9uZsEh0pXQEs7OK+nQBYw=;
        b=XdOXuxDtTc7QzeBmk5l5g29O4MWMjWFe5hyXozXHkIgNbgMEujXnFjefWAIWcBhH5y
         9Q2QHYoxdy2s33kYRREJMIICEM6YH29i66oNO/VxvpCgpArNTGYSWukMJ3ryscXQzHm/
         opi51gbP+Nj0cfsEuLQw1R5ptVkF/OuhxcXIwAYP2SObay9ScQ9gidTr5aBH31D+/yh7
         ROZ0RADDJL8rOXl+CBiVJ0Fz1s9Pqvrnwg+FRe+GE4l9vhxxG60/ud9TFq2N/l0l3zd5
         i1UyPyhPvbPbAVW61RnYQJK/rrmjIypK7W3WrqkWJ7uvr0cvOIrRvUzNxkcUK1IY82r3
         XkoA==
X-Gm-Message-State: AFqh2krWSIkTboONoCtvlSvlq+nmxRMvE0kr6k+uKS7ZFYZxsDB7KQQ3
        ojuXIUJrZWT0WS7tB6NYadU=
X-Google-Smtp-Source: AMrXdXsGC5cwDrscK9zfqya1W9a0AUROGuAxhCkIiB+QuUseJeEHf7YPmb7ebCFt6ikROnxni4p6EA==
X-Received: by 2002:a17:90a:6744:b0:219:1d62:9e05 with SMTP id c4-20020a17090a674400b002191d629e05mr164074pjm.34.1671233634873;
        Fri, 16 Dec 2022 15:33:54 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id 64-20020a630743000000b0047781f8ac17sm1976000pgh.77.2022.12.16.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:33:54 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: Fix GEM handle creation UAF
Date:   Fri, 16 Dec 2022 15:33:55 -0800
Message-Id: <20221216233355.542197-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221216233355.542197-1-robdclark@gmail.com>
References: <20221216233355.542197-1-robdclark@gmail.com>
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

Userspace can guess the handle value and try to race GEM object creation
with handle close, resulting in a use-after-free if we dereference the
object after dropping the handle's reference.  For that reason, dropping
the handle's reference must be done *after* we are done dereferencing
the object.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index a5cccccb4998..f1c55c1630ca 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -366,10 +366,18 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		drm_gem_object_release(obj);
 		return ret;
 	}
-	drm_gem_object_put(obj);
 
 	rc->res_handle = qobj->hw_res_handle; /* similiar to a VM address */
 	rc->bo_handle = handle;
+
+	/*
+	 * The handle owns the reference now.  But we must drop our
+	 * remaining reference *after* we no longer need to dereference
+	 * the obj.  Otherwise userspace could guess the handle and
+	 * race closing it from another thread.
+	 */
+	drm_gem_object_put(obj);
+
 	return 0;
 }
 
@@ -731,11 +739,18 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 		drm_gem_object_release(obj);
 		return ret;
 	}
-	drm_gem_object_put(obj);
 
 	rc_blob->res_handle = bo->hw_res_handle;
 	rc_blob->bo_handle = handle;
 
+	/*
+	 * The handle owns the reference now.  But we must drop our
+	 * remaining reference *after* we no longer need to dereference
+	 * the obj.  Otherwise userspace could guess the handle and
+	 * race closing it from another thread.
+	 */
+	drm_gem_object_put(obj);
+
 	return 0;
 }
 
-- 
2.38.1

