Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F388A638612
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKYJZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:25:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217772B601
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:25:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8431FB829D5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414C4C4347C;
        Fri, 25 Nov 2022 09:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669368336;
        bh=x/y+szJ8KPLOirBS8g49dHJV5eBl1VP/3dRCqZ45QHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oN+2qXbNouXK3zuJkF+Tg/wJMa21UJNagtwBE/xcH1aiBqFLdUkyi3zQEY0RSUm+w
         BYiIzTSpk0FqGNZZfcDBCX2/zGjJPtDbwLA43zCsWQ+5CO1AJ4AX986BFfqYOyyaa1
         7Dmvbo0Ag7xamum5Vug7rYSXizzzixXbcfhg5ieWzdY8ECVw6Wd7G7fNuMlp2BsVLC
         CFaZRwhTDc3hBxsW7NJYKxuFUAXdN7MOFB9rJeZzbqwPJAKfsVPsjqYELnBonZTHVe
         iK98nxnVFxASVt/2fscfmENnzrllB4Dzt3Io7b2L05IgvDdYMBObpk55XKZLPwDNXZ
         272GY6Lo0+Rqg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, arnd@arndb.de, akpm@linux-foundation.org,
        nathan@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, ndesaulniers@google.com, trix@redhat.com,
        harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/display/dc/calcs/dce_calcs: Break-out a stack-heavy chunk of code
Date:   Fri, 25 Nov 2022 09:25:15 +0000
Message-Id: <20221125092517.3074989-2-lee@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221125092517.3074989-1-lee@kernel.org>
References: <20221125092517.3074989-1-lee@kernel.org>
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

