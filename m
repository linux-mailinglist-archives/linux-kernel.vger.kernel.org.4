Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565D77366BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjFTI4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFTIz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:55:59 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 84F9110DB;
        Tue, 20 Jun 2023 01:55:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 09F1760C12808;
        Tue, 20 Jun 2023 16:55:44 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     dan.carpenter@linaro.org, Jane.Jian@amd.com, Likun.Gao@amd.com,
        David.Francis@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
Subject: [PATCH] =?UTF-8?q?drm/amd/amdgpu:=20Use=20=E2=80=9C=5F=5Fpacked?= =?UTF-8?q?=E2=80=9C=20instead=20of=20"pragma=20pack()"?=
Date:   Tue, 20 Jun 2023 16:55:43 +0800
Message-Id: <20230620085543.576733-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use "__packed" is clearer amd better than “pragma pack()”.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
As Dan Carpenter mentioned:
'"Mark the associated types properly packed individually, rather than
use the disgusting "pragma pack()" that should never be used."
https://lore.kernel.org/linux-sparse/CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com/'
use "__packed" is better.
the previous wrong patch's address:
https://lore.kernel.org/kernel-janitors/c12c4031-52fb-25a2-b411-e668eb9baaa2@tom.com/T/#t
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 24d42d24e6a0..025adc950026 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -83,8 +83,6 @@ enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID__MAX
 };
 
-#pragma pack(push, 1) // PF2VF / VF2PF data areas are byte packed
-
 union amd_sriov_msg_feature_flags {
 	struct {
 		uint32_t error_log_collect : 1;
@@ -210,7 +208,7 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t pcie_atomic_ops_support_flags;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
-};
+} __packed;
 
 struct amd_sriov_msg_vf2pf_info_header {
 	/* the total structure size in byte */
@@ -263,7 +261,7 @@ struct amd_sriov_msg_vf2pf_info {
 	struct {
 		uint8_t id;
 		uint32_t version;
-	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+	} __packed ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
 	uint64_t dummy_page_addr;
 
 	/* reserved */
@@ -301,8 +299,6 @@ enum amd_sriov_gpu_init_data_version {
 	GPU_INIT_DATA_READY_V1 = 1,
 };
 
-#pragma pack(pop) // Restore previous packing option
-
 /* checksum function between host and guest */
 unsigned int amd_sriov_msg_checksum(void *obj, unsigned long obj_size, unsigned int key,
 				    unsigned int checksum);
-- 
2.30.2

