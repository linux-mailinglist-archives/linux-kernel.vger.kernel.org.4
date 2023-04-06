Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE186D94A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjDFLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbjDFLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E461BF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680778977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9PADBV7kdrsYwkgT7yvWF1gcrM9r8sRUlyu8sOkzqE=;
        b=K6T8Cxeusk9tBwuid+TsZsopn1FouKLESD4Y5MiDQQUwYBzmy7ftY25IFwfoXF1noiS7j8
        CTabkr8DP4kTnnwGnwCEPUt8XLAYtdjuokUPLUqkxj1NNqPssgTD8/mBeysACPCBhuzwEt
        efM29HRfNp1tmCukc+lbjIJX8SlUNAo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-gZzYQ7NxOpCeYBN4MSf4iA-1; Thu, 06 Apr 2023 07:02:56 -0400
X-MC-Unique: gZzYQ7NxOpCeYBN4MSf4iA-1
Received: by mail-wr1-f72.google.com with SMTP id bn9-20020a056000060900b002cfe8493fe6so4785263wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680778973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9PADBV7kdrsYwkgT7yvWF1gcrM9r8sRUlyu8sOkzqE=;
        b=1hIHOQMOKOj37htjjEqfQzsWCCwqEWHxNMbHOFuu3aQem8MLP/eYFyJ4NwS4n/NgK2
         E7ReYqLVHv5xxvfMFO6oUtep7kbTQ+bg/fNr8y/qLKvb1/qws0sE19c5MjT8mHBhmVOL
         P9zb/YmI7BYemP15qyZFY3nj4pP5eoF7YUcFcWePI6l6ytypyVfLemIzCTwzDJjgcp5h
         017AqL8IqSxPkWH440ThRb8xQeh9eKeymOg8kQvCnF4KDoti3KjhUtYsm5aPR9H9VTL0
         kGnV3G8CejMo6taJw2KJDsCr9HJ36ph86LZfU97q7udzsn+WoCpz2Bia0RDprej7NBcq
         sFFg==
X-Gm-Message-State: AAQBX9elt8NyqM8F/0K8rQX88OlOVi7jPaD1N/0msRxqE0QCdh0FYzpq
        e6ssblAhSU3IAbs8p4mxPcT7j1CdrOtb5cZtqWJUizwtBwZNiKLsMoWJZocoKi2CD1SS8Iy/mS6
        enrr7H9Uiq5lQ8LCq7j5WriDEpyGwk3bx5goNEPDYay6785TsUT0tA/v7Zxo9Yj8/FJ8Ktzt6Eq
        qWEj1G5Uo=
X-Received: by 2002:adf:f44d:0:b0:2d2:3ca:8c43 with SMTP id f13-20020adff44d000000b002d203ca8c43mr7623967wrp.31.1680778973660;
        Thu, 06 Apr 2023 04:02:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350b6JKhqw/6XDyaEayJzxte+WOAAroTJ4RHjeRqTghA3qFfh8cm9uXUn7uG9fUuRMoP4XtdxlA==
X-Received: by 2002:adf:f44d:0:b0:2d2:3ca:8c43 with SMTP id f13-20020adff44d000000b002d203ca8c43mr7623929wrp.31.1680778973292;
        Thu, 06 Apr 2023 04:02:53 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b6-20020a05600010c600b002d8566128e5sm1472401wrx.25.2023.04.06.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:02:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Marius Vlad <marius.vlad@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/vkms: Remove <drm/drm_simple_kms_helper.h> include
Date:   Thu,  6 Apr 2023 13:02:35 +0200
Message-Id: <20230406110235.3092055-3-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406110235.3092055-1-javierm@redhat.com>
References: <20230406110235.3092055-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver doesn't use simple-KMS helpers to set a simple display pipeline
but it only uses the drm_simple_encoder_init() helper from simple-KMS that
initializes and encoder.

That helper is just a wrapper of drm_encoder_init(), but passing a struct
drm_encoder_funcs that sets the .destroy handler to drm_encoder_cleanup().

Since the <drm/drm_simple_kms_helper.h> header is only included for this
helper and because the connector is initialized with drm_connector_init()
as well, do the same for the encoder and drop the header include.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/vkms/vkms_output.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 4de6f8ae38be..5ce70dd946aa 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -4,7 +4,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 static const struct drm_connector_funcs vkms_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
@@ -14,6 +13,10 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static const struct drm_encoder_funcs vkms_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int vkms_conn_get_modes(struct drm_connector *connector)
 {
 	int count;
@@ -86,7 +89,8 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
 
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
 		goto err_encoder;
-- 
2.40.0

