Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82E56B1A02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 04:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCIDhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 22:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCIDhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:37:04 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1A5C70B5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 19:37:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VdRlr5N_1678333015;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VdRlr5N_1678333015)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 11:36:59 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: Remove useless else if
Date:   Thu,  9 Mar 2023 11:36:54 +0800
Message-Id: <20230309033654.64762-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
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

The assignment of the else and if branches is the same, so the if else
here is redundant, so we remove it.

./drivers/gpu/drm/amd/amdgpu/nv.c:1048:2-4: WARNING: possible condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4454
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 855d390c41de..84803929f7d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1045,19 +1045,11 @@ static int nv_common_late_init(void *handle)
 
 	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_get_irq(adev);
-		if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
-			amdgpu_virt_update_sriov_video_codec(adev,
-							     sriov_sc_video_codecs_encode_array,
-							     ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
-							     sriov_sc_video_codecs_decode_array_vcn1,
-							     ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
-		} else {
-			amdgpu_virt_update_sriov_video_codec(adev,
-							     sriov_sc_video_codecs_encode_array,
-							     ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
-							     sriov_sc_video_codecs_decode_array_vcn1,
-							     ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
-		}
+		amdgpu_virt_update_sriov_video_codec(adev,
+						     sriov_sc_video_codecs_encode_array,
+						     ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
+						     sriov_sc_video_codecs_decode_array_vcn1,
+						     ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
 	}
 
 	return 0;
-- 
2.20.1.7.g153144c

