Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4025F62D3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiKQHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiKQHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:07:17 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485F4657FD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:07:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VV-tMJ4_1668668827;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VV-tMJ4_1668668827)
          by smtp.aliyun-inc.com;
          Thu, 17 Nov 2022 15:07:12 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/2] drm/amd/display: Remove set but unused variable cursor_bpp
Date:   Thu, 17 Nov 2022 15:06:55 +0800
Message-Id: <20221117070655.52749-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20221117070655.52749-1-jiapeng.chong@linux.alibaba.com>
References: <20221117070655.52749-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable cursor_bpp is not effectively used in the function, so delete it.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:217:10: warning: variable ‘cursor_bpp’ set but not used.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3120
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 763311ffb967..311be35de315 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -214,7 +214,6 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 	uint32_t lines_per_way = 0;
 	uint8_t num_ways = 0;
 	uint8_t bytes_per_pixel = 0;
-	uint8_t cursor_bpp = 0;
 	uint16_t mblk_width = 0;
 	uint16_t mblk_height = 0;
 	uint16_t mall_alloc_width_blk_aligned = 0;
@@ -288,19 +287,16 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 				switch (pipe->stream->cursor_attributes.color_format) {
 				case CURSOR_MODE_MONO:
 					cursor_size /= 2;
-					cursor_bpp = 4;
 					break;
 				case CURSOR_MODE_COLOR_1BIT_AND:
 				case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
 				case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
 					cursor_size *= 4;
-					cursor_bpp = 4;
 					break;
 
 				case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
 				case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
 					cursor_size *= 8;
-					cursor_bpp = 8;
 					break;
 				}
 
-- 
2.20.1.7.g153144c

