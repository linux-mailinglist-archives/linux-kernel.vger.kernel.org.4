Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B236BE37D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCQI0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCQI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:26:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36F21A3B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D386222B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62EAC4339E;
        Fri, 17 Mar 2023 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041419;
        bh=xZ13Sd87g9CKUnDrgvkkNwNiDfiWnXZudwoi/OaryNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=St2SF/s3v1p6ct/nxEVpyCflMhM+8DHR0z2aPQdZ7xVZDFtuPfrXYY2Qc5tpx3oS1
         IIQHSPOQDnWV9HASgwgdyeWBIDNaM+VCyYPSShkwxxlxyqIcOxVdiecZ8h5UOgh98C
         sQvpRs2jgnUvBRVcTdJVBtlj3GGVjEf4/mJG9rZWnRKPCQ52z8Jm4rpKriokJrSx4j
         9Ae/0p8dC5kAIEsusC16uPNiRSrR/Y9/91oZDQsmFnr/ND8X/4gKG6Vw4kVdea2vBC
         nid2hyp3wEmEz4n8LiROTVE3dthzdBJHrD0uNnVvzbveIwtFfYnOnk8Mlo+34vcDYI
         iQXP7MGZXh6oQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/37] drm/amd/display/dc/link/protocols/link_dp_capability: Remove unused variable and mark another as __maybe_unused
Date:   Fri, 17 Mar 2023 08:17:13 +0000
Message-Id: <20230317081718.2650744-33-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

‘ds_port’ is clearly not used anywhere and ‘result_write_min_hblank’ is
only utilised when debugging is enabled.  The alternative would be to
allocate the variable under the same clause as the debugging code, but
that would become very messy, very quickly.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c: In function ‘dp_wa_power_up_0010FA’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:280:42: warning: variable ‘ds_port’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c: In function ‘dpcd_set_source_specific_data’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:1296:32: warning: variable ‘result_write_min_hblank’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index e9bcb35ae185a..51427f5081642 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1284,7 +1284,7 @@ bool dp_overwrite_extended_receiver_cap(struct dc_link *link)
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
-		enum dc_status result_write_min_hblank = DC_NOT_SUPPORTED;
+		enum dc_status __maybe_unused result_write_min_hblank = DC_NOT_SUPPORTED;
 		struct dpcd_amd_signature amd_signature = {0};
 		struct dpcd_amd_device_id amd_device_id = {0};
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

