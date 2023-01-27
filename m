Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB45467E05F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjA0Jgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjA0Jgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:36:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89772C9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC618CE26E2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3989C433EF;
        Fri, 27 Jan 2023 09:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674812196;
        bh=wlz6HIVQ/GgIj0YbTS0RXKypfcVwy2vvEGBqBClsFuo=;
        h=From:To:Cc:Subject:Date:From;
        b=Tir3d55g29BmdExqeS9YYdmYN3bB9BIsEcfWaB4gHjRQgIO8DPGdyUbu8a/h5jel7
         wqVAdY0QxPgzZ8nAJrUxKX2rkHn0ipkyfFP73Eg4NTygD1wosC1bd5jRxEdSmWMzNq
         PUGnUrXSQ2AMGsUKfkRZsrWwOUOt7C89Ou7P4a6320syjhHDnqOH1KHDRKYDFMAwMP
         dEMELwYPsl0pM0VEfTXtHIT3HgN1pF4TDrlJ57QDkqodr9+Gp+bXLa2RRI6EfUyQ/J
         mT8tXwQvo5u9E+ImLVjmuudBFc69W/JU8nIwqBH79cGtmkHp37C8hqFqG040dnIh9E
         G+fwgYcmFJh3g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Oded Gabbay <ogabbay@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Melissa Wen <mwen@igalia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accel: work around DRM_ACCEL dependencies
Date:   Fri, 27 Jan 2023 10:36:20 +0100
Message-Id: <20230127093631.2132187-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

At the moment, accel drivers can be built-in even with CONFIG_DRM=m,
but this causes a link failure:

x86_64-linux-ld: drivers/accel/ivpu/ivpu_drv.o: in function `ivpu_dev_init':
ivpu_drv.c:(.text+0x1535): undefined reference to `drmm_kmalloc'
x86_64-linux-ld: ivpu_drv.c:(.text+0x1562): undefined reference to `drmm_kmalloc'
x86_64-linux-ld: drivers/accel/ivpu/ivpu_drv.o: in function `ivpu_remove':
ivpu_drv.c:(.text+0x1faa): undefined reference to `drm_dev_unregister'
x86_64-linux-ld: drivers/accel/ivpu/ivpu_drv.o: in function `ivpu_probe':
ivpu_drv.c:(.text+0x1fef): undefined reference to `__devm_drm_dev_alloc'

This could be avoided by making DRM_ACCEL a tristate symbol, which
would mean that every ACCEL driver is guarantee to be able to link
against DRM as well. However, having both as =m causes another link
failure because the DRM core code also links against the accel driver:

x86_64-linux-ld: drivers/gpu/drm/drm_drv.o: in function `drm_minor_register':
drm_drv.c:(.text+0x259): undefined reference to `accel_debugfs_init'
x86_64-linux-ld: drm_drv.c:(.text+0x298): undefined reference to `accel_minor_replace'

I think it will be necessary to establish a link hierarchy between drm.ko
and drm_accel.ko to avoid circular dependencies like this, but until then
the only way that both can be used is to have both subsystems built into
the kernel. Enforce this using a Kconfig dependency.

Fixes: 8bf4889762a8 ("drivers/accel: define kconfig and register a new major")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/accel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index 834863902e16..dd18d3b2028c 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -8,7 +8,7 @@
 #
 menuconfig DRM_ACCEL
 	bool "Compute Acceleration Framework"
-	depends on DRM
+	depends on DRM=y
 	help
 	  Framework for device drivers of compute acceleration devices, such
 	  as, but not limited to, Machine-Learning and Deep-Learning
-- 
2.39.0

