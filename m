Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3649E7183C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbjEaNwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbjEaNty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD9B273A;
        Wed, 31 May 2023 06:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CD4C63B2A;
        Wed, 31 May 2023 13:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B48C4339E;
        Wed, 31 May 2023 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540652;
        bh=P8VOBaAvWoWUl0YcRAIKvloxz3acn3TyCvUITgVlkdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biQNvJ8HuKsJddxlmeLYBt+u2KDGEqNDnNjmBN/thbKBzL46fkUnmkp5cDg1NJZJP
         yDgomHRNLqtrjY9tyvotOEx/YPO3uMcj5Vsas7k4ez9R19GNSBIz7jKh+g/oSDGmim
         ZbRMnEcK+HoAHpsCztLOWwRey5dVEitLj8ZXclKo+yHVTzHhT76TAcyhZ5HsDayERk
         /nIbym0jJuIXPBwbOUsOM/m+pH1WLemJRXYcmhCsp6ZWgyeSFr68xtYcyHTHmaw12+
         bV83uN5Z4weiRpbMaOoQsJUUPgSUD1gTP3B7r+JDJUxaTk7OEar39jiR0TzEbhTWc/
         Ooowa8dp9W96g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, Jack.Gui@amd.com, lijo.lazar@amd.com,
        mario.limonciello@amd.com, le.ma@amd.com,
        Arunpravin.PaneerSelvam@amd.com, Victor.Zhao@amd.com,
        Likun.Gao@amd.com, Jiadong.Zhu@amd.com, jesse.zhang@amd.com,
        candice.li@amd.com, YiPeng.Chai@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 23/24] drm:amd:amdgpu: Fix missing buffer object unlock in failure path
Date:   Wed, 31 May 2023 09:43:19 -0400
Message-Id: <20230531134320.3384102-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134320.3384102-1-sashal@kernel.org>
References: <20230531134320.3384102-1-sashal@kernel.org>
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

From: Sukrut Bellary <sukrut.bellary@linux.com>

[ Upstream commit 60ecaaf54886b0642d5c4744f7fbf1ff0d6b3e42 ]

smatch warning -
1) drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:3615 gfx_v9_0_kiq_resume()
warn: inconsistent returns 'ring->mqd_obj->tbo.base.resv'.

2) drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:6901 gfx_v10_0_kiq_resume()
warn: inconsistent returns 'ring->mqd_obj->tbo.base.resv'.

Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 970d59a21005a..daff4da1a8bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7197,8 +7197,10 @@ static int gfx_v10_0_kiq_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
 		return r;
+	}
 
 	gfx_v10_0_kiq_init_queue(ring);
 	amdgpu_bo_kunmap(ring->mqd_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5f325ded7f752..de1fab165041f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3871,8 +3871,10 @@ static int gfx_v9_0_kiq_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
 		return r;
+	}
 
 	gfx_v9_0_kiq_init_queue(ring);
 	amdgpu_bo_kunmap(ring->mqd_obj);
-- 
2.39.2

