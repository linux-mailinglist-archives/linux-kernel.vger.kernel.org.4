Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03D6EDD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjDYHxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjDYHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:53:40 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED5C9F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 00:53:38 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rDUWpfoNtvolhrDUWpTpgz; Tue, 25 Apr 2023 09:53:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682409217;
        bh=5mXZM2+8CUq1MLkMg5pCYcpJ5YHT+aXC4TWjV894QWw=;
        h=From:To:Cc:Subject:Date;
        b=TnvJO9+WncBBDJvXwGxUGPZpoAVDCM9dCNOGEU0rqOTlm0gCl3atNvsuo/MZ8D0rH
         hc0nxV3G5j9dk4MjnbEt5pxtRu3a51zzcVgZfeMTyvBzTvsvj1AxTgp4ivP59Mm0x8
         bKanJ+IA/L/Kx3eKki/wsL6JLYoQy/dlOeOJxG4J4y04j1lanRs8//O8NRG9KlgURY
         20CRQc+UCFa85ucEXacBZQbNhRusWfHXpxn9PfQP84aFcZSoEV2jbnfW0vHdun4dpF
         1DSX9oeWmHjOJ25XWrYw+0p17UkCu0dT4oyE3FMZLHjSAxnNTE4pAjHCH4IF1g3u1v
         xLNqU7hYp7wzw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 Apr 2023 09:53:37 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Correctly initialize some memory in get_available_dsc_slices()
Date:   Tue, 25 Apr 2023 09:53:34 +0200
Message-Id: <f7953bb41b7d5e28ec6bc3abfa06c8aaa0193ca4.1682409190.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent here is to clear the 'available_slices' buffer before setting
some values in it.

This is an array of int, so in order to fully initialize it, we must clear
MIN_AVAILABLE_SLICES_SIZE * sizeof(int) bytes.

Compute the right length of the buffer when calling memset().

Fixes: 97bda0322b8a ("drm/amd/display: Add DSC support for Navi (v2)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
NOT even compile-tested.

make -j7  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.o

on my setup, it fails with:
  CC      drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.o
drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c:27:10: fatal error: dc_hw_types.h: Aucun fichier ou dossier de ce type
   27 | #include "dc_hw_types.h"
      |          ^~~~~~~~~~~~~~~

I've not investigated why.
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index b9a05bb025db..1d7384b2be28 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -645,7 +645,7 @@ static int get_available_dsc_slices(union dsc_enc_slice_caps slice_caps, int *av
 {
 	int idx = 0;
 
-	memset(available_slices, -1, MIN_AVAILABLE_SLICES_SIZE);
+	memset(available_slices, -1, MIN_AVAILABLE_SLICES_SIZE * sizeof(*available_slices));
 
 	if (slice_caps.bits.NUM_SLICES_1)
 		available_slices[idx++] = 1;
-- 
2.34.1

