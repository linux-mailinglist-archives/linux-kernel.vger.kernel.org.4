Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD0672D97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjASAnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjASAnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:43:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48659E6F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:43:00 -0800 (PST)
Received: from workpc.. (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B0DF6600864;
        Thu, 19 Jan 2023 00:42:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674088979;
        bh=y/gY+85NjTLhBn5wfhTsCF0KzUxBtwU+VsZUtinaWsM=;
        h=From:To:Cc:Subject:Date:From;
        b=ObxgNy00VQe6VFaTDvpux7dxn/S4GD77rvxR7sS5Kl5tbMGHTm3GhoMxKkBScly1c
         nOb27Ks5sppviP4L443OpFtU/LGRlu+dATKoB8MHGEjf9YTWtpoBUrkhBBSYs2RW/G
         jfVwThzYeCF1fnRGj2PQ2Muu3I+M14Agqv4O2Bd5/8HlZEMMaZIMAEaU1T8onGaail
         jDzVfbiMHjzhTiGxKW0wLp7/c4SscuXyM8dJq8hLH0SHQfvKUE6E0+thKYxM0NKJhL
         KkTYqe00PP9H1Io1r3ldlWcXopbCI3UVFJFbCbYawqcS3tkRcIGATyyvxA3sKPG09U
         mgFx5X8ef3VPQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v1 0/1] Add sync object UAPI support to VirtIO-GPU driver
Date:   Thu, 19 Jan 2023 03:41:42 +0300
Message-Id: <20230119004143.968942-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have multiple Vulkan context types that are awaiting for the addition
of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:

 1. Venus context
 2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)

Mesa core supports DRM sync object UAPI, providing Vulkan drivers with a
generic fencing implementation that we want to utilize.

This patch adds initial sync objects support. It creates fundament for a
further fencing improvements. Later on we will want to extend the VirtIO-GPU
fencing API with passing fence IDs to host for waiting, it will be a new
additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU context
drivers in works that require VirtIO-GPU to support sync objects UAPI.

The patch is heavily inspired by the sync object UAPI implementation of the
MSM driver.

Dmitry Osipenko (1):
  drm/virtio: Support sync objects

 drivers/gpu/drm/virtio/virtgpu_drv.c   |   3 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 223 ++++++++++++++++++++++++-
 include/uapi/drm/virtgpu_drm.h         |  16 +-
 3 files changed, 239 insertions(+), 3 deletions(-)

-- 
2.39.0

