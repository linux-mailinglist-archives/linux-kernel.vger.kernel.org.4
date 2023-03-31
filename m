Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA626D13F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCaARl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCaARj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ABFDBC6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680221628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sxdUBC3+7/+FoRE3AV8lIbZMqGBJVuxDsooJhZM+Js0=;
        b=KmBAlkm3y91WOQsmI55pFOF+VetxGU4yTjEGz/ipZtC3QuJ5cXDmikdIokpRGLNZNRgqxv
        W1GR+f9HPAJvNDn702Y6IV5Wd3Rq0r9m7CRf+BWjqsKIDGKCSCg4CY5Jixw5OJUSJkN9GW
        8EpQxjQWOmXTUQIeS5311/Km9cNiStU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-kl5TJukgPsaRFJTdGrhGJg-1; Thu, 30 Mar 2023 20:10:36 -0400
X-MC-Unique: kl5TJukgPsaRFJTdGrhGJg-1
Received: by mail-qv1-f72.google.com with SMTP id y19-20020ad445b3000000b005a5123cb627so9031441qvu.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680221436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxdUBC3+7/+FoRE3AV8lIbZMqGBJVuxDsooJhZM+Js0=;
        b=P3knfyPr2ShkgnQK33rB/fKYOBWL0e24yu7BruiVhv/VpaKi/+V+C3wVH7LNPwHFTN
         0bO8orDON3FDQIE1pr0mBLNEVS+QUxKY2O1KpjoHUf9Ow0MpTV4Br9o7ViKAULs7uG+U
         3ZYne1XIa9qiNNQFevpA+FB8ThkVZ94XEdVGTYiFmLtrx5OG8xQNruFtBzhmI/iyFs98
         zGNae82cd6TqDs6gBnYCB9Xyc/b8eiTteLpD5l7fEEhPHr4L4ajUhKH/ESSlxuguw1S2
         wSfLpvSuyqHsxMhF+1yWDCApfIukqYNvZSvajQvw2YEX55qbVxM/yonhy2rojYWcWB7Y
         tA7w==
X-Gm-Message-State: AAQBX9cg8f9NY465IYuLTbBKhp4i48c8z5YCfEiqUHbvGsZgfP7jHHTR
        zVvsFXipZE4aBI7RiCADjqIoVwP8yD2GnSLwb3SsH9ZCZa0DU5X3nXVHPQxpWJlPMU7rapGaZrY
        cM8/ykhzYisyBHzYSaoKz5Pw3
X-Received: by 2002:ac8:5b01:0:b0:3e6:3851:b949 with SMTP id m1-20020ac85b01000000b003e63851b949mr5097002qtw.18.1680221436262;
        Thu, 30 Mar 2023 17:10:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZfvmPI/ZvqdmyfvzOcRsU2w4va42Sg5iZv/lqX0s90R5xmXd2ghuy7behp6ugqVkYCdP5wxg==
X-Received: by 2002:ac8:5b01:0:b0:3e6:3851:b949 with SMTP id m1-20020ac85b01000000b003e63851b949mr5096964qtw.18.1680221436015;
        Thu, 30 Mar 2023 17:10:36 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e14-20020ac8670e000000b003e38d6c013dsm223281qtp.60.2023.03.30.17.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 17:10:35 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        aric.cyr@amd.com, HaoPing.Liu@amd.com, Anthony.Koo@amd.com,
        hanghong.ma@amd.com, Angus.Wang@amd.com, Dillon.Varone@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unused average_render_time_in_us and i variables
Date:   Thu, 30 Mar 2023 20:10:32 -0400
Message-Id: <20230331001032.1846456-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:1132:15: error: variable
  'average_render_time_in_us' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned int average_render_time_in_us = 0;
                     ^
This variable is not used so remove it, which caused i to be unused so remove that as well.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../drm/amd/display/modules/freesync/freesync.c    | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 315da61ee897..5c41a4751db4 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1129,7 +1129,6 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 {
 	struct core_freesync *core_freesync = NULL;
 	unsigned int last_render_time_in_us = 0;
-	unsigned int average_render_time_in_us = 0;
 
 	if (mod_freesync == NULL)
 		return;
@@ -1138,7 +1137,6 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 
 	if (in_out_vrr->supported &&
 			in_out_vrr->state == VRR_STATE_ACTIVE_VARIABLE) {
-		unsigned int i = 0;
 		unsigned int oldest_index = plane->time.index + 1;
 
 		if (oldest_index >= DC_PLANE_UPDATE_TIMES_MAX)
@@ -1147,18 +1145,6 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 		last_render_time_in_us = curr_time_stamp_in_us -
 				plane->time.prev_update_time_in_us;
 
-		/* Sum off all entries except oldest one */
-		for (i = 0; i < DC_PLANE_UPDATE_TIMES_MAX; i++) {
-			average_render_time_in_us +=
-					plane->time.time_elapsed_in_us[i];
-		}
-		average_render_time_in_us -=
-				plane->time.time_elapsed_in_us[oldest_index];
-
-		/* Add render time for current flip */
-		average_render_time_in_us += last_render_time_in_us;
-		average_render_time_in_us /= DC_PLANE_UPDATE_TIMES_MAX;
-
 		if (in_out_vrr->btr.btr_enabled) {
 			apply_below_the_range(core_freesync,
 					stream,
-- 
2.27.0

