Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26D9656486
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiLZSME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 13:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiLZSLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 13:11:40 -0500
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C582218B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 10:11:35 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 26 Dec
 2022 21:10:28 +0300
Received: from localhost (10.0.253.157) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Dec
 2022 21:10:28 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Alex Deucher <alexander.deucher@amd.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/radeon: Fix potential null-ptr-deref
Date:   Mon, 26 Dec 2022 10:10:23 -0800
Message-ID: <20221226181023.86196-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.157]
X-ClientProxiedBy: Ex16-01.fintech.ru (10.0.10.18) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

radeon_get_connector_for_encoder() assigns radeon_encoder->enc_priv to
mst_enc which is dereferenced later without being checked for NULL
beforehand. It is possible for radeon_encoder->enc_priv and therefore
mst_enc, to be NULL due to potential lack of memory.

This patch adds a sanity NULL-check to prevent the issue.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9843ead08f18 ("drm/radeon: add DisplayPort MST support (v2)")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/radeon/radeon_encoders.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
index 46549d5179ee..3f68f0af443a 100644
--- a/drivers/gpu/drm/radeon/radeon_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_encoders.c
@@ -251,6 +251,9 @@ radeon_get_connector_for_encoder(struct drm_encoder *encoder)
 				continue;
 
 			mst_enc = radeon_encoder->enc_priv;
+			if (!mst_enc)
+				return NULL;
+
 			if (mst_enc->connector == radeon_connector->mst_port)
 				return connector;
 		} else if (radeon_encoder->active_device & radeon_connector->devices)
-- 
2.25.1

