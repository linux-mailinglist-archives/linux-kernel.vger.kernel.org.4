Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58444722408
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFEK6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFEK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:58:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA93FED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60BE16155E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8AAC433EF;
        Mon,  5 Jun 2023 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685962720;
        bh=zFZh3DbitN9/k0ynfjMxiJVKXQDruFuT+gVPq2YmqCo=;
        h=From:To:Cc:Subject:Date:From;
        b=rBrmPNUsgjY6al0qoJqoSXyT5aYOhiIKrmiF/ZdmjXFxlThaQMW7jlGR9p1jzPNQc
         IpMDKNokZ4FTmzs4tvOl+sb/RxGbQCXpx7nMXMXI4N9xPZRtzW/zNYMlC+abLbnSnS
         eMwz2g1ZKQ2JxWuIGKGhjNEtqUwj+x7pwlTHsmM+srlIG/j5yWcEQk3qSL39F+I3XL
         RklCd6dmIlnbLCD98jmsSMASvZX+QzU9u42KgyLZfnP1tClmLBqjux4OcTTXjLZlV0
         aoaW5QYhEg28wGfb/GUYKYQzEzbMQmy+ukoGcUW1OeEiC8CRNuWwClPV/go/0IUHHi
         t6UzQ30QEb6CQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Kim <jonathan.kim@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Yifan Zha <Yifan.Zha@amd.com>, Le Ma <le.ma@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: mark som eclear_address_watch() callback static
Date:   Mon,  5 Jun 2023 12:58:28 +0200
Message-Id: <20230605105834.702945-1-arnd@kernel.org>
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

Some of the newly introduced clear_address_watch callback handlers have
no prototype because they are only used in one file, which causes a W=1
warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c:164:10: error: no previous prototype for 'kgd_gfx_aldebaran_clear_address_watch' [-Werror=missing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c:782:10: error: no previous prototype for 'kgd_gfx_v11_clear_address_watch' [-Werror=missing-prototypes]

Mark these ones static. If another user comes up in the future, that
can be reverted along with adding the prototype.

Fixes: cfd9715f741a1 ("drm/amdkfd: add debug set and clear address watch points operation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index efd6a72aab4eb..bdda8744398fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -161,7 +161,7 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 	return watch_address_cntl;
 }
 
-uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
+static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_id)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 52efa690a3c21..131859ce3e7e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -779,7 +779,7 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 	return watch_address_cntl;
 }
 
-uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
+static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_id)
 {
 	return 0;
-- 
2.39.2

