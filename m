Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867286F2D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjEADJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjEADFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B559E5253;
        Sun, 30 Apr 2023 20:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F5E61710;
        Mon,  1 May 2023 03:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BF7C433D2;
        Mon,  1 May 2023 03:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910125;
        bh=+toHp4X0nOCv1qRh+pB6iNACVsP45WsBsc8cECZa6UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5M8W3V8MtZuhqzKgEzcwBTjxF5C7SRgVxAu1nnrwU0vZgvHqS/C0oncID6wfMJOR
         FlR2n/AWeusYc1s+Wih+UG16bSzv2PlXzu9PQntNld4Ab2Nft98//IJ/ekofGf+Sh5
         sp4NXed5i1LztXpzwbPR4x9c+5jnSCX0LrNxNQsJhEm+j6Anr6qhXdysQdz0JS3Duj
         YMW0lPGJ2yYL8TFXizVZrHlGPFrdwA2BFTSsqKrYplsW1+1hs+kQrMHKAjfKtoEEYA
         peAnp0wKQI0Mjmsaau0gwuBqEyRKzP56ScurLXhuaUBWc/QlfSU0ug92Pirouxnnhc
         pkEc3V9K36znw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     lyndonli <Lyndon.Li@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, lijo.lazar@amd.com, Prike.Liang@amd.com,
        mario.limonciello@amd.com, le.ma@amd.com, Jack.Xiao@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.2 34/37] drm/amdgpu: Fix sdma v4 sw fini error
Date:   Sun, 30 Apr 2023 22:59:42 -0400
Message-Id: <20230501025945.3253774-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lyndonli <Lyndon.Li@amd.com>

[ Upstream commit 5e08e9c742a00384e5abe74bd40cf4dc15cb3a2e ]

Fix sdma v4 sw fini error for sdma 4.2.2 to
solve the following general protection fault

[  +0.108196] general protection fault, probably for non-canonical
address 0xd5e5a4ae79d24a32: 0000 [#1] PREEMPT SMP PTI
[  +0.000018] RIP: 0010:free_fw_priv+0xd/0x70
[  +0.000022] Call Trace:
[  +0.000012]  <TASK>
[  +0.000011]  release_firmware+0x55/0x80
[  +0.000021]  amdgpu_ucode_release+0x11/0x20 [amdgpu]
[  +0.000415]  amdgpu_sdma_destroy_inst_ctx+0x4f/0x90 [amdgpu]
[  +0.000360]  sdma_v4_0_sw_fini+0xce/0x110 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 4d780e4430e78..bc073b4c94703 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1908,7 +1908,7 @@ static int sdma_v4_0_sw_fini(void *handle)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
-	if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 0) ||
+	if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) ||
             adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 4, 0))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
 	else
-- 
2.39.2

