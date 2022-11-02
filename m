Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E65616E22
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKBUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiKBUAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:00:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFED194
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:59:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso3106190pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTlEc+TwvUwH4QO7vIX81PZfuP6PZEvZ9DCLC/XDVPw=;
        b=Da2Tkm1nScX/U5I2jMWmKou8fXW4etyob6wD/3/kfuYL5zhqiXQHxF/mB7vIfBQr/m
         JlGucOwtE6bRHi9K+rhHrWT3f2nQYyquha0Za5oQsTxmaYoB8w9O2+9y7xcbCL1kzW1N
         8o8t4sMvo6w3/Oi/XZ4FNTC16116JU4dZ2EBBbBI302gwtu5XB60XFIp8Y7MGLDIVMXn
         A6l2IKAzxIQmoolS0C+l6TcsS4oMRLMnbpHnEBjVPTZJ3Ki0hSgR+nTt6XdwK+qz68EH
         WGrPQ5DM6GLxu0Aej+IZ4LhQ/1cb14UE6bg/cqItDbNvmf4rVlMPDGbxrHe38+qX6elR
         nFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTlEc+TwvUwH4QO7vIX81PZfuP6PZEvZ9DCLC/XDVPw=;
        b=m9PiBTBCvANR8EwYyAGfA1K12A2KDhfHB9BwGBMEh2h51rHwW5KvMVXF9E+aO86QnL
         ZI1yDvbN4hH4GOw60AOCqDHtFWbYGvky9V7H8Fi/zG4HSbs1FdilTcEgaZtnC0woAJdk
         upziZNuNo7dOwUPmSiu55y5ESPeAbK+Mbpd+5M/j/+f8qSart7vqrLcegFb8rPP+PXU+
         hM1C2ZuXN2GtwGi4t7GApl1K3szL4n00QLtfgmYW1dJwtbXAnJFcIWX62/itR+a8y1/W
         /MHSbBk+l/v6zAfuHuGly+d69NEQkto8MicuDfVLqxSfrXWQdYKwflLfZIXatl47+ad5
         NobA==
X-Gm-Message-State: ACrzQf2gQjv1q/tsh3yrCdVTrOMPzcLtKls2OJ76m8CSevkxNUa9mL23
        uETRV/UutPV1YsjtkGmZNfg=
X-Google-Smtp-Source: AMsMyM6xr4NMN2eMK3hCghPDMLTRzAK3wTcOFMxNhnOCA8mBK8fv37f/h/FU7rx7wHbOsucG2WOdYw==
X-Received: by 2002:a17:90a:fa0b:b0:213:ead5:92d7 with SMTP id cm11-20020a17090afa0b00b00213ead592d7mr16688766pjb.147.1667419160296;
        Wed, 02 Nov 2022 12:59:20 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id o10-20020a62f90a000000b005625d5ae760sm9058299pfh.11.2022.11.02.12.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:59:19 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/syncobj: Remove unused field
Date:   Wed,  2 Nov 2022 12:59:44 -0700
Message-Id: <20221102195945.352241-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Seems to be a leftover after commit e7cdf5c82f17 ("drm/syncobj: Stop
reusing the same struct file for all syncobj -> fd").

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 include/drm/drm_syncobj.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index 6cf7243a1dc5..affc4d8e50e2 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -57,10 +57,6 @@ struct drm_syncobj {
 	 * @lock: Protects &cb_list and write-locks &fence.
 	 */
 	spinlock_t lock;
-	/**
-	 * @file: A file backing for this syncobj.
-	 */
-	struct file *file;
 };
 
 void drm_syncobj_free(struct kref *kref);
-- 
2.38.1

