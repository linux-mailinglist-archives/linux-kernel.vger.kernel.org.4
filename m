Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93858715220
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjE2Wqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjE2WqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:46:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FF3DC;
        Mon, 29 May 2023 15:46:14 -0700 (PDT)
Received: from workpc.. (109-252-150-34.dynamic.spd-mgts.ru [109.252.150.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9169666059A4;
        Mon, 29 May 2023 23:46:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685400373;
        bh=diSuU8WE+GzMlVnXkaI/r+P2dI6dJeYsLrzxIYvrc1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdNDdM3K2T/HYTvI+BLbQI3D84sMGjiUTjSdI4bAeuzpLzKt1SMz5e5kXEFMJ5w8l
         A1pucO/aXTnm26Ci+YbRAknR+4V0/BLgTQcZpLEBwaV/0jRk/Pdk3bqd4l29lmKFuD
         P3u+em7b2inQ7PxzOxBlxyH4fpFOaymWCok7UjfwamzywV6BtX6DO+DElk3KWupr5E
         UsSOzMJYjlJezA5XUowbceFB+v4v8lolEXIgVpXThjLtAuq2HPpC5Ls7Mo4edPW7gL
         k2EAOMf0ilRNaswDEZo6NZh3WyuMkVdr3uiCJWKz8G0q5B5oljoC6ZwSiOS03HZ4Ds
         HJpO690nOGaig==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v4 3/6] udmabuf: Don't assert held reservation lock for dma-buf mmapping
Date:   Tue, 30 May 2023 01:39:32 +0300
Message-Id: <20230529223935.2672495-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
References: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't assert held dma-buf reservation lock on memory mapping of exported
buffer.

We're going to change dma-buf mmap() locking policy such that exporters
will have to handle the lock. The previous locking policy caused deadlock
problem for DRM drivers in a case of self-imported dma-bufs once these
drivers are moved to use reservation lock universally. The problem is
solved by moving the lock down to exporters. This patch prepares udmabuf
for the locking policy update.

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/dma-buf/udmabuf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 740d6e426ee9..277f1afa9552 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -52,8 +52,6 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
 {
 	struct udmabuf *ubuf = buf->priv;
 
-	dma_resv_assert_held(buf->resv);
-
 	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-- 
2.40.1

