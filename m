Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4C65447F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiLVPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiLVPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:43:25 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20952B255
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:43:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1671723649; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Fub5C9NlCORIkvWi/8Kjs74RJ7k4MImwXBpFtATEPZ17BAp6w/OQ9XJAMlop3Vuhkf+7E3pcsOhg6Uu2vdLythqXTq2zgKY+0sETuCkj2s8SZ7gMsk/qojBay5J88bxhLtD6hadC/hLiLf1oy1XwSXlTu5gRv+4dAOsipK3YCOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1671723649; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=tL/P1i4iMJc5VhZfCY58mDeHvqscFRuLwd2Nnlm0Pt0=; 
        b=BNui7a9D+tqlhEr9x66zchMzyVXyYrem6RsQIQOZ6xHSUE4t9aqNEcacfIOH0HrggNV+f3lMeFUxifyj6nnQrRcQzCHdLdTqHEYfiT51JpCWZYGGAIi4UrkdnvXyjdz3UP+OIaJ8bcVl6calaJGWeGO5FYuBJcann0YuXOe4ikQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1671723649;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=tL/P1i4iMJc5VhZfCY58mDeHvqscFRuLwd2Nnlm0Pt0=;
        b=UwTWkCPBeIlYvW49Jhhu0cAfLelbO9sblGD81ETJMes3VzCXKHm4Ik+67HRJIAAx
        0NdJm+3GBFHN9ZTL4GqU/BytK2/xTo/rxXiw6ycp+roAtdfBrQ7a/0sp3RpKU/fmpYD
        Ahx1NtQSZI467YWR7EyAr93JhJmwKS+EIVqphwqc=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 167172364697892.94726004909683; Thu, 22 Dec 2022 21:10:46 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <cover.1671723195.git.code@siddh.me>
Subject: [PATCH v2 0/9] drm: Remove usage of deprecated DRM_* macros
Date:   Thu, 22 Dec 2022 21:10:34 +0530
X-Mailer: git-send-email 2.35.1
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
so I fixed that before removing usages of DRM_DEBUG_* macros.

This patchset should be applied in order as changes might be dependent.

Please review and let me know if any errors are there, and hopefully
this gets accepted.

----
Changes in v2:
- Removed conversions to pr_*() in DRM_INFO, DRM_NOTE, and DRM_ERROR change=
s.
- Due to above, DRM_NOTE usage cannot be removed and the patch is dropped.
- DRY: NULL support is now achieved by way of a separate function.

Siddh Raman Pant (9):
  drm: Remove usage of deprecated DRM_INFO
  drm: Remove usage of deprecated DRM_ERROR
  drm/print: Fix support for NULL as first argument of drm_dbg_*
  drm: Remove usage of deprecated DRM_DEBUG
  drm: Remove usage of deprecated DRM_DEBUG_DRIVER
  drm: Remove usage of deprecated DRM_DEBUG_KMS
  drm: Remove usage of deprecated DRM_DEBUG_PRIME
  drm/drm_blend: Remove usage of deprecated DRM_DEBUG_ATOMIC
  drm/drm_lease: Remove usage of deprecated DRM_DEBUG_LEASE

 drivers/gpu/drm/drm_agpsupport.c       |   4 +-
 drivers/gpu/drm/drm_blend.c            |  13 ++-
 drivers/gpu/drm/drm_bridge.c           |   8 +-
 drivers/gpu/drm/drm_bufs.c             | 122 +++++++++++++------------
 drivers/gpu/drm/drm_client_modeset.c   | 118 +++++++++++++-----------
 drivers/gpu/drm/drm_color_mgmt.c       |   4 +-
 drivers/gpu/drm/drm_connector.c        |  28 +++---
 drivers/gpu/drm/drm_context.c          |  18 ++--
 drivers/gpu/drm/drm_crtc.c             |  36 ++++----
 drivers/gpu/drm/drm_crtc_helper.c      |  60 ++++++------
 drivers/gpu/drm/drm_debugfs_crc.c      |   8 +-
 drivers/gpu/drm/drm_displayid.c        |   4 +-
 drivers/gpu/drm/drm_dma.c              |  10 +-
 drivers/gpu/drm/drm_drv.c              |  20 ++--
 drivers/gpu/drm/drm_edid.c             |  17 ++--
 drivers/gpu/drm/drm_file.c             |  18 ++--
 drivers/gpu/drm/drm_framebuffer.c      |   3 +-
 drivers/gpu/drm/drm_gem.c              |   7 +-
 drivers/gpu/drm/drm_gem_dma_helper.c   |   6 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c |   6 +-
 drivers/gpu/drm/drm_hashtab.c          |   6 +-
 drivers/gpu/drm/drm_ioc32.c            |  13 +--
 drivers/gpu/drm/drm_ioctl.c            |  24 ++---
 drivers/gpu/drm/drm_irq.c              |   4 +-
 drivers/gpu/drm/drm_lease.c            |  68 +++++++-------
 drivers/gpu/drm/drm_legacy_misc.c      |   4 +-
 drivers/gpu/drm/drm_lock.c             |  20 ++--
 drivers/gpu/drm/drm_mipi_dbi.c         |  19 ++--
 drivers/gpu/drm/drm_mode_config.c      |   2 +-
 drivers/gpu/drm/drm_mode_object.c      |   6 +-
 drivers/gpu/drm/drm_modes.c            |  10 +-
 drivers/gpu/drm/drm_modeset_helper.c   |   2 +-
 drivers/gpu/drm/drm_pci.c              |  12 +--
 drivers/gpu/drm/drm_plane.c            |  46 +++++-----
 drivers/gpu/drm/drm_probe_helper.c     |  39 ++++----
 drivers/gpu/drm/drm_rect.c             |   4 +-
 drivers/gpu/drm/drm_scatter.c          |  19 ++--
 drivers/gpu/drm/drm_syncobj.c          |   2 +-
 drivers/gpu/drm/drm_sysfs.c            |  22 ++---
 drivers/gpu/drm/drm_vm.c               |  45 +++++----
 include/drm/drm_print.h                |  44 ++++++---
 41 files changed, 486 insertions(+), 435 deletions(-)

--=20
2.35.1


