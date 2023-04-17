Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A436E53F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDQVfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjDQVfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:35:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04AE4C28
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:35:12 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id oWVBpmySP7JnhoWVBpp7Yo; Mon, 17 Apr 2023 23:35:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681767311;
        bh=exdfx2AQYI+d3tNi/ZWU6Qg32IUD8RC19Z/dcWtgLqs=;
        h=From:To:Cc:Subject:Date;
        b=NdxG2WsGN31gVPGEViY7Gfx6CGXCETw38SsVxY6IMCbDTSfxJfXScMtFpUjcrKaKG
         NVgFyLzcDAenFlcjEu92emWpI0WggHaWsRMRyb1j5k0GqiAzyRgTYoXhNLRHvnRR9C
         k/uxWrNaiTFNq1C8OBkSyax8cLOpnVn5gXA0002el4r+WuB58lXuybGxlgyZQVdbYU
         nnjfp7Zw2UQWmUDflTkQ34Dr3CEm02FFBu8uwmhsaHf/kv586EWgib/eHTjbpLtnDF
         jVSer0ib8ZfQ6hgF0MOUutTWNMqpSOHW6rhUWpXZNwfNO9BecmslqM1kij833b97lQ
         KUlMW8ZxR2/hw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Apr 2023 23:35:11 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pavle Kotarac <Pavle.Kotarac@amd.com>,
        Nevenko Stupar <Nevenko.Stupar@amd.com>,
        Aric Cyr <aric.cyr@amd.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix a test CalculatePrefetchSchedule()
Date:   Mon, 17 Apr 2023 23:35:08 +0200
Message-Id: <13ab79d7a6c7ec6292c803ce1e52c8ac12af320f.1681767298.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely Height was expected here, instead of Width.

Test the correct variable.

Fixes: 17529ea2acfa ("drm/amd/display: Optimizations for DML math")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index b7c2844d0cbe..f294f2f8c75b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -810,7 +810,7 @@ static bool CalculatePrefetchSchedule(
 			*swath_width_chroma_ub = dml_ceil(SwathWidthY / 2 - 1, myPipe->BlockWidth256BytesC) + myPipe->BlockWidth256BytesC;
 	} else {
 		*swath_width_luma_ub = dml_ceil(SwathWidthY - 1, myPipe->BlockHeight256BytesY) + myPipe->BlockHeight256BytesY;
-		if (myPipe->BlockWidth256BytesC > 0)
+		if (myPipe->BlockHeight256BytesC > 0)
 			*swath_width_chroma_ub = dml_ceil(SwathWidthY / 2 - 1, myPipe->BlockHeight256BytesC) + myPipe->BlockHeight256BytesC;
 	}
 
-- 
2.34.1

