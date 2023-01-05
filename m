Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823DE65F6B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbjAEWZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbjAEWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:25:45 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708BA6D52E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:25:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672957507; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=X00VaZkNjOUCiefvNHXAFh3yAAXU7yolHt5Pgx1RIo/dquRXi7H5OGU2acGlrGXsTSbb7XVC1BOq6fKKrCwElH255FUSwple27LhAnVZnNYqMXpE+UQ4dh+UWKr14LRWtk5lRX7Ie+LF83XjS6uDsEv2lsc3uVdhygo2gdQPQE4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1672957507; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=hx8cb38taCen8OQI7QOC8s3lWyzk+oc9eJdN0dfq8fU=; 
        b=cIWAOlvOe4roYs9PzN0RaZYmgAEZEyE1qwEFUVsxpVAp+432Sj2fWIQjB0c5Wse0xi9gqEJmzcBtQ8fH8V79ySAGZlz/KiRbfrdN1HV97cGzwFM5a3doIodHZnxNTX3q6r/ar8QesIbP5a4X2JT7ib2eZymCFLsyxiT0f2vqdj4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672957507;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=hx8cb38taCen8OQI7QOC8s3lWyzk+oc9eJdN0dfq8fU=;
        b=FXVurf+z0GXHb/Cz7v5wRzrN4bDuuSzlj6ClsBiO0oDYQAtdY9DZU+oMkEUaou8h
        adILWk4LROZNbVeXlLonuY5r/8DQ3whN++WEUi6wLKXKZT2DwTKgfvaex5uEfVOsUOt
        9FWkqoMgbAGWqfPaFnibvKKqezHCthgKksEhYwhI=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1672957506070946.3534416582344; Fri, 6 Jan 2023 03:55:06 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <cover.1672957022.git.code@siddh.me>
Subject: [PATCH v4 00/10] drm: Remove usage of deprecated DRM_* macros
Date:   Fri,  6 Jan 2023 03:54:51 +0530
X-Mailer: git-send-email 2.39.0
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
discussion on v1, I added support for NULL in drm_()* macros too in this
v3.

This patchset should be applied in order as changes might be dependent.


Please review and let me know if any errors are there, and hopefully
this gets accepted.

---
Changes in v4:
- Fix commit message for DRM_NOTE erroneously mentioning DRM_INFO.
- Rebased to drm-misc-next, as 723dad977acd added drm_dbg_core() to some
  files.
- Move Generic out to a separate macro __drm_get_dev_ptr, so that interface
  of drm_dbg_*() is also same as other drm_*() macros.
- Fix comment in __drm_get_dev_ptr (now ___drm_get_dev_ptr) to use correct
  name.

Changes in v3:
- Added support for NULL is __drm_printk and thus by extension to drm_()*.
- Thus, converted dropped pr_()* changes to drm_*(NULL, ...).
- Rebased to drm-misc-next and resulting appropriate changes.

Changes in v2:
- Removed conversions to pr_*() in DRM_INFO, DRM_NOTE, and DRM_ERROR change=
s.
- Due to above, DRM_NOTE usage cannot be removed and the patch is dropped.
- DRY: NULL support is now achieved by way of a separate function.

Siddh Raman Pant (10):
  drm/print: Fix and add support for NULL as first argument in drm_*
    macros
  drm: Remove usage of deprecated DRM_INFO
  drm: Remove usage of deprecated DRM_NOTE
  drm: Remove usage of deprecated DRM_ERROR
  drm: Remove usage of deprecated DRM_DEBUG
  drm: Remove usage of deprecated DRM_DEBUG_DRIVER
  drm: Remove usage of deprecated DRM_DEBUG_KMS
  drm: Remove usage of deprecated DRM_DEBUG_PRIME
  drm/drm_blend: Remove usage of deprecated DRM_DEBUG_ATOMIC
  drm/drm_lease: Remove usage of deprecated DRM_DEBUG_LEASE

 drivers/gpu/drm/drm_agpsupport.c        |   4 +-
 drivers/gpu/drm/drm_blend.c             |  13 ++-
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
 drivers/gpu/drm/drm_drv.c               |  26 ++---
 drivers/gpu/drm/drm_edid.c              |  17 ++--
 drivers/gpu/drm/drm_flip_work.c         |   2 +-
 drivers/gpu/drm/drm_framebuffer.c       |   3 +-
 drivers/gpu/drm/drm_gem.c               |   7 +-
 drivers/gpu/drm/drm_gem_dma_helper.c    |   6 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c  |   6 +-
 drivers/gpu/drm/drm_hashtab.c           |  10 +-
 drivers/gpu/drm/drm_irq.c               |   4 +-
 drivers/gpu/drm/drm_kms_helper_common.c |   2 +-
 drivers/gpu/drm/drm_lease.c             |  68 ++++++-------
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
 include/drm/drm_print.h                 | 103 ++++++++++++++------
 42 files changed, 543 insertions(+), 464 deletions(-)

--=20
2.39.0


