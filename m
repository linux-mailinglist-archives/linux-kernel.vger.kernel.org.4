Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E998665F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjAKPle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjAKPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A4E2E0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso9268933wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGvydfcnswB5kCTr6pgmQFxcgFjCL3fOh+5DF0n/kHQ=;
        b=MlaP4iz9T5QOEdEs7QRCj0LRht0gbuOE12jC5lqdYaja6OmWEu3x44yTN6+eBPdseA
         ZRP3gRxjIwfx/RvbvL1abOvvxn4IUBTB76ngU0gOrbj6czdukqRxbFjuguKcKlCvBiAi
         OIRDopYxEw1xY1T5KE6yRdOqY5ob94mIqBzMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGvydfcnswB5kCTr6pgmQFxcgFjCL3fOh+5DF0n/kHQ=;
        b=VZpzVkbw0UJ2Obb5M9//zNIWwT6UwblykdmmFXPv+f3kprKGisgHsKiLan0UvOA9IS
         IMqZToQKAyEWfxzTDQ0LCNZpzuZxTtDpkdKVboswpG6vMfIcpfUdJt8EMKn0KqpXwjN3
         zNCvmJEKEdrfaM81OIE/SzwffJ82Aevc/BddzyE7NNN1GpY9LPJNzRO/AKP8WiY9kb6Z
         wlfRDG7OJM8YJHdgzZ7bajPfMXgwwUjjnO3fP+bsQ7BrN1XtlMgNHJgZTzmT+epBqqFy
         BSzD8M/iVPbHAomKYYuObDRnL2uPPuYYh6hFWa315d+YVBZJqz8Y/dXza8vk2UM/LXzB
         ngXw==
X-Gm-Message-State: AFqh2koeVV7R/higXKXrhRMjwsHGIQW4vqv/BTcSopRzCJ9QYD/LTvyj
        Hge2Ritdi6IQMVESBf+NTd8r0A==
X-Google-Smtp-Source: AMrXdXvZL6+Fq4x6+s6c1TzAuUbbiOvtCaS9MpQRLMdhQaJKNpbYwvT73xPCftXvxiNmLgwrl3Fc5Q==
X-Received: by 2002:a05:600c:3482:b0:3d3:4f56:62e1 with SMTP id a2-20020a05600c348200b003d34f5662e1mr51193693wmq.27.1673451681375;
        Wed, 11 Jan 2023 07:41:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:20 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH 01/11] drm/ast: Use drm_aperture_remove_conflicting_pci_framebuffers
Date:   Wed, 11 Jan 2023 16:41:02 +0100
Message-Id: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
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

It's just open coded and matches.

Note that Thomas said that his version apparently failed for some
reason, but hey maybe we should try again.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/gpu/drm/ast/ast_drv.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 420fc75c240e..3ac24a780f50 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -90,27 +90,13 @@ static const struct pci_device_id ast_pciidlist[] = {
 
 MODULE_DEVICE_TABLE(pci, ast_pciidlist);
 
-static int ast_remove_conflicting_framebuffers(struct pci_dev *pdev)
-{
-	bool primary = false;
-	resource_size_t base, size;
-
-	base = pci_resource_start(pdev, 0);
-	size = pci_resource_len(pdev, 0);
-#ifdef CONFIG_X86
-	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
-#endif
-
-	return drm_aperture_remove_conflicting_framebuffers(base, size, primary, &ast_driver);
-}
-
 static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct ast_private *ast;
 	struct drm_device *dev;
 	int ret;
 
-	ret = ast_remove_conflicting_framebuffers(pdev);
+	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &ast_driver);
 	if (ret)
 		return ret;
 
-- 
2.39.0

