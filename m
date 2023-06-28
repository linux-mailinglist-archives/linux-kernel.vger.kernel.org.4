Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB3741ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjF1VZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjF1VZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB3359A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687987375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L25XPrE4POZxEhhk2/19p0p2PCDX/k5AJ4PHMsFVmoI=;
        b=C7cn9kpXShsHV2zZMAovda79ERP6uZEadJUIqZpuNzFdfvPYpurzwJK3QUcVZkqewQ/xrG
        5/sDzFGNQdfWwvE85yolvaZmBMOj/kJPT7lKqeE27nZJgJnMNfD4nPIWc62OljnSdM5Xz1
        jkJ2jAj1eJCDYavuAJ1f79YrhnzdvAs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-HITjAXnYPamJAbjC2l50zw-1; Wed, 28 Jun 2023 17:22:54 -0400
X-MC-Unique: HITjAXnYPamJAbjC2l50zw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa982366acso7685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687987372; x=1690579372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L25XPrE4POZxEhhk2/19p0p2PCDX/k5AJ4PHMsFVmoI=;
        b=fHkAsOZ6LsXfCidFo+vRIIFNCj6HGPImxUgJHiZIvCM79SBXOjFgmwziG/QDQIHPwI
         KxNTIelDX04iVRzPYk795AJ2Si83iJg8eWxe0uPsCCx9lO8Brh8OSfadK/LyRIEZzoL+
         b54f2K6ftUuRCwYhmRCr2R7DWVieCHQ72XU8hBredQ4BbiOCl3YcT2b++zFU1IQxbeG5
         yQ8HQevwxct4CgLMZN82dRdpd60PK4cBYSNlkXElBYhDB9yvuJfZekQeV+nbwi7/Gpep
         2RuaDqQ3f8G5JeR5XKNj8a0F0MB/A31qfgGzgl2L5EJGJALEq2jPjr+D0/KQ+9ZT5D9O
         KiKA==
X-Gm-Message-State: AC+VfDziCU/sXbkwoc5Z29SVbsDmhWDE6GEt0XkflxwkRnFKEjGK83DH
        fggcIz3/RdV++YwZ/i/h0FqOadH/2zyzpWMILutatOZ6RqOa2LMLYn63rYFldnweZXEpFnMI28x
        ftT+7Xni+7mEOMIS3OaNvBEBd1NaQDqFGI9JODenfXVp/ujPM7u4Rt+tbWs3xnLqSu6zEVKQxLR
        IX/fchWLk=
X-Received: by 2002:adf:f990:0:b0:313:edaa:24f3 with SMTP id f16-20020adff990000000b00313edaa24f3mr9337094wrr.5.1687987371910;
        Wed, 28 Jun 2023 14:22:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HubsUmqIJhwm4B7AbWuPZejQ5/Mr/9PKWcvbTsxn13ECBZOSCiJ2Y0q/28ms0yNC5JG/oVw==
X-Received: by 2002:adf:f990:0:b0:313:edaa:24f3 with SMTP id f16-20020adff990000000b00313edaa24f3mr9337087wrr.5.1687987371669;
        Wed, 28 Jun 2023 14:22:51 -0700 (PDT)
Received: from kherbst.pingu ([95.90.48.30])
        by smtp.gmail.com with ESMTPSA id r3-20020adfda43000000b0030ae3a6be4asm14294323wrl.72.2023.06.28.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:22:50 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 2/3] drm/nouveau/disp: drop unused argument in nv50_dp_mode_valid
Date:   Wed, 28 Jun 2023 23:22:47 +0200
Message-ID: <20230628212248.3798605-2-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628212248.3798605-1-kherbst@redhat.com>
References: <20230628212248.3798605-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_dp.c        | 3 +--
 drivers/gpu/drm/nouveau/nouveau_encoder.h   | 3 +--
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 1637e08b548c..6221eaaad1b7 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1127,7 +1127,7 @@ nv50_mstc_mode_valid(struct drm_connector *connector,
 	 * MSTB's max possible PBN
 	 */
 
-	return nv50_dp_mode_valid(connector, outp, mode, NULL);
+	return nv50_dp_mode_valid(outp, mode, NULL);
 }
 
 static int
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index f75c6f09dd2a..22c42a5e184d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1079,7 +1079,7 @@ nouveau_connector_mode_valid(struct drm_connector *connector,
 	case DCB_OUTPUT_TV:
 		return get_slave_funcs(encoder)->mode_valid(encoder, mode);
 	case DCB_OUTPUT_DP:
-		return nv50_dp_mode_valid(connector, nv_encoder, mode, NULL);
+		return nv50_dp_mode_valid(nv_encoder, mode, NULL);
 	default:
 		BUG();
 		return MODE_BAD;
diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index d49b4875fc3c..6a4980b2d4d4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -267,8 +267,7 @@ nouveau_dp_irq(struct work_struct *work)
  *   yet)
  */
 enum drm_mode_status
-nv50_dp_mode_valid(struct drm_connector *connector,
-		   struct nouveau_encoder *outp,
+nv50_dp_mode_valid(struct nouveau_encoder *outp,
 		   const struct drm_display_mode *mode,
 		   unsigned *out_clock)
 {
diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/nouveau/nouveau_encoder.h
index 70c1ad6c4d9d..bcba1a14cfab 100644
--- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
+++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
@@ -143,8 +143,7 @@ enum nouveau_dp_status {
 int nouveau_dp_detect(struct nouveau_connector *, struct nouveau_encoder *);
 bool nouveau_dp_link_check(struct nouveau_connector *);
 void nouveau_dp_irq(struct work_struct *);
-enum drm_mode_status nv50_dp_mode_valid(struct drm_connector *,
-					struct nouveau_encoder *,
+enum drm_mode_status nv50_dp_mode_valid(struct nouveau_encoder *,
 					const struct drm_display_mode *,
 					unsigned *clock);
 
-- 
2.41.0

