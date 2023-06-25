Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD8473CE1C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjFYCqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjFYCqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:46:04 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F419CE48
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 19:45:59 -0700 (PDT)
X-UUID: e108507f782f4c5b8b769380e689645e-20230625
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:51816aac-f470-4fc2-a1be-856c24e82c84,IP:5,U
        RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:10
X-CID-INFO: VERSION:1.1.25,REQID:51816aac-f470-4fc2-a1be-856c24e82c84,IP:5,URL
        :0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:10
X-CID-META: VersionHash:d5b0ae3,CLOUDID:5ce15e3f-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230625104550PT0L52SW,BulkQuantity:0,Recheck:0,SF:44|38|24|17|19|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: e108507f782f4c5b8b769380e689645e-20230625
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <jiangfeng@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1486572970; Sun, 25 Jun 2023 10:45:49 +0800
From:   Feng Jiang <jiangfeng@kylinos.cn>
To:     christian.koenig@amd.com, ray.huang@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, michael.j.ruhl@intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH] drm/ttm: Remove duplicate assignments to ttm->caching
Date:   Sun, 25 Jun 2023 10:45:28 +0800
Message-ID: <20230625024528.13668-1-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter 'caching' has already been assigned to
'ttm->caching', so 'ttm_cached' is redundant.

Fixes: 1b4ea4c5980f ("drm/ttm: set the tt caching state at creation time")
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index ab725d9d14a6..1ce4b36ab33b 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -137,7 +137,6 @@ static void ttm_tt_init_fields(struct ttm_tt *ttm,
 			       unsigned long extra_pages)
 {
 	ttm->num_pages = (PAGE_ALIGN(bo->base.size) >> PAGE_SHIFT) + extra_pages;
-	ttm->caching = ttm_cached;
 	ttm->page_flags = page_flags;
 	ttm->dma_address = NULL;
 	ttm->swap_storage = NULL;
-- 
2.41.0

