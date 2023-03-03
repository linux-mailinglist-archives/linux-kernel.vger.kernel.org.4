Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EB76A971C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCCMRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCCMRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:17:34 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF85F500
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:17:33 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so847705wmb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 04:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677845852;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D03Dx4Z6sjOCGLIbT2UoYAjEZ9PiPy+/g5LTNKuL45w=;
        b=Li4J2KcZYUwJ0+D32V0Voa3V2Fc7c1SAukOUyuJMz+1qJgDxWG5Mb/c0Pq2qncUSf9
         O6WmmN86zj6E0X8RgB0Ro+QOInprnevHI+aS7ISR6MHjtVFCVkrfHVqh5rXbo2N6Kewi
         oeiTMMuCsieHVI7LrKM190aXE7iCE1jidcyQMyKer4ohKWZb4oaQge72giBABF4f46pF
         nok0QFh/bMF1GCp8KqqGFTrpOUArwvAtXA+faSAHzQpSMnp7zpFIs3AcpIqwjeNcu7iy
         jRlByIJm8C4goZhiIv4cGqHMjUpaT1MWei6KpLtemLltf3GRR+g7JbOJoEC6KNOlFJUh
         okaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677845852;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D03Dx4Z6sjOCGLIbT2UoYAjEZ9PiPy+/g5LTNKuL45w=;
        b=h3MlEW68WfI6Nm9x/oPAA52pGhFuwbuVCebCzpLGA9XAYdfGJthqPaqn3MZ4bRaH1i
         UdEkOFLCRpMXYs06MVsWjK8WKmRkMcfZVVIznMQy1D2HKQQsh1UT7Ka6+mZljHNW72Vh
         Z+Uvlw3uvqzkjFVevqvJcgWcXgTDaB+4tq1jgLKIOonFinSjwaUBopyA0F89YqgbX8vz
         83u4sVP24Gi2wM35s0IrYt6LxIFshVrTV/dTJWAM92VRXyRFz5obfDrW6R0HuANItH9y
         myN28rY8DsgM0FLNcXYxkvbw2vajxxsREVomsS5ASmw/+x0tbKzsCfK0R/IUlxp5MXqe
         YKLQ==
X-Gm-Message-State: AO0yUKWnwvUOgXRmFoYaaB8mZ7s0TMgBMiOc0Mt1zWkZPXP6QLVHir0M
        2GkLUyIzDV5775XxrjDq799EU/HgCI+ViA==
X-Google-Smtp-Source: AK7set/c/MIucZ0glMbV3kmk9UjPTLjQCjs1sWZdMYqqGtZH/zqjJTxTivaya6tTDuXll5hXepyDxnHM5jHhDw==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:798:b0:3df:d8c9:caa9 with SMTP
 id z24-20020a05600c079800b003dfd8c9caa9mr370367wmo.7.1677845852143; Fri, 03
 Mar 2023 04:17:32 -0800 (PST)
Date:   Fri,  3 Mar 2023 12:11:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230303121151.3489618-1-smostafa@google.com>
Subject: [PATCH] vfio/platform: Fix reset_required behaviour
From:   Mostafa Saleh <smostafa@google.com>
To:     eric.auger@redhat.com, alex.williamson@redhat.com
Cc:     cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, smostafa@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfio_platform_device has a flag reset_required that can be set from
module_param or vfio driver which indicates that reset is not a
requirement and it bypasses related checks.

This was introduced and implemented in vfio_platform_probe_common in
"b5add544d67 vfio, platform: make reset driver a requirement by default"

However, vfio_platform_probe_common was removed in
"ac1237912fb vfio/amba: Use the new device life cycle helpers"

And new implementation added in vfio_platform_init_common in
"5f6c7e0831a vfio/platform: Use the new device life cycle helpers"

which causes an error even if vfio-platform.reset_required=0, as it
only guards printing and not the return as before.

This patch fixes this by returning 0 if there is no reset function
for the device and reset_required=0. This is also consistent with
checks in vfio_platform_open_device and vfio_platform_close_device.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/vfio/platform/vfio_platform_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 1a0a238ffa35..7325ff463cf0 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -650,10 +650,13 @@ int vfio_platform_init_common(struct vfio_platform_device *vdev)
 	mutex_init(&vdev->igate);
 
 	ret = vfio_platform_get_reset(vdev);
-	if (ret && vdev->reset_required)
+	if (ret && vdev->reset_required) {
 		dev_err(dev, "No reset function found for device %s\n",
 			vdev->name);
-	return ret;
+		return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_platform_init_common);
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

