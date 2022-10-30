Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CD4612B4D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 16:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJ3PpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 11:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJ3Pox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 11:44:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A03B1DE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 08:44:53 -0700 (PDT)
Received: from dimapc.. (unknown [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E00E066022A2;
        Sun, 30 Oct 2022 15:44:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667144691;
        bh=Jr+CDx/FOmbAS4EXsPeToboJf/vzEdDZoQONhOc44DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D77hkyxoateNQYLF7wJaHR+9csvedoBuzF1VEUTMenUkMjtdSeyXUAhgE0j4RXuLL
         Linbwa8HPzpUigLIVoxs7LY25ZnDHWu77L1e1Q7YGyXwmOKgD3BcSzOhrRNW06qo8h
         vIMEKpXsMe8QU+z9CDPFk7/fR+FFtgzo3b4+FJjHQYU9K1kXH8ISUBV8sOjaF86c1g
         oPB4Zkj4zO4tGmixIgmZ0m4jNShlzyv6vRfkWt4KlbW+uX+eJypQ916ceOZdx6DhKc
         dbOzHIpE1tWqNwSK2G/EjpcU6QwFq2DrhD7r7oTmaWUaCYVeTLqy3SkZoLn2Oi//WB
         i4qutZJMPkWVA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, noralf@tronnes.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/client: Prevent NULL dereference in drm_client_buffer_delete()
Date:   Sun, 30 Oct 2022 18:44:12 +0300
Message-Id: <20221030154412.8320-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030154412.8320-1-dmitry.osipenko@collabora.com>
References: <20221030154412.8320-1-dmitry.osipenko@collabora.com>
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

The drm_gem_vunmap() will crash with a NULL dereference if the passed
object pointer is NULL. It wasn't a problem before we added the locking
support to drm_gem_vunmap function because the mapping argument was always
NULL together with the object. Make drm_client_buffer_delete() to check
whether GEM is NULL before trying to unmap the GEM, it will happen on
framebuffer creation error.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/dri-devel/Y1kFEGxT8MVlf32V@kili/
Fixes: 79e2cf2e7a19 ("drm/gem: Take reservation lock for vmap/vunmap operations")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 38e1be991caa..fd67efe37c63 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -235,10 +235,10 @@ static void drm_client_buffer_delete(struct drm_client_buffer *buffer)
 {
 	struct drm_device *dev = buffer->client->dev;
 
-	drm_gem_vunmap_unlocked(buffer->gem, &buffer->map);
-
-	if (buffer->gem)
+	if (buffer->gem) {
+		drm_gem_vunmap_unlocked(buffer->gem, &buffer->map);
 		drm_gem_object_put(buffer->gem);
+	}
 
 	if (buffer->handle)
 		drm_mode_destroy_dumb(dev, buffer->handle, buffer->client->file);
-- 
2.37.3

