Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9593370BC57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjEVLv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjEVLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:51:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012DA1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DFB3611AC
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2EBC4339B;
        Mon, 22 May 2023 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684756279;
        bh=TRV8Ny4PJMXTeyf3oIo1EZT/b+jnBF0oOM2xdHt1ejw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lsvk8ncsJzq6J/GHSZvjZVawAB94qDoWC6ys2sgjuJaP5QNX10ARI3Qp5eL8l1VVq
         9MTWkFCzshBJdQfHusdOiTCdXKTM8r2bpRwDXPIp5o81CBHnR6/ZyjbvFoGdENPb+h
         Wavnsq+Hzzu77LtogSIvbxOdUyf5HySLQRz+dLNHw/X4yHfvVVnWqF0NXPtwUPqJ0y
         zPN3DV0/8tr3p3U/16CpyXY+q5fUZOcH2FqpFmnKGzBASV/4VVpio4vJ/qU3wkA2RX
         OLvBYSEXWqIRs7ghJPmG1fGg7DxfPSZMj2dyQlkaLmsPkGAPXM54JGDlAloZWJWvK9
         E1a3u8u34pR4Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/amdgpu: use %pad format string for dma_addr_t
Date:   Mon, 22 May 2023 13:50:31 +0200
Message-Id: <20230522115047.1169839-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522115047.1169839-1-arnd@kernel.org>
References: <20230522115047.1169839-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

DMA addresses can be shorter than u64, which results in a broken debug output:

drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c: In function 'amdgpu_gart_table_ram_alloc':
drivers/gpu/drm/amd/amdgpu/amdgpu.h:41:22: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Werror=format=]
drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:146:9: note: in expansion of macro 'dev_info'
  146 |         dev_info(adev->dev, "%s dma_addr:%llx\n", __func__, dma_addr);

Use the special %pad format string and pass the DMA address by reference.

Fixes: d020a29b6b58 ("drm/amdgpu: Allocate GART table in RAM for AMD APU")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index a070adf30c88..73b8cca35bab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -143,7 +143,7 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev)
 		return -EFAULT;
 	}
 
-	dev_info(adev->dev, "%s dma_addr:%llx\n", __func__, dma_addr);
+	dev_info(adev->dev, "%s dma_addr:%pad\n", __func__, &dma_addr);
 	/* Create SG table */
 	sg = kmalloc(sizeof(*sg), GFP_KERNEL);
 	if (!sg) {
-- 
2.39.2

