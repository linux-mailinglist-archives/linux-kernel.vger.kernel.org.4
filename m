Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670FF633B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiKVL3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiKVL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:28:50 -0500
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE5F09
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:22:14 -0800 (PST)
X-QQ-mid: bizesmtp72t1669116099txffgh0h
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 22 Nov 2022 19:21:37 +0800 (CST)
X-QQ-SSF: 01400000000000E0R000000C0000000
X-QQ-FEAT: +ynUkgUhZJlLDq+nP6+uedbXvgas1IUa13PrtWgKs2DOViskOswrChYt+MFKv
        Pl7pXSgPAC9YYzk66eyueb4WltFQHvZSCvT3pmXv1se7I7PYRHHS2+1FKm7VBkBJICOOW8B
        kK3W9lrRUW/buANCKL1Wyp2c+1nEoipKiy6JgwdUq3RRSUWkt6Otm7FKIjn7koJ3WcNt5U1
        HCfEsmgZBOHhvElsFR/C8Zo/QMfTfy3Tuj/xOWkzr1h7gtV6oVBaD9kndG5aPvZ5y+5HrWm
        +IB/Qsw+TMBz8rvwDV2InH89ZTSvxtWCalAOe4Gh6p8sl8iI1ql3AyD0jf9HTaHiiQ5H9jU
        0cXEbZXTvvLg/v9KKHunEUcUQkl8vYnVIPxMovw9J360ql9NDpQpoyOBRfLR9AO/8hLpun8
        K5v013a9cN8=
X-QQ-GoodBg: 1
From:   hongao <hongao@uniontech.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
        aurabindo.pillai@amd.com, roman.li@amd.com, Jerry.Zuo@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, hongao <hongao@uniontech.com>
Subject: [PATCH] drm/amd/display: Fix set scaling doesn's work
Date:   Tue, 22 Nov 2022 19:20:34 +0800
Message-Id: <20221122112034.30080-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why]
Setting scaling does not correctly update CRTC state. As a result
dc stream state's src (composition area) && dest (addressable area)
was not calculated as expected. This causes set scaling doesn's work.

[How]
Correctly update CRTC state when setting scaling property.

Signed-off-by: hongao <hongao@uniontech.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3e1ecca72430..a88a6f758748 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9386,8 +9386,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
-		if (dm_old_con_state->abm_level !=
-		    dm_new_con_state->abm_level)
+		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
+		    dm_old_con_state->scaling != dm_new_con_state->scaling)
 			new_crtc_state->connectors_changed = true;
 	}
 
-- 
2.20.1

