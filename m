Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2A67F100
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjA0WPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA0WPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:15:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191ED84FBC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:15:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9F0CB8214D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065FBC433D2;
        Fri, 27 Jan 2023 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674857708;
        bh=tYeVWVDqmrYCQ68BomdAu9i6GwFXBSSVooD9s632kl0=;
        h=From:To:Cc:Subject:Date:From;
        b=FcoP7OuX+aYmdJQtza1BnQZJTENkfGj2s/ORLK/+cRjT/Psyfu1W8AV4ydF3eNhC4
         XXCAoj8GK47nhBs3IU+aL/uffgBty8u8nFWRAk4NG0CJ056LuvVKgN8ZBR+DwVcWMc
         8F+CCJhb/Xt5iPcAdxyiydjRrWCjaAdwfMN/jUNq8C1ssKDlUQCcxeYdZCrmWk0xlf
         zQj+nwBibCyeGIE3dc8O80I5MHFObt+w58qik5L5HMH0sajKK3BcP3YJYioNhqMi2E
         cgGK+g2XhMMQPQ38zdz5a4NPM1OrVk5kQqCHUUJ+vQlBJf2xZkMWoAns3sWxacbMqu
         9s56ZSw5PuR5w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Oded Gabbay <ogabbay@kernel.org>, Dave Airlie <airlied@redhat.com>,
        Melissa Wen <mwen@igalia.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] accel: fix CONFIG_DRM dependencies
Date:   Fri, 27 Jan 2023 23:14:55 +0100
Message-Id: <20230127221504.2522909-1-arnd@kernel.org>
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

The problem is that DRM_ACCEL is a 'bool' symbol symbol, so driver that
only depend on DRM_ACCEL but not also on DRM do not see the restriction
to =m configs.

To ensure that each accel driver has an implied dependency on CONFIG_DRM,
enclose the entire Kconfig file in an if/endif check.

Fixes: 8bf4889762a8 ("drivers/accel: define kconfig and register a new major")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rearrage the DRM dependency rather than requiring DRM to be built-in
---
 drivers/accel/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index 834863902e16..c437206aa3f1 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -6,9 +6,10 @@
 # as, but not limited to, Machine-Learning and Deep-Learning acceleration
 # devices
 #
+if DRM
+
 menuconfig DRM_ACCEL
 	bool "Compute Acceleration Framework"
-	depends on DRM
 	help
 	  Framework for device drivers of compute acceleration devices, such
 	  as, but not limited to, Machine-Learning and Deep-Learning
@@ -25,3 +26,5 @@ menuconfig DRM_ACCEL
 
 source "drivers/accel/habanalabs/Kconfig"
 source "drivers/accel/ivpu/Kconfig"
+
+endif
-- 
2.39.0

