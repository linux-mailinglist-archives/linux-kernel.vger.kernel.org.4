Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFFD6A9674
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCCLgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCCLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:36:11 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852855F525
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:35:53 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso1952279pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677843348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29OzWpxyOz2YKbe7gk+wlUnvCGzWDi9lW+7/pophrnY=;
        b=UXsv+zvJpY9npxxDaimqGLy6Jst1fhPTP8qDTyYqL5k8VsJK6RCu/FDuoLjqaptlTW
         vDQ56LfI4SzRu6KWj0WwhuIzvIbcKRYeNV5ySrzG77VGflvocShjGwEdarhNyUfEY0IY
         1WCjtxBYwmHAqHTua6ekv1ho1Kp1OYTgvIoFqT3ZL8XbvQkMbJ4GH5x7SAvtVl40nXnT
         vHp19aimeOozvuCJWppH6cyyPsiBdUK2GXCNE0UcSjKAvz1AMPxVyvHJ5+GGH/q+3Z3/
         sWF/lvIXxsdXSFukVTCVzW6i3xuUqlGrXDas780jw30i675/Vl6yrknmAZmKhJPgUuCR
         Ib5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29OzWpxyOz2YKbe7gk+wlUnvCGzWDi9lW+7/pophrnY=;
        b=skNInfzVaWbO6bnqKAugkXha08HA39SQ7szppvP+/F8yOvJ7xJFkOZb6D1fWMXVNsC
         moLs3poqP4+RLKA5tr+0q2BU5LuoNaMQjLPfsDdGAKH0cxCrh/KhhsAoXdxYXOfazH7Y
         cIb73K7wT0HLvKmLZPF+NiTpyRaFIqc/kMcMa1Kja+m3O1WYp6koXYnYu84MH187Yt4s
         UbvnQ37M9LAI4/rRSrCmisrAnZH6jmF8gyEGOk60YniW29PgFeKi/8eTtyQmaEm49ytj
         YBfOuXAk++O0ydo8siRrdgq9jf7VhV4AtJBFW5EV0iHGdjXLVe4mQwTmqB3UZXeehk2H
         2s4Q==
X-Gm-Message-State: AO0yUKUPogDH9D2/5oY+m4mHAQr26DtIqPhg5HzlwtJi+qPrlJI9cHdE
        s5Z0WpE9fwQYJRuSkZb+W38=
X-Google-Smtp-Source: AK7set++BCkVpQ27OESBIxlcacoRVz6Aj+XkJCD7OJ1vEPatpzdcaaEL/yM+9LCNECISm5A4drmRzw==
X-Received: by 2002:a17:903:32cf:b0:19a:8e52:ce0 with SMTP id i15-20020a17090332cf00b0019a8e520ce0mr2187517plr.58.1677843348598;
        Fri, 03 Mar 2023 03:35:48 -0800 (PST)
Received: from localhost.localdomain (124-148-239-17.tpgi.com.au. [124.148.239.17])
        by smtp.gmail.com with ESMTPSA id jz6-20020a170903430600b0019ab3308554sm1316798plb.85.2023.03.03.03.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 03:35:48 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v2 RESEND] drm/amdgpu: register a vga_switcheroo client for MacBooks with apple-gmux
Date:   Fri,  3 Mar 2023 22:34:25 +1100
Message-Id: <20230303113423.3819-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
vga_switcheroo") made amdgpu only register a vga_switcheroo client for
GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
register, but don't have PX. Instead of AMD's PX, they use apple-gmux.

Use apple_gmux_detect() to identify these gpus, and
pci_is_thunderbolt_attached() to ensure eGPUs connected to Dual GPU
Macbooks don't register with vga_switcheroo.

Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
Link: https://lore.kernel.org/amd-gfx/20230210044826.9834-10-orlandoch.dev@gmail.com/
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v1->v2: Use apple_gmux_detect()
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f28a8c02f64..ef8b996f0622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -35,6 +35,7 @@
 #include <linux/devcoredump.h>
 #include <generated/utsrelease.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/apple-gmux.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -3919,12 +3920,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
-	if (amdgpu_device_supports_px(ddev)) {
-		px = true;
+	px = amdgpu_device_supports_px(ddev);
+
+	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
+				apple_gmux_detect(NULL, NULL)))
 		vga_switcheroo_register_client(adev->pdev,
 					       &amdgpu_switcheroo_ops, px);
+
+	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
-	}
 
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
@@ -4029,6 +4033,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
 	int idx;
+	bool px;
 
 	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_device_ip_fini(adev);
@@ -4048,10 +4053,16 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	kfree(adev->bios);
 	adev->bios = NULL;
-	if (amdgpu_device_supports_px(adev_to_drm(adev))) {
+
+	px = amdgpu_device_supports_px(adev_to_drm(adev));
+
+	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
+				apple_gmux_detect(NULL, NULL)))
 		vga_switcheroo_unregister_client(adev->pdev);
+
+	if (px)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
-	}
+
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-- 
2.39.1

