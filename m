Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E36563EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiLZPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiLZPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:51:56 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657126DD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OXbSziPUtP0NBz3Ri+ufOZyM1ccFIFns/4pM3n5+BoA=; b=sH/9P5+QlsEJ0PJH2fS/fN+z3L
        yswK1yklIoI7QvSv2JHFUpMjquDkVvKdnX3tw2B5MpDi2SZnKy4vQdxDReNBi2BgRvTQJC17gMiLk
        uV+bF5wvKfJOH2qYMj+1JdYn7OYCzWuZ65/Fk9ctaYDooydC7XcWoG1gMBU5733479MLRmiXsUzex
        kctrDwPy8nefJhsDbtcX+alG1Kjc6rMX+UlMsN6mHFaS+8xMuQSqCruBplhvxJ1Wf4pXmuO5oUwPp
        Pu701BuJOrURY5nGiYyc1E27otqa+9Y+o0wLEVOW5n5yQRERV65GUGM6JiYJdrWxYaGgqlgvDyMKN
        gglfZREw==;
Received: from [187.36.234.139] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1p9plX-00AXBr-Vp; Mon, 26 Dec 2022 16:51:52 +0100
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
Subject: [PATCH 2/9] drm/gud: use new debugfs device-centered functions
Date:   Mon, 26 Dec 2022 12:50:22 -0300
Message-Id: <20221226155029.244355-3-mcanal@igalia.com>
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
debugfs_init hook and add the debugfs files directly on gud_probe(),
before drm_dev_register().

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 5aac7cda0505..9d7bf8ee45f1 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -325,8 +325,8 @@ static struct drm_gem_object *gud_gem_prime_import(struct drm_device *drm, struc
 
 static int gud_stats_debugfs(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = m->private;
-	struct gud_device *gdrm = to_gud_device(node->minor->dev);
+	struct drm_debugfs_entry *entry = m->private;
+	struct gud_device *gdrm = to_gud_device(entry->dev);
 	char buf[10];
 
 	string_get_size(gdrm->bulk_len, 1, STRING_UNITS_2, buf, sizeof(buf));
@@ -352,16 +352,6 @@ static int gud_stats_debugfs(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list gud_debugfs_list[] = {
-	{ "stats", gud_stats_debugfs, 0, NULL },
-};
-
-static void gud_debugfs_init(struct drm_minor *minor)
-{
-	drm_debugfs_create_files(gud_debugfs_list, ARRAY_SIZE(gud_debugfs_list),
-				 minor->debugfs_root, minor);
-}
-
 static const struct drm_simple_display_pipe_funcs gud_pipe_funcs = {
 	.check      = gud_pipe_check,
 	.update	    = gud_pipe_update,
@@ -386,7 +376,6 @@ static const struct drm_driver gud_drm_driver = {
 	.fops			= &gud_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
 	.gem_prime_import	= gud_gem_prime_import,
-	.debugfs_init		= gud_debugfs_init,
 
 	.name			= "gud",
 	.desc			= "Generic USB Display",
@@ -623,6 +612,8 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (!gdrm->dmadev)
 		dev_warn(dev, "buffer sharing not supported");
 
+	drm_debugfs_add_file(drm, "stats", gud_stats_debugfs, NULL);
+
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
 		put_device(gdrm->dmadev);
-- 
2.38.1

