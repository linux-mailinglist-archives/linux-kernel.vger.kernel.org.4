Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E966B3FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCJNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCJNAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:00:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3049748E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678453190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2dYSWwUySYcCPwCj0zZ4jmWfYgjqhwsnkIueYQNMFPE=;
        b=Xe9pbwsFxtl+U/epN9SjKcQ45Kb67fsjFs2dYtb2MQCtTpFlEcXBdWVH0MbisxrXl/NR2w
        nIMVLbKh5zb/oGgL2t7QsoxNzmVwIL7+4HmnhC5uDZkYRJaLSEllBlgVz4/7GU6Xa8w0Ce
        RIvJP4gdjpF+AYYAkrRbLngFxjxFORI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-RTXHGq7uOMmwtC2MvYW6qQ-1; Fri, 10 Mar 2023 07:59:49 -0500
X-MC-Unique: RTXHGq7uOMmwtC2MvYW6qQ-1
Received: by mail-wm1-f72.google.com with SMTP id l31-20020a05600c1d1f00b003e8626cdd42so1786554wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678453188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dYSWwUySYcCPwCj0zZ4jmWfYgjqhwsnkIueYQNMFPE=;
        b=tzmHIzrFR79uan7NRIe10DhmTrFzvcb0lQKyPMfce2Sv4iQ0wGrsok5o3+lmyTHo2V
         b0IvQb+K8WmTnWRzjvWCnOaMKFIgrErKu9wXeaHCmHM/dMKN2Ali8qD7lhly88W8/5Sg
         VsCBRmF//8sYyEI5qpCYPhsjPiihEEbD2yRrrTjDr2jPWMp6el1R2nHKAnASH1muTN6g
         YnwwJS2+6+21XUhs3qXFkLzyJ3a0BBPcBcywzPRxcRv7Av8HlaOC4JI/6Y0WMs2Ty6VT
         6OBVyDjv926YwEsFOKgGE9P4yKhFC5df7/UkEbbzgCp/0UG0Rjefr/EcZcCltL1OWeBb
         PfGw==
X-Gm-Message-State: AO0yUKWsINmxmi12irEdMoSOn04sZhdEWHsA620Va2bBigpNu9vs1yVP
        tcmrQFUNRzD1EU8U0EiSDMn+itVoEBUYzoSlyzozjPnXWkww9cNPR6z4YCw0e9FGCktzPhFPlSL
        HtaLyADtQO/RWHjSgwuvsVpKwNeanrmvfVsKzASZBW/6aqe2WLnawmX0GzL+nC+yQhLsl08H1CI
        bhcNslLVw=
X-Received: by 2002:adf:f78e:0:b0:2c8:bf89:39be with SMTP id q14-20020adff78e000000b002c8bf8939bemr19183570wrp.7.1678453188216;
        Fri, 10 Mar 2023 04:59:48 -0800 (PST)
X-Google-Smtp-Source: AK7set80rTJ2zYZH0pCoVKSCAU3hAHXk32L0Gs52YHTKrZjmlC0veiVbVbzF6MfqPtBHSQ3xSq1nyA==
X-Received: by 2002:adf:f78e:0:b0:2c8:bf89:39be with SMTP id q14-20020adff78e000000b002c8bf8939bemr19183540wrp.7.1678453187892;
        Fri, 10 Mar 2023 04:59:47 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z26-20020a05600c221a00b003e6efc0f91csm2072799wml.42.2023.03.10.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:59:47 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Christian Hergert <chergert@redhat.com>,
        Albert Esteve <aesteve@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] drm/virtio: Enable fb damage clips property for the primary plane
Date:   Fri, 10 Mar 2023 13:59:42 +0100
Message-Id: <20230310125943.912514-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hergert reports that the driver doesn't enable the property and
that leads to always doing a full plane update, even when the driver does
support damage clipping for the primary plane.

Don't enable it for the cursor plane, because its .atomic_update callback
doesn't handle damage clips.

Reported-by: Christian Hergert <chergert@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 4c09e313bebc..a2e045f3a000 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -390,5 +390,9 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 		return plane;
 
 	drm_plane_helper_add(plane, funcs);
+
+	if (type == DRM_PLANE_TYPE_PRIMARY)
+		drm_plane_enable_fb_damage_clips(plane);
+
 	return plane;
 }

base-commit: 3e853b9f89e4bcc8aa342fa350d83ff0df67d7e9
-- 
2.39.2

