Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED6644002
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiLFJnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiLFJnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:43:06 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832F71B7B6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:43:05 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1670319783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2JW7gMUzxibRP+GHgK8qpM96Hq/qafYCWCOIJkhoC7M=;
        b=KcIUWuiXVk3IwtwMxtT4aKYFQWrP40qyqqpg2MzjWGXlOH5h4Ki6IJFYZwiw3CdyRUAfCh
        Hj7szKU7U4WTUVGpe7sjngFjwdCUceZeH1goOOJxa4X6qS+v2qn2BDqhEOHBWkwKswyRI3
        /R1GIXHBdNITD2NXoZafkI1oXpCXSFQ=
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Roman Li <roman.li@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: 
Date:   Tue,  6 Dec 2022 12:43:03 +0300
Message-Id: <20221206094303.29282-1-arefev@swemel.ru>
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

Date: Thu, 10 Nov 2022 16:47:26 +0300
Subject: [PATCH] drm/amdgpu/display: Add pointer check

Return value of a function 'dc_create_state' is
dereferenced at amdgpu_dm.c:2027 without checking for null

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0f7749e9424d..529483997154 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1960,7 +1960,9 @@ static int dm_resume(void *handle)
 	dc_release_state(dm_state->context);
 	dm_state->context = dc_create_state(dm->dc);
 	/* TODO: Remove dc_state->dccg, use dc->dccg directly. */
-	dc_resource_state_construct(dm->dc, dm_state->context);
+	if (dm_state->context) {
+		dc_resource_state_construct(dm->dc, dm_state->context);
+	}
 
 	/* Before powering on DC we need to re-initialize DMUB. */
 	r = dm_dmub_hw_init(adev);
-- 
2.25.1

