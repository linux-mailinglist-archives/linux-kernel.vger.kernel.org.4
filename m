Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DDE64DEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiLOQhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiLOQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:37:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4091EAFF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:36:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAD3DB81C03
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07826C433EF;
        Thu, 15 Dec 2022 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122216;
        bh=ZJ+UjuFlAHEeqnv1r+X8Y1fN3lyrw6ECR6xLRaAEqRs=;
        h=From:To:Cc:Subject:Date:From;
        b=s/ZJp7C9+lCHF8eafSYx+Wl0LjwFFtKVRaeM6VE62PEFslr7gD0rOlWNHK8Q9aO/u
         IJOYYYtArmR9K6dhMjAmuTjXMsFNnBg6W3wep8Co6lTtLQsYIKH3u2M6AbVbY7jja2
         ZVQ9NHhLpZr+PjJGuKeDYs1dCR8BIWWjsHfX83awoSjiyEEmswpWr0EnvUAcS+omvL
         Nb3YMtjm36x6088xcboN9A1ic9ArjNsJMSPpirfuQlZeJ/gwe5CfmJl9tS1pu5EmB/
         B7u2G1o0fLIXH1ssDwvxusBqB/+lI+ZZD4jDgJZVsnS2bfDHZW/5RkG/5AOPrG0eLM
         PNwp9/RZx9cTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kenneth Feng <kenneth.feng@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Yang Wang <KevinYang.Wang@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] drm/amd/pm: avoid large variable on kernel stack
Date:   Thu, 15 Dec 2022 17:36:31 +0100
Message-Id: <20221215163649.386750-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The activity_monitor_external[] array is too big to fit on the
kernel stack, resulting in this warning with clang:

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1438:12: error: stack frame size (1040) exceeds limit (1024) in 'smu_v13_0_7_get_power_profile_mode' [-Werror,-Wframe-larger-than]

Use dynamic allocation instead. It should also be possible to
have single element here instead of the array, but this seems
easier.

Fixes: 334682ae8151 ("drm/amd/pm: enable workload type change on smu_v13_0_7")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c270f94a1b86..7eba854e09ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1439,7 +1439,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 
 static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
-	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external[PP_SMC_POWER_PROFILE_COUNT];
+	DpmActivityMonitorCoeffIntExternal_t *activity_monitor_external;
 	uint32_t i, j, size = 0;
 	int16_t workload_type = 0;
 	int result = 0;
@@ -1447,6 +1447,12 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 	if (!buf)
 		return -EINVAL;
 
+	activity_monitor_external = kcalloc(sizeof(activity_monitor_external),
+					    PP_SMC_POWER_PROFILE_COUNT,
+					    GFP_KERNEL);
+	if (!activity_monitor_external)
+		return -ENOMEM;
+
 	size += sysfs_emit_at(buf, size, "                              ");
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
 		size += sysfs_emit_at(buf, size, "%-14s%s", amdgpu_pp_profile_name[i],
@@ -1459,15 +1465,17 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       i);
-		if (workload_type < 0)
-			return -EINVAL;
+		if (workload_type < 0) {
+			result = -EINVAL;
+			goto out;
+		}
 
 		result = smu_cmn_update_table(smu,
 					  SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
 					  (void *)(&activity_monitor_external[i]), false);
 		if (result) {
 			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return result;
+			goto out;
 		}
 	}
 
@@ -1495,7 +1503,10 @@ do {													\
 	PRINT_DPM_MONITOR(Fclk_BoosterFreq);
 #undef PRINT_DPM_MONITOR
 
-	return size;
+	result = size;
+out:
+	kfree(activity_monitor_external);
+	return result;
 }
 
 static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
-- 
2.35.1

