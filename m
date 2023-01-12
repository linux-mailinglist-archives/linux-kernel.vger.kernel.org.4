Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1646667398
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjALNwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjALNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:51:49 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C870517F2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673531496; bh=ZAn7ZSvuny3A40ep6L1C3DqFhwPZfavNHTKFbfUsRxU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=hsLsYzmBjETINLz1Ja9/z1RFZVcBYUbHn7a9lGQeWWxVIR2aOvEaCHM3hW/0vW3Wg
         4uQveX+YjNjCQ7FeCzMA0owVm4zZaIibEUhv69J8B1+mduCsJuL/r6IvseMXRAIcLL
         UKBbH2XziNiSDioZE0ffoofCAATDAKel1aRhBse4=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 12 Jan 2023 14:51:36 +0100 (CET)
X-EA-Auth: Jql7kLVBTRErAY5Y8kPmRih3iDlhh+Av3Q2tRc5pWKa4/h+rUuSd4pAfiyzp58G/Z7umku8+u+IV1WMtssm9vCSzWYHyaSk2
Date:   Thu, 12 Jan 2023 19:21:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] drm/amd/display: Conversion to bool not necessary
Message-ID: <Y8AQYhVkJjV86VXV@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A logical evaluation already results in bool. There is no need for using
a ternary operator based evaluation and bool conversion of the outcome.
Issue identified using boolconv.cocci Coccinelle semantic patch.
This was also reported by the Kernel Test Robot. Hence

Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 22125daf9dcf..1e39d0939700 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -105,8 +105,7 @@ static void vblank_control_worker(struct work_struct *work)
 	else if (dm->active_vblank_irq_count)
 		dm->active_vblank_irq_count--;
 
-	dc_allow_idle_optimizations(
-		dm->dc, dm->active_vblank_irq_count == 0 ? true : false);
+	dc_allow_idle_optimizations(dm->dc, dm->active_vblank_irq_count == 0);
 
 	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
 
-- 
2.34.1