bw_calcs() presently blows the stack-frame limit by calling functions
inside a argument list which return quite a bit of data to be passed
onto sub-functions.  Simply breaking out this hunk reduces the
stack-frame use by 500 Bytes, preventing the following compiler
warning:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/dce_calcs.c:3285:6:
      warning: stack frame size (1384) exceeds limit (1024)
        in 'bw_calcs' [-Wframe-larger-than]
    bool bw_calcs(struct dc_context *ctx,
         ^
    1 warning generated.

This resolves the issue and takes us one step closer towards a
successful allmodconfig WERROR build.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 .../drm/amd/display/dc/dml/calcs/dce_calcs.c  | 483 +++++++++---------
 1 file changed, 245 insertions(+), 238 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
index 0100a6053ab6b..ce5918830c030 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
@@ -3034,6 +3034,248 @@ static bool all_displays_in_sync(const struct pipe_ctx pipe[],
 	return true;
 }
 
+void bw_calcs_mid_phase(struct dc_context *ctx, const struct bw_calcs_dceip *dceip,
+			const struct bw_calcs_vbios *vbios, struct dce_bw_output *calcs_output,
+			struct bw_fixed low_sclk, struct bw_fixed mid1_sclk,
+			struct bw_fixed mid2_sclk, struct bw_fixed mid3_sclk,
+			struct bw_fixed mid_yclk, struct bw_calcs_data *data)
+{
+	((struct bw_calcs_vbios *)vbios)->low_sclk = mid3_sclk;
+	((struct bw_calcs_vbios *)vbios)->mid1_sclk = mid3_sclk;
+	((struct bw_calcs_vbios *)vbios)->mid2_sclk = mid3_sclk;
+	calculate_bandwidth(dceip, vbios, data);
+
+	calcs_output->nbp_state_change_wm_ns[0].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       nbp_state_change_watermark[4],bw_int_to_fixed(1000)));
+	calcs_output->nbp_state_change_wm_ns[1].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       nbp_state_change_watermark[5], bw_int_to_fixed(1000)));
+	calcs_output->nbp_state_change_wm_ns[2].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       nbp_state_change_watermark[6], bw_int_to_fixed(1000)));
+
+	if (ctx->dc->caps.max_slave_planes) {
+		calcs_output->nbp_state_change_wm_ns[3].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       nbp_state_change_watermark[0], bw_int_to_fixed(1000)));
+		calcs_output->nbp_state_change_wm_ns[4].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       nbp_state_change_watermark[1], bw_int_to_fixed(1000)));
+	} else {
+		calcs_output->nbp_state_change_wm_ns[3].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       nbp_state_change_watermark[7], bw_int_to_fixed(1000)));
+		calcs_output->nbp_state_change_wm_ns[4].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       nbp_state_change_watermark[8], bw_int_to_fixed(1000)));
+	}
+	calcs_output->nbp_state_change_wm_ns[5].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       nbp_state_change_watermark[9], bw_int_to_fixed(1000)));
+
+	calcs_output->stutter_exit_wm_ns[0].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_exit_watermark[4], bw_int_to_fixed(1000)));
+	calcs_output->stutter_exit_wm_ns[1].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_exit_watermark[5], bw_int_to_fixed(1000)));
+	calcs_output->stutter_exit_wm_ns[2].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_exit_watermark[6], bw_int_to_fixed(1000)));
+	if (ctx->dc->caps.max_slave_planes) {
+		calcs_output->stutter_exit_wm_ns[3].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_exit_watermark[0], bw_int_to_fixed(1000)));
+		calcs_output->stutter_exit_wm_ns[4].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_exit_watermark[1], bw_int_to_fixed(1000)));
+	} else {
+		calcs_output->stutter_exit_wm_ns[3].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_exit_watermark[7], bw_int_to_fixed(1000)));
+		calcs_output->stutter_exit_wm_ns[4].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_exit_watermark[8], bw_int_to_fixed(1000)));
+	}
+	calcs_output->stutter_exit_wm_ns[5].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_exit_watermark[9], bw_int_to_fixed(1000)));
+
+	calcs_output->stutter_entry_wm_ns[0].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_entry_watermark[4], bw_int_to_fixed(1000)));
+	calcs_output->stutter_entry_wm_ns[1].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_entry_watermark[5], bw_int_to_fixed(1000)));
+	calcs_output->stutter_entry_wm_ns[2].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_entry_watermark[6], bw_int_to_fixed(1000)));
+	if (ctx->dc->caps.max_slave_planes) {
+		calcs_output->stutter_entry_wm_ns[3].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_entry_watermark[0], bw_int_to_fixed(1000)));
+		calcs_output->stutter_entry_wm_ns[4].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_entry_watermark[1], bw_int_to_fixed(1000)));
+	} else {
+		calcs_output->stutter_entry_wm_ns[3].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_entry_watermark[7], bw_int_to_fixed(1000)));
+		calcs_output->stutter_entry_wm_ns[4].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_entry_watermark[8], bw_int_to_fixed(1000)));
+	}
+	calcs_output->stutter_entry_wm_ns[5].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_entry_watermark[9], bw_int_to_fixed(1000)));
+
+	calcs_output->urgent_wm_ns[0].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       urgent_watermark[4], bw_int_to_fixed(1000)));
+	calcs_output->urgent_wm_ns[1].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       urgent_watermark[5], bw_int_to_fixed(1000)));
+	calcs_output->urgent_wm_ns[2].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       urgent_watermark[6], bw_int_to_fixed(1000)));
+	if (ctx->dc->caps.max_slave_planes) {
+		calcs_output->urgent_wm_ns[3].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       urgent_watermark[0], bw_int_to_fixed(1000)));
+		calcs_output->urgent_wm_ns[4].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       urgent_watermark[1], bw_int_to_fixed(1000)));
+	} else {
+		calcs_output->urgent_wm_ns[3].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       urgent_watermark[7], bw_int_to_fixed(1000)));
+		calcs_output->urgent_wm_ns[4].b_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       urgent_watermark[8], bw_int_to_fixed(1000)));
+	}
+	calcs_output->urgent_wm_ns[5].b_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       urgent_watermark[9], bw_int_to_fixed(1000)));
+
+	((struct bw_calcs_vbios *)vbios)->low_sclk = low_sclk;
+	((struct bw_calcs_vbios *)vbios)->mid1_sclk = mid1_sclk;
+	((struct bw_calcs_vbios *)vbios)->mid2_sclk = mid2_sclk;
+	((struct bw_calcs_vbios *)vbios)->low_yclk = mid_yclk;
+	calculate_bandwidth(dceip, vbios, data);
+
+	calcs_output->nbp_state_change_wm_ns[0].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       nbp_state_change_watermark[4], bw_int_to_fixed(1000)));
+	calcs_output->nbp_state_change_wm_ns[1].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       nbp_state_change_watermark[5], bw_int_to_fixed(1000)));
+	calcs_output->nbp_state_change_wm_ns[2].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       nbp_state_change_watermark[6], bw_int_to_fixed(1000)));
+	if (ctx->dc->caps.max_slave_planes) {
+		calcs_output->nbp_state_change_wm_ns[3].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       nbp_state_change_watermark[0], bw_int_to_fixed(1000)));
+		calcs_output->nbp_state_change_wm_ns[4].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       nbp_state_change_watermark[1], bw_int_to_fixed(1000)));
+	} else {
+		calcs_output->nbp_state_change_wm_ns[3].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       nbp_state_change_watermark[7], bw_int_to_fixed(1000)));
+		calcs_output->nbp_state_change_wm_ns[4].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       nbp_state_change_watermark[8], bw_int_to_fixed(1000)));
+	}
+	calcs_output->nbp_state_change_wm_ns[5].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       nbp_state_change_watermark[9], bw_int_to_fixed(1000)));
+
+
+	calcs_output->stutter_exit_wm_ns[0].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_exit_watermark[4], bw_int_to_fixed(1000)));
+	calcs_output->stutter_exit_wm_ns[1].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_exit_watermark[5], bw_int_to_fixed(1000)));
+	calcs_output->stutter_exit_wm_ns[2].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_exit_watermark[6], bw_int_to_fixed(1000)));
+	if (ctx->dc->caps.max_slave_planes) {
+		calcs_output->stutter_exit_wm_ns[3].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_exit_watermark[0], bw_int_to_fixed(1000)));
+		calcs_output->stutter_exit_wm_ns[4].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_exit_watermark[1], bw_int_to_fixed(1000)));
+	} else {
+		calcs_output->stutter_exit_wm_ns[3].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_exit_watermark[7], bw_int_to_fixed(1000)));
+		calcs_output->stutter_exit_wm_ns[4].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       stutter_exit_watermark[8], bw_int_to_fixed(1000)));
+	}
+	calcs_output->stutter_exit_wm_ns[5].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_exit_watermark[9], bw_int_to_fixed(1000)));
+	calcs_output->stutter_entry_wm_ns[0].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_entry_watermark[4], bw_int_to_fixed(1000)));
+	calcs_output->stutter_entry_wm_ns[1].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_entry_watermark[5], bw_int_to_fixed(1000)));
+	calcs_output->stutter_entry_wm_ns[2].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_entry_watermark[6], bw_int_to_fixed(1000)));
+	if (ctx->dc->caps.max_slave_planes) {
+		calcs_output->stutter_entry_wm_ns[3].c_mark =
+			bw_fixed_to_int(bw_mul(data->stutter_entry_watermark[0],
+					       bw_int_to_fixed(1000)));
+		calcs_output->stutter_entry_wm_ns[4].c_mark =
+			bw_fixed_to_int(bw_mul(data->stutter_entry_watermark[1],
+					       bw_int_to_fixed(1000)));
+	} else {
+		calcs_output->stutter_entry_wm_ns[3].c_mark =
+			bw_fixed_to_int(bw_mul(data->stutter_entry_watermark[7],
+					       bw_int_to_fixed(1000)));
+		calcs_output->stutter_entry_wm_ns[4].c_mark =
+			bw_fixed_to_int(bw_mul(data->stutter_entry_watermark[8],
+					       bw_int_to_fixed(1000)));
+	}
+	calcs_output->stutter_entry_wm_ns[5].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       stutter_entry_watermark[9], bw_int_to_fixed(1000)));
+	calcs_output->urgent_wm_ns[0].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       urgent_watermark[4], bw_int_to_fixed(1000)));
+	calcs_output->urgent_wm_ns[1].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       urgent_watermark[5], bw_int_to_fixed(1000)));
+	calcs_output->urgent_wm_ns[2].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       urgent_watermark[6], bw_int_to_fixed(1000)));
+	if (ctx->dc->caps.max_slave_planes) {
+		calcs_output->urgent_wm_ns[3].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       urgent_watermark[0], bw_int_to_fixed(1000)));
+		calcs_output->urgent_wm_ns[4].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       urgent_watermark[1], bw_int_to_fixed(1000)));
+	} else {
+		calcs_output->urgent_wm_ns[3].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       urgent_watermark[7], bw_int_to_fixed(1000)));
+		calcs_output->urgent_wm_ns[4].c_mark =
+			bw_fixed_to_int(bw_mul(data->
+					       urgent_watermark[8], bw_int_to_fixed(1000)));
+	}
+	calcs_output->urgent_wm_ns[5].c_mark =
+		bw_fixed_to_int(bw_mul(data->
+				       urgent_watermark[9], bw_int_to_fixed(1000)));
+}
+
 /*
  * Return:
  *	true -	Display(s) configuration supported.
@@ -3228,244 +3470,9 @@ bool bw_calcs(struct dc_context *ctx,
 			bw_fixed_to_int(bw_mul(data->
 				urgent_watermark[9], bw_int_to_fixed(1000)));
 
-		if (dceip->version != BW_CALCS_VERSION_CARRIZO) {
-			((struct bw_calcs_vbios *)vbios)->low_sclk = mid3_sclk;
-			((struct bw_calcs_vbios *)vbios)->mid1_sclk = mid3_sclk;
-			((struct bw_calcs_vbios *)vbios)->mid2_sclk = mid3_sclk;
-			calculate_bandwidth(dceip, vbios, data);
-
-			calcs_output->nbp_state_change_wm_ns[0].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					nbp_state_change_watermark[4],bw_int_to_fixed(1000)));
-			calcs_output->nbp_state_change_wm_ns[1].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					nbp_state_change_watermark[5], bw_int_to_fixed(1000)));
-			calcs_output->nbp_state_change_wm_ns[2].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					nbp_state_change_watermark[6], bw_int_to_fixed(1000)));
-
-			if (ctx->dc->caps.max_slave_planes) {
-				calcs_output->nbp_state_change_wm_ns[3].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						nbp_state_change_watermark[0], bw_int_to_fixed(1000)));
-				calcs_output->nbp_state_change_wm_ns[4].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						nbp_state_change_watermark[1], bw_int_to_fixed(1000)));
-			} else {
-				calcs_output->nbp_state_change_wm_ns[3].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						nbp_state_change_watermark[7], bw_int_to_fixed(1000)));
-				calcs_output->nbp_state_change_wm_ns[4].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						nbp_state_change_watermark[8], bw_int_to_fixed(1000)));
-			}
-			calcs_output->nbp_state_change_wm_ns[5].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					nbp_state_change_watermark[9], bw_int_to_fixed(1000)));
-
-
-
-			calcs_output->stutter_exit_wm_ns[0].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_exit_watermark[4], bw_int_to_fixed(1000)));
-			calcs_output->stutter_exit_wm_ns[1].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_exit_watermark[5], bw_int_to_fixed(1000)));
-			calcs_output->stutter_exit_wm_ns[2].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_exit_watermark[6], bw_int_to_fixed(1000)));
-			if (ctx->dc->caps.max_slave_planes) {
-				calcs_output->stutter_exit_wm_ns[3].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_exit_watermark[0], bw_int_to_fixed(1000)));
-				calcs_output->stutter_exit_wm_ns[4].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_exit_watermark[1], bw_int_to_fixed(1000)));
-			} else {
-				calcs_output->stutter_exit_wm_ns[3].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_exit_watermark[7], bw_int_to_fixed(1000)));
-				calcs_output->stutter_exit_wm_ns[4].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_exit_watermark[8], bw_int_to_fixed(1000)));
-			}
-			calcs_output->stutter_exit_wm_ns[5].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_exit_watermark[9], bw_int_to_fixed(1000)));
-
-			calcs_output->stutter_entry_wm_ns[0].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[4], bw_int_to_fixed(1000)));
-			calcs_output->stutter_entry_wm_ns[1].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[5], bw_int_to_fixed(1000)));
-			calcs_output->stutter_entry_wm_ns[2].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[6], bw_int_to_fixed(1000)));
-			if (ctx->dc->caps.max_slave_planes) {
-				calcs_output->stutter_entry_wm_ns[3].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_entry_watermark[0], bw_int_to_fixed(1000)));
-				calcs_output->stutter_entry_wm_ns[4].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_entry_watermark[1], bw_int_to_fixed(1000)));
-			} else {
-				calcs_output->stutter_entry_wm_ns[3].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_entry_watermark[7], bw_int_to_fixed(1000)));
-				calcs_output->stutter_entry_wm_ns[4].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_entry_watermark[8], bw_int_to_fixed(1000)));
-			}
-			calcs_output->stutter_entry_wm_ns[5].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[9], bw_int_to_fixed(1000)));
-
-			calcs_output->urgent_wm_ns[0].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					urgent_watermark[4], bw_int_to_fixed(1000)));
-			calcs_output->urgent_wm_ns[1].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					urgent_watermark[5], bw_int_to_fixed(1000)));
-			calcs_output->urgent_wm_ns[2].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					urgent_watermark[6], bw_int_to_fixed(1000)));
-			if (ctx->dc->caps.max_slave_planes) {
-				calcs_output->urgent_wm_ns[3].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						urgent_watermark[0], bw_int_to_fixed(1000)));
-				calcs_output->urgent_wm_ns[4].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						urgent_watermark[1], bw_int_to_fixed(1000)));
-			} else {
-				calcs_output->urgent_wm_ns[3].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						urgent_watermark[7], bw_int_to_fixed(1000)));
-				calcs_output->urgent_wm_ns[4].b_mark =
-					bw_fixed_to_int(bw_mul(data->
-						urgent_watermark[8], bw_int_to_fixed(1000)));
-			}
-			calcs_output->urgent_wm_ns[5].b_mark =
-				bw_fixed_to_int(bw_mul(data->
-					urgent_watermark[9], bw_int_to_fixed(1000)));
-
-			((struct bw_calcs_vbios *)vbios)->low_sclk = low_sclk;
-			((struct bw_calcs_vbios *)vbios)->mid1_sclk = mid1_sclk;
-			((struct bw_calcs_vbios *)vbios)->mid2_sclk = mid2_sclk;
-			((struct bw_calcs_vbios *)vbios)->low_yclk = mid_yclk;
-			calculate_bandwidth(dceip, vbios, data);
-
-			calcs_output->nbp_state_change_wm_ns[0].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					nbp_state_change_watermark[4], bw_int_to_fixed(1000)));
-			calcs_output->nbp_state_change_wm_ns[1].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					nbp_state_change_watermark[5], bw_int_to_fixed(1000)));
-			calcs_output->nbp_state_change_wm_ns[2].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					nbp_state_change_watermark[6], bw_int_to_fixed(1000)));
-			if (ctx->dc->caps.max_slave_planes) {
-				calcs_output->nbp_state_change_wm_ns[3].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						nbp_state_change_watermark[0], bw_int_to_fixed(1000)));
-				calcs_output->nbp_state_change_wm_ns[4].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						nbp_state_change_watermark[1], bw_int_to_fixed(1000)));
-			} else {
-				calcs_output->nbp_state_change_wm_ns[3].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						nbp_state_change_watermark[7], bw_int_to_fixed(1000)));
-				calcs_output->nbp_state_change_wm_ns[4].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						nbp_state_change_watermark[8], bw_int_to_fixed(1000)));
-			}
-			calcs_output->nbp_state_change_wm_ns[5].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					nbp_state_change_watermark[9], bw_int_to_fixed(1000)));
-
-
-			calcs_output->stutter_exit_wm_ns[0].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_exit_watermark[4], bw_int_to_fixed(1000)));
-			calcs_output->stutter_exit_wm_ns[1].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_exit_watermark[5], bw_int_to_fixed(1000)));
-			calcs_output->stutter_exit_wm_ns[2].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_exit_watermark[6], bw_int_to_fixed(1000)));
-			if (ctx->dc->caps.max_slave_planes) {
-				calcs_output->stutter_exit_wm_ns[3].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_exit_watermark[0], bw_int_to_fixed(1000)));
-				calcs_output->stutter_exit_wm_ns[4].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_exit_watermark[1], bw_int_to_fixed(1000)));
-			} else {
-				calcs_output->stutter_exit_wm_ns[3].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_exit_watermark[7], bw_int_to_fixed(1000)));
-				calcs_output->stutter_exit_wm_ns[4].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						stutter_exit_watermark[8], bw_int_to_fixed(1000)));
-			}
-			calcs_output->stutter_exit_wm_ns[5].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_exit_watermark[9], bw_int_to_fixed(1000)));
-			calcs_output->stutter_entry_wm_ns[0].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[4], bw_int_to_fixed(1000)));
-			calcs_output->stutter_entry_wm_ns[1].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[5], bw_int_to_fixed(1000)));
-			calcs_output->stutter_entry_wm_ns[2].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[6], bw_int_to_fixed(1000)));
-			if (ctx->dc->caps.max_slave_planes) {
-				calcs_output->stutter_entry_wm_ns[3].c_mark =
-					bw_fixed_to_int(bw_mul(data->stutter_entry_watermark[0],
-						bw_int_to_fixed(1000)));
-				calcs_output->stutter_entry_wm_ns[4].c_mark =
-					bw_fixed_to_int(bw_mul(data->stutter_entry_watermark[1],
-						bw_int_to_fixed(1000)));
-			} else {
-				calcs_output->stutter_entry_wm_ns[3].c_mark =
-					bw_fixed_to_int(bw_mul(data->stutter_entry_watermark[7],
-						bw_int_to_fixed(1000)));
-				calcs_output->stutter_entry_wm_ns[4].c_mark =
-					bw_fixed_to_int(bw_mul(data->stutter_entry_watermark[8],
-						bw_int_to_fixed(1000)));
-			}
-			calcs_output->stutter_entry_wm_ns[5].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					stutter_entry_watermark[9], bw_int_to_fixed(1000)));
-			calcs_output->urgent_wm_ns[0].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					urgent_watermark[4], bw_int_to_fixed(1000)));
-			calcs_output->urgent_wm_ns[1].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					urgent_watermark[5], bw_int_to_fixed(1000)));
-			calcs_output->urgent_wm_ns[2].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					urgent_watermark[6], bw_int_to_fixed(1000)));
-			if (ctx->dc->caps.max_slave_planes) {
-				calcs_output->urgent_wm_ns[3].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						urgent_watermark[0], bw_int_to_fixed(1000)));
-				calcs_output->urgent_wm_ns[4].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						urgent_watermark[1], bw_int_to_fixed(1000)));
-			} else {
-				calcs_output->urgent_wm_ns[3].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						urgent_watermark[7], bw_int_to_fixed(1000)));
-				calcs_output->urgent_wm_ns[4].c_mark =
-					bw_fixed_to_int(bw_mul(data->
-						urgent_watermark[8], bw_int_to_fixed(1000)));
-			}
-			calcs_output->urgent_wm_ns[5].c_mark =
-				bw_fixed_to_int(bw_mul(data->
-					urgent_watermark[9], bw_int_to_fixed(1000)));
-		}
+		if (dceip->version != BW_CALCS_VERSION_CARRIZO)
+			bw_calcs_mid_phase(ctx, dceip, vbios, calcs_output, low_sclk,
+					   mid1_sclk, mid2_sclk, mid3_sclk, mid_yclk, data);
 
 		if (dceip->version == BW_CALCS_VERSION_CARRIZO) {
 			((struct bw_calcs_vbios *)vbios)->low_yclk = high_yclk;
-- 
2.38.1.584.g0f3c55d4c2-goog

