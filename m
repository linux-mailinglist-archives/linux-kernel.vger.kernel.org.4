Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2D566E41D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAQQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjAQQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:53:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E8B3A846
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:53:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83F4EB81912
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCF6C433EF;
        Tue, 17 Jan 2023 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673974383;
        bh=sjHnLfZeTv9osDceNwp3J0deH6tLLJyX+qHIX4MFm24=;
        h=From:To:Cc:Subject:Date:From;
        b=H+4dXZAoInFEP1VyT8Lgd9naMxssr2v64AkJXNrV5A/4RhjWllNTOhpTXNPvYt/OU
         NZZh5lRbpCLLrRJk6phh2EcWvucKrBUmJlZy/9o6w8Io+7nnu941LPUB6AjGV77kLO
         TdJAByFqPBvpjsuSlBKMoFYA3YqQ0Z+M8wJv9tjjFxZUWOp4sZ+IN1ab+KXyLP1U+R
         8KIZBnsZ2oyED8du9Td//Fw+zH3FW331/hyiTnqCyfHprprH1obmJitSUAhl4G2tRu
         zt8G70niwDO2rHQdtI3frtpRoi+LAuluCqGTb6gD9oK6iXnkFEjZafTju2xAVEPwRm
         0JObmsx/xgFMQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vc4: fix build failure in vc4_dsi_dev_probe()
Date:   Tue, 17 Jan 2023 17:52:51 +0100
Message-Id: <20230117165258.1979922-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The bridge->of_node field is defined inside of an #ifdef, which
results in a build failure when compile-testing the vc4_dsi driver
without CONFIG_OF:

drivers/gpu/drm/vc4/vc4_dsi.c: In function 'vc4_dsi_dev_probe':
drivers/gpu/drm/vc4/vc4_dsi.c:1822:20: error: 'struct drm_bridge' has no member named 'of_node'
 1822 |         dsi->bridge.of_node = dev->of_node;

Add another #ifdef in the place it is used in. Alternatively we
could consider dropping the #ifdef in the struct definition
and all other users.

Fixes: 78df640394cd ("drm/vc4: dsi: Convert to using a bridge instead of encoder")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 2a71321b9222..a5c075f802e4 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1819,7 +1819,9 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
 
 	dsi->pdev = pdev;
 	dsi->bridge.funcs = &vc4_dsi_bridge_funcs;
+#ifdef CONFIG_OF
 	dsi->bridge.of_node = dev->of_node;
+#endif
 	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
 	dsi->dsi_host.ops = &vc4_dsi_host_ops;
 	dsi->dsi_host.dev = dev;
-- 
2.39.0

