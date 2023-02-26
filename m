Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B316A2EC4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 08:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBZHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 02:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBZHWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 02:22:50 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E51258E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 23:22:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677396129; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=MQWndFLpjkSFFl5JiQHUuu/dGCoJC03On4pfL78jqfAZae7v1pDGor4jwuEafPV28y2mdqz6KHNX+9gYeqb9hx4jX+wUCNPQsgz4KS4VpSZh3j4Q3R7mTKPht7tXqabdZSr0ti+agfkMZ47uVIpO0AuW/AnBC7Ndt14Yt7KsCzo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1677396129; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=vjZUX7bk5n2/6NzT59W4cJpTv/AwpebIVItN+pYV5Zc=; 
        b=KiXi1TBVJgY32YZnx1T9ZcOSwBPoE8Nbc59E9GrTEkfPYKPcCnZMvOtz3EDjKgSXGwo3kUVyPV2iSsgu9Lwm5K2e1XbbT4IFDs1VSFRKCL2T68w5bmLo2ewRzTYwxGQ+LcFc4L27qy1KCEs7rEHoC3YgNnOZWP9FSyblP+CSuJ8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677396129;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=vjZUX7bk5n2/6NzT59W4cJpTv/AwpebIVItN+pYV5Zc=;
        b=nnI3yTuA3w1pbnpEXBsdHLuHBQWop3zto03NCeveCoOaa9RYDvEl9RAo/KVp6EIR
        vfvc7xm6WEVFctfeQWLDxmc09nNJardrzBtvVo7k9RFzMC8no5luA321pfyzaVfjPc7
        qv5cTgE7eE54f5t3Sq3Fg2AqCodIWp6kOZbiHLpU=
Received: from kampyooter.. (122.170.64.102 [122.170.64.102]) by mx.zoho.in
        with SMTPS id 1677396127095503.1730406630637; Sun, 26 Feb 2023 12:52:07 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Message-ID: <cover.1677395403.git.code@siddh.me>
Subject: [PATCH v7 0/7] drm: Remove usage of deprecated DRM_* macros
Date:   Sun, 26 Feb 2023 12:51:47 +0530
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to remove usages of deprecated DRM_* macros from the
files residing in drivers/gpu/drm root.

In process, I found out that NULL as first argument of drm_dbg_* wasn't
working, but it was listed as the alternative in deprecation comment,
so I fixed that before removing usages of DRM_DEBUG_* macros. Courtesy
discussion on v1, I added support for NULL in drm_()* macros too.

This patchset should be applied in order as changes might be dependent.

Please review and let me know if any errors are there, and hopefully
this gets accepted.

---
v6 -> v7 (Today):
- Rebased to drm-misc-next, accounting for the merger of last 3 patches
  in the previous series (4665280990fa, fc2602b553c8, 7bd224b6625a),
  and 7428ff70a18 ("drm: initialize accel framework").

v5 -> v6 (09 Jan 2023):
- Move drm_device to default case in _Generic as it is the default behaviou=
r.
- Fix incorrect const drm_device handling in _Generic.
- Minor positioning / comment changes.

v4 -> v5 (07 Jan 2023):
- Make separate function instead of using boolean in _Generic (sravn on IRC=
).
- Also, simplified the Generic macro, and renamed the function and macro.

v3 -> v4 (05 Jan 2023):
- Fix commit message for DRM_NOTE erroneously mentioning DRM_INFO.
- Rebased to drm-misc-next, as 723dad977acd added drm_dbg_core() to some
  files.
- Move Generic out to a separate macro __drm_get_dev_ptr, so that interface
  of drm_dbg_*() is also same as other drm_*() macros.
- Fix comment in __drm_get_dev_ptr (now ___drm_get_dev_ptr) to use correct
  name.

v2 -> v3 (26 Dec 2022):
- Added support for NULL in __drm_printk and thus by extension to drm_()*.
- Thus, converted dropped pr_()* changes to drm_*(NULL, ...).
- Rebased to drm-misc-next and resulting appropriate changes.

