Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7D665F79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbjAKPly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjAKPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6B7D49
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so12970581wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA+tPLir+1X4c7NIGPD8fbGsyIZBKsPUjYPi9h9kAc8=;
        b=eNQu3m5MBYcJ4ir7wnU2uKSOdOlTVnwwoNbl7ndwmx7pL0oaymY4tJ+VPavmH4gWu3
         ctX/ciqpqll+Gi0G39VkzdIVV+zIy+55w4NRmQ48GvAAagPpdV92t11x9dtuCypNqs8x
         VKs1+2qNooBYEQ/WTCaaYQDd8eQZXRMv5YgkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA+tPLir+1X4c7NIGPD8fbGsyIZBKsPUjYPi9h9kAc8=;
        b=l8uxN7DnE+uvTiAP3Efp3ZBjGg5WOMuCHWUP248q2M89Zfkvht2XRqOpw7uHoxjdCs
         n81rPFiq6CC3O3EHpfrEt2OM2Usbwn7QCIgvJ4jESzByaLaEAs60h2rbU0dN8mKoCvA9
         C0+Ecvtvzd2XiIhm8IMVVCraJs6Tn2dzct/dfDjnqx9HUrZYD3AbhGJM3Aw/KaM4CIwR
         XeMBsA0iAlj3/72IpN6Q9Y8T8ZI57HnBk7fyK3yNj1NxjECfXWj0IEdlPM3Np4oZlpO4
         4XR4v/3WPo68o1/oKLWKMP/++69veIEOYbD1rW+QjcoUV2gTQmdDe+mirVTXJ8ZAKEyX
         o+wA==
X-Gm-Message-State: AFqh2kq6/b4CjNx/p1TR12oQVelFvfrhZD2mvOz+OV3rJVR1gZaoqj8x
        dh6/uxr9LCtNd9ZODG6ePl9SuapCh3cXvR+z
X-Google-Smtp-Source: AMrXdXvP0g7aBxRONWD/2hWDOWNy8uqW2LewLgFiVP8szo0yPD2T/n1jDfUyAtI8xKF52PjIaacOWg==
X-Received: by 2002:a05:600c:4f83:b0:3d2:3f55:f73f with SMTP id n3-20020a05600c4f8300b003d23f55f73fmr53421615wmq.8.1673451688237;
        Wed, 11 Jan 2023 07:41:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:27 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 06/11] staging/lynxfb: Use pci aperture helper
Date:   Wed, 11 Jan 2023 16:41:07 +0100
Message-Id: <20230111154112.90575-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It exists! Note that since this is an exact copy, there shouldn't be
any functional difference here.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/staging/sm750fb/sm750.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index effc7fcc3703..22ace3168723 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -989,20 +989,6 @@ static int sm750fb_framebuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
 	return err;
 }
 
-static int lynxfb_kick_out_firmware_fb(struct pci_dev *pdev)
-{
-	resource_size_t base = pci_resource_start(pdev, 0);
-	resource_size_t size = pci_resource_len(pdev, 0);
-	bool primary = false;
-
-#ifdef CONFIG_X86
-	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
-					IORESOURCE_ROM_SHADOW;
-#endif
-
-	return aperture_remove_conflicting_devices(base, size, primary, "sm750_fb1");
-}
-
 static int lynxfb_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -1011,7 +997,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	int fbidx;
 	int err;
 
-	err = lynxfb_kick_out_firmware_fb(pdev);
+	err = aperture_remove_conflicting_pci_devices(pdev, "sm750_fb1");
 	if (err)
 		return err;
 
-- 
2.39.0

