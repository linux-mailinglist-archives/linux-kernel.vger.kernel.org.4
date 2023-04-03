Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB46D4560
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjDCNMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjDCNMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:12:14 -0400
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A92D45
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:11:55 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 02F3B102390;
        Mon,  3 Apr 2023 16:11:52 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id F19EE102391;
        Mon,  3 Apr 2023 16:11:01 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.53.223])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 333DAwDL024350;
        Mon, 3 Apr 2023 16:10:58 +0300
From:   Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To:     David Airlie <airlied@gmail.com>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] drm/amd/display: Fix potential null dereference
Date:   Mon,  3 Apr 2023 16:10:37 +0300
Message-Id: <20230403131037.1912215-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230403 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adev->dm.dc pointer can be NULL and dereferenced in amdgpu_dm_fini()
without checking.

Add a NULL pointer check before calling dc_dmub_srv_destroy(). 

Found by Linux Verification Center (linuxtesting.org) with SVACE. 

Fixes: 9a71c7d31734 ("drm/amd/display: Register DMUB service with DC")
Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a01fd41643fc..27f7a554874e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1854,7 +1854,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
 
-	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
+	if (adev->dm.dc)
+		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 
 	if (dc_enable_dmub_notifications(adev->dm.dc)) {
 		kfree(adev->dm.dmub_notify);
-- 
2.30.2

