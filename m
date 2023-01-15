Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B266AFB2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 08:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAOHSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 02:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjAOHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 02:17:05 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC25B464
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 23:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673767007; bh=+fQITG3zFSx+3AQZJEQdW3kgJY9FXR6AQ5P5BGfD2f0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=LpJYY7WRGDZodMaM42Nvvqcb2MZktoqZz+wtt4XW7KBZiD1VUwc4IzgbJOvnTvcf/
         QPZfZcbt9uq3rLkD6qTMS7gSQHXGwfHl0ljBiDiUuRsqlHR8h0WZ19QOHRqt8Kj8gn
         TBlQHS+QRDAIKTJOd/VQCmKw1Z5fO2zlXm/gbk0A=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 15 Jan 2023 08:16:47 +0100 (CET)
X-EA-Auth: TgOkwxa4yz4MbR4/OVAaqXgSCIUEw7Eb+uea7TiQJukxZ6pfKqePsPmuSldH7seB5/nw1+KkWUkNpqZu4IcfmodnAMEIlYgN
Date:   Sun, 15 Jan 2023 12:46:43 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH 1/3] drm/amd/pm/powerplay/smumgr: use bitwise or for addition
Message-ID: <b1cceaacb32bd2a72ac4d8e12a04da3f78e8c41c.1673766696.git.drv@mailo.com>
References: <cover.1673766696.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673766696.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For bit mask addition, it is recommended to use or operator "|" instead
of numerical addition as the former is quicker and cleaner. Change
suggested by orplus.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 03df35dee8ba..060fc140c574 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -2165,7 +2165,7 @@ static int iceland_program_mem_timing_parameters(struct pp_hwmgr *hwmgr)
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
 	if (data->need_update_smu7_dpm_table &
-		(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_OD_UPDATE_MCLK))
+		(DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_OD_UPDATE_MCLK))
 		return iceland_program_memory_timing_parameters(hwmgr);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
index 04b561f5d932..acbe41174d7e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
@@ -2554,7 +2554,7 @@ static int tonga_program_mem_timing_parameters(struct pp_hwmgr *hwmgr)
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
 	if (data->need_update_smu7_dpm_table &
-		(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_OD_UPDATE_MCLK))
+		(DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_OD_UPDATE_MCLK))
 		return tonga_program_memory_timing_parameters(hwmgr);
 
 	return 0;
-- 
2.34.1



