Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1565E63BA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiK2HKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiK2HKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:10:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494413E096
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:10:41 -0800 (PST)
Received: from frapeml100007.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NLthB5Kmyz67tG2;
        Tue, 29 Nov 2022 15:07:38 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (7.191.163.9) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 08:10:38 +0100
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 29 Nov 2022 07:10:36 +0000
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <alexander.deucher@amd.com>
CC:     <Xinhui.Pan@amd.com>, <christian.koenig@amd.com>,
        <daniel@ffwll.ch>, <airlied@gmail.com>, <evan.quan@amd.com>,
        <guchun.chen@amd.com>, <mdaenzer@redhat.com>, <nirmoy.das@amd.com>,
        <yifan1.zhang@amd.com>, <Hawking.Zhang@amd.com>,
        <lijo.lazar@amd.com>, <linux-kernel@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <yusongping@huawei.com>, <hukeping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [PATCH] drm: amdgpu: Fix logic error
Date:   Tue, 29 Nov 2022 15:10:32 +0800
Message-ID: <20221129071032.2154949-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes logic error in function 'amdgpu_hw_ip_info':
       - value 'uvd' might be 'vcn'.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fe23e09eec98..28752a6a92c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -424,7 +424,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_VCN_DEC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->uvd.harvest_config & (1 << i))
+			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
 			if (adev->vcn.inst[i].ring_dec.sched.ready)
@@ -436,7 +436,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_VCN_ENC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->uvd.harvest_config & (1 << i))
+			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
 			for (j = 0; j < adev->vcn.num_enc_rings; j++)
-- 
2.25.1

