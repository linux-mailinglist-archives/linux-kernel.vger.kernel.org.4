Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0398690927
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBIMpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBIMpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:45:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8619A5AB08
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:45:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40835B82126
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 12:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA601C433EF;
        Thu,  9 Feb 2023 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675946717;
        bh=Q8Fs1hhzx5yW8jDp0z06JUZNBw9/Yhiv31VTrLxhk+I=;
        h=From:To:Cc:Subject:Date:From;
        b=RRJ0na7po8V+zfKZ36Chtjh+XkJ1NIq1DbPWpjVh5qhDa64EDy+8bX2EK9EyYAjlx
         P4Z1MvQ2l9Hx/aUYzQQmkImGSN8T874/QERNRl2/ynLTJwiC12wOrI0RuucLFjaqYU
         6/2/LSIDUVF72fNgSDk2iCHQFxRJCMsiMi3BAmvQ2GbfeUCddEY9dzPbY3yh68lZBq
         cBZxbQbhIY6KV2AyIE7bwys0K+ksAenAbBHmBPIiVdaHpf70SJ/T3yo9Gco378WWGp
         e9JDovC3HZovVmQfQEOqtxiHSg/Mpg4rGcS3yhAJJxBpIdZVkOa97tjIA4eMKG3pyb
         ofv0qV8Uy4Fhw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        George Shen <George.Shen@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix link_validation build failure
Date:   Thu,  9 Feb 2023 13:45:03 +0100
Message-Id: <20230209124513.1341645-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_DRM_AMD_DC_DCN is disabled, the is_frl member
is not defined:

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c: In function 'dp_active_dongle_validate_timing':
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:126:66: error: 'const struct dc_dsc_config' has no member named 'is_frl'
  126 |                         if (timing->flags.DSC && !timing->dsc_cfg.is_frl)
      |                                                                  ^

Use the same #ifdef as the other references to this.

Fixes: 54618888d1ea ("drm/amd/display: break down dc_link.c")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/link/link_validation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index cd821d077d73..8ddebf3bdd46 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -123,9 +123,11 @@ static bool dp_active_dongle_validate_timing(
 		if (dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps > 0) { // DP to HDMI FRL converter
 			struct dc_crtc_timing outputTiming = *timing;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 			if (timing->flags.DSC && !timing->dsc_cfg.is_frl)
 				/* DP input has DSC, HDMI FRL output doesn't have DSC, remove DSC from output timing */
 				outputTiming.flags.DSC = 0;
+#endif
 			if (dc_bandwidth_in_kbps_from_timing(&outputTiming) > dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps)
 				return false;
 		} else { // DP to HDMI TMDS converter
-- 
2.39.1

