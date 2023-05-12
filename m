Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5377370076D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbjELMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbjELMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3611BC6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683892970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RAs/4nxfcMFyg2HMPmspBZO1jWwkNauHuupqA+XX4a4=;
        b=eLdiE/kEBjO0dCDieDAkxRTUJrwFL5KakZUU6E+VC9Ok6QVa+3R0y2q2ASt6eFep8ADKGE
        gpYtXbv1g+D14Mfdih8Nb/0rZ36PlHG8etM+kE2lAv620rJnzyw0TNDZ5wpEYTFqjS2U4+
        0VyYgfgrFTVHZAaYnYtDwox9kWHpA3M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-uL6yD0jRPJujpEKZ_olPQA-1; Fri, 12 May 2023 08:02:49 -0400
X-MC-Unique: uL6yD0jRPJujpEKZ_olPQA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f4ef4bf00dso8953435e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683892967; x=1686484967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAs/4nxfcMFyg2HMPmspBZO1jWwkNauHuupqA+XX4a4=;
        b=ls7Tc0c0zovIBtIVaYvXQEZqpIwfjJgTt9cnbatHUcfpzrIH4TqGg99SioH9bGrOJR
         1vKMNY/GWyCJv7yoEA5Ky7xqth1YjlZ8tosjPUlTSTMgeO7E/i0CYIps7ktqGZi+FYTL
         uPrq20twh8B9BlmUdQZTaaM6NRN2AUwxRRPSPHxg+EFf3YOiAeFkve+/OIKybCMWtMUC
         CVGH2Plse9IC32R8ApgnbzfyhAAztVxzxeTO59ow9eQgBtV2sqk4bojj05ywXq6ZItU+
         N4uMiPmLK/O5lZ2Q2dGUZx+tedOdce9Wppn2fS2/qf3RDTA7waT6CtnQpwheU6h/iYHG
         M4Ow==
X-Gm-Message-State: AC+VfDze0f5XjICVOZ0Wk9gQ0N9b6hKjW8efgy1SQ/NAdBVS6oS6JyZa
        D57+KMFv1puzX5UiCI9cG3XAv5AcTLD2+3Qc9vQsyxjJXMQxpuHMyrR3rgUaR4AHI0pXTfELegg
        GDLJNCUwrvi3rMK0bn7neqL2sGLsMC75v9BAFJJYFRtujYCVnnZRaGpVyCOr7lLNxQh9+NJZUCr
        SLp6SxVbQ=
X-Received: by 2002:a7b:c381:0:b0:3f1:819d:d046 with SMTP id s1-20020a7bc381000000b003f1819dd046mr19644169wmj.5.1683892967327;
        Fri, 12 May 2023 05:02:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5fvpMIjT+Pk3DwjS3y+l8kVbtbSlkIGLjRil5kTUCGo+INLDkRdEH6D48w0NoTg9f7K//t2Q==
X-Received: by 2002:a7b:c381:0:b0:3f1:819d:d046 with SMTP id s1-20020a7bc381000000b003f1819dd046mr19644147wmj.5.1683892967030;
        Fri, 12 May 2023 05:02:47 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4003000000b003063176ef0dsm23285317wrp.97.2023.05.12.05.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 05:02:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Fix include guard name
Date:   Fri, 12 May 2023 14:02:31 +0200
Message-Id: <20230512120232.304603-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a leftover from an early iteration of the driver when it was still
named ssd1307 instead of ssd130x. Change it for consistency with the rest.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index 03038c1b6476..db03ee5db392 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -10,8 +10,8 @@
  * Copyright 2012 Free Electrons
  */
 
-#ifndef __SSD1307X_H__
-#define __SSD1307X_H__
+#ifndef __SSD130X_H__
+#define __SSD130X_H__
 
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
@@ -94,4 +94,4 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap);
 void ssd130x_remove(struct ssd130x_device *ssd130x);
 void ssd130x_shutdown(struct ssd130x_device *ssd130x);
 
-#endif /* __SSD1307X_H__ */
+#endif /* __SSD130X_H__ */
-- 
2.40.1

