Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29037115E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbjEYSok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbjEYSnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ABE173E;
        Thu, 25 May 2023 11:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8628D648CE;
        Thu, 25 May 2023 18:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34770C433D2;
        Thu, 25 May 2023 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039929;
        bh=86r+xkKIRhYgUF7Bq+La4YvxxcG5eH8HiqlRcq7Fy5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIitHQyZ/JIgQe9Rw7KuBFcq1ca/MKLH6Vl5rtjWqtCd7TE3TEu+Ue3TquF/tOTdI
         OIlnsdoDuNHpC1ewXSe9fonf7KS6YcTomeci8K/G2+yIkl8pCb1R0JbYA4vpDgQbf+
         SZhgf189N2DjWpBEeU1l31gzWO7fzjaBTJWVW9erzjfdai/fnbeQUJeXkD+f0ccN7s
         0ZCU1ishCvlO9o7lIsYu5PCk4JBK/M5/JYToi2rOEHKFlbfUKYhlCFvHTFkDoXIvbw
         9nY2BlnqH/xCn2OxRlFftCdZ2I4f0a0aVuffmK2/2iMsp+b/bnRyMgWmC5P0XoUKI3
         ZvYZ6EgVBC0JA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guchun Chen <guchun.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        andrey.grodzovsky@amd.com, luben.tuikov@amd.com,
        Jiadong.Zhu@amd.com, YuBiao.Wang@amd.com, gpiccoli@igalia.com,
        slark_xiao@163.com, Likun.Gao@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 54/57] drm/amdgpu: skip disabling fence driver src_irqs when device is unplugged
Date:   Thu, 25 May 2023 14:36:04 -0400
Message-Id: <20230525183607.1793983-54-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit c1a322a7a4a96cd0a3dde32ce37af437a78bf8cd ]

When performing device unbind or halt, we have disabled all irqs at the
very begining like amdgpu_pci_remove or amdgpu_device_halt. So
amdgpu_irq_put for irqs stored in fence driver should not be called
any more, otherwise, below calltrace will arrive.

[  139.114088] WARNING: CPU: 2 PID: 1550 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:616 amdgpu_irq_put+0xf6/0x110 [amdgpu]
[  139.114655] Call Trace:
[  139.114655]  <TASK>
[  139.114657]  amdgpu_fence_driver_hw_fini+0x93/0x130 [amdgpu]
[  139.114836]  amdgpu_device_fini_hw+0xb6/0x350 [amdgpu]
[  139.114955]  amdgpu_driver_unload_kms+0x51/0x70 [amdgpu]
[  139.115075]  amdgpu_pci_remove+0x63/0x160 [amdgpu]
[  139.115193]  ? __pm_runtime_resume+0x64/0x90
[  139.115195]  pci_device_remove+0x3a/0xb0
[  139.115197]  device_remove+0x43/0x70
[  139.115198]  device_release_driver_internal+0xbd/0x140

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3cc1929285fc0..ed6878d5b3ce3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -528,7 +528,8 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 		if (r)
 			amdgpu_fence_driver_force_completion(ring);
 
-		if (ring->fence_drv.irq_src)
+		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
+		    ring->fence_drv.irq_src)
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
 
-- 
2.39.2

