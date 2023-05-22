Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF74070BC59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjEVLwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjEVLvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E64FE6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 204336179D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3408BC4339C;
        Mon, 22 May 2023 11:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684756287;
        bh=wsmVaRXDTHdYbuzmc+ErLrw25ByhRTk9OeHIp7wng8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTNepLXJ+mYAtmR4o5JKpUOvPO1eRVNdd7Bhp2iGfAJip1Q/5PSMSIx0CI+vW2Fp6
         Vq/NmHzdGFrnK14KS8GQJrTGU+eG4+EdqOoELESOGtqfl+UPv5KMXTgjdxQ/iZkS5g
         E8ey02Rhx6A+T41wu2pPHqoRyIMJnbfEt7hfLkwEGfubolT3Wvjgk1cKzLQQjpWfyK
         Lu2KuvvISEEHKmhr2QpSpVcxQw12jCW5bmFlYtdp6bGb1SoKjW3SiD/Jfny61b9n5Z
         SpVkb8W7HZi266CLcAGhRx8GH1P9hlVZxTsYxOSTFnvzof4aoe9KXj8mjTtXppwN9v
         xac9IM03fxpYQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lijo Lazar <lijo.lazar@amd.com>, Le Ma <le.ma@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tim Huang <tim.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jingyu Wang <jingyuwang_vip@163.com>,
        Hans de Goede <hdegoede@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/amdgpu: fix acpi build warnings
Date:   Mon, 22 May 2023 13:50:32 +0200
Message-Id: <20230522115047.1169839-5-arnd@kernel.org>
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

Two newly introduced functions are in the global namespace but have no prototypes
or callers outside of amdgpu_acpi.c, another function is static but only has
a caller inside of an #ifdef:

drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:902:13: error: no previous prototype for 'amdgpu_acpi_get_node_id' [-Werror=missing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:928:30: error: no previous prototype for 'amdgpu_acpi_get_dev' [-Werror=missing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:860:33: error: 'amdgpu_acpi_get_numa_info' defined but not used [-Werror=unused-function]

Avoid the warnings by marking all of them static and ensuring that the compiler is
able to see the callsites.

Fixes: c34db97b8217 ("drm/amdgpu: Add API to get numa information of XCC")
Fixes: 1f6f659d06e1 ("drm/amdgpu: Store additional numa node information")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 873532c4adbe..1dbcd0e62478 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -899,13 +899,15 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
  *
  * Returns ACPI STATUS OK with Node ID on success or the corresponding failure reason
  */
-acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
+static acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
 				    struct amdgpu_numa_info **numa_info)
 {
-#ifdef CONFIG_ACPI_NUMA
 	u64 pxm;
 	acpi_status status;
 
+	if (!IS_ENABLED(CONFIG_ACPI_NUMA))
+		return_ACPI_STATUS(AE_NOT_EXIST);
+
 	if (!numa_info)
 		return_ACPI_STATUS(AE_ERROR);
 
@@ -920,12 +922,9 @@ acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
 		return_ACPI_STATUS(AE_ERROR);
 
 	return_ACPI_STATUS(AE_OK);
-#else
-	return_ACPI_STATUS(AE_NOT_EXIST);
-#endif
 }
 
-struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
+static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
 {
 	struct amdgpu_acpi_dev_info *acpi_dev;
 
-- 
2.39.2

