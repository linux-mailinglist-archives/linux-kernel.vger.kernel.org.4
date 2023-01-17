Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D360766E499
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjAQROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjAQRO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:14:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C654C0E4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:12:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13A7AB8164B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89186C433D2;
        Tue, 17 Jan 2023 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673975567;
        bh=WwkZdJTRH/e6oDjQt1JBj5r7Hxk3Sps4Rt8KnDt4/u0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZNGm4dQXyPpdlm7+X9Q4CvkWy0n/zRxxC7Ir3C+TUbW7gC1qxMaaS5DvieEd5lipB
         enf5LpmFk7sumKBslDpDA4iwMbwtkaco2vtLfWHLz3agHqyEFmDjTuJvj0Hqv+zKSH
         xKKUwC0JlzGg23g4T8+MHo6zp64b1EiBKmdlrQG0n5hijI21iRv5HUdykcWJz24et2
         SW/Lk95wWovkMoSGbJ5uySheXx62h3p13bsj02eTXe08CERf4E7LKK8dhRZGcGyr2n
         3dKH6wXinGH1vHVrOkN39F4fDBMA8ZoaeOBIb5POjI4UKDLtvWiRuAT28+zz6P5aUF
         xKt199peEHU4A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>,
        George Shen <george.shen@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Lewis Huang <Lewis.Huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] drm/amd/display: fix dp_retrieve_lttpr_cap return code
Date:   Tue, 17 Jan 2023 18:12:24 +0100
Message-Id: <20230117171239.2714855-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

The dp_retrieve_lttpr_cap() return type changed from 'bool'
to 'enum dc_status', so now the early 'return' uses the wrong
type:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function 'dp_retrieve_lttpr_cap':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:5075:24: error: implicit conversion from 'enum <anonymous>' to 'enum dc_status' [-Werror=enum-conversion]
 5075 |                 return false;
      |                        ^~~~~

Convert it to return 'DC_ERROR_UNEXPECTED', which was apparently set
as a default return code here but never used.

Fixes: b473bd5fc333 ("drm/amd/display: refine wake up aux in retrieve link caps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2 changes:
 - use DC_ERROR_UNEXPECTED instead of DC_OK
 - remove bogus initializers
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9edfcdf3db3b..cf512362b4f1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5088,14 +5088,14 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 {
 	uint8_t lttpr_dpcd_data[8];
-	enum dc_status status = DC_ERROR_UNEXPECTED;
-	bool is_lttpr_present = false;
+	enum dc_status status;
+	bool is_lttpr_present;
 
 	/* Logic to determine LTTPR support*/
 	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
 
 	if (!vbios_lttpr_interop || !link->dc->caps.extended_aux_timeout_support)
-		return false;
+		return DC_ERROR_UNEXPECTED;
 
 	/* By reading LTTPR capability, RX assumes that we will enable
 	 * LTTPR extended aux timeout if LTTPR is present.
-- 
2.39.0

