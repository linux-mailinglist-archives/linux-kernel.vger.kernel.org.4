Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4977D745C51
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGCMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276D115
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A08A60F14
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51115C433D9;
        Mon,  3 Jul 2023 12:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688387765;
        bh=8pRVnz7l/AWZY8R6a2pMc6+C9qMNZAMoJ59TR8NJIO0=;
        h=From:To:Cc:Subject:Date:From;
        b=DZLcDDKvSxSTlWD4URjmpKjyoA7HRwAyBFPaqyTHxpjhmm3nUChEjL5c73BbXSp33
         QWU+n/0gPMEpL9fceFAujDyjMffuS1hzoQJsVI6j6ImASFy8SO0oSGq69uotxEhMCw
         ag4fpWtODUz+PLLJX+iZRIdjp0lph64ubJnFcNprRVbBcpQVLXrecePaqIlJmUPnfw
         kphGwx6UiNShSXEIjGtmuqJE45gnBCUlonNvSferCdcIOvHM3jSvheiwJ5nO8/WP9L
         OPC5FB3WoWvY9d4MpwPSA9qKv9YqPYDl5D7+yuF+9GeX9Alj0lZw2kAr/lF6dyPc2S
         S0J5j13mbhkmQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>, Le Ma <le.ma@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Shiwu Zhang <shiwu.zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: avoid integer overflow warning in amdgpu_device_resize_fb_bar()
Date:   Mon,  3 Jul 2023 14:35:49 +0200
Message-Id: <20230703123557.3355657-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit architectures comparing a resource against a value larger than
U32_MAX can cause a warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1344:18: error: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                    res->start > 0x100000000ull)
                    ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~

The compiler is right that this cannot happen in this configuration, which
is ok, so just add a cast to shut up the warning.

Fixes: 31b8adab3247e ("drm/amdgpu: require a root bus window above 4GB for BAR resize")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f069e1731fee..abd13942aac5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1341,7 +1341,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	pci_bus_for_each_resource(root, res, i) {
 		if (res && res->flags & (IORESOURCE_MEM | IORESOURCE_MEM_64) &&
-		    res->start > 0x100000000ull)
+		    (u64)res->start > 0x100000000ull)
 			break;
 	}
 
-- 
2.39.2

