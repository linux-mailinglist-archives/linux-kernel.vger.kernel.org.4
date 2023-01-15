Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9066AFB5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 08:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAOHTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 02:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjAOHRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 02:17:48 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164FB461
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 23:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673767035; bh=I3+xbeejP+Mpq4K5m4TzJZrSIon4q38AOF3ZpdFrylo=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=IsRjtVNsGDYx+WOWd6j4eCyEdIyigztK7dZmLZbcf8VEXIPNIre0Hid9UvnhbFR47
         95tkI7mlCLsYVn4EZxpB1fAfYzm2CgrrPHB6s3GJDuq3LWN4o4YXENvsuqqyp2W+6t
         RYNc34aizemXPMpsMWbWhGBRZOP9rcCF++N7Q6to=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 15 Jan 2023 08:17:15 +0100 (CET)
X-EA-Auth: i0m5Yh1v59gse93tDhXj0+cVsXlEcluODqey9DktC0Ky9u6sczLwoOHPrya1/xH80c7qkR+ph0gDxQO0Ht4k4uok3OssLyDy
Date:   Sun, 15 Jan 2023 12:47:11 +0530
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
Subject: [PATCH 2/3] drm/amd/pm/powerplay/hwmgr: use bitwise or for bitmasks
 addition
Message-ID: <77f7e23c8a40cbaa72aa92b35e013f43f0952f45.1673766696.git.drv@mailo.com>
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
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 7ef7e81525a3..bf9bcc4e5338 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4153,7 +4153,7 @@ static int smu7_freeze_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 
 	if ((0 == data->sclk_dpm_key_disabled) &&
 		(data->need_update_smu7_dpm_table &
-			(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_UPDATE_SCLK))) {
+			(DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_UPDATE_SCLK))) {
 		PP_ASSERT_WITH_CODE(true == smum_is_dpm_running(hwmgr),
 				"Trying to freeze SCLK DPM when DPM is disabled",
 				);
@@ -4210,7 +4210,7 @@ static int smu7_populate_and_upload_sclk_mclk_dpm_levels(
 	}
 
 	if (data->need_update_smu7_dpm_table &
-			(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_UPDATE_SCLK)) {
+			(DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_UPDATE_SCLK)) {
 		result = smum_populate_all_graphic_levels(hwmgr);
 		PP_ASSERT_WITH_CODE((0 == result),
 				"Failed to populate SCLK during PopulateNewDPMClocksStates Function!",
@@ -4218,7 +4218,7 @@ static int smu7_populate_and_upload_sclk_mclk_dpm_levels(
 	}
 
 	if (data->need_update_smu7_dpm_table &
-			(DPMTABLE_OD_UPDATE_MCLK + DPMTABLE_UPDATE_MCLK)) {
+			(DPMTABLE_OD_UPDATE_MCLK | DPMTABLE_UPDATE_MCLK)) {
 		/*populate MCLK dpm table to SMU7 */
 		result = smum_populate_all_memory_levels(hwmgr);
 		PP_ASSERT_WITH_CODE((0 == result),
@@ -4309,7 +4309,7 @@ static int smu7_unfreeze_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 
 	if ((0 == data->sclk_dpm_key_disabled) &&
 		(data->need_update_smu7_dpm_table &
-		(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_UPDATE_SCLK))) {
+		(DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_UPDATE_SCLK))) {
 
 		PP_ASSERT_WITH_CODE(true == smum_is_dpm_running(hwmgr),
 				"Trying to Unfreeze SCLK DPM when DPM is disabled",
-- 
2.34.1



