Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DAD665F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbjAKPmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjAKPlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7BB2E0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so12970636wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okH8AsNmtLn+Xev5OTCMqwCCcQgJeFP0KaGCnceKOFQ=;
        b=e3QgYRhA/FauY7S29GhmvTbp6mhIVjL3kUKyk/aiNJTXGHtP9m5oMyVm5h+bchf5VB
         5Ozpe8kode9PPOMtykJJWS4wCtMq4JeTqLZWhNsrNNrrwUmqJgCj6729094+1wKf7qV8
         SfwbZApVC/cUEh7SexrqejM4npd5PFpvVRP4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okH8AsNmtLn+Xev5OTCMqwCCcQgJeFP0KaGCnceKOFQ=;
        b=7LxQFHcmqk3oeufFgmgwt/NoLkhG5P2Z1Hv/geOQC1W2IZ6nqzRRuq55upDtjPxuUz
         2UWp5MmhzqVaZzXCgBEto1owCa+YPSJE8KF464s5OUAj+oRxbHfKyzIXyjwsVx/LqcFx
         k82cEI7rMgAMVvAY3uggT7/1CC7Tb8ENxaG/R4T/arf9YUou0FKNvVR/ZS1l/jXcZcRC
         A6zoENEwrG1zQ0acQrkSonSYpJCa5qL8krb016YgD8K25GDqu1V2TSUOhkB0vuqlDROK
         52uKwjfrtuJUVcplNjrIw/6nq2KR9HuqtHhXjUYr4HfFvYUabvto0U3FnArwI/1NV5sA
         pE/g==
X-Gm-Message-State: AFqh2koen4opR2qYhx4YAM+I3ESGoQRakEndxdtd7fm/TL1vJ1l2pQuT
        dbPSk0aOXTVGvh1tbbjX/dmmnw==
X-Google-Smtp-Source: AMrXdXv1xjpTqbp3o72Jk+q/9NKQX+TzVLexEvL4brcebjiwodaMtz9/eJQ29HVAzKVNvEUGaR8qtg==
X-Received: by 2002:a05:600c:3d05:b0:3d3:5c21:dd94 with SMTP id bh5-20020a05600c3d0500b003d35c21dd94mr54680019wmb.9.1673451689538;
        Wed, 11 Jan 2023 07:41:29 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:28 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 07/11] fbdev/radeon: use pci aperture helpers
Date:   Wed, 11 Jan 2023 16:41:08 +0100
Message-Id: <20230111154112.90575-7-daniel.vetter@ffwll.ch>
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

It's not exactly the same since the open coded version doesn't set
primary correctly. But that's a bugfix, so shouldn't hurt really.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/aty/radeon_base.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 657064227de8..972c4bbedfa3 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2238,14 +2238,6 @@ static const struct bin_attribute edid2_attr = {
 	.read	= radeon_show_edid2,
 };
 
-static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
-{
-	resource_size_t base = pci_resource_start(pdev, 0);
-	resource_size_t size = pci_resource_len(pdev, 0);
-
-	return aperture_remove_conflicting_devices(base, size, false, KBUILD_MODNAME);
-}
-
 static int radeonfb_pci_register(struct pci_dev *pdev,
 				 const struct pci_device_id *ent)
 {
@@ -2296,7 +2288,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
-	ret = radeon_kick_out_firmware_fb(pdev);
+	ret = aperture_remove_conflicting_pci_devices(pdev, KBUILD_MODNAME);
 	if (ret)
 		goto err_release_fb;
 
-- 
2.39.0

