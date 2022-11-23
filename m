Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBABD636CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiKWWIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiKWWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:08:10 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD0EE26
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Fwc20CJUecS7GLke9Ig/JlVNgOvswrRSYfMtJ8IQTng=; b=QzDjsmT9NpSf1X5bsdBTHF4vsP
        n1tNDFcR9egPB0D/H2eMjoJsJ+p805HTP+iZ5kI0XgcIDmNHGXEzLYCIpwgDxWbsH/onSInWTf4QO
        tAh08HnZiLoBPADJT5PQWwlZM1ujF8bImymLRHhSh5tsKfehfkQiiDu92r9qGQCQvZPvpN8uuX9PQ
        qRckgwFCRQLVceIQKSlDJB4DGT6GBNhmPtOhDhK4wpYie0WzYSzCSnsT73GAD2JJAm2qg0ifcGXLx
        v2YH/8SwmFCxrJ707+TEq+ii+QXAgYxRpx7CcAbmjuG9ClaaNHXW+9w/Qd7H3ck+FHLCTIcjzffwk
        So3ACG6A==;
Received: from [177.34.169.227] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oxxuG-0080ww-5d; Wed, 23 Nov 2022 23:07:48 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Melissa Wen <mwen@igalia.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Wambui Karuga <wambui@karuga.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/6] Introduce debugfs device-centered functions
Date:   Wed, 23 Nov 2022 19:07:19 -0300
Message-Id: <20221123220725.1272155-1-mcanal@igalia.com>
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

---

v1 -> v2: https://lore.kernel.org/dri-devel/20221122190314.185015-1-mcanal@igalia.com/T/#t

- Fix compilation errors in the second patch (kernel test robot).
- Drop debugfs_init hook from vkms (Maíra Canal).
- Remove return values and error handling to debugfs related
functions (Jani Nikula).
- Remove entry from list after the file is created, so that drm_debugfs_init
can be called more than once (Maíra Canal).

---

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
 drivers/gpu/drm/drm_debugfs.c         | 88 ++++++++++++++++++++++++---
 drivers/gpu/drm/drm_drv.c             |  3 +
 drivers/gpu/drm/drm_framebuffer.c     | 11 ++--
 drivers/gpu/drm/drm_gem_vram_helper.c | 11 ++--
 drivers/gpu/drm/v3d/v3d_debugfs.c     | 22 +++----
 drivers/gpu/drm/vc4/vc4_bo.c          | 10 +--
 drivers/gpu/drm/vc4/vc4_crtc.c        |  7 +--
 drivers/gpu/drm/vc4/vc4_debugfs.c     | 36 +++--------
 drivers/gpu/drm/vc4/vc4_dpi.c         |  5 +-
 drivers/gpu/drm/vc4/vc4_drv.c         |  1 -
 drivers/gpu/drm/vc4/vc4_drv.h         | 32 +++-------
 drivers/gpu/drm/vc4/vc4_dsi.c         |  6 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c        | 12 ++--
 drivers/gpu/drm/vc4/vc4_hvs.c         | 24 +++-----
 drivers/gpu/drm/vc4/vc4_v3d.c         | 14 ++---
 drivers/gpu/drm/vc4/vc4_vec.c         |  6 +-
 drivers/gpu/drm/vkms/vkms_drv.c       | 17 ++----
 include/drm/drm_debugfs.h             | 41 +++++++++++++
 include/drm/drm_device.h              | 15 +++++
 22 files changed, 212 insertions(+), 180 deletions(-)

-- 
2.38.1

