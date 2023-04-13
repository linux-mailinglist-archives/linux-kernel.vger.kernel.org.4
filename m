Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE06E0C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDMLNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDMLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE86183
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5092F611EF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4756AC433EF;
        Thu, 13 Apr 2023 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681384376;
        bh=4VkW1+23Lm1d+I+PifbrLvyuCj+NZ7vdD2QP9Uyn9NE=;
        h=From:To:Cc:Subject:Date:From;
        b=sQInOiqfc3Or7ClBdvXEMdSjp3hBfxTBwzHxD4aM2vVbz/JuaSGuD0B/f5imgRWG8
         TzlntPxLhaJ8q5Ve0FIGZVCmQL/Q+WL67Vyckotzxfi61o3ZnjMjUCk6MTOCDO9AaD
         jg1pQourlDe1LlHUupWzwiDBmB1cBMsCcU3HNdG/ZlkDercA0c8vwZwbARnOAYjImx
         c+phH/xw2+FTblCPOZ7prUmr0eeDkU5csYjTRW08CK8IHc0PQ08nruKWGtPgJWTUz/
         ebRdENkYtgHUi3aC95FRAQkrR60CybTQjVvlBtXOeg38hjhbUoywhneM0ly/vftMgw
         X8giehzGLXrqA==
From:   Jeff Layton <jlayton@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: make drm_dp_add_payload_part2 gracefully handle NULL state pointer
Date:   Thu, 13 Apr 2023 07:12:54 -0400
Message-Id: <20230413111254.22458-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing some intermittent crashes down in the display
driver code. The symptoms are ususally a line like this in dmesg:

    amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 000000006d3a3885: -5

...followed by an Oops due to a NULL pointer dereference.

The real bug is probably in the caller of this function, which is
passing it a NULL state pointer, but this patch at least keeps my
machine from oopsing when this occurs.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2184855
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 38dab76ae69e..87ad406c50f9 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3404,7 +3404,8 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
 
 	/* Skip failed payloads */
 	if (payload->vc_start_slot == -1) {
-		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
+		drm_dbg_kms(state ? state->dev : NULL,
+			    "Part 1 of payload creation for %s failed, skipping part 2\n",
 			    payload->port->connector->name);
 		return -EIO;
 	}
-- 
2.39.2

