Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5177E6F2CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjEADE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjEADEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12BB2698;
        Sun, 30 Apr 2023 20:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 965EF61740;
        Mon,  1 May 2023 03:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBB4C433D2;
        Mon,  1 May 2023 03:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910017;
        bh=MdfxqeYAwDXh2VRMUaumN0FZctQaD2Tdai+MJVSkBmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGgCX8oARn1H2BTpJBb1xNQWJPusx4R/IywPXJ7XFMQNnriQcs5y+OcSvg5arY/xA
         E4lS0omqmqV1nEPDxBIW7fLvsJyHYf2G4KDYua+ZnHtstxrkpxNIgpP0vMWk3RnGma
         Mt6nE09m6D0xfy0ohOkuKljMQ3BHMxUgGdRno3MVmYs5PdxBsraYb9QHZANXjzR+Dr
         F7A+/CKHtnfMrSQ7Py/P0eHkmRe9HmMrQGMN48/+P2lW1XYj6A+Oq6fJTfg1ORs/xx
         +TPIgV/FSsXNXPIe1VZ14Q3wezwUhudCg3+Waxx3xchZjENKYiX01JN0dPOnJyMC7k
         t6jUdetbY1IRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gabe Teeger <gabe.teeger@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, Jun.Lei@amd.com,
        chiahsuan.chung@amd.com, Pavle.Kotarac@amd.com, duncan.ma@amd.com,
        Charlene.Liu@amd.com, trix@redhat.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.2 06/37] drm/amd/display: Enable HostVM based on rIOMMU active
Date:   Sun, 30 Apr 2023 22:59:14 -0400
Message-Id: <20230501025945.3253774-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabe Teeger <gabe.teeger@amd.com>

[ Upstream commit 97fa4dfa66fdd52ad3d0c9fadeaaa1e87605bac7 ]

[Why]
There is underflow and flickering occuring. The
underflow stops when hostvm is forced to active.
According to policy, hostvm should be enabled if riommu
is active, but this is not taken into account when
deciding whether to enable hostvm.

[What]
For DCN314, set hostvm to true if riommu is active.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 6a1cf6adea77d..8fa47233bc0a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -308,6 +308,10 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 				pipe->plane_state->src_rect.width < pipe->plane_state->dst_rect.width))
 			upscaled = true;
 
+		/* Apply HostVM policy - either based on hypervisor globally enabled, or rIOMMU active */
+		if (dc->debug.dml_hostvm_override == DML_HOSTVM_NO_OVERRIDE)
+			pipes[i].pipe.src.hostvm = dc->vm_pa_config.is_hvm_enabled || dc->res_pool->hubbub->riommu_active;
+
 		/*
 		 * Immediate flip can be set dynamically after enabling the plane.
 		 * We need to require support for immediate flip or underflow can be
-- 
2.39.2

