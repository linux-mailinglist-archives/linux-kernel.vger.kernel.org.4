Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAA870A9F6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjETSWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjETSWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAC81702;
        Sat, 20 May 2023 11:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA4660B8D;
        Sat, 20 May 2023 18:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BACC4339B;
        Sat, 20 May 2023 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606901;
        bh=Caj9Chv14WJIy5OSbKzEcAb/SOrNpcH0u4TKTyOodn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHuQFJPzr0vbY4R/e1kvCF/7TUpp2fu6TI6jhAE7dQakIWpdCNe7i3qzaIrCF4q1H
         dygU9rfaffRfDfhDQHmOrF49DBVI0DRfbI5ZUflI4Nf8Lf05nYXUtc5s41xDEzifFB
         EgDunWHps/X48dDrSwuk0KKc7yHH/mZDToOYOYxMD4YSvV3R3bmKqEtrQUT8qbtUZ1
         jDoFS8yj6fjJo/t/hn+SoDsRO3nxygu8m5r4N0tc3hrE5bqms8+2TA6sihXaNZaaK7
         LOui5VwpENzFv0oDgbGi+v7hu0U9S4zMLlbB1rzj5J9etjfnSlFvuDk2vokq7n7m3I
         eSJTrMMmzsHLQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <lang.yu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, mario.limonciello@amd.com,
        lijo.lazar@amd.com, YiPeng.Chai@amd.com, andrey.grodzovsky@amd.com,
        Amaranath.Somalapuram@amd.com, Bokun.Zhang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 09/14] drm/amdgpu: set gfx9 onwards APU atomics support to be true
Date:   Sat, 20 May 2023 14:20:37 -0400
Message-Id: <20230520182044.836702-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182044.836702-1-sashal@kernel.org>
References: <20230520182044.836702-1-sashal@kernel.org>
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

From: Yifan Zhang <yifan1.zhang@amd.com>

[ Upstream commit af7828fbceed4f9e503034111066a0adef3db383 ]

APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather
it is internal path w/ native atomic support. Set have_atomics_support
to true.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 011e4fbe27f10..646a211e1a964 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3735,6 +3735,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
 			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
 			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	/* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is a
+	 * internal path natively support atomics, set have_atomics_support to true.
+	 */
+	else if ((adev->flags & AMD_IS_APU) &&
+		(adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0)))
+		adev->have_atomics_support = true;
 	else
 		adev->have_atomics_support =
 			!pci_enable_atomic_ops_to_root(adev->pdev,
-- 
2.39.2

