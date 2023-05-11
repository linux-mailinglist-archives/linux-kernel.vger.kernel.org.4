Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FE6FFA85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbjEKTki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbjEKTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5B3D06C;
        Thu, 11 May 2023 12:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F35B365104;
        Thu, 11 May 2023 19:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9E8C433D2;
        Thu, 11 May 2023 19:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683833982;
        bh=39Gk684Rim1ohb6ZXsT2jGO/luPnpzXRpJSZyBbr9rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLlrYxepFIpfOuWbYrFMihgrZuJREpEzmLJScOtjBBOLk+yohkFnEdFcdh7OAbBTv
         HQDePiLm0RthFf8sLTHzztyebzR44tq0YRdvk/QflQ+CiCxnUCWI3DtfgP4ujlEJop
         D17jeRliQEDMFyVoloUXBEZ5QNe3rOIbaGvf/ybJ76zYBEJO0BmQubiMWJb2A9Txik
         jzNQsFWzSZ6/HVNKiHNdMh60rWgV+k/7/d3vzgp10cgK3Qx6KbcRKy/lqi6Ax/ac7i
         uvrax08bHbHFCJctQzp2ScN4ZCUApTpeZ2Msb+M/GivtkGHNIDexw1oeA18IbTvgNH
         ssll9mb1F8Png==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     lyndonli <Lyndon.Li@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, mario.limonciello@amd.com,
        lijo.lazar@amd.com, YiPeng.Chai@amd.com, andrey.grodzovsky@amd.com,
        Amaranath.Somalapuram@amd.com, Bokun.Zhang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.2 10/10] drm/amdgpu: Use the default reset when loading or reloading the driver
Date:   Thu, 11 May 2023 15:38:48 -0400
Message-Id: <20230511193850.623289-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511193850.623289-1-sashal@kernel.org>
References: <20230511193850.623289-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lyndonli <Lyndon.Li@amd.com>

[ Upstream commit 4eea7fb980dc44545a32eec92e2662053b34cd9d ]

Below call trace and errors are observed when reloading
amdgpu driver with the module parameter reset_method=3.

It should do a default reset when loading or reloading the
driver, regardless of the module parameter reset_method.

v2: add comments inside and modify commit messages.

[  +2.180243] [drm] psp gfx command ID_LOAD_TOC(0x20) failed
and response status is (0x0)
[  +0.000011] [drm:psp_hw_start [amdgpu]] *ERROR* Failed to load toc
[  +0.000890] [drm:psp_hw_start [amdgpu]] *ERROR* PSP tmr init failed!
[  +0.020683] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to
clear memory with ring turned off.
[  +0.000003] RIP: 0010:amdgpu_bo_release_notify+0x1ef/0x210 [amdgpu]
[  +0.000004] Call Trace:
[  +0.000003]  <TASK>
[  +0.000008]  ttm_bo_release+0x2c4/0x330 [amdttm]
[  +0.000026]  amdttm_bo_put+0x3c/0x70 [amdttm]
[  +0.000020]  amdgpu_bo_free_kernel+0xe6/0x140 [amdgpu]
[  +0.000728]  psp_v11_0_ring_destroy+0x34/0x60 [amdgpu]
[  +0.000826]  psp_hw_init+0xe7/0x2f0 [amdgpu]
[  +0.000813]  amdgpu_device_fw_loading+0x1ad/0x2d0 [amdgpu]
[  +0.000731]  amdgpu_device_init.cold+0x108e/0x2002 [amdgpu]
[  +0.001071]  ? do_pci_enable_device+0xe1/0x110
[  +0.000011]  amdgpu_driver_load_kms+0x1a/0x160 [amdgpu]
[  +0.000729]  amdgpu_pci_probe+0x179/0x3a0 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2af5f9f62b93b..e7cef6fc35771 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3564,6 +3564,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	int r, i;
 	bool px = false;
 	u32 max_MBps;
+	int tmp;
 
 	adev->shutdown = false;
 	adev->flags = flags;
@@ -3785,7 +3786,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				}
 			}
 		} else {
+			tmp = amdgpu_reset_method;
+			/* It should do a default reset when loading or reloading the driver,
+			 * regardless of the module parameter reset_method.
+			 */
+			amdgpu_reset_method = AMD_RESET_METHOD_NONE;
 			r = amdgpu_asic_reset(adev);
+			amdgpu_reset_method = tmp;
 			if (r) {
 				dev_err(adev->dev, "asic reset on init failed\n");
 				goto failed;
-- 
2.39.2

