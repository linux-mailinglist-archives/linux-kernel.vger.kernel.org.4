Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0C366B025
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjAOJcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAOJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:32:32 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122959017
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673775142; bh=h3BV35ExW4Qp8mSJAt5y1TYkCZQhRUQwk+nplpac6xs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=XRtOftUNorQbmCMcA54sJ3NrwQZVSNveuKgJbOSftQ3YhAniPLLuZd6n26IXyzBvP
         IdBHzt9gQ8rZfCuwx8McAyz0q2H+nOcVA26wP9Ap4z+eD/nstnLbVAdBeEhuEjwYMk
         Yn3IEohbNoTvKG/x3Sfn3FqUK71GNlLbyu9dxWok=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 15 Jan 2023 10:32:22 +0100 (CET)
X-EA-Auth: DwObgLNILM2GtGPAI+00q8N5h+32tnvd/PwBaxq/eKJBAyAYbimivsEbXvC9hVqYG8F0mkVbytx8mh28znre75c7q2Kq5iw9
Date:   Sun, 15 Jan 2023 15:02:17 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] drm/amd/display: avoid variable reinitialization
Message-ID: <Y8PIId1k1TmIAo18@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member variable set_odm_combine is already initialized and hence the
reinitialization instruction can be removed. Issue identified using the
dubleinit.cocci Coccinelle semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index 41edbd64ea21..777d8efee977 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -254,7 +254,6 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
 		.get_hw_timing = optc1_get_hw_timing,
 		.init_odm = optc3_init_odm,
 		.set_odm_bypass = optc314_set_odm_bypass,
-		.set_odm_combine = optc314_set_odm_combine,
 		.set_h_timing_div_manual_mode = optc314_set_h_timing_div_manual_mode,
 };
 
-- 
2.34.1



