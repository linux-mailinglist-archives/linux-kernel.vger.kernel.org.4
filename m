Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49E26563E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiLZPvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLZPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:51:40 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC0BB0C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rma/6l23MS9C4FR5JDIPAjsfEzUFpsYwj7pYGeckqyo=; b=N5x3iBtzXoyvQoAR35OI3Lak1V
        g1KpUISJgC/cu2CU0L4i4Bplx4TDUC4iUN6Nox34Ql+sdCnZTVENxHDR0/r/kx73mrD190tdSCeRD
        jsF7/CA4saUhR1oaHHYntVBKLDSpp6SDMY/9c5HttH+DhKaSSegI2FeemZHGRbmQssreMfzuLiDxV
        TTB2BIkkts0BOupsJuTeMWXyFIeNf+04E59YlDZNEro9fooelnmwBfIxiCVT5HK2+L2zKKRyH85X1
        DOssx2aN4IyDazepUffDc23GhGVsFPSR0qtDHjFsnNksmRJS7Kb+IdHLsT8NYL9wNt4O3hhKCnlus
        0CBOJ3Sg==;
Received: from [187.36.234.139] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1p9plB-00AXBr-0X; Mon, 26 Dec 2022 16:51:29 +0100
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
Subject: [PATCH 0/9] Convert drivers to the new debugfs device-centered functions
Date:   Mon, 26 Dec 2022 12:50:20 -0300
Message-Id: <20221226155029.244355-1-mcanal@igalia.com>
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

The commit 1c9cacbea880 ("drm/debugfs: create device-centered debugfs functions")
introduced new device-centered debugfs functions, which center the debugfs files
management on the drm_device instead of drm_minor. Therefore, this patchset
converts 8 drivers to this new debugfs device-centered structure as it was already
performed on the vc4 (f2ede40e46e8), v3d (c0dda238e264), and vkms (03d2673bb757)
drivers.

Best Regards,
- Maíra Canal

Maíra Canal (9):
  drm/etnaviv: use new debugfs device-centered functions
  drm/gud: use new debugfs device-centered functions
  drm/arm/hdlcd: use new debugfs device-centered functions
  drm/pl111: use new debugfs device-centered functions
  drm/arc: use new debugfs device-centered functions
  drm/virtio: use new debugfs device-centered functions
  drm/omap: use new debugfs device-centered functions
  drm/qxl: remove unused debugfs structure
  drm/qxl: use new debugfs device-centered functions

 drivers/gpu/drm/arm/hdlcd_drv.c          | 24 +++++-------
 drivers/gpu/drm/etnaviv/etnaviv_drv.c    | 29 ++++++---------
 drivers/gpu/drm/gud/gud_drv.c            | 17 ++-------
 drivers/gpu/drm/omapdrm/omap_debugfs.c   | 29 +++++----------
 drivers/gpu/drm/omapdrm/omap_drv.c       |  7 ++--
 drivers/gpu/drm/omapdrm/omap_drv.h       |  2 +-
 drivers/gpu/drm/pl111/pl111_debugfs.c    | 15 ++------
 drivers/gpu/drm/pl111/pl111_drm.h        |  2 +-
 drivers/gpu/drm/pl111/pl111_drv.c        |  6 +--
 drivers/gpu/drm/qxl/qxl_debugfs.c        | 47 ++++--------------------
 drivers/gpu/drm/qxl/qxl_drv.c            |  5 +--
 drivers/gpu/drm/qxl/qxl_drv.h            | 22 +----------
 drivers/gpu/drm/tiny/arcpgu.c            | 22 +++--------
 drivers/gpu/drm/virtio/virtgpu_debugfs.c | 17 ++++-----
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  5 +--
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  2 +-
 16 files changed, 74 insertions(+), 177 deletions(-)

-- 
2.38.1

