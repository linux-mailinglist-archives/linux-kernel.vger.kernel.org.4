Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE56665A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjAKLb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjAKLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:30:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E4ED2FA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:30:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FB9661C44
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E858C433EF;
        Wed, 11 Jan 2023 11:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436644;
        bh=PbvUrZFDDqA/zKZJizBhQHcpk8Qr9JjCk+UTHtD7YcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewFGxEZrPXSDdTzsC5QBHU8HraX6MjPyINJ9nAyCGq07kCKSZDR4oDlB60E/anZW+
         EtvVN5R1EYDR6J1RW17ibZspQ37lj+BKZW1maB3ZRKq5DYu5pllTiPiSGNydbC17nl
         tGGHay/GZ8qsK7cVUkI7wRAfHGDxUJklyN2l7bfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 12/16] drm/mipi-dsi: move to_mipi_dsi_device() to use container_of_const()
Date:   Wed, 11 Jan 2023 12:30:14 +0100
Message-Id: <20230111113018.459199-13-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=gregkh@linuxfoundation.org; h=from:subject; bh=PbvUrZFDDqA/zKZJizBhQHcpk8Qr9JjCk+UTHtD7YcU=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p60iLoutu7+VnGDkPXPlaIP+P5NOnohIMfi3atDNTop 1bNyOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiLfsZFux54/mgYbZmq1N1yp2Sgz ySv+Y2T2SYZ33tTenjYpd/z//sd7QTbj8kFDY/CgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core is changing to pass some pointers as const, so move
to_mipi_dsi_device() to use container_of_const() to handle this change.

to_mipi_dsi_device() now properly keeps the const-ness of the pointer passed
into it, while as before it could be lost.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/drm/drm_mipi_dsi.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 20b21b577dea..56a6557b2f4c 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -197,10 +197,7 @@ struct mipi_dsi_device {
 
 #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
 
-static inline struct mipi_dsi_device *to_mipi_dsi_device(struct device *dev)
-{
-	return container_of(dev, struct mipi_dsi_device, dev);
-}
+#define to_mipi_dsi_device(__dev)	container_of_const(__dev, struct mipi_dsi_device, dev)
 
 /**
  * mipi_dsi_pixel_format_to_bpp - obtain the number of bits per pixel for any
-- 
2.39.0

