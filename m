Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BB164DEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLOQh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiLOQhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:37:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4B21270
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:37:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 281A6B81AAC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDEDC433D2;
        Thu, 15 Dec 2022 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122269;
        bh=RV+MWWk++Ih2bkesG4BCmtmkZAUvC1BBjtjl9erq92U=;
        h=From:To:Cc:Subject:Date:From;
        b=HBBGEmENzDsR6v2JzTk9TsAw9a5xMy9TsGY6JZDw1L0qqzQqPIY07i8Qw2odeYYUg
         qqxgxiB9NJXMLxLCaAk33gZIBI+IOaUEvqtdIgJzxgo/5ykUWho5ljgwWk1yrQzAz4
         f0TUSjbzj0c6VqOhrB/VkJA/B5J+FqIYxqM11wNxjGgNe+0im4oWCBXyOdYU6zlssx
         wsY6ynr08+JA0+mt4x20OnPZgyhQcpRPib361frVWiv9bcenSBL0itX5DV5OHiRIBq
         9JI7gmWa5Yq9BiUJ7Fr7FvjrUXaQtLHCL9qOgWA4jAEG4CIe79ZlNpUHiC5BeRTlQc
         u1ea7XRG0LeKg==
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
        Wenjing Liu <wenjing.liu@amd.com>,
        George Shen <george.shen@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix dp_retrieve_lttpr_cap return code
Date:   Thu, 15 Dec 2022 17:37:10 +0100
Message-Id: <20221215163743.452648-1-arnd@kernel.org>
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

The dp_retrieve_lttpr_cap() return type changed from 'bool'
to 'enum dc_status', so now the early 'return' uses the wrong
type:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function 'dp_retrieve_lttpr_cap':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:5075:24: error: implicit conversion from 'enum <anonymous>' to 'enum dc_status' [-Werror=enum-conversion]
 5075 |                 return false;
      |                        ^~~~~

Convert it to return 'DC_OK', which is the same value as 'false'.

Fixes: b473bd5fc333 ("drm/amd/display: refine wake up aux in retrieve link caps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
No idea if DC_OK is the intended return code, but it leaves the behavior
unchanged and fixes the warning.
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index af9411ee3c74..95dbfa4e996a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5095,7 +5095,7 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
 
 	if (!vbios_lttpr_interop || !link->dc->caps.extended_aux_timeout_support)
-		return false;
+		return DC_OK;
 
 	/* By reading LTTPR capability, RX assumes that we will enable
 	 * LTTPR extended aux timeout if LTTPR is present.
-- 
2.35.1

