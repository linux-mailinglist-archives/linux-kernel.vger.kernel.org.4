Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC062445B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKJOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKJOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:33:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1828212A85
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:33:21 -0800 (PST)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7PT02XXZzRp8r;
        Thu, 10 Nov 2022 22:33:08 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 22:33:16 +0800
From:   Dong Chenchen <dongchenchen2@huawei.com>
To:     <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
        <Xinhui.Pan@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <yuehaibing@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_cs_pass1
Date:   Thu, 10 Nov 2022 22:33:14 +0800
Message-ID: <20221110143314.708434-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When p->gang_size equals 0, amdgpu_cs_pass1() will return directly
without freeing chunk_array, which will cause a memory leak issue,
this patch fixes it.

Fixes: 4624459c84d7 ("drm/amdgpu: add gang submit frontend v6")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1bbd39b3b0fc..0e24d6b80e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -287,8 +287,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		}
 	}
 
-	if (!p->gang_size)
-		return -EINVAL;
+	if (!p->gang_size) {
+		ret = -EINVAL;
+		goto free_partial_kdata;
+	}
 
 	for (i = 0; i < p->gang_size; ++i) {
 		ret = amdgpu_job_alloc(p->adev, num_ibs[i], &p->jobs[i], vm);
-- 
2.25.1
