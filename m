Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7D7362E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjFTE7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFTE7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:59:34 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 50A95DF;
        Mon, 19 Jun 2023 21:59:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id EF41360B6AA47;
        Tue, 20 Jun 2023 12:59:21 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, Xinhui.Pan@amd.com,
        daniel@ffwll.ch
Cc:     David.Francis@amd.com, Jane.Jian@amd.com, Bokun.Zhang@amd.com,
        monk.liu@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
Subject: [PATCH] drm/amd/amdgpu: Properly tune the size of struct
Date:   Tue, 20 Jun 2023 12:59:19 +0800
Message-Id: <20230620045919.492128-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch error:
    gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:316:49: error:
    static assertion failed: "amd_sriov_msg_pf2vf_info must be 1 KB"
    static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"

Fixes: 1721bc1b2afa ("drm/amdgpu: Update VF2PF interface")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 24d42d24e6a0..a482b422fed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -177,10 +177,10 @@ struct amd_sriov_msg_pf2vf_info {
 	uint64_t mecfw_offset;
 	/* MEC FW size in BYTE */
 	uint32_t mecfw_size;
-	/* UVD FW position in BYTE from the start of VF visible frame buffer */
-	uint64_t uvdfw_offset;
 	/* UVD FW size in BYTE */
 	uint32_t uvdfw_size;
+	/* UVD FW position in BYTE from the start of VF visible frame buffer */
+	uint64_t uvdfw_offset;
 	/* VCE FW position in BYTE from the start of VF visible frame buffer */
 	uint64_t vcefw_offset;
 	/* VCE FW size in BYTE */
@@ -193,8 +193,8 @@ struct amd_sriov_msg_pf2vf_info {
 	/* frequency for VF to update the VF2PF area in msec, 0 = manual */
 	uint32_t vf2pf_update_interval_ms;
 	/* identification in ROCm SMI */
-	uint64_t uuid;
 	uint32_t fcn_idx;
+	uint64_t uuid;
 	/* flags to indicate which register access method VF should use */
 	union amd_sriov_reg_access_flags reg_access_flags;
 	/* MM BW management */
@@ -263,7 +263,7 @@ struct amd_sriov_msg_vf2pf_info {
 	struct {
 		uint8_t id;
 		uint32_t version;
-	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+	} __packed ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
 	uint64_t dummy_page_addr;
 
 	/* reserved */
-- 
2.30.2

