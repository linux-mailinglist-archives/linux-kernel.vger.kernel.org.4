Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC86D1378
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjC3XoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjC3XoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33048C148
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680219789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sxdUBC3+7/+FoRE3AV8lIbZMqGBJVuxDsooJhZM+Js0=;
        b=XhpjhzhlCl9o4t9L7XPe81ywFngSnHEBhkJE4zuNr8OoXa2laHCbKCDd89ilfOlxxR2dXS
        k+g/d5QP1+kDKwx+/qTySSpGidJdH+eR/T+HvGQs6qNlpUGVJNebPPL1Aywc4+Fy4fLS9F
        Efa3/Yt1Mlb0UPcaQUpTkx1nY9tATa0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-OEfhCQ2bPuWTFdYvkcAxpw-1; Thu, 30 Mar 2023 19:43:08 -0400
X-MC-Unique: OEfhCQ2bPuWTFdYvkcAxpw-1
Received: by mail-qv1-f72.google.com with SMTP id px9-20020a056214050900b005d510cdfc41so9102983qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680219787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxdUBC3+7/+FoRE3AV8lIbZMqGBJVuxDsooJhZM+Js0=;
        b=T/DH4vc2FfVrssUn1dd90AOqm3T+snPdYnnBF3OKcXPBk38o+0zxxqeRPou2MjIwVM
         tTjoxe6caUgWWPjYerYI12inK81+CztfP1q9nuLMfwsSnIhscBd+dZW5DNcpn2zXpJrW
         6INRVFXukrYBVBHdCdMXkhRlk4AX78Bumk7d3grTWk3RJ+c31CNHYgG3YWhS5JOVvIhe
         x7Q/2IwEWOMoYvUzJf8FJgMTHY59GvcV5xo9h93KywNsxBF3rMYf1nRoQj3AJMfNcPsm
         k23mp5oURJDvIEX7eOS9ZrtQJJZyMBPIOniu2QUmPQSyeOWGorNfMHiMzH3tH0DU05yV
         QpiQ==
X-Gm-Message-State: AO0yUKVChELPMc1+q1nTU4PvdqleWSnhzy2M28fOg22l9B2cl76v8oBd
        Gf+g6wcI/yDSU0Wp9sVTQasSpjYlsMy4frVqvXStLKzE/3Jy1xFxSynnc56uAZlI9VLSCzoJQZS
        GYRGK7BRqyhQygohuBOeRWVe/
X-Received: by 2002:a05:622a:1a98:b0:3d8:9b45:d362 with SMTP id s24-20020a05622a1a9800b003d89b45d362mr38620994qtc.28.1680219787540;
        Thu, 30 Mar 2023 16:43:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set8e+7pjqcJzugW+87SA4B2ztfpVpwfdIdmQmFB4Xnk8pbSHqG3Dep8cVHiY/IIHhrhVsGayJA==
X-Received: by 2002:a05:622a:1a98:b0:3d8:9b45:d362 with SMTP id s24-20020a05622a1a9800b003d89b45d362mr38620961qtc.28.1680219787200;
        Thu, 30 Mar 2023 16:43:07 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q19-20020ac87353000000b003e387a2fbdfsm235015qtp.0.2023.03.30.16.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:43:06 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        HaoPing.Liu@amd.com, aric.cyr@amd.com, chiahsuan.chung@amd.com,
        felipe.clark@amd.com, Angus.Wang@amd.com, hanghong.ma@amd.com,
        lv.ruyi@zte.com.cn, Dillon.Varone@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unused average_render_time_in_us and i variables
Date:   Thu, 30 Mar 2023 19:43:03 -0400
Message-Id: <20230330234303.1845377-1-trix@redhat.com>
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

