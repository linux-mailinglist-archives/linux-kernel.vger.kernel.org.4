Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B426B378D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjCJHlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCJHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:40:24 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062ACF8647
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:40:11 -0800 (PST)
X-UUID: bfaf3b3b4df0410c8d7f35f284529c16-20230310
X-CPASD-INFO: 9d00fa27f33d41c298fadc8022794e1a@grRqUJOTYGeSU3Wwg3SubFlpmo2Esnp
        qUmJlaWCFhrOMbFJkYl1SgIFqVmprYmBZUHt1bFZgYGJdUXh3lHKPVGBeYIJUdJOAe55QYZSR
X-CLOUD-ID: 9d00fa27f33d41c298fadc8022794e1a
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:196.
        0,ESV:0.0,ECOM:-5.0,ML:14.0,FD:0.0,CUTS:112.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-
        5.0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:1.0,SPC:0,SIG:
        -5,AUF:7,DUF:17729,ACD:257,DCD:257,SL:0,EISP:0,AG:0,CFC:0.319,CFSR:0.082,UAT:
        0,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM
        :0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: bfaf3b3b4df0410c8d7f35f284529c16-20230310
X-CPASD-BLOCK: 14
X-CPASD-STAGE: 1
X-UUID: bfaf3b3b4df0410c8d7f35f284529c16-20230310
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1495147978; Fri, 10 Mar 2023 15:40:09 +0800
From:   Zhenneng Li <lizhenneng@kylinos.cn>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhenneng Li <lizhenneng@kylinos.cn>
Subject: [PATCH] drm/amdgpu: resove reboot exception for si oland
Date:   Fri, 10 Mar 2023 15:39:59 +0800
Message-Id: <20230310074000.2078124-1-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During reboot test on arm64 platform, it may failure
on boot.

The error message are as follows:
[    6.996395][ 7] [  T295] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR*
			    late_init of IP block <si_dpm> failed -22
[    7.006919][ 7] [  T295] amdgpu 0000:04:00.0: amdgpu_device_ip_late_init failed
[    7.014224][ 7] [  T295] amdgpu 0000:04:00.0: Fatal error during GPU init
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index d6d9e3b1b2c0..dee51c757ac0 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7632,9 +7632,6 @@ static int si_dpm_late_init(void *handle)
 	if (!adev->pm.dpm_enabled)
 		return 0;
 
-	ret = si_set_temperature_range(adev);
-	if (ret)
-		return ret;
 #if 0 //TODO ?
 	si_dpm_powergate_uvd(adev, true);
 #endif
-- 
2.25.1

