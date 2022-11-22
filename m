Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1563A63443A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiKVTE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiKVTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:04:54 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F757DEE0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dxk5tRADgn21CYwUatICiwNiLOEDiPF1CkVnet231r0=; b=BGRS9cLlENS/MyyjK4f/P3HAJJ
        hDSGmU4bLxmUBIG7U7jA9lbUwHcRftDWz0w93MNg+0HRSm6yBafrI0HyI3KthAMfYMElNOTW9BuQ2
        fHkaaCN8++9pnnrFxH+pp7LrhH5KSghbr0HHPo5RHrHEum+6pjJYw6YVVEbXUleAxI1bS9IWy8of5
        GFQmdhxdcClAqgMrrYZdGvXjVZRAgeP/KsFICVUOQoSEC5jBR3Bth/rxfqNPlWALEFRRr4OCaCEiD
        bWtqCh/lUMz+483bjGUPMDbF2pfec+WlTtq3n7WXr0Ye7P0/MJ51vWdx4xveq1UA9DbTZfwx5AGwm
        qA/noXOQ==;
Received: from [177.34.169.227] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oxYZR-007AP3-Ks; Tue, 22 Nov 2022 20:04:38 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <ogabbay@kernel.org>
Cc:     Melissa Wen <mwen@igalia.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Wambui Karuga <wambui@karuga.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/6] Introduce debugfs device-centered functions
Date:   Tue, 22 Nov 2022 16:03:08 -0300
Message-Id: <20221122190314.185015-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.38.1
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

This series introduces the initial structure to make DRM debugfs more
device-centered and it is the first step to drop the
drm_driver->debugfs_init hooks in the future [1].

Currently, DRM debugfs files are created using drm_debugfs_create_files()
on request. The first patch of this series makes it possible for DRM devices
for creating debugfs files during drm_dev_register(). For it, it introduces
two new functions that can be used by the drivers: drm_debugfs_add_files()
and drm_debugfs_add_file(). The requests are added to a list and are created
all at once during drm_dev_register(). Moreover, the first patch was based on
this RFC series [2].

The main difference between the RFC series and the current series is the
creation of a new fops structure to accommodate the new structs and, also,
the creation of a new drm_debugfs_open. Moreover, the new series uses
device-managed allocation, returns memory allocation errors, and converts
more drivers to the new structure.

Apart from the first patch, the following patches are converting some drivers
to the new DRM debugfs structure and the last patch update the TODO task
related to it.

[1] https://cgit.freedesktop.org/drm/drm/tree/Documentation/gpu/todo.rst#n506
[2] https://lore.kernel.org/dri-devel/20200513114130.28641-2-wambui.karugax@gmail.com/

Best Regards,
- Maíra Canal

Maíra Canal (6):
  drm/debugfs: create device-centered debugfs functions
  drm: use new debugfs device-centered functions on DRM core files
  drm/vc4: use new debugfs device-centered functions
  drm/v3d: use new debugfs device-centered functions
  drm/vkms: use new debugfs device-centered functions
  drm/todo: update the debugfs clean up task

 Documentation/gpu/todo.rst            |  9 +--
 drivers/gpu/drm/drm_atomic.c          | 11 ++--
 drivers/gpu/drm/drm_client.c          | 11 ++--
 drivers/gpu/drm/drm_debugfs.c         | 94 ++++++++++++++++++++++++---
 drivers/gpu/drm/drm_drv.c             |  3 +
 drivers/gpu/drm/drm_framebuffer.c     | 11 ++--
 drivers/gpu/drm/drm_gem_vram_helper.c | 11 ++--
 drivers/gpu/drm/v3d/v3d_debugfs.c     | 22 +++----
 drivers/gpu/drm/vc4/vc4_bo.c          |  6 +-
 drivers/gpu/drm/vc4/vc4_debugfs.c     | 30 ++-------
 drivers/gpu/drm/vc4/vc4_drv.c         |  1 -
 drivers/gpu/drm/vc4/vc4_drv.h         | 16 -----
 drivers/gpu/drm/vc4/vc4_hdmi.c        |  6 +-
 drivers/gpu/drm/vc4/vc4_hvs.c         | 12 ++--
 drivers/gpu/drm/vc4/vc4_v3d.c         |  6 +-
 drivers/gpu/drm/vkms/vkms_drv.c       | 10 +--
 include/drm/drm_debugfs.h             | 45 +++++++++++++
 include/drm/drm_device.h              | 15 +++++
 18 files changed, 203 insertions(+), 116 deletions(-)

-- 
2.38.1

