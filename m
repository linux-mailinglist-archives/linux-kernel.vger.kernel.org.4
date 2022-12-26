Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B9F6563F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiLZPw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiLZPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:52:26 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69226336
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/kZMLPqQnBN8PK+NTipJKTw+jAOXbJ78l4KtMYdcI1I=; b=bmtntYHbu51SuuWqOk02JYIKIh
        EeAVKEi4LQN8uLcUR088djajJp8Kyuju5ZKB1gFveA/G1gGI8mcQ0GMCT1dm4qZ1PVqAX3+H01O/p
        NPWjOysfQfFZVbeiahMiF0rHAhlafzgmb6QPPi70+QMu5+6CNjg7gFU/IFSiKLJValEtgmSKTKaAc
        SQE214nyfah6VLadxcVJ5p9g6zH4yL8qIq/WsWNQmhM2eEbjs3tRuiidbNetubTLOhvb/gpxWpOjG
        gnf/iiP3fenG/XGvZ/sddxv/KNQV9Z3NBywwf+/A345XuM0YXmttdkZ0ckP0Ix17aWSDgZdZEzWka
        NuHaO+jA==;
Received: from [187.36.234.139] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1p9pm2-00AXBr-Iu; Mon, 26 Dec 2022 16:52:23 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Melissa Wen <mwen@igalia.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, noralf@tronnes.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Emma Anholt <emma@anholt.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 5/9] drm/arc: use new debugfs device-centered functions
Date:   Mon, 26 Dec 2022 12:50:25 -0300
Message-Id: <20221226155029.244355-6-mcanal@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226155029.244355-1-mcanal@igalia.com>
References: <20221226155029.244355-1-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of drm_debugfs_create_files() with the new
drm_debugfs_add_file() function, which center the debugfs files
management on the drm_device instead of drm_minor. Moreover, remove the
debugfs_init hook and add the debugfs files directly on arcpgu_probe(),
before drm_dev_register().

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 611bbee15071..b074a0b4c7b3 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -338,8 +338,8 @@ static int arcpgu_unload(struct drm_device *drm)
 #ifdef CONFIG_DEBUG_FS
 static int arcpgu_show_pxlclock(struct seq_file *m, void *arg)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *drm = node->minor->dev;
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *drm = entry->dev;
 	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(drm);
 	unsigned long clkrate = clk_get_rate(arcpgu->clk);
 	unsigned long mode_clock = arcpgu->pipe.crtc.mode.crtc_clock * 1000;
@@ -348,17 +348,6 @@ static int arcpgu_show_pxlclock(struct seq_file *m, void *arg)
 	seq_printf(m, "mode: %lu\n", mode_clock);
 	return 0;
 }
-
-static struct drm_info_list arcpgu_debugfs_list[] = {
-	{ "clocks", arcpgu_show_pxlclock, 0 },
-};
-
-static void arcpgu_debugfs_init(struct drm_minor *minor)
-{
-	drm_debugfs_create_files(arcpgu_debugfs_list,
-				 ARRAY_SIZE(arcpgu_debugfs_list),
-				 minor->debugfs_root, minor);
-}
 #endif
 
 static const struct drm_driver arcpgu_drm_driver = {
@@ -371,9 +360,6 @@ static const struct drm_driver arcpgu_drm_driver = {
 	.patchlevel = 0,
 	.fops = &arcpgu_drm_ops,
 	DRM_GEM_DMA_DRIVER_OPS,
-#ifdef CONFIG_DEBUG_FS
-	.debugfs_init = arcpgu_debugfs_init,
-#endif
 };
 
 static int arcpgu_probe(struct platform_device *pdev)
@@ -390,6 +376,10 @@ static int arcpgu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_DEBUG_FS
+	drm_debugfs_add_file(&arcpgu->drm, "clocks", arcpgu_show_pxlclock, NULL);
+#endif
+
 	ret = drm_dev_register(&arcpgu->drm, 0);
 	if (ret)
 		goto err_unload;
-- 
2.38.1

