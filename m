Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2690666D5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbjAQGAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjAQF7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:59:50 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC88A22DEE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 21:59:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VZls40E_1673935165;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VZls40E_1673935165)
          by smtp.aliyun-inc.com;
          Tue, 17 Jan 2023 13:59:33 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/3] drm/amd/display: Remove the unused variable value0
Date:   Tue, 17 Jan 2023 13:59:21 +0800
Message-Id: <20230117055922.53911-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable value0 is not effectively used, so delete it.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:1222:11: warning: variable ‘value0’ set but not used.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3783
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index c4287147b853..4c067f8a19b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -1219,7 +1219,6 @@ void dcn10_link_encoder_update_mst_stream_allocation_table(
 	const struct link_mst_stream_allocation_table *table)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t value0 = 0;
 	uint32_t value1 = 0;
 	uint32_t value2 = 0;
 	uint32_t slots = 0;
@@ -1321,13 +1320,9 @@ void dcn10_link_encoder_update_mst_stream_allocation_table(
 	do {
 		udelay(10);
 
-		value0 = REG_READ(DP_MSE_SAT_UPDATE);
-
-		REG_GET(DP_MSE_SAT_UPDATE,
-				DP_MSE_SAT_UPDATE, &value1);
-
-		REG_GET(DP_MSE_SAT_UPDATE,
-				DP_MSE_16_MTP_KEEPOUT, &value2);
+		REG_READ(DP_MSE_SAT_UPDATE);
+		REG_GET(DP_MSE_SAT_UPDATE, DP_MSE_SAT_UPDATE, &value1);
+		REG_GET(DP_MSE_SAT_UPDATE, DP_MSE_16_MTP_KEEPOUT, &value2);
 
 		/* bit field DP_MSE_SAT_UPDATE is set to 1 already */
 		if (!value1 && !value2)
-- 
2.20.1.7.g153144c

