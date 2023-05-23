Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504D670D7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjEWIhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjEWIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D501FDD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B1D61219
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E437C433EF;
        Tue, 23 May 2023 08:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684830885;
        bh=uDeBCUkzcBHJ92URNdM9l1Brx4f2zSG2cwz+M+3kjvU=;
        h=From:To:Cc:Subject:Date:From;
        b=f5lHK/UaPZHvvrCbyx8U+aSfrFNlBZeuo6IrZ6le9c3sH92ANJkt14t08Prn4LoOy
         aIuvhhQi/1nO4uzPhjngpWtLDjNIAHBTnqJsqArO9m02ahkOfZ0o6x2n7EXxdnGV2m
         JArBQp54U8gqNVM7fhvgaESODqmOCagh+i9gpqABf4acdG1cHCMkgF5d47NS8GSaeH
         NuZcZuidG6dVplphDurX1sBEP1+zq6fmcbSyP0oLWbV3Ffgpy3H0dEYHU6y0VhTqIT
         pPewrt3Fi0vWXd5EnC+dlICVBF6bDoCqWw05jXwk2xE3JlzAcJYz/fVlZGSXfbPPdB
         M5gyAovdlDcdg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Saaem Rizvi <syedsaaem.rizvi@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wenjing Liu <wenjing.liu@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jingwen Zhu <Jingwen.Zhu@amd.com>,
        "Nagulendran, Iswara" <Iswara.Nagulendran@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: avoid calling missing .resync_fifo_dccg_dio()
Date:   Tue, 23 May 2023 10:34:30 +0200
Message-Id: <20230523083437.986490-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The .resync_fifo_dccg_dio() callback pointer was added in an #ifdef block,
but is called unconditionally:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:2292:31: error: 'struct hwseq_private_funcs' has no member named 'resync_fifo_dccg_dio'

Add the same #ifdef around the caller as well.

Fixes: 6354b0dc3a7a ("drm/amd/display: Trigger DIO FIFO resync on commit streams")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index c6fe2c00aedb..d4cacb8df631 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2289,8 +2289,10 @@ enum dc_status dce110_apply_ctx_to_hw(
 		if (DC_OK != status)
 			return status;
 
+#ifdef CONFIG_DRM_AMD_DC_FP
 		if (hws->funcs.resync_fifo_dccg_dio)
 			hws->funcs.resync_fifo_dccg_dio(hws, dc, context);
+#endif
 	}
 
 	if (dc->fbc_compressor)
-- 
2.39.2

