Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64ED6E8D13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjDTIrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjDTIrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30F19A9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E63EF64616
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF976C433D2;
        Thu, 20 Apr 2023 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681980437;
        bh=uADxxtxxbjR1ZmBmGvPD7EU2EEluZLYB+5f1TqvzOxs=;
        h=From:To:Cc:Subject:Date:From;
        b=ViTEOfcPaOYEWW6eyaRDKjG09tmHwSLtnm4Cljj4u20xjKIKZpyXkQO27yc4pIrI4
         tOSLhFA6R+2a7n9TDWtFgvtYuKFKX/PtfWkyV4+FspVRe5iNDXFqaWVE3arjpFO5Qh
         ETNPK3v2QOh3+Q4rCoxgk3HvJhYsMaHrTo5VhjN/3DPrQu+BTPbIabLzE2/55ssA8z
         q84IQU5rq3vBlW2TVlxKi/ax0nrc2ZkU7Izm8MPS4XxQ6PHfbyMxymCAGJ32e05yf8
         1nxyYUou7XEYImRNo0SltMmngP+iGObZ+r2F6zA7UKmJ8nf9922LaTkpdtsPJwvFcP
         GK7HNXCZEtHFA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Morris Zhang <Shiwu.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/amdgpu: mark gfx_v9_4_3_disable_gpa_mode() static
Date:   Thu, 20 Apr 2023 10:47:00 +0200
Message-Id: <20230420084711.3063453-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

This was left global by accident, the corresponding functions for other
hardware types are already static:

drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1072:6: error: no previous prototype for function 'gfx_v9_4_3_disable_gpa_mode' [-Werror,-Wmissing-prototypes]

Fixes: 86301129698b ("drm/amdgpu: split gc v9_4_3 functionality from gc v9_0")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index baa10ee8ec69..5d3aafba1f8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1069,7 +1069,7 @@ static void gfx_v9_4_3_init_pg(struct amdgpu_device *adev, int xcc_id)
 	}
 }
 
-void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
+static void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 
-- 
2.39.2

