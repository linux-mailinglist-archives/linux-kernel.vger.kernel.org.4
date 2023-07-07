Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BDB74B6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjGGTJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjGGTJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:09:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616912A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:09:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31441bc0092so2217017f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688756947; x=1691348947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhjADJtp0nquqcDpxB6UxubGora2hMOTttGWENjgrAs=;
        b=ZVNe//Rm/YVC1n2rYGKZu9ldb0uovlvi1jqqMcAkPPRguMRiggz+vs3MgrGCItV3VY
         dtBocLUcoapGmuutOoDiHOU1bhT645gaFeMxvnQYEIavJA92bYTIG/GiYPtjg5ngvCzZ
         0hlPTW1iy26/7Ju2xQg5MdSCJZnkhxigU8C6KYIIXHdRAnfqRjBvvu3tetIzXem/PVf0
         bQU0okiB4DF01+Di6m4noXn4eejU69CXRBpljkuwvxzbAYZ47q7nRFTEFwVHFcBaRhwW
         O81MBgT2STQWm18zha7jFGUu9f0NPrU/upiCKoNRqDFPNUcB2oAFOuTBqu4gEHYFIFBn
         nJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688756947; x=1691348947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhjADJtp0nquqcDpxB6UxubGora2hMOTttGWENjgrAs=;
        b=WyRPUPsgpl/TqeTtdIbKUDX5inCaPXdgv/EEyNr/emOE9oJ7jMofJ+R24ReJViDA5I
         rkqFEbGncKrO4/gJ+CBXs5sXz+BDwckw7Z0LiopFjBleSyS13F1o3YFQS0i9pLo8TnM5
         O4q62A69Z6f8OhYqZR/R+gMdd3LDMnzh+xuix1Y+B7Fyz1Njrpnoo+i7XWEwR/xTaioF
         hbAP5vXxpZL5AVPw5FG/dCDXFpOLnyHl8A4VGeUbOLz5Y655PH/E6CpiZvWSHZFLv/ex
         Spq3bS+C4hAmb7fsl6CO3zBTupERZZTGn8q0ZOD/nh3THTE+P0aY4n0R70g8P+l14vLu
         o28A==
X-Gm-Message-State: ABy/qLbGKVYUJOkGxKdM97b0lYwVcZdymarG7vAdrn9WKAbtf7/9r23P
        jCMzbcDLFI73qM4pNdE4638=
X-Google-Smtp-Source: APBJJlHm1ZY+TFebf1Am1eya9vkNuRMCMc4ssUAXvLg9CDO+pLeZ4dlirNOk4QNRemU0RE4LXyVXCQ==
X-Received: by 2002:a5d:4288:0:b0:314:5f4a:5a63 with SMTP id k8-20020a5d4288000000b003145f4a5a63mr2893630wrq.54.1688756946996;
        Fri, 07 Jul 2023 12:09:06 -0700 (PDT)
Received: from localhost.localdomain (public-nat-01.vpngate.v4.open.ad.jp. [219.100.37.233])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d6187000000b00301a351a8d6sm5114483wru.84.2023.07.07.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 12:09:06 -0700 (PDT)
From:   Vladimir Lypak <vladimir.lypak@gmail.com>
To:     Vladimir Lypak <vladimir.lypak@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/bridge: Fix handling of bridges with pre_enable_prev_first flag
Date:   Fri,  7 Jul 2023 22:00:19 +0300
Message-ID: <20230707190020.6280-2-vladimir.lypak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function drm_atomic_bridge_chain_post_disable handling of
pre_enable_prev_first flag is broken because "next" variable will always
end up set to value of "bridge". This breaks loop which should disable
bridges in reverse:

 next = list_next_entry(bridge, chain_node);

 if (next->pre_enable_prev_first) {
        /* next bridge had requested that prev
         * was enabled first, so disabled last
         */
        limit = next;

        /* Find the next bridge that has NOT requested
         * prev to be enabled first / disabled last
         */
        list_for_each_entry_from(next, &encoder->bridge_chain,
                                 chain_node) {
// Next condition is always true. It is likely meant to be inversed
// according to comment above. But doing this uncovers another problem:
// it won't work if there are few bridges with this flag set at the end.
                if (next->pre_enable_prev_first) {
                        next = list_prev_entry(next, chain_node);
                        limit = next;
// Here we always set next = limit = branch at first iteration.
                        break;
                }
        }

        /* Call these bridges in reverse order */
        list_for_each_entry_from_reverse(next, &encoder->bridge_chain,
                                         chain_node) {
// This loop never executes past this branch.
                if (next == bridge)
                        break;

                drm_atomic_bridge_call_post_disable(next, old_state);

In this patch logic for handling the flag is simplified. Temporary
"iter" variable is introduced instead of "next" which is used only
inside inner loops.

Fixes: 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init order")
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
 drivers/gpu/drm/drm_bridge.c | 46 ++++++++++++++----------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c3d69af02e79..7a5b39a46325 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -660,7 +660,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 					  struct drm_atomic_state *old_state)
 {
 	struct drm_encoder *encoder;
-	struct drm_bridge *next, *limit;
+	struct drm_bridge *iter, *limit;
 
 	if (!bridge)
 		return;
@@ -670,36 +670,26 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
 		limit = NULL;
 
-		if (!list_is_last(&bridge->chain_node, &encoder->bridge_chain)) {
-			next = list_next_entry(bridge, chain_node);
-
-			if (next->pre_enable_prev_first) {
-				/* next bridge had requested that prev
-				 * was enabled first, so disabled last
-				 */
-				limit = next;
-
-				/* Find the next bridge that has NOT requested
-				 * prev to be enabled first / disabled last
-				 */
-				list_for_each_entry_from(next, &encoder->bridge_chain,
-							 chain_node) {
-					if (next->pre_enable_prev_first) {
-						next = list_prev_entry(next, chain_node);
-						limit = next;
-						break;
-					}
-				}
+		/* Find sequence of bridges (bridge, limit] which requested prev to
+		 * be enabled first and disabled last
+		 */
+		iter = list_next_entry(bridge, chain_node);
+		list_for_each_entry_from(iter, &encoder->bridge_chain, chain_node) {
+			if (!iter->pre_enable_prev_first)
+				break;
+
+			limit = iter;
+		}
 
-				/* Call these bridges in reverse order */
-				list_for_each_entry_from_reverse(next, &encoder->bridge_chain,
-								 chain_node) {
-					if (next == bridge)
-						break;
-
-					drm_atomic_bridge_call_post_disable(next,
-									    old_state);
-				}
+		if (limit) {
+			/* Call these bridges in reverse order */
+			iter = limit;
+			list_for_each_entry_from_reverse(iter,
+					&encoder->bridge_chain, chain_node) {
+				if (iter == bridge)
+					break;
+
+				drm_atomic_bridge_call_post_disable(iter, old_state);
 			}
 		}
 
-- 
2.41.0

