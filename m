Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319CE60264C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJRIAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJRIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:00:42 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161401010
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:00:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSTywLl_1666080030;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VSTywLl_1666080030)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 16:00:37 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     anitha.chrisanthus@intel.com
Cc:     edmund.j.dea@intel.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/kmb: Remove some unused functions
Date:   Tue, 18 Oct 2022 15:59:44 +0800
Message-Id: <20221018075944.108207-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
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

Functions set_test_mode_src_osc_freq_target_low_bits() and
set_test_mode_src_osc_freq_target_hi_bits() are defined in the kmb_dsi.c
file, but not called elsewhere, so remove these unused functions.

drivers/gpu/drm/kmb/kmb_dsi.c:822:2: warning: unused function 'set_test_mode_src_osc_freq_target_low_bits'.
drivers/gpu/drm/kmb/kmb_dsi.c:834:2: warning: unused function 'set_test_mode_src_osc_freq_target_hi_bits'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2426
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/kmb/kmb_dsi.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index cf7cf0b07541..ed99b14375aa 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -818,34 +818,6 @@ static void test_mode_send(struct kmb_dsi *kmb_dsi, u32 dphy_no,
 	}
 }
 
-static inline void
-	set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi *kmb_dsi,
-						   u32 dphy_no,
-						   u32 freq)
-{
-	/* Typical rise/fall time=166, refer Table 1207 databook,
-	 * sr_osc_freq_target[7:0]
-	 */
-	test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES,
-		       (freq & 0x7f));
-}
-
-static inline void
-	set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi *kmb_dsi,
-						  u32 dphy_no,
-						  u32 freq)
-{
-	u32 data;
-
-	/* Flag this as high nibble */
-	data = ((freq >> 6) & 0x1f) | (1 << 7);
-
-	/* Typical rise/fall time=166, refer Table 1207 databook,
-	 * sr_osc_freq_target[11:7]
-	 */
-	test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES, data);
-}
-
 static void mipi_tx_get_vco_params(struct vco_params *vco)
 {
 	int i;
-- 
2.20.1.7.g153144c

