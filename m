Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127966E59E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDRG40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDRG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:56:24 -0400
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D935BA5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:55:57 -0700 (PDT)
From:   Daniil Dulov <d.dulov@aladdin.ru>
To:     Felix Kuehling <Felix.Kuehling@amd.com>
CC:     Daniil Dulov <d.dulov@aladdin.ru>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Oak Zeng <ozeng@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/amdkfd: Fix potential deallocation of previously deallocated memory.
Date:   Mon, 17 Apr 2023 23:55:21 -0700
Message-ID: <20230418065521.453001-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.20.32]
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer mqd_mem_obj can be deallocated in kfd_gtt_sa_allocate().
The function then returns non-zero value, which causes the second deallocation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d1f8f0d17d40 ("drm/amdkfd: Move non-sdma mqd allocation out of init_mqd")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 3b6f5963180d..bce11c5b07d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -119,7 +119,8 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
 	}
 
 	if (retval) {
-		kfree(mqd_mem_obj);
+		if (mqd_mem_obj)
+			kfree(mqd_mem_obj);
 		return NULL;
 	}
 
-- 
2.25.1

