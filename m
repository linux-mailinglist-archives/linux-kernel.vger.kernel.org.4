Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150BE74B998
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGGWl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjGGWlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:41:25 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E52123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/xdpnaJnTHtg5FSHdCoDQS8EallIvgOjIsBWKl9/fjk=; b=QYDDLzhIB0GVmvqlbo4ICBgXwm
        S1qC68aLZyknYycWCrl0qwwIiLMxRRxOmQVR64lG1sLEGjxWMosbPYlp2LjFPK5wq/O7dBmxoOShv
        Ei7iR9tlPvjyEeVTAizwz1g/Egv2Eu93E1m+Ryj7LVN1SQUO2c7HwO5hewlglfI8BvWI3XPdk9Fpv
        qV9dDlP6VJiqM5R+FJRFywYJny/k8HgL5DzfWFUzhrP0nZeJ8GZvN72sqc8mghlctnUVDoJ+WeDpj
        YYVmYpuNZ9NGFL6Hdiz9RctwUgiGtTeHnHKe4eE4lYtf9+hDmUcq5ImnHbT381ZUtRnp1sFEx7ZZI
        rri8D0fA==;
Received: from [187.74.70.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qHu8W-00AP6e-GO; Sat, 08 Jul 2023 00:41:12 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 0/6] drm: Add support for atomic async page-flip
Date:   Fri,  7 Jul 2023 19:40:53 -0300
Message-ID: <20230707224059.305474-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This work from me and Simon adds support for DRM_MODE_PAGE_FLIP_ASYNC through
the atomic API. This feature is already available via the legacy API. The use
case is to be able to present a new frame immediately (or as soon as
possible), even if after missing a vblank. This might result in tearing, but
it's useful when a high framerate is desired, such as for gaming.

Differently from earlier versions, this one refuses to flip if any prop changes
for async flips. The idea is that the fast path of immediate page flips doesn't
play well with modeset changes, so only the fb_id can be changed. The exception
is for mode_id changes, that might be referring to an identical mode (which
would skip a modeset). This is done to make the async API more similar to the
normal API.

Thanks,
	André

- User-space patch: https://github.com/Plagman/gamescope/pull/595
- IGT tests: https://gitlab.freedesktop.org/andrealmeid/igt-gpu-tools/-/tree/atomic_async_page_flip

Changes from v4:
 - Documentation rewrote by Pekka Paalanen

v4: https://lore.kernel.org/dri-devel/20230701020917.143394-1-andrealmeid@igalia.com/

Changes from v3:
 - Add new patch to reject prop changes
 - Add a documentation clarifying the KMS atomic state set

v3: https://lore.kernel.org/dri-devel/20220929184307.258331-1-contact@emersion.fr/

André Almeida (1):
  drm: Refuse to async flip with atomic prop changes

Pekka Paalanen (1):
  drm/doc: Define KMS atomic state set

Simon Ser (4):
  drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic commits
  drm: introduce DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP
  drm: introduce drm_mode_config.atomic_async_page_flip_not_supported
  amd/display: indicate support for atomic async page-flips on DC

 Documentation/gpu/drm-uapi.rst               | 41 ++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c |  1 +
 drivers/gpu/drm/drm_atomic_helper.c          |  5 ++
 drivers/gpu/drm/drm_atomic_uapi.c            | 80 ++++++++++++++++++--
 drivers/gpu/drm/drm_crtc_internal.h          |  2 +-
 drivers/gpu/drm/drm_ioctl.c                  |  5 ++
 drivers/gpu/drm/drm_mode_object.c            |  2 +-
 drivers/gpu/drm/i915/display/intel_display.c |  1 +
 drivers/gpu/drm/nouveau/nouveau_display.c    |  1 +
 include/drm/drm_mode_config.h                | 11 +++
 include/uapi/drm/drm.h                       | 10 ++-
 include/uapi/drm/drm_mode.h                  |  9 +++
 12 files changed, 159 insertions(+), 9 deletions(-)

-- 
2.41.0

