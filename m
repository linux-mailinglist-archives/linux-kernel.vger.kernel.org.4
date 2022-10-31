Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536506134B4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJaLnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiJaLmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12148E0CE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A261A611CE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5341EC433C1;
        Mon, 31 Oct 2022 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216572;
        bh=0Ny5jDHTsXvs2qGGUs+LNd/KCTTEaEmH3NAom76nAhY=;
        h=From:To:Cc:Subject:Date:From;
        b=FD4dyCMIDDdkiz7eJlnhS4GEpm9MqWOmIdOBoQn5gLt4Og3ol/4LnVy4sTByeaySu
         kn9YvxVB2LJUV0Xt+BxT/DENQ36OpbCaPgFmongTtCsaCFIWRwCPQ6s+8dh5Rl7kA7
         Kmh292PDAdQpP1y6wHVzehrFIgY93EnBVv+uR1JwWPM1ocoUXPLy1p1/j8LcpDn8ds
         yTmckj76GdGT58LkYH3a5whcB5SP2zgiw8QEak0Zr4uXCk5bL1gqdZyr8aBmrLvLbq
         5AXs3vbbj557ymKZCInk438btbO7k9TI/w/PZzbkseZasb+chf5aG8m1dqTRlhUxTx
         n3rq/HPf0W3dw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     harry.wentland@amd.com
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display (gcc13): fix enum mismatch
Date:   Mon, 31 Oct 2022 12:42:47 +0100
Message-Id: <20221031114247.10309-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rn_vbios_smu_set_dcn_low_power_state() produces a valid warning with
gcc-13:
  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c:237:6: error: conflicting types for 'rn_vbios_smu_set_dcn_low_power_state' due to enum/integer mismatch; have 'void(struct clk_mgr_internal *, enum dcn_pwr_state)'
  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h:36:6: note: previous declaration of 'rn_vbios_smu_set_dcn_low_power_state' with type 'void(struct clk_mgr_internal *, int)'

I.e. the type of the 2nd parameter of
rn_vbios_smu_set_dcn_low_power_state() in the declaration is int, while
the definition spells enum dcn_pwr_state. Synchronize them to the
latter (and add a forward enum declaration).

Cc: Martin Liska <mliska@suse.cz>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h
index 3e5df27aa96f..1ce19d875358 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h
@@ -26,6 +26,8 @@
 #ifndef DAL_DC_RN_CLK_MGR_VBIOS_SMU_H_
 #define DAL_DC_RN_CLK_MGR_VBIOS_SMU_H_
 
+enum dcn_pwr_state;
+
 int rn_vbios_smu_get_smu_version(struct clk_mgr_internal *clk_mgr);
 int rn_vbios_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispclk_khz);
 int rn_vbios_smu_set_dprefclk(struct clk_mgr_internal *clk_mgr);
@@ -33,7 +35,7 @@ int rn_vbios_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int reque
 int rn_vbios_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int requested_min_ds_dcfclk_khz);
 void rn_vbios_smu_set_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz);
 int rn_vbios_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_khz);
-void rn_vbios_smu_set_dcn_low_power_state(struct clk_mgr_internal *clk_mgr, int display_count);
+void rn_vbios_smu_set_dcn_low_power_state(struct clk_mgr_internal *clk_mgr, enum dcn_pwr_state);
 void rn_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable);
 void rn_vbios_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr);
 int rn_vbios_smu_is_periodic_retraining_disabled(struct clk_mgr_internal *clk_mgr);
-- 
2.38.1

