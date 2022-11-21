Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2780C632329
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKUNIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiKUNIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:08:51 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA838DF22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:08:48 -0800 (PST)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NG7420Vtrz15Mml;
        Mon, 21 Nov 2022 21:08:18 +0800 (CST)
Received: from huawei.com (10.67.175.34) by kwepemi500022.china.huawei.com
 (7.221.188.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 21:08:45 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
        <yusongping@huawei.com>, <renzhijie2@huawei.com>
Subject: [PATCH] drm/amdgpu: fix unused-function error
Date:   Mon, 21 Nov 2022 13:04:18 +0000
Message-ID: <20221121130418.53267-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500022.china.huawei.com (7.221.188.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_AMDGPU=y and CONFIG_DRM_AMD_DC is not set,
gcc complained about unused-function :

drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1705:13: error: ‘amdgpu_discovery_set_sriov_display’ defined but not used [-Werror=unused-function]
 static void amdgpu_discovery_set_sriov_display(struct amdgpu_device *adev)
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

To fix this error, use CONFIG_DRM_AMD_DC to wrap
the definition of amdgpu_discovery_set_sriov_display().

Fixes: 25263da37693 ("drm/amdgpu: rework SR-IOV virtual display handling")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6b48178455bc..2509341df92d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1702,11 +1702,13 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+#if defined(CONFIG_DRM_AMD_DC)
 static void amdgpu_discovery_set_sriov_display(struct amdgpu_device *adev)
 {
 	amdgpu_device_set_sriov_virtual_display(adev);
 	amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 }
+#endif
 
 static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 {
-- 
2.17.1

