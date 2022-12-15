Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411A164DEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLOQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLOQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:46:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FFC14D34
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:46:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E356B81AAC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C28C433D2;
        Thu, 15 Dec 2022 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122761;
        bh=aNi+MDukcWClJUpGNHicqsKzCYbsXQMr0xrEnMsi1Ts=;
        h=From:To:Cc:Subject:Date:From;
        b=p32bcg5JZOWdcq6LRNSuomdYw4Xuu/fO3b8cx0vILTMUqsLZ0+QxZ8LyZ2b6qk/sU
         DK4rjWufN/ywpUM5+ZWqONZd7yoLfU8kU9nXeaYiaisv2wfkPnwdREpGoJTIrqXtHw
         cFlF8rOWX2Aash/2xiNLlbfGvAVpBnrnuc7aH7XHBMpC42XA28xwfdnAp9N/9esM6/
         5SVW03nnnN2i76DAIcn51k6Jx/HBAxw9FNAzyx0oTAjy8VJsTnQ8ykug9OdDqi3TmA
         v2XGRdQocpyrZLX9dlNLn237Ady1yssU7TP9RXW1oWA3A7RslJ/dLqZS/CxE8wO/wk
         T0NKYJuTSyUKQ==
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
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Alex Hung <alex.hung@amd.com>, Roman Li <roman.li@amd.com>,
        Duncan Ma <duncan.ma@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix duplicate assignments
Date:   Thu, 15 Dec 2022 17:45:25 +0100
Message-Id: <20221215164537.1126692-1-arnd@kernel.org>
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

The .set_odm_combine callback pointer was added twice, causing
a harmless -Wextra warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_optc.c:258:36: error: initialized field overwritten [-Werror=override-init]
  258 |                 .set_odm_combine = optc314_set_odm_combine,
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_optc.c:258:36: note: (near initialization for 'dcn314_tg_funcs.set_odm_combine')

Fixes: 5ade1b951dec ("drm/amd/display: Add OTG/ODM functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index f246aab23050..0086cafb0f7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -241,7 +241,6 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
 		.set_dsc_config = optc3_set_dsc_config,
 		.get_dsc_status = optc2_get_dsc_status,
 		.set_dwb_source = NULL,
-		.set_odm_combine = optc314_set_odm_combine,
 		.get_optc_source = optc2_get_optc_source,
 		.set_out_mux = optc3_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-- 
2.35.1

