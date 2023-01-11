Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE5665F85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbjAKPmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjAKPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC9B43
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja17so11392849wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvSF0y9cGVydackbO4wbJNVFr06wRRTkQkIKN/PkYhQ=;
        b=DS7eOdA9ggp4AlFEpH67KG9/Cyrzc8B52VSXtRv27As9iIaxCjD1rF7UtS4h4TapEk
         Quz07JxkUhXAlDX9lIGGsOfQOVMNJyvTYgSIuwpUlvI4g9njZiG5av0/RgjEXMFc/zhv
         JALqBUcMWnCnrHQHz+bk/xt1vMvCFmUL8DchE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvSF0y9cGVydackbO4wbJNVFr06wRRTkQkIKN/PkYhQ=;
        b=MyxBbQhnvDl60atvQ0M+DIVIeZxI1jl3wJi9L0AvsFRyL+tYp2d/dXgGQsPWhCps4D
         b9wA4RR6D68cyHU66R8yVJ6fJ5+arOa0ep2tV4CXl2RT98nG2Nuu5qYZzpL4feXh9oh/
         gLWI7IIEwcD3MbM6kMZ4jBmfwTn5NyJidU3qXXsM9qWio0H0P+RuReLa/Emd+1p9AqmH
         f1yqhTnOk5O1uYJZaZRz8pIkxXRIWcchU8RKiehv00Mm++WdG6CUYvulmL2ZcE2kCIGX
         RXlG5Zh4CmcHCOBCUznWoptcO09aCgrbM5NEvYzQ9Oy/zE1O7Kh0DH41Xxp1WGZRd8BM
         pn7w==
X-Gm-Message-State: AFqh2krjKZrel3+y5KVZvJ+DMSVJoqp9lOrWQw3zgZixczUXRY/1kJj/
        hPEkjfZ25VAX1Q1rksHB7OBbseSpmBAoXI/o
X-Google-Smtp-Source: AMrXdXvlLbbyUpsJ/0Isc83fGIkQVv5L0p8vpuSZp55Xs48ktQXVK61WwUBQhAWGdU1GXTXAU2Hqzw==
X-Received: by 2002:a05:600c:3b8f:b0:3d0:85b5:33d3 with SMTP id n15-20020a05600c3b8f00b003d085b533d3mr54156813wms.16.1673451692093;
        Wed, 11 Jan 2023 07:41:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:31 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH 09/11] video/aperture: Move vga handling to pci function
Date:   Wed, 11 Jan 2023 16:41:10 +0100
Message-Id: <20230111154112.90575-9-daniel.vetter@ffwll.ch>
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

A few reasons for this:

- It's really the only one where this matters. I tried looking around,
  and I didn't find any non-pci vga-compatible controllers for x86
  (since that's the only platform where we had this until a few
  patches ago), where a driver participating in the aperture claim
  dance would interfere.

- I also don't expect that any future bus anytime soon will
  not just look like pci towards the OS, that's been the case for like
  25+ years by now for practically everything (even non non-x86).

- Also it's a bit funny if we have one part of the vga removal in the
  pci function, and the other in the generic one.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/aperture.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 6f351a58f6c6..03f8a5e95238 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -298,14 +298,6 @@ int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t si
 
 	aperture_detach_devices(base, size);
 
-	/*
-	 * If this is the primary adapter, there could be a VGA device
-	 * that consumes the VGA framebuffer I/O range. Remove this device
-	 * as well.
-	 */
-	if (primary)
-		aperture_detach_devices(VGA_FB_PHYS_BASE, VGA_FB_PHYS_SIZE);
-
 	return 0;
 }
 EXPORT_SYMBOL(aperture_remove_conflicting_devices);
@@ -344,6 +336,13 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 	if (!primary)
 		return 0;
 
+	/*
+	 * If this is the primary adapter, there could be a VGA device
+	 * that consumes the VGA framebuffer I/O range. Remove this device
+	 * as well.
+	 */
+	aperture_detach_devices(VGA_FB_PHYS_BASE, VGA_FB_PHYS_SIZE);
+
 	/*
 	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
 	 * otherwise the vga fbdev driver falls over.
-- 
2.39.0

