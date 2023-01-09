Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB466266A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbjAINDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjAINCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:02:46 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF41310FD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:01:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673269250; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=WrMqFd4CwDYS0yLAf/tCBS7gqk/J3gieVzLllTXvNaBfJqroX1pNJz+RN3eWkFH6m6XjbGMOTaclEOCPyLt4kmpK8h9//4XYyHLhPZ0MoT99ycpp9fV6h/ABNb2dhCC1jYXPJYBL33OtZBHb3d5dLdTIvPXU/dvtopD0mpXkQ6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673269250; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=MWekVh7g0aNC8fU4Gyt4wLdjrGx1HtGYSC6SCLpolcA=; 
        b=KoO61Yi1UxZc9SAOUYsuAyk83xnJZcK9JS7RZ7GyHA8JEE383wTYT5jeqVUs/FjQabyha1yCKtewZBN8ELUVwD8IeO5HCFxm7O4mZbA8tUB97Gl6m2FySVjzo3siwShaOV8oytzl7rzLbxNtbV90HNyqWpk7djm42BY89AidHPg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673269250;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=MWekVh7g0aNC8fU4Gyt4wLdjrGx1HtGYSC6SCLpolcA=;
        b=cB2ONmhbwa4IPtOlS9w8Ka90G85pjKThkDAdhVBD8hjLvBCC5dl5M4qsWE4fY8sa
        ZCtVHgie3xhmRFwG45SYhvbS5PSBR2Ug06DyuYqsFvZ0x8TH46jOexQzI6BxxIjbyHj
        I3Sidat0XL74Rd2+31aW6Sf1973wGiViCFwlBYns=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1673269247710493.7155399455969; Mon, 9 Jan 2023 18:30:47 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <cover.1673269059.git.code@siddh.me>
Subject: [PATCH v6 00/10] drm: Remove usage of deprecated DRM_* macros
Date:   Mon,  9 Jan 2023 18:30:25 +0530
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
discussion on v1, I added support for NULL in drm_()* macros too.

This patchset should be applied in order as changes might be dependent.

Please review and let me know if any errors are there, and hopefully
this gets accepted.

---
v5 -> v6:
- Move drm_device to default case in _Generic as it is the default behaviou=
r.
- Fix incorrect const drm_device handling in _Generic.
- Minor positioning / comment changes.

v4 -> v5:
- Make separate function instead of using boolean in _Generic (sravn on IRC=
).
- Also, simplified the Generic macro, and renamed the function and macro.

v3 -> v4:
- Fix commit message for DRM_NOTE erroneously mentioning DRM_INFO.
- Rebased to drm-misc-next, as 723dad977acd added drm_dbg_core() to some
  files.
- Move Generic out to a separate macro __drm_get_dev_ptr, so that interface
  of drm_dbg_*() is also same as other drm_*() macros.
- Fix comment in __drm_get_dev_ptr (now ___drm_get_dev_ptr) to use correct
  name.

v2 -> v3:
- Added support for NULL in __drm_printk and thus by extension to drm_()*.
- Thus, converted dropped pr_()* changes to drm_*(NULL, ...).
- Rebased to drm-misc-next and resulting appropriate changes.

v1 -> v2:
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
 include/drm/drm_print.h                 | 116 ++++++++++++++++------
 42 files changed, 557 insertions(+), 463 deletions(-)

--=20
2.39.0