v1 (20 Dec 2022) -> v2 (22 Dec 2022):
- Removed conversions to pr_*() in DRM_INFO, DRM_NOTE, and DRM_ERROR change=
s.
- Due to above, DRM_NOTE usage cannot be removed and the patch is dropped.
- DRY: NULL support is now achieved by way of a separate function.

Siddh Raman Pant (7):
  drm/print: Fix and add support for NULL as first argument in drm_*
    macros
  drm: Remove usage of deprecated DRM_INFO
  drm: Remove usage of deprecated DRM_NOTE
  drm: Remove usage of deprecated DRM_ERROR
  drm: Remove usage of deprecated DRM_DEBUG
  drm: Remove usage of deprecated DRM_DEBUG_DRIVER
  drm: Remove usage of deprecated DRM_DEBUG_KMS

 drivers/gpu/drm/drm_agpsupport.c        |   4 +-
 drivers/gpu/drm/drm_bridge.c            |   8 +-
 drivers/gpu/drm/drm_bufs.c              | 122 ++++++++++++------------
 drivers/gpu/drm/drm_client_modeset.c    | 118 +++++++++++++----------
 drivers/gpu/drm/drm_color_mgmt.c        |   4 +-
 drivers/gpu/drm/drm_connector.c         |  28 +++---
 drivers/gpu/drm/drm_context.c           |  18 ++--
 drivers/gpu/drm/drm_crtc.c              |  36 ++++---
 drivers/gpu/drm/drm_crtc_helper.c       |  62 ++++++------
 drivers/gpu/drm/drm_debugfs_crc.c       |   8 +-
 drivers/gpu/drm/drm_displayid.c         |   6 +-
 drivers/gpu/drm/drm_dma.c               |  10 +-
 drivers/gpu/drm/drm_drv.c               |  28 +++---
 drivers/gpu/drm/drm_edid.c              |  17 ++--
 drivers/gpu/drm/drm_flip_work.c         |   2 +-
 drivers/gpu/drm/drm_framebuffer.c       |   3 +-
 drivers/gpu/drm/drm_gem.c               |   7 +-
 drivers/gpu/drm/drm_gem_dma_helper.c    |   2 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c  |   4 +-
 drivers/gpu/drm/drm_hashtab.c           |  10 +-
 drivers/gpu/drm/drm_irq.c               |   4 +-
 drivers/gpu/drm/drm_kms_helper_common.c |   2 +-
 drivers/gpu/drm/drm_lease.c             |   4 +-
 drivers/gpu/drm/drm_legacy_misc.c       |   4 +-
 drivers/gpu/drm/drm_lock.c              |  36 +++----
 drivers/gpu/drm/drm_mipi_dbi.c          |  19 ++--
 drivers/gpu/drm/drm_mipi_dsi.c          |  12 +--
 drivers/gpu/drm/drm_mm.c                |   8 +-
 drivers/gpu/drm/drm_mode_config.c       |   2 +-
 drivers/gpu/drm/drm_mode_object.c       |   6 +-
 drivers/gpu/drm/drm_modes.c             |  36 +++----
 drivers/gpu/drm/drm_modeset_helper.c    |   2 +-
 drivers/gpu/drm/drm_pci.c               |  14 +--
 drivers/gpu/drm/drm_plane.c             |  46 ++++-----
 drivers/gpu/drm/drm_probe_helper.c      |  39 ++++----
 drivers/gpu/drm/drm_rect.c              |   4 +-
 drivers/gpu/drm/drm_scatter.c           |  19 ++--
 drivers/gpu/drm/drm_syncobj.c           |   2 +-
 drivers/gpu/drm/drm_sysfs.c             |  22 ++---
 drivers/gpu/drm/drm_vm.c                |  45 +++++----
 include/drm/drm_print.h                 | 116 ++++++++++++++++------
 41 files changed, 515 insertions(+), 424 deletions(-)

--=20
2.39.1


